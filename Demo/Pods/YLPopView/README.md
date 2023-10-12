# YLPopView
This is a easy popView.这是一个简单的弹窗
### 代码侵入低
# 使用方法
### ->cocoapods->pod 'YLPopView'
### ->download->拉进项目内
YLPop 等于-> PopManager.share
任选一种使用即可,详情看代码块或者demo

```swift
//MARK: 推荐方法一 block全局配置
YLPop.config { config in
    config.loadingImage = UIImage(named: "PopLoading")
    config.errorImage = UIImage(named: "PopError")
    config.successImage = UIImage(named: "PopSuccess")
    config.font = .systemFont(ofSize: 13, weight: .regular)
}
//MARK: 方法二定义一个配置对象
//定义一个新的配置文件
var config = PopConfig()
//加载图片设置
config.loadingImage = UIImage(named: "PopLoading")
//失败图片设置
config.errorImage = UIImage(named: "PopError")
//成功图片设置
config.successImage = UIImage(named: "PopSuccess")
//传入设置
YLPop.share.config(result: config)
//MARK: 方法三
//全局设置报错图片
YLPop.config.errorImage = UIImage(named: "PopError")


//MARK: 在开始加载后单次设置弹窗的属性(开始加载后可以设置)
YLPop.pop.font = .systemFont(ofSize: 30, weight: .regular)


//MARK: 使用
//加载中
YLPop.loading(view: view, text: "加载中")
//加载成功(动画2秒移除)
YLPop.success(text:)
//加载失败(动画2秒移除)
YLPop.error(text:)
//提示信息
YLPop.tips(view: <#T##UIView#>, text: <#T##String#>, showMask: <#T##Bool#>)
```
### Parameters:
加在什么View上
提示信息
点击关闭按钮回调(exitBlock:)
加载中仅需调用
```swift
YLPop.loading(view:, text:)方法
```
### Parameters:
加在什么View上(view:)
提示信息

成功/失败调用
```swift
YLPop.success(text:)
YLPop.error(text:)
```

### Parameters:
加在什么View上
提示文字信息
是否需要蒙层
是否展示蒙层
上左下右文字间距

文字提示使用
```swift
YLPop.tips(view:, text:, mask, showMask:,)并传入对应参数
```

## 注:加载中与成功失败弹窗只能出现一个,文字提示tips可以出现无数次
