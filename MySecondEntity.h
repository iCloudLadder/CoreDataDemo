//
//  MySecondEntity.h
//  CoreDataDemo
//
//  Created by syweic on 14-8-26.
//  Copyright (c) 2014年 ___iSoftStone___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;


@interface MySecondEntity : NSManagedObject

@property (nonatomic, strong) NSString *oneAttribute;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) Person *onePerson;


@end
