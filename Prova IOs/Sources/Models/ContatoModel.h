//
//  ContatoModel.h
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContatoModel : NSObject

@property (nonatomic,weak) NSString *nome;
@property (nonatomic,weak) NSString *sobreNome;
@property (nonatomic,weak) NSDate *dataNascimeto;
@property (nonatomic,weak) NSString *enderecoCompleto;
@property (nonatomic,weak) NSString *cep;
@property (nonatomic,weak) NSString *latitude;
@property (nonatomic,weak) NSString *longitude;

@end
