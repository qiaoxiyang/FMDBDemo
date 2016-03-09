//
//  XYDBMain.m
//  数据缓存
//
//  Created by xiyang on 16/3/8.
//  Copyright © 2016年 xiyang. All rights reserved.
//

#import "XYDBMain.h"
#import "FMDB.h"
#import "XYContactsModel.h"
@interface XYDBMain ()

@property (nonatomic, retain) FMDatabase *database;

//@property (nonatomic, copy) NSString *databaseName;
@end


@implementation XYDBMain


#pragma mark - Public

+(instancetype)sharedDBMainWithName:(NSString *)dbName{
    static XYDBMain *dbmain = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       
        dbmain = [[XYDBMain alloc] init];
        [dbmain configurationDataBase:dbName];
    });
    
    return dbmain;
    
}

-(BOOL)createTableWithName:(NSString *)tableName paramters:(NSDictionary *)param{
    
    NSArray *keysArray = [param allKeys];
    NSArray *valuesArray = [param allValues];

    //判断一下valuesArray是否是数据库中的数据类型
    
    NSArray *sqlTypeArray = @[@"int",@"float",@"char",@"varchar",@"text",@"integer",@"date",@"time"];
    int correct = 0;
    for (NSString *value in valuesArray) {
        
        for (NSString *sqlTypeStr in sqlTypeArray) {
            if ([value isEqualToString:sqlTypeStr]) {
                correct++;
                break;
            }
        }
    }
    
    if (correct!=valuesArray.count) {
        NSLog(@"sql数据类型错误");
        return NO;
    }
    //拼接keys values
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i=0; i<keysArray.count; i++) {
        
        NSString *keys_values = [NSString stringWithFormat:@"%@ %@",keysArray[i],valuesArray[i]];
        [muArray addObject:keys_values];

    }
    
    NSString *keyTypeString = [muArray componentsJoinedByString:@","];
    
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@(%@);",tableName,keyTypeString];
    
    return  [self.database executeUpdate:sqlStr];
}

-(BOOL)dropTableWithName:(NSString *)tableName{
    NSString *sqlStr = [NSString stringWithFormat:@"drop table %@;", tableName];
    
    return [self.database executeUpdate:sqlStr];
}


-(BOOL)insertOneDataOnTable:(NSString *)tableName model:(XYContactsModel *)model{
    
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@ (name,age) values(?,?);",tableName];
    
    return [self.database executeUpdate:sqlStr,model.name,model.age];
}


-(BOOL)deleteOneDataFromTable:(NSString *)tableName model:(XYContactsModel *)model{
    
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where name = ? and age = ?;",tableName];
    
    return [self.database executeUpdate:sqlStr,model.name,model.age];
}

-(BOOL)deleteAllDataFromTable:(NSString *)tableName{
    
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@;",tableName];
    return [self.database executeUpdate:sqlStr];
}


-(BOOL)updateOneDataWithTable:(NSString *)tableName model:(XYContactsModel *)model{
    
    NSString *sqlStr = [NSString stringWithFormat:@"update %@ set age = ? where name = ?;",tableName];
    return [self.database executeUpdate:sqlStr,model.age,model.name];
}

-(NSArray *)selecteFromTable:(NSString *)tableName name:(NSString *)name{
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ where name = ?;",tableName];
    FMResultSet *result = [self.database executeQuery:sqlStr,name];
    NSMutableArray *array = [NSMutableArray array];
    while (result.next) {
        
        XYContactsModel *model = [[XYContactsModel alloc] init];
        model.name = [result stringForColumn:@"name"];
        model.age = [result objectForColumnName:@"age"];
        [array addObject:model];
    }
    return array;
}


#pragma mark - Private

-(void)configurationDataBase:(NSString *)dbName{
    
    NSString *documentPath = [self documentPath];
    
    self.database = [FMDatabase databaseWithPath:[documentPath stringByAppendingPathComponent:dbName]];
    
    NSLog(@"数据库路径%@",[documentPath stringByAppendingPathComponent:dbName]);
    
//    self.databaseName = dbName;
    if (![self.database open]) {
        NSLog(@"数据库打开失败！");
        return;
    }
}

-(NSString *)documentPath{
    
   return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
}


















@end
