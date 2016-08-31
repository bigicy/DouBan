//
//  CartonViewController.m
//  作业
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CartonViewController.h"
#import "CartonModel.h"
#import "CartonCell.h"
#import "GDataXMLNode.h"

@interface CartonViewController ()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSString *string;
@property (nonatomic,strong)CartonModel *model;
@property (nonatomic,strong)NSMutableDictionary *dic;

@end

@implementation CartonViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}

- (void)analyseData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Cartoon.xml" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict;
{
    if ([elementName isEqualToString:@"AlbumInfo"]) {
        self.model = [[CartonModel alloc]init];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
self.string = string;
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName;
{
    if ([elementName isEqualToString:@"name"]||[elementName isEqualToString:@"desc"]) {
        [self.dic setObject:_string forKey:elementName];
        [self.model setValuesForKeysWithDictionary:_dic];
    }
    if ([elementName isEqualToString:@"AlbumInfo"]){
        [self.dataArray addObject:_model];
        NSLog(@"%@",_model.desc);
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
   
}


- (void)analyseDomData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Cartoon.xml" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
     GDataXMLDocument *documents = [[GDataXMLDocument alloc]initWithData:data options:0 error:&error];
    GDataXMLElement *rootElememt = documents.rootElement;
    NSArray *array1 = rootElememt.children;
    for ( GDataXMLElement *results in array1) {
        NSArray *array2 = results.children;
        for (GDataXMLElement *AlbumInfo in array2) {
            NSArray *array3 = AlbumInfo.children;
            for (GDataXMLElement *childrenElement in array3) {
                if ([childrenElement.name isEqualToString:@"desc"]||[childrenElement.name isEqualToString:@"name"]) {
                    [self.dic setValue:childrenElement.stringValue forKey:childrenElement.name];
                    NSLog(@"%@",childrenElement.stringValue);
                   self.model = [[CartonModel alloc]init];
                    [_model setValuesForKeysWithDictionary:_dic];
                    
                }
            }[self.dataArray addObject:_model];
        }
    }
    
    

}


- (void)setupTabview
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"CartonCell" bundle:nil] forCellReuseIdentifier:@"CartonCell"];
    [self.view addSubview:tableView];
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 10000;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartonCell" forIndexPath:indexPath];
    CartonModel *model = _dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.descLabel.text = model.desc;
    return cell;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//  [self analyseData];
    
    [self analyseDomData];
    [self setupTabview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
