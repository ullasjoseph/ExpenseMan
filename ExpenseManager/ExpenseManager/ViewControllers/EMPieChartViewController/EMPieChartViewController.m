//
//  EMPieChartViewController.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 09/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMPieChartViewController.h"
#import "EMPListManager.h"
#import "EMCoredataManager.h"

@interface EMPieChartViewController ()

@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
//@property (nonatomic,strong) NSMutableArray *valueArray2;
//@property (nonatomic,strong) NSMutableArray *colorArray2;
@property (nonatomic,strong) PieChartView *pieChartView;
@property (nonatomic,strong) UIView *pieContainer;
@property (nonatomic)BOOL inOut;
@property (nonatomic,strong) UILabel *selLabel;

@end

#define PIE_HEIGHT 280

@implementation EMPieChartViewController

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
    [self setUpPiChart];

}


- (void)viewDidAppear:(BOOL)animated {
    [self.pieChartView reloadChart];
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


#pragma mark - IBActions

- (IBAction)btnBackClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Utils

- (void)setUpPiChart {
    
    self.inOut = YES;
    categories = [EMPListManager getPlistArray:@"ExpenseCategories"];
    
    self.valueArray = [[NSMutableArray alloc] init];
    self.colorArray = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSString *category in categories) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date >= %@) && (category == %@)", _startDate, category];
        double value = ([[EMCoredataManager getSumOfExpense:predicate] doubleValue]/[_totalExpense doubleValue])*10;
        [self.valueArray addObject:[NSNumber numberWithDouble:value]];
        [self.colorArray addObject:[UIColor colorWithHue:((i/8)%20)/20.0+0.02 saturation:(i%8+3)/10.0 brightness:91/100.0 alpha:1]];
        i++;
    }
//    self.valueArray = [[NSMutableArray alloc] initWithObjects:
//                       [NSNumber numberWithInt:20],
//                       [NSNumber numberWithInt:20],
//                       [NSNumber numberWithInt:20],
//                       [NSNumber numberWithInt:10],
//                       [NSNumber numberWithInt:10],
//                       [NSNumber numberWithInt:40],
//                       nil];
//    self.valueArray2 = [[NSMutableArray alloc] initWithObjects:
//                        [NSNumber numberWithInt:3],
//                        [NSNumber numberWithInt:2],
//                        [NSNumber numberWithInt:2],
//                        nil];
    
//    self.colorArray = [NSMutableArray arrayWithObjects:
//                       [UIColor colorWithHue:((0/8)%20)/20.0+0.02 saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
//                       [UIColor colorWithHue:((1/8)%20)/20.0+0.02 saturation:(1%8+3)/10.0 brightness:91/100.0 alpha:1],
//                       [UIColor colorWithHue:((2/8)%20)/20.0+0.02 saturation:(2%8+3)/10.0 brightness:91/100.0 alpha:1],
//                       [UIColor colorWithHue:((3/8)%20)/20.0+0.02 saturation:(3%8+3)/10.0 brightness:91/100.0 alpha:1],
//                       [UIColor colorWithHue:((4/8)%20)/20.0+0.02 saturation:(4%8+3)/10.0 brightness:91/100.0 alpha:1],
//                       [UIColor colorWithHue:((5/8)%20)/20.0+0.02 saturation:(5%8+3)/10.0 brightness:91/100.0 alpha:1],
//                       nil];
//    self.colorArray2 = [[NSMutableArray alloc] initWithObjects:
//                        [UIColor purpleColor],
//                        [UIColor orangeColor],
//                        [UIColor magentaColor],
//                        nil];
    
    //add shadow img
    CGRect pieFrame = CGRectMake((self.containerView.frame.size.width - PIE_HEIGHT) / 2, 50-0, PIE_HEIGHT, PIE_HEIGHT);
    
    
    self.pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
    self.pieChartView.delegate = self;
    [self.pieContainer addSubview:self.pieChartView];
    [self.pieChartView setAmountText:[NSString stringWithFormat:@"%.2f$",[_totalExpense doubleValue]]];
    [self.containerView addSubview:self.pieContainer];
    
    //add selected view
    UIImageView *selView = [[UIImageView alloc]init];
    selView.image = [UIImage imageNamed:@"select.png"];
    selView.frame = CGRectMake((self.containerView.frame.size.width - selView.image.size.width/2)/2, self.pieContainer.frame.origin.y + self.pieContainer.frame.size.height, selView.image.size.width/2, selView.image.size.height/2);
    [self.containerView addSubview:selView];
    
    self.selLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, selView.image.size.width/2, 21)];
    self.selLabel.backgroundColor = [UIColor clearColor];
    self.selLabel.textAlignment = NSTextAlignmentCenter;
    self.selLabel.font = [UIFont systemFontOfSize:17];
    self.selLabel.textColor = [UIColor whiteColor];
    [selView addSubview:self.selLabel];
    [self.pieChartView setTitleText:@"Expense"];
    self.title = @"Expense";
    //    self.view.backgroundColor = [self colorFromHexRGB:@"f3f3f3"];
}

- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    self.selLabel.text = [NSString stringWithFormat:@"%@ : %2.2f%@",[categories objectAtIndex:index],per*100,@"%"];
}

@end
