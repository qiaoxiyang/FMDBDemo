//
//  ViewController.m
//  FMDBDemo
//
//  Created by xiyang on 16/3/9.
//  Copyright © 2016年 xiyang. All rights reserved.
//


#import "ViewController.h"
#import "XYDBMain.h"
#import "XYContactsModel.h"

@interface ViewController ()


@property (nonatomic, retain) XYDBMain *dbmain;
@property (nonatomic, retain) XYContactsModel *model;
@property (nonatomic, copy)   NSString *tablename;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dbmain = [XYDBMain sharedDBMainWithName:@"nongjibang.sqlite"];
    
    NSDictionary *dict = @{
                           @"name" :   @"text",
                           @"age"  :   @"integer"
                           };
    
    _tablename = @"contacts";
    
    [_dbmain createTableWithName:_tablename paramters:dict];
    
    
    _model = [[XYContactsModel alloc] init];
    _model.name = @"zhangsan";
    _model.age = @"23";
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addOneDataClick:(UIButton *)sender {
    //增
    [_dbmain insertOneDataOnTable:_tablename model:_model];
    
}

- (IBAction)deleteOneDataClick:(UIButton *)sender {
    
    //删
    [_dbmain deleteOneDataFromTable:_tablename model:_model];
    
}

- (IBAction)updateOneDataClick:(UIButton *)sender {
    
    
    
    XYContactsModel *contactModel = [[XYContactsModel alloc] init];
    contactModel.name = @"zhangsan";
    contactModel.age = @"40";
    [_dbmain updateOneDataWithTable:_tablename model:contactModel];
    
}

- (IBAction)searchDataClick:(UIButton *)sender {
    
    
    NSArray *array = [_dbmain selecteFromTable:_tablename name:@"zhangsan"];
    for (XYContactsModel *model in array) {
        
        NSLog(@"%@",model.name);
        NSLog(@"%@",model.age);
        
    }
    
    
}
@end
