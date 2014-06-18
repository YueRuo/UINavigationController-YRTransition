//
//  RootViewController.m
//  YRTransitionDemo
//
//  Created by 王晓宇 on 14-6-18.
//  Copyright (c) 2014年 YueRuo. All rights reserved.
//

#import "RootViewController.h"
#import "UINavigationController+YRTransition.h"//import this


@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
    NSArray *_transitionNameArray;
}
@property (assign,nonatomic) BOOL needBack;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout=false;//attention，if use navigatinBar，you need this line,or will not work ok when use YRTransitionTypeCoveIn & YRTransitionTypeCoveReavel
    }


    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    [self.view addSubview:_tableView];
    
    
    _transitionNameArray=@[@"Fade-淡入淡出",@"Push-推入",@"MoveIn-上层覆盖进入,iOS7下带淡入淡出效果",@"Reveal-上层拉出,iOS7下带淡入淡出效果",@"CoverIn-上层覆盖进入,无淡入淡出效果",@"CoverReveal-上层拉出,无淡入淡出效果",@"Cube-立方体",@"SuckEffect-吸收",@"OglFlip-翻转",@"RippleEffect-水波纹",@"PageCurl-翻页",@"PageUnCurl-反翻页",@"CameraIrisHollowOpen-镜头开",@"CameraIrisHollowClose-镜头关"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_transitionNameArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=_transitionNameArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RootViewController *otherViewController=[[RootViewController alloc]initWithNibName:nil bundle:nil];
    [otherViewController.view setBackgroundColor:[UIColor colorWithRed:0.3 green:0.8 blue:0.4 alpha:1]];
    [otherViewController.navigationItem setTitle:@"Second"];
    otherViewController.needBack=true;
    
    YRTransitionType type=(YRTransitionType)(indexPath.row+1);
    if (!self.needBack) {//push
//    [self.navigationController pushViewController:otherViewController withYRTransition:[YRTransition transitionWithType:type]];
//    [self.navigationController pushViewController:otherViewController withYRTransition:[YRTransition transitionWithType:type duration:0.35]];
        [self.navigationController pushViewController:otherViewController withYRTransition:[YRTransition transitionWithType:type direction:YRTransitionDirection_FromLeft duration:1.35]];
        
    }else{//pop
        [self.navigationController popViewControllerWithYRTransition:[YRTransition transitionWithType:type direction:YRTransitionDirection_FromRight duration:1.2]];
    
    }
}
@end
