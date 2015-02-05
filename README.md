UINavigationController-YRTransition
===================================

A category to help navigationController do pop and push animation


支持iOS4以上，对于iOS7之后有个别动画使用更高级API完成。  

在iOS7以前，我们经常使用CATransition完成push和pop的特殊动画
比如：

	
    CATransition *animation = [CATransition animation];
    animation.duration =0.35;
    [animation setRemovedOnCompletion:true];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromLeft;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController pushViewController:vc animated:false];
    
对此我做了这个navigationController的category来简化类似的操作，对于上面这种效果，只需要正常的push调用一句话

	[self.navigationController pushViewController:vc withYRTransition:[YRTransition transitionWithType:YRTransitionType_Fade duration:0.35]];
	
这个工具一直工作很好，直到iOS7出现后，有部分动画效果变得不一样了，我们发现对于如MoveIn和Reveal这一对动画来说，在动画过程中会添加类似渐变的效果，其中的一个vc的颜色会逐渐的变为navigationController的背景色（参见[http://stackoverflow.com/questions/19093688/catransition-for-segue-animation-pre-ios-7-style](http://stackoverflow.com/questions/19093688/catransition-for-segue-animation-pre-ios-7-style)）    
因此我额外处理了两个类型CoverIn和CoverReveal（类似presentViewController的效果），来使得我这个category继续工作。  
<br><br><br>
最新版的库保留之前的YRTransition，并接入了我后来做的iOS7之后的动画库YRVCTransition，使用了iOS7之后的更高级的API来进行个别效果，并且支持交互式操作（左滑可以拖动返回），所有效果中，Push、CoverIn和CoverReveal是支持高版本API的。`同时对于低于iOS7的系统也是支持的`

使用之前，导入`YRTransitionKit.h`头文件(库内部使用较多category实现完成，别导入错了)  
对于NavigationController，初始化后需要显式调用            
    
    [navigationController enableTransition];
    
才能使用相应的动画效果
并且对于modelViewController的动画也做了相应的封装，方便大家使用。


如果大家不想要使用左滑返回上一层的功能，