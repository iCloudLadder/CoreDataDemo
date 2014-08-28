//
//  Common.h
//  CoreDataDemo
//
//  Created by syweic on 14-8-26.
//  Copyright (c) 2014年 ___iSoftStone___. All rights reserved.
//

#ifndef CoreDataDemo_Common_h
#define CoreDataDemo_Common_h

#define appDelegate (AppDelegate*)[UIApplication sharedApplication].delegate

#define objectContext [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext]

#define objectModel [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectModel]

#endif
