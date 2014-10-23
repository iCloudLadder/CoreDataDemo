//
//  MainViewController.m
//  CoreDataDemo
//
//  Created by syweic on 14-8-26.
//  Copyright (c) 2014年 ___iSoftStone___. All rights reserved.
//

#import "MainViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface MainViewController ()
{
    NSFetchRequest *_fetchRequest;
    NSFetchedResultsController *_frc;
    
    UITableView *_mainTableView;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:nil];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    // _mainTableView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_mainTableView];
    
    
    
    NSLog(@"%@",[appDelegate managedObjectContext]);
    
    NSLog(@"path = %@",NSHomeDirectory());
    
    
    _frc = [self setfrc];
    // [self setFetchRequest];

    // 添加
    // [self addOnePerson];
    

    // 查询
    [self selectPerson];

    // 继承
//    NSEntityDescription *des = [NSEntityDescription entityForName:@"ChildrenEntity" inManagedObjectContext:objectContext];
//    NSLog(@"des = %@",des.propertiesByName);

    NSLog(@"____________________________________________");
    // NSManagedObjectModel *model = objectModel;
    // NSLog(@"%@ - %@ - %@",model,[NSManagedObjectModel mergedModelFromBundles:nil],[NSManagedObjectModel modelByMergingModels:nil]);
    // NSLog(@"%@",model.fetchRequestTemplatesByName);
    
    // NSEntityDescription *des = [NSEntityDescription entityForName:@"ChildrenEntity" inManagedObjectContext:objectContext];
     // NSLog(@"%@ - %@",des.name,des.managedObjectClassName);
     // NSLog(@"%@",des.superentity);
//    [des.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"%@",[obj class]);
    
//    }];
//    NSManagedObject
//    NSPropertyDescription
    
}

-(void)setFetchRequest
{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name='云天河'"];
//    _fetchRequest.predicate = predicate;
}

-(NSFetchedResultsController *)setfrc
{
    if (_frc) {
        return _frc;
    }
    
    _fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MyFirstEntity"];
    
    // 包含 XX
    // NSString *str0 = [NSString stringWithFormat:@"name contains '%@'",@"1"];
    // 以 XX 开头
    // NSString *str1 = [NSString stringWithFormat:@"name BEGINSWITH '菱纱'"];
    // 以 XX 结束
    NSString *str2 = [NSString stringWithFormat:@"name endswith '4'"];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str2]; // @"tel='13022222222'"
    _fetchRequest.predicate = predicate;
    [_fetchRequest setPropertiesToFetch:@[@"name",@"tel"]];
    
    
    NSLog(@"%@",_fetchRequest.propertiesToFetch);
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"tel" ascending:YES];

    _fetchRequest.sortDescriptors = @[sort];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:_fetchRequest managedObjectContext:objectContext sectionNameKeyPath:nil cacheName:@"persons"];
    frc.delegate = self;
    
    NSError *error = nil;
    if (![frc performFetch:&error]) {
        NSLog(@"_frc error = %@",error);
    }
    return frc;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"query finished");
    NSLog(@"sections = %@",controller.sections);
}



// 添加 数据
-(void)addOnePerson
{
    for (int i = 0; i < 5; i++) {
        Person *onePerson = [NSEntityDescription insertNewObjectForEntityForName:@"MyFirstEntity" inManagedObjectContext:objectContext];
        NSLog(@"onePerson = %@",onePerson);
        onePerson.name = [NSString stringWithFormat:@"天河 %d",i];
        onePerson.tel = @"13122222222";
        NSError *error = nil;
        if (![objectContext save:&error]) {
            NSLog(@"error = %@",error);
            abort();
        }
        NSLog(@"add success");
    }
   
    
}

-(void)selectPerson
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"MyFirstEntity"];
    
//    // 从第3+1条 信息开始取
//    [req setFetchOffset:3];
//    // 去除 3 条信息
//    [req setFetchLimit:3];
    //
    
    
    NSError *error = nil;
    NSArray *items = [objectContext executeFetchRequest:req error:&error];
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Person *person = obj;
        NSLog(@"name = %@",person.name);
        NSLog(@"tel = %@",person.tel);
//        // 修改
        if (idx == 1) {
            // [self updatePersonWith:person];
        }
//        // 删除
//        if (idx == 4) {
//            [self deletePersonWith:person];
//        }
        
    }];
    
//    NSLog(@"********************************************");
//    // NSLog(@"%@",req.entity);
//    NSLog(@"entityName = %@",req.entityName);
//    NSLog(@"predicate = %@",req.predicate);
//    NSLog(@"%@",req.havingPredicate);
//    NSLog(@"********************************************");
}

// 修改
-(void)updatePersonWith:(Person*)person
{
    person.name = @"云天河";
    NSError *error = nil;
    if (![objectContext save:&error]) {
        NSLog(@"update error = %@",error);
    }
    NSLog(@"update success");
}

// 删除
-(void)deletePersonWith:(Person*)person
{
    [objectContext deleteObject:person];
    NSError *error = nil;
    if (![objectContext save:&error]) {
        NSLog(@"delete error = %@",error);
    }
    NSLog(@"delete success");

}





#pragma mark tableView delegate and dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"sections = %@",_frc.sections);
    return [[_frc sections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_frc.sections objectAtIndex:section] numberOfObjects];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"person cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    Person *onePerson = [_frc objectAtIndexPath:indexPath];
    cell.textLabel.text = onePerson.name;
    cell.detailTextLabel.text = onePerson.tel;
    return cell;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
