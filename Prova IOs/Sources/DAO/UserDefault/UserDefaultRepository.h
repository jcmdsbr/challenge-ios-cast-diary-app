//
//  UserDefaultRepository.h
//  Prova IOs
//
//  Created by Cast Group on 09/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultRepository : NSObject

+(instancetype) sharedInstance;

@property (nonatomic, assign) NSString *nomeUsuario;

@end
