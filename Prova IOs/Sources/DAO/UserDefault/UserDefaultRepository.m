//
//  UserDefaultRepository.m
//  Prova IOs
//
//  Created by Cast Group on 09/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "UserDefaultRepository.h"

static NSString *kNomeUsuario = @"kNomeUsuario";

@implementation UserDefaultRepository

+ (instancetype)sharedInstance {
    
    static UserDefaultRepository *shared = nil;
    static dispatch_once_t oneToken;
    
    
    dispatch_once(&oneToken, ^{
        shared = [[UserDefaultRepository alloc] init];
    });
    
    return shared;
}


- (NSUserDefaults*)defaults {
    return [NSUserDefaults standardUserDefaults];
}

- (void)setNomeUsuario:(NSString *)nomeUsuario {
    
    [[self defaults] setObject: nomeUsuario forKey:kNomeUsuario];
    
}

-(NSString *)nomeUsuario {
    
    return [[self defaults] objectForKey:kNomeUsuario];
}

@end

