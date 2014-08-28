//
//  Person.h
//  CoreDataDemo
//
//  Created by syweic on 14-8-26.
//  Copyright (c) 2014年 ___iSoftStone___. All rights reserved.
//

#import <CoreData/CoreData.h>
@class MySecondEntity;

@interface Person : NSManagedObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, strong) MySecondEntity *sec;

@end
