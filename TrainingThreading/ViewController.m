//
//  ViewController.m
//  TrainingThreading
//
//  Created by Fabian Celdeiro on 11/4/14.
//  Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import "ViewController.h"
#import "OperationManager.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *viewToAnimate;
@property (nonatomic,strong) CABasicAnimation *animation;
@property (nonatomic,strong) OperationManager * operationManager;

@end

@implementation ViewController

#pragma mark - Init

-(void) awakeFromNib{
    [super awakeFromNib];
    self.operationManager = [[OperationManager alloc] init];
}

#pragma mark - ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
  //  self.concurrentQueue = dispatch_queue_create("com.mercadolibre.training", DISPATCH_QUEUE_CONCURRENT);
    
    
    
    UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    myView.backgroundColor = [UIColor redColor];
    self.viewToAnimate = myView;
    [self.view addSubview:myView];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = [NSNumber numberWithDouble:self.viewToAnimate.bounds.size.width / 2];
    animation.toValue = [NSNumber numberWithDouble:self.view.bounds.size.width - self.viewToAnimate.frame.size.width/2];
    animation.duration = 1.0;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.autoreverses = YES;
    animation.repeatCount = NSIntegerMax;
    
    self.animation = animation;
    
    
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.viewToAnimate.layer removeAllAnimations];

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
   __block  CFTimeInterval startTime = CACurrentMediaTime();
    
   __block CFTimeInterval endTimeMainThread = CGFLOAT_MAX;

    NSAssert(self.operationManager, @"El operation manager debe estar creado");
    [self.operationManager startOperationsWithCompletitionBlock:^(BOOL finished) {
        
        
        if (endTimeMainThread == CGFLOAT_MAX){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"=(!" message:@"Me bloqueaste el main thread!" delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles:nil];
            
            [alert show];
            return;
        }
        if (!finished){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UPS!" message:@"No terminó bien, faltan valores!" delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles:nil];
            
            [alert show];
        }
        else{
            
            CFTimeInterval endTime = CACurrentMediaTime();
            CFTimeInterval totalRunTime = endTime - startTime;
            
            NSLog(@"Total Runtime: %g s", endTime - startTime);
            
            if (totalRunTime > 10){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Casii!" message:@"Casi casi pero muuuy lento!" delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles:nil];
                
                [alert show];
            
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"Perfecto!" delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles:nil];
            
                [alert show];
            }
        }
    }];
    
    
    endTimeMainThread = CACurrentMediaTime();
    
    [self animateStuff];


}


#pragma mark - Custom methods


#pragma mark - Animations

-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    self.animation.fromValue = [NSNumber numberWithDouble:self.viewToAnimate.bounds.size.width / 2];
    self.animation.toValue = [NSNumber numberWithDouble:size.width - self.viewToAnimate.frame.size.width/2];

    [self animateStuff];
  
}
-(void) animateStuff{
    
    
    [self.viewToAnimate.layer addAnimation:self.animation forKey:@"basic"];
    self.viewToAnimate.layer.position = CGPointMake(0, 100);
    
}


#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
