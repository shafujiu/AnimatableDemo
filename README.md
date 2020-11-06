[toc]

# AnimatableDemo
IBAnimatable库的是用

## 封装模仿UIAlertController 封装 自定义的SFJAlertController

**使用**
```Swift
let alert = SFJAlertController.alert(title: nil, message: nil)
alert.addAction(SFJAlertAction("下一份", .default(nil), {
}))
alert.addAction(SFJAlertAction("确认", .confirm(nil), {

}))
present(alert, animated: true, completion: nil)
```


