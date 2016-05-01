## 前言

首先定义业务控件的概念：我们将iOS中UILabel、UIButton等称之为普通控件，当这些普通控件真正表示某一具体含义时，如名字的UILabel、发送的Button，我们就叫做业务控件。业务控件可以自动更新内容，解耦视图和业务逻辑。

本文是介绍业务控件自动更新内容的框架，框架提供模块间解耦的一种方法，而且框架的应用场景非常广泛，如自动换肤等。

代码地址：
[iOS业务控件框架](https://github.com/hamilyjing/JJComponentUpdateKit)

## 问题

当我们开发时，会遇到这种情况：同一业务控件会出现在多个模块中，每个模块需要维护此业务控件（控件的初始化，控件内容的更新等），由此产生代码依赖，重复代码，而且每个模块都要熟悉业务逻辑。如果代码考虑不周全，可能会出现相同业务控件在不同模块中展示的内容不同。

此框架就是解决以上类似的问题。

## 框架详解

1.框架保存所有业务控件，当某一业务更新时，框架更新此业务相关的所有控件。

2.业务控件在框架中定义为实现JJCUKComponentDataSource协议的任何对象，协议中定义控件对应的业务功能。

```
typedef NSString JJCUKFunctionType;

@protocol JJCUKComponentDataSource <NSObject>

- (JJCUKFunctionType *)jjCUK_getFunctionType;

@end

```

3.框架对NSObject做了类别，并实现了JJCUKComponentDataSource协议，因此基本iOS所有对象都可以作为业务控件加入到框架中，使用者只需设置jjCUKFunctionType即可。另外使用者只需要作为jjCUKComponentDelegate代理，就可以监听控件更新状态，还可以通过jjCUKUserInfo传递参数。

```
@interface NSObject (JJCUK) <JJCUKComponentDataSource>

@property (nonatomic, copy) JJCUKFunctionType *jjCUKFunctionType;
@property (nonatomic, weak) id<JJCUKComponentDelegate> jjCUKComponentDelegate;
@property (nonatomic, strong, readonly) NSMutableDictionary *jjCUKUserInfo;

- (void)jjCUK_setUserInfoWithObject:(id)object forKey:(id)key;

@end

@protocol JJCUKComponentDelegate <NSObject>

@optional
- (BOOL)jjCUK_shouldUpdateComponent:(id<JJCUKComponentDataSource>)component;
- (void)jjCUK_willUpdateComponent:(id<JJCUKComponentDataSource>)component;
- (void)jjCUK_didUpdateComponent:(id<JJCUKComponentDataSource>)component;

@end
```

4.有了业务控件，还需要有对应的业务更新处理逻辑，需要业务提供者编写相应代码，框架提供了基类JJCUKBaseFunction（还有JJCUKHashTableComponentsFunction、JJCUKHashTableViewFunction和JJCUKMapTableComponentsFunction），定义组件加入、删除、更新接口。多个模块使用同一个业务控件，需要数组或字典保存加入到框架中的业务控件，框架使用可以保存weak类型的NSMapTable和NSHashTable来存储控件，可以自动释放控件，不需要使用者手动释放的目的。

```
@interface JJCUKBaseFunction : NSObject

@property (nonatomic, strong) NSMapTable *componentMapTable;
@property (nonatomic, strong) NSHashTable *componentHashTable;

- (BOOL)addComponent:(id<JJCUKComponentDataSource>)component;
- (void)removeComponent:(id<JJCUKComponentDataSource>)component;

- (void)updateProcessWithComponent:(id<JJCUKComponentDataSource>)component withObject:(id)object;

- (BOOL)shouldUpdateComponent:(id<JJCUKComponentDataSource>)component withObject:(id)object;
- (void)updateComponent:(id<JJCUKComponentDataSource>)component withObject:(id)object;

- (void)updateAllComponentWithObject:(id)object;

@end
```

5.业务控件的更新逻辑如下。

```
- (void)updateProcessWithComponent:(NSObject<JJCUKComponentDataSource> *)component_ withObject:(id)object_
{
    if (![self shouldUpdateComponent:component_ withObject:object_])
    {
        return;
    }
    
    if ([component_.jjCUKComponentDelegate respondsToSelector:@selector(jjCUK_shouldUpdateComponent:)])
    {
        if (![component_.jjCUKComponentDelegate jjCUK_shouldUpdateComponent:component_])
        {
            return;
        }
    }
    
    if ([component_.jjCUKComponentDelegate respondsToSelector:@selector(jjCUK_willUpdateComponent:)])
    {
        [component_.jjCUKComponentDelegate jjCUK_willUpdateComponent:component_];
    }
    
    [self updateComponent:component_ withObject:object_];
    
    if ([component_.jjCUKComponentDelegate respondsToSelector:@selector(jjCUK_didUpdateComponent:)])
    {
        [component_.jjCUKComponentDelegate jjCUK_didUpdateComponent:component_];
    }
}
```

6.JJComponentUpdateKitManager是框架的管理类，使用者不需要直接调用，当设置jjCUKFunctionType后，控件会自动加入到框架中。

```
- (void)setJjCUKFunctionType:(NSString *)jjCUKFunctionType_
{
    if (![self.jjCUKFunctionType isEqualToString:jjCUKFunctionType_])
    {
        [[JJComponentUpdateKitManager sharedInstance] removeComponent:self];
        objc_setAssociatedObject(self, @selector(jjCUKFunctionType), jjCUKFunctionType_, OBJC_ASSOCIATION_COPY);
    }
    
    [[JJComponentUpdateKitManager sharedInstance] addComponent:self];
}
```

## 使用

1.下载JJComponentUpdateKit代码，将JJComponentUpdateKit文件夹放到项目中，引入头文件"JJComponentUpdateKit.h"。或使用cocoaPod，pod 'JJComponentUpdateKit'.

2.创建业务更新类，此类主要监听业务变化，并更新业务控件。

```
let ChangeLabelTextNotificationName = "ChangeLabelTextNotificationName"

class JJCUKFunctionChangeLabelText: JJCUKHashTableComponentsFunction{
    var pos = 1
    
    override init() {
        super.init()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "changeLabelTextNotification", name: ChangeLabelTextNotificationName, object: nil)
    }
    
    override func updateComponent(component: JJCUKComponentDataSource!, withObject object: AnyObject!)
    {
        // 业务开发者知道业务控件的具体类型
        let label = component as! UILabel;
        label.text = String(pos)
    }
    
    func changeLabelTextNotification()
    {
        ++pos
        updateAllComponentWithObject(nil)
    }
}
```

3.定义业务功能，建议使用业务更新类的名字，因为当设置jjCUKFunctionType后，框架通过名字自动创建对应的业务更新类。如果不一致，使用者需要在JJComponentUpdateKitManager的setFunctionTypeDictionary接口中提前设置好对应关系。

```
let JJCUKFunctionTypeChangeLabelText = "JJCUKFunctionTypeChangeLabelText"
```

4.使用业务控件

```
// label1和label2具有相同的初始值和更新值
label1.jjCUKFunctionType = JJCUKFunctionTypeChangeLabelText
label2.jjCUKFunctionType = JJCUKFunctionTypeChangeLabelText
```

使用者只需要设置好业务控件的功能即可，控件内容的初始值和更新过程都不需要使用者处理。

## 总结

业务控件创建者实现业务更新类，并定义业务功能，其他使用者只需要简单设置业务功能即可，从而减少模块依赖，视图和业务逻辑解耦的目的。

-----------------------------------------------------------------------------------

【相关文章】

APP开发框架：http://mp.weixin.qq.com/s?__biz=MzIwMzI0MTI5MA==&mid=2247483658&idx=1&sn=a564529aa0bcee10c4103efaa7bde84b#rd

iOS皮肤框架：http://mp.weixin.qq.com/s?__biz=MzIwMzI0MTI5MA==&mid=2247483670&idx=1&sn=b1a76605965632fd078d7e3adaca19ee#rd

【LoveAPP开发订阅号】

![image](https://mmbiz.qlogo.cn/mmbiz/YTAjOycganOGG6qPHNdqTN5d5sJ3UiahpSUemVlhbcNfsCkb0YwXt8dClvWcve4J6LGRrjBeZP8iaYqMy6o7k2vg/0?wx_fmt=jpeg)