# JJComponentUpdateKit

JJComponentUpdateKit can update all relative components for the same thing changed. You do not wirte notification     process code for each module. JJComponentUpdateKit ensure all components to update the same status.

For example, you should show the same name in different module, and you must write the name changed notification code in different module. It can cause code repetition and name is wrong in different module. JJComponentUpdateKit can resolve it and you do not need write any updated codes in different module.

# Usage

* Move JJComponentUpdateKit/JJComponentUpdateKit directory to your project.

* Write funcion class to process notification and component updated. 
	
	The function class should begin with JJCUKFunction. JJComponentUpdateKit will create function class accroding to the class name rule: "JJCUKFunction" + "funciton type". [Fucntion type see below.]
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

* define function type, and set to your component. 

	The component must response the JJCUKComponentDataSource protocol. I have set NSObject to response the JJCUKComponentDataSource protocol.

```
let JJCUKFunctionTypeChangeLabelText = "ChangeLabelText"

label1.jjCUKFunctionType = JJCUKFunctionTypeChangeLabelText
label2.jjCUKFunctionType = JJCUKFunctionTypeChangeLabelText
```
JJComponentUpdateKit will set label1's text first when you set function type. And it will update label1's text if the label text changed. Label1 and lable2 have the same text and update together.

# License

JJSkin is released under the MIT license. See
[LICENSE](https://github.com/hamilyjing/JJComponentUpdateKit/blob/master/LICENSE).

# More Info

Have a question? Please [open an issue](https://github.com/hamilyjing/JJComponentUpdateKit/issues/new)!
