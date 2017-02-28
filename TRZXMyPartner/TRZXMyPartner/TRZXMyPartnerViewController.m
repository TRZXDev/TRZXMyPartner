//
//  TRZXMyPartnerViewController.m
//  TRZXMyPartner
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "TRZXMyPartnerViewController.h"
//#import "TRMyPerformanceViewController.h"
//#import "PersonalInformationVC.h"

#import "TRZXMyPartnerViewModel.h"
#import "TRZXMyPartnerModel.h"
#import "TRZXMyPartnerCell.h"
#import "TRZXDVSwitch.h"
#import "MJExtension.h"
#import "TRZXKit.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIDevice+MyPartner_Frame.h"


#define MPWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define MPHEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface TRZXMyPartnerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)TRZXDVSwitch *switcher;
@property (nonatomic,copy)NSString *totalPage;
@property (nonatomic,copy)NSString *pageNO;
@property (nonatomic,strong)UIImageView *noneImageView;

@property (nonatomic,copy)NSString *level;
@property (nonatomic,copy)NSString *countDelegates;//代理
@property (nonatomic,copy)NSString *countTenants;//运营商
@property (nonatomic,copy)NSString *countAllProxys;

@end

@implementation TRZXMyPartnerViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:RCDUmengNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addUI];
    self.level = @"1";
    [self loadData];
}

- (void)addUI
{
    self.title = self.titleString;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRZXMyPartnerCell" bundle:nil] forCellReuseIdentifier:@"TRZXMyPartnerCell"];
    [self.view addSubview:self.tableView];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
}

- (UIView *)headeView{
    UIView *view = nil;
    if ([UIDevice MyPartner_iPhonesModel]==iPhone5) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MPWIDTH, 53)];
    }else{
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MPWIDTH, 63)];
    }
    view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1];
    [view addSubview:self.switcher];
    
    NSString *regist = [NSString stringWithFormat:@"%@\n业务代表",self.countDelegates];
    NSString *auther = [NSString stringWithFormat:@"%@\n运营商",self.countTenants];
    NSArray *itemArr = @[regist,auther];
    [self.switcher changeLabelTextWithArrayString:itemArr];
    return view;
}

- (void)noneImageViewClick:(UITapGestureRecognizer *)tap{
    //    [_noneImageView removeFromSuperview];
    //    _noneImageView = nil;
    //    [self loadData];
    //我的业绩
    //    TRMyPerformanceViewController *myPerformance = [[TRMyPerformanceViewController alloc]init];
    //    [self.navigationController pushViewController:myPerformance animated:YES];
}

#pragma mark - 数据请求------------------------
- (void)loadDataWithIndex:(NSInteger)index
{
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    [self.tableView reloadData];
    switch (index) {
        case 0://业务代表
            self.level = @"1";
            break;
        case 1://运营商
            self.level = @"2";
            break;
        default:
            break;
    }
    [self loadData];
}


- (void)loadData{
    
    self.pageNO = @"1";
    self.tableView.mj_footer.hidden = YES;
    
    [TRZXMyPartnerViewModel myTeamLevel:self.level pageNo:self.pageNO success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            
            if (self.dataSource.count > 0) {
                [self.dataSource removeAllObjects];
            }
            
            self.countDelegates = dict[@"countDelegates"];
            self.countTenants = dict[@"countTenants"];
            self.totalPage = dict[@"totalPage"];
            self.countAllProxys = dict[@"countAllProxys"];
            
            
            NSArray *dataArray = dict[@"data"];
            if ( dataArray.count < 1) {
                
                [self.view addSubview:self.noneImageView];
                [self.view addSubview:[self headeView]];
            }else{
                
                [self.noneImageView removeFromSuperview];
                _noneImageView = nil;
                [self paseDataWithDict:dict];
                [self.view addSubview:[self headeView]];
            }
        }
        
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
        
    }];
    
    
}
- (void)loadMoreData{
    
    NSInteger page =  [self.pageNO integerValue];
    page ++;
    
    if (page > [self.totalPage integerValue]) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    self.pageNO = [NSString stringWithFormat:@"%ld",(long)page];
    [TRZXMyPartnerViewModel myTeamLevel:self.level pageNo:self.pageNO success:^(id json) {
        
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            [self paseDataWithDict:dict];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = NO;
        
    }];
    
}

