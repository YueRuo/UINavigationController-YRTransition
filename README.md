UINavigationController-YRTransition
===================================

A category to help navigationController do pop and push animation


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
因此我额外手工处理了两个类型CoverIn和CoverReveal（类似presentViewController的效果），来使得我这个category继续工作。  

需要注意的是：如果使用这两个手工处理的类型，当使用NavigationBar时，需要关闭VC的iOS7特性

	self.edgesForExtendedLayout=false;
否则会有显示效果偏移的问题。(PS：个人一直不使用原生NavigationBar，因此无这问题)

当然，在iOS7下还是推荐使用更新的API去处理转场动画，但是目前来看，我的这个category依然还可以用上一阵子，因此开源出来，希望能对大家有所帮助。  
也欢迎大家给出意见，或是想出更好的办法能保留类似的api来实现iOS7下用新API的转场处理。
