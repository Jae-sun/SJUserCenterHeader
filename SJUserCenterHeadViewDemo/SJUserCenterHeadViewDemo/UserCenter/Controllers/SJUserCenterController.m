


#import "SJUserCenterController.h"

#import "SJDynamicHeadView.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define HEAD_HEIGHT 235.0
#define NAV_HEIGHT 64.0

@interface SJUserCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SJDynamicHeadView *headView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat lastOffset;

@property (nonatomic, assign) BOOL isShowWave;

@end

@implementation SJUserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 数据初始化
- (void)setupDatas {
    self.lastOffset = HEAD_HEIGHT;
}

#pragma mark 视图初始化
- (void)setupViews {

    // tableView
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:(UITableViewStyleGrouped)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID_Cell"];
        
        self.tableView.contentInset = UIEdgeInsetsMake(HEAD_HEIGHT, 0, 0, 0);
        [self.view addSubview:self.tableView];
    }

    // self.headView
    {
        self.headView = [[SJDynamicHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEAD_HEIGHT)];
        self.headView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.headView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (0 == indexPath.section) {
        switch (indexPath.row) {
            case 0: {
                cell.imageView.image = [UIImage imageNamed:@"img_app"];
                cell.textLabel.text = @"关于APP";
            }
                break;
        }
    }
    else if (1 == indexPath.section) {
        switch (indexPath.row) {
            case 0: {
                cell.imageView.image = [UIImage imageNamed:@"img_cache"];
                cell.textLabel.text = @"清除缓存";
                
            }
                break;
            case 1: {
                cell.imageView.image = [UIImage imageNamed:@"img_feedback"];
                cell.textLabel.text = @"意见反馈";
            }
                break;
            default:
                break;
        }
    }
    else if (2 == indexPath.section) {
        switch (indexPath.row) {
            case 0: {
                cell.imageView.image = [UIImage imageNamed:@"img_version"];
                cell.textLabel.text = @"版本更新";
            }
                break;
            default:
                break;
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   
    if (self.isShowWave) {
         [self.headView.waveView starWave];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
     CGFloat offsetY = scrollView.contentOffset.y;
    
    if (fabs(offsetY) > HEAD_HEIGHT) {
        self.isShowWave = YES;
    }
    else {
        self.isShowWave = NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.headView.waveView stopWave];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // contentOffset.y 为负值
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat height = HEAD_HEIGHT - (self.lastOffset + offsetY);

    if (height < NAV_HEIGHT) {
        height = NAV_HEIGHT;
        self.headView.navBar.alpha = 1;
    }
    else {
        self.headView.navBar.alpha = 1 - height / HEAD_HEIGHT;
    }

    self.headView.frame  = CGRectMake(0, 0, self.headView.frame.size.width, height);
    self.headView.imgView.frame = CGRectMake(0, 0, self.headView.frame.size.width, height);
}


@end
