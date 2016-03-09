//
//  XYDBMain.h
//  数据缓存
//
//  Created by xiyang on 16/3/8.
//  Copyright © 2016年 xiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYContactsModel;
@interface XYDBMain : NSObject
/**
 *  创建数据库
 *
 *  @param dbname 数据库名
 *
 *  @return 返回XYDBMain实例
 */
+(instancetype)sharedDBMainWithName:(NSString *)dbName;


/**
 *  创建表
 *
 *  @param tableName 表名
 *  @param param     表中的 键名和类型  ⚠️该字典中的key为表中的键名，value为表中的类型
 *
 *  @return 创建表是否成功
 */
-(BOOL)createTableWithName:(NSString *)tableName paramters:(NSDictionary *)param;

/**
 *  删除一张表
 *
 *  @param tableName 表名
 *
 *  @return 删除是否成功
 */
-(BOOL)dropTableWithName:(NSString *)tableName;


/**
 *  向表中插入一条数据
 *
 *  @param tableName 表名
 *  @param model     插入数据的模型 ，改模型可以根据工程需要进行修改
 *
 *  @return 插入数据是否成功
 */
-(BOOL)insertOneDataOnTable:(NSString *)tableName model:(XYContactsModel *)model;

/**
 *   删除一条数据
 *
 *  @param tableName 表名
 *  @param model     插入数据的模型 ，改模型可以根据工程需要进行修改
 *
 *  @return 删除是否成功
 */
-(BOOL)deleteOneDataFromTable:(NSString *)tableName model:(XYContactsModel *)model;

/**
 *   删除表中的所有数据
 *
 *  @param tableName 表名
 *
 *  @return 删除是否成功
 */
-(BOOL)deleteAllDataFromTable:(NSString *)tableName;


/**
 *  更改一条数据
 *
 *  @param tableName 表名
 *  @param model     插入数据的模型 ，改模型可以根据工程需要进行修改
 *
 *  @return 更改是否成功
 *  ⚠️具体情况请根据什么条件更替什么值，请更改sql语句实现你想要的，本🌰中是根据名字更改年龄
 */
-(BOOL)updateOneDataWithTable:(NSString *)tableName model:(XYContactsModel *)model;


/**
 *  查询数据
 *
 *  @param tableName 表名
 *  @param name      根据名称进行查询
 *
 *  @return 查询结果
 */
-(NSArray *)selecteFromTable:(NSString *)tableName name:(NSString *)name;




@end
