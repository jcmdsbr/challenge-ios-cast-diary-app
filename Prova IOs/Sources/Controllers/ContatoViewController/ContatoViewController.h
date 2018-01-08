//
//  ContatoViewController.h
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prova_IOs+CoreDataModel.h"

@interface ContatoViewController : UIViewController

@property (weak, nonatomic) Contato *contato;

@property (nonatomic) BOOL isAlterar;

@end
