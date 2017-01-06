/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/23.
 *    Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "SZCalendarPicker.h"
#import "SZCalendarCell.h"
#import "UIColor+ZXLazy.h"
#import "TianmushanAPI.h"
#import "TimeItem.h"

@interface CalendarBtn: UIButton
@end

@implementation CalendarBtn
- (void)setHighlighted:(BOOL)highlighted {}
@end



NSString *const SZCalendarCellIdentifier = @"cell";

@interface SZCalendarPicker ()

/**
 *  日期界面相关控件
 */
@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic , weak) IBOutlet UILabel *monthLabel;
@property (nonatomic , weak) IBOutlet UIButton *previousButton;
@property (nonatomic , weak) IBOutlet UIButton *nextButton;
@property (nonatomic , strong) NSArray *weekDayArray;
@property (nonatomic , strong) UIView *mask;

/**
 *  时间界面控件
 */
@property (weak, nonatomic) IBOutlet UICollectionView *timeCollection;

@property (weak, nonatomic) IBOutlet UIView *minuteView;


/**
 *  内容视图
 */
@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UIView *timeView;


/**
 *  日期按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

/**
 *  时间按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

/**
 *  选中的时间
 */
@property (nonatomic, weak) UIButton *selectMinute; //选中的多少分
@property (nonatomic, strong) NSString *selectHour; //选中的几点

@property (nonatomic, assign) NSInteger year; //选中的年

@property (nonatomic, assign) NSInteger month; //选中的yue

@property (nonatomic, assign) NSInteger day; ///选中的天

/**
 *  上一个选中的按钮
 */
@property (weak, nonatomic) UIButton *lastButton;


/**
 *  时间数据
 */
@property (nonatomic, strong) NSArray *hours;

@end

@implementation SZCalendarPicker


static NSString *timeCell = @"timeItem";

- (NSArray *)hours {
    if (!_hours) {
        _hours = @[@"08:00", @"09:00", @"10:00", @"11:00", @"12:00", @"13:00",
                   @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00",
                   @"20:00", @"21:00", @"22:00", @"23:00", @"00:00", @"01:00",
                   @"02:00", @"03:00", @"04:00", @"05:00", @"06:00", @"07:00"];
    }
    return _hours;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addTap];
    [self addSwipe];
    [self show];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[SZCalendarCell class] forCellWithReuseIdentifier:SZCalendarCellIdentifier];
     _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    _selectHour = @"";
    
    self.dateButton.backgroundColor =  [UIColorFromRGB(0x30CDAD) colorWithAlphaComponent:0.8];
    self.timeButton.backgroundColor =  [UIColorFromRGB(0x30CDAD) colorWithAlphaComponent:0.6];
    self.timeCollection.backgroundColor = [UIColor whiteColor];
    self.timeCollection.bounces = NO;
    
    //默认选中日期
    [self dateBtnClick];
    
    //布局时间界面
    [self setUpHourCollectionView];
    
    //布局几点界面
    [self setUpminuteView];
}

/**
 *  布局时间的view
 */
- (void)setUpHourCollectionView {
    
    NSLog(@"%f",_timeCollection.frame.size.height);
    

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (SCREEN_WIDTH - 47) / 6;
    CGFloat itemH = (CreateTideCanlenderHeight-2*44-56)/4;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _timeCollection.collectionViewLayout = flowLayout;
    _timeCollection.scrollEnabled = NO;
    [_timeCollection registerClass:[TimeItem class] forCellWithReuseIdentifier:timeCell];
}

/**
 *  布局几点的view
 */
- (void)setUpminuteView {
    CGFloat btnMargin = 2;
    CGFloat btnW = (SCREEN_WIDTH - btnMargin * 13) / 12;
    CGFloat btnH = 48;
    CGFloat btnY = (_minuteView.frame.size.height - btnH) * 0.5;
    for (int i = 0; i < 12; i++) {
        CalendarBtn *btn = [[CalendarBtn alloc] initWithFrame:CGRectMake(btnMargin + i * (btnW + btnMargin), btnY, btnW, btnH)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectMinute:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0.251 green:0.694 blue:1.000 alpha:1.000]] forState:UIControlStateSelected];
        if (i % 3 == 0) {
            [btn setTitle:[NSString stringWithFormat:@"%d", i * 5] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor colorWithRed:0.220 green:0.235 blue:0.255 alpha:1.000] forState:UIControlStateNormal];
        } else {
            [btn setTitle:[NSString stringWithFormat:@"%d", i * 5] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
            [btn setTitleColor:[UIColor colorWithRed:0.510 green:0.576 blue:0.620 alpha:1.000] forState:UIControlStateNormal];
        }
        [_minuteView addSubview:btn];
        
    }
}
/**
 *  选择了多少分
 *
 *  @param btn <#btn description#>
 */
- (void)selectMinute:(UIButton *)btn {
    if (_selectMinute == btn) return;
    btn.selected = YES;
    _selectMinute.selected = NO;
    _selectMinute = btn;
    
}

/**
 *  布局日期
 */
- (void)customInterface
{
    CGFloat itemWidth = _collectionView.frame.size.width / 7;
    CGFloat itemHeight = _collectionView.frame.size.height / 7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [_collectionView setCollectionViewLayout:layout animated:YES];
    
    
}

/**
 *  日期按钮点击
 */
