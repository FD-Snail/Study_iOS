# Study_iOS


### 1.navigation
- 简介  
	使用WKNavigationBarTransition可以为每个ViewController的NavigationBar设置自己的颜色、透明度、以及隐藏/显示，并且不同样式的NavigationBar在进行push或者pop时，动画过度和谐美观。
	
- 实现原理：
	1. 实现原理

- 后期引用:
	1. 引用：`#import "CFYNavigationBarTransition.h"`，  
	2. 调用一下接口改变navigationBar的颜色，调用:`[viewController wk_setNavigationBarBackgroundColor:]`  
	3. 改变navigationBar的背景图，调用:`[viewController wk_setNavigationBarBackgroundImage:]`  
	4. 改变navigationBar的透明度，调用:`[viewController wk_setNavigationBarAlpha:]`
	5. 改变navigationBar的ShadowImage，调用:`[viewController wk_setNavigationBarShadowImage:]`
	6. 改变navigationBar的ShadowImage的BackgroundColor，调用:`[viewController wk_setNavigationBarShadowImageBackgroundColor:]`
	7. 隐藏/显示则直接调用UINavigationController中原生的设置NavigationBar隐藏的方法`[navigationController setNavigationBarHidden:]`或`[navigationController setNavigationBarHidden:animated:]`