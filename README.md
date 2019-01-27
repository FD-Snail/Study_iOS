# Study_iOS


### 1.navigation
- 简介  
	使用WKNavigationBarTransition可以为每个ViewController的NavigationBar设置自己的颜色、透明度、以及隐藏/显示，并且不同样式的NavigationBar在进行push或者pop时，动画过度和谐美观。
	
- 实现原理：
	1. 系统的NavigationBar是全局的。所以只要更改就把所有的都改掉了，一个应用中多个页面的NavigationBar都不一致的情况就会比较繁琐。所以就自定义NavigationBar使每一个页面都有一个独立的NavigationBar。
	2. 自定义NavigationBar:有背景ImageView和下方的阴影ImageView。当设置NavigationBar背景色和阴影色及图片的时候只要相应的对这两个imageView进行设置。
	3. 写一个NavigationController的分类。主要是使用方法交换使得push响应自己的的方法，为push过去的navi保持上一个navi的属性。
	4. 写一个ViewController的分类。在layoutsubViews添加自定义的navigationBar。使用方法交换把原来设置系统navigationBar的颜色，下划线的方法交换设置自定义的bar的颜色。
	5. 总结：主要的思想就是给每一个UIViewController一个类似navigationbar的View。这个View只能更改背景色背景图，下划线的阴影色和阴影图。使用方法交换来实现更改系统navigationBar的背景和阴影来实现修改这个自定义View的背景和阴影。push一样的道理。使用自定义的push方法。其他的item，title什么的还是使用系统的navigationBar上面的东西。

- 后期引用:
	1. 引用：`#import "CFYNavigationBarTransition.h"`，  
	2. 调用一下接口改变navigationBar的颜色，调用:`[viewController wk_setNavigationBarBackgroundColor:]`  
	3. 改变navigationBar的背景图，调用:`[viewController wk_setNavigationBarBackgroundImage:]`  
	4. 改变navigationBar的透明度，调用:`[viewController wk_setNavigationBarAlpha:]`
	5. 改变navigationBar的ShadowImage，调用:`[viewController wk_setNavigationBarShadowImage:]`
	6. 改变navigationBar的ShadowImage的BackgroundColor，调用:`[viewController wk_setNavigationBarShadowImageBackgroundColor:]`
	7. 隐藏/显示则直接调用UINavigationController中原生的设置NavigationBar隐藏的方法`[navigationController setNavigationBarHidden:]`或`[navigationController setNavigationBarHidden:animated:]`