- (void)paseDataWithDict:(NSDictionary *)dict{
    
    NSArray *dataArray = dict[@"data"];
    NSArray *modelArray = [TRZXMyPartnerModel mj_objectArrayWithKeyValuesArray:dataArray];
    [self.dataSource addObjectsFromArray:modelArray];
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRZXMyPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRZXMyPartnerCell" forIndexPath:indexPath];
    [self setupCellModel:self.dataSource[indexPath.row] andCell:cell];
    return cell;
}

- (void)setupCellModel:(TRZXMyPartnerModel *)model andCell:(TRZXMyPartnerCell *)cell{
    
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"展位图"]];
    cell.nameLabel.text = model.name;
    
    //    NSString *createDate = [self timeWithTimeIntervalString:model.createDate];
    NSString *updateData = [self timeWithTimeIntervalString:model.updateDate];
    
    //    if ([self.level isEqualToString:@"1"]) {
    //        //业务代表
    //        cell.subTitleLabel.text = @"";
    //    }else{
    if (model.company.length > 1 && model.post.length > 1) {
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@,%@",model.company,model.post];
    }else{
        cell.subTitleLabel.text = @"";
    }
    //    }
    
    
    cell.registerTimeLabel.text = updateData;
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TRZXMyPartnerModel *model = self.dataSource[indexPath.row];
    [self transToPersonalWithMid:model.ID];
    
}

#pragma mark - 跳转个人主页

- (void)transToPersonalWithMid:(NSString *)mid
{
    
//    if (![NSObject showCertificationTip:self]) {
//        
//        PersonalInformationVC * studentPersonal=[[PersonalInformationVC alloc]init];
//        studentPersonal.midStrr = mid;
//        studentPersonal.otherStr = @"1";
//        [self.navigationController pushViewController:studentPersonal animated:true];
//        
//    }
    
}



- (void)dealloc{
    
}
-(void)setRadius:(CGFloat)cornerRadius view:(UIView *)view{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    view.layer.shouldRasterize = YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - setter/getter------------------------------------------------------------------------
- (UITableView *)tableView
{
    if (!_tableView) {
        if ([UIDevice MyPartner_iPhonesModel]==iPhone5) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64+53, MPWIDTH, MPHEIGHT-64-53) style:UITableViewStylePlain];
        }else{
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64+63, MPWIDTH, MPHEIGHT-64-63) style:UITableViewStylePlain];
        }
        _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 105;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionIndexBackgroundColor=[UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor blackColor];
    }
    return _tableView;
}
//开关 切换切面
- (TRZXDVSwitch *)switcher
{
    if (!_switcher) {
        NSString *regist = [NSString stringWithFormat:@"%@\n业务代表",self.countDelegates];
        NSString *auther = [NSString stringWithFormat:@"%@\n合伙人",self.countTenants];
        
        NSArray *itemArr = @[regist,auther];
        
        _switcher = [[TRZXDVSwitch alloc] initWithStringsArray:itemArr];
        
        if ([UIDevice MyPartner_iPhonesModel]==iPhone5) {
            _switcher.frame = CGRectMake(10, 10, MPWIDTH -20, 30);
            [self setRadius:14 view:_switcher];
        }else{
            _switcher.frame = CGRectMake(10, 10, MPWIDTH -20, 41);
            [self setRadius:19 view:_switcher];
        }
        
        _switcher.sliderOffset = 1.0;
        _switcher.font = [UIFont systemFontOfSize:15];
        _switcher.backgroundColor = [UIColor whiteColor];
        _switcher.sliderColor = [UIColor colorWithRed:215.0/255.0 green:0/255.0 blue:15.0/255.0 alpha:1];
        _switcher.labelTextColorInsideSlider = [UIColor whiteColor];
        _switcher.labelTextColorOutsideSlider = [UIColor lightGrayColor];
        
        __weak __typeof(self)weakSelf = self;
        [self.switcher setPressedHandler:^(NSUInteger index) {
            
            [weakSelf loadDataWithIndex:index];
        }];
        
    }
    return _switcher;
}

- (UIImageView *)noneImageView{
    if (_noneImageView == nil) {
        if([UIDevice MyPartner_iPhonesModel]==iPhone5){
            _noneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,64+54, MPWIDTH, MPHEIGHT-64-54)];
        }else{
            _noneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,64+64, MPWIDTH, MPHEIGHT-64-64)];
        }
        _noneImageView.image = [UIImage imageNamed:@"tr_nocontent"];
        _noneImageView.userInteractionEnabled = YES;
        _noneImageView.contentMode = UIViewContentModeScaleAspectFill;
        _noneImageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noneImageViewClick:)];
        [_noneImageView addGestureRecognizer:tap];
    }
    return _noneImageView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