- (IBAction)dateBtnClick {
    
    self.lastButton.backgroundColor = [UIColorFromRGB(0x30CDAD) colorWithAlphaComponent:0.6];
    
    self.dateButton.backgroundColor =  [UIColorFromRGB(0x30CDAD) colorWithAlphaComponent:0.8];
    
    self.lastButton = self.dateButton;
    
    self.dateView.hidden = NO;
    self.timeView.hidden = YES;
    
}

/**
 *  时间按钮点击
 */
- (IBAction)timeBtnClick {
    
    self.lastButton.backgroundColor = [UIColorFromRGB(0x30CDAD) colorWithAlphaComponent:0.6];
    
    self.timeButton.backgroundColor =  [UIColorFromRGB(0x30CDAD) colorWithAlphaComponent:0.8];
    
    self.lastButton = self.timeButton;
    
    self.dateView.hidden = YES;
    self.timeView.hidden = NO;
}

/**
 *  完成按钮的点击
 */
- (IBAction)finishButtonClick {
    
    
    if (self.calendarBlock) {
        
        NSString *miniutStr = nil;
        
       
        if (_selectMinute.titleLabel.text.length<2) {
            
            if (_selectMinute!=nil) {
                miniutStr = [NSString stringWithFormat:@"0%@",_selectMinute.titleLabel.text];

            }else{
                miniutStr = @"00";
            }
            
        }else{
            miniutStr = _selectMinute.titleLabel.text;
        }
        
        if (self.year>0 && self.month>0 && self.day>0) {
            
            self.calendarBlock(self.day, self.month, self.year,self.selectHour,miniutStr?miniutStr:@"00");

        }else{
            
            self.calendarBlock(0, 0, 0,self.selectHour,miniutStr?miniutStr:@"00");

        }
    }
    
    [self hide];
    
}


- (void)setDate:(NSDate *)date
{
    _date = date;
    [_monthLabel setText:[NSString stringWithFormat:@"%.2zd-%zd",[self month:date],[self year:date]]];
    [_collectionView reloadData];
}

#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
 
    if (collectionView == _timeCollection) {
        
        return 1;
   
    }else{
       
        return 2;

    }

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _timeCollection) {
        
        return self.hours.count;
    }else
    {
        if (section == 0) {
            return _weekDayArray.count;
        } else {
            return 42;
        }
        
    }
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //如果是时间
    if (collectionView == _timeCollection) {
        
        TimeItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:timeCell forIndexPath:indexPath];
        item.hour = self.hours[indexPath.item];
//        if (indexPath.row==0) {
//            item.isSelect = YES;
//        }
        return item;
        
        
    }
    
        SZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZCalendarCellIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [cell.dateLabel setText:_weekDayArray[indexPath.row]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#30cdad"]];
        } else {
            NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
            NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
            
            NSInteger day = 0;
            NSInteger i = indexPath.row;
            
            if (i < firstWeekday) {
                [cell.dateLabel setText:@""];
                
            }else if (i > firstWeekday + daysInThisMonth - 1){
                [cell.dateLabel setText:@""];
            }else{
                day = i - firstWeekday + 1;
                [cell.dateLabel setText:[NSString stringWithFormat:@"%zd",day]];
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
                
                //this month
                if ([_today isEqualToDate:_date]) {
                    if (day == [self day:_date]) {
                        [cell.dateLabel setTextColor:[UIColor redColor]];
                    } else if (day > [self day:_date]) {
                        //                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cbcbcb"]];
                    }
                } else if ([_today compare:_date] == NSOrderedAscending) {
                    //                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cbcbcb"]];
                }
            }
        }
        return cell;
        
   
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _timeCollection) {
        
        
        //拿到当前所有的cell
        NSArray *items = [collectionView visibleCells];
        
        for (TimeItem *item in items) {
            item.isSelect = NO;
        }
        
        TimeItem *item = (TimeItem*)[collectionView cellForItemAtIndexPath:indexPath];
        
        item.isSelect = YES;
        
        NSString *hour = self.hours[indexPath.item];
        
        if (hour) {
            
            hour = [hour substringWithRange:NSMakeRange(0, 2)];
            
        }
        
        _selectHour = hour;
        NSLog(@"======%@",hour);
        
        
    }else{
        
        
        
        NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        day = i - firstWeekday + 1;
        
        self.day =day;
        self.month = [comp month];
        self.year = [comp year];
        
        //选择日期完成跳转到 选择时间界面
        [self timeBtnClick];
        
    }
  
}

- (IBAction)previouseAction:(UIButton *)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^(void) {
        self.date = [self lastMonth:self.date];
    } completion:nil];
}

- (IBAction)nexAction:(UIButton *)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^(void) {
        self.date = [self nextMonth:self.date];
    } completion:nil];
}

+ (instancetype)showOnView:(UIView *)view
{
    SZCalendarPicker *calendarPicker = [[[NSBundle mainBundle] loadNibNamed:@"SZCalendarPicker" owner:self options:nil] firstObject];
    calendarPicker.mask = [[UIView alloc] initWithFrame:view.bounds];
    calendarPicker.mask.backgroundColor = [UIColor blackColor];
    calendarPicker.mask.alpha = 0.3;
    [view addSubview:calendarPicker.mask];
    [view addSubview:calendarPicker];
    return calendarPicker;
}

- (void)show
{
    self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL isFinished) {
        [self customInterface];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformTranslate(self.transform, 0, - (self.frame.size.height+100));
        self.mask.alpha = 0;
    } completion:^(BOOL isFinished) {
        [self.mask removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}

- (void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.mask addGestureRecognizer:tap];
}
@end
