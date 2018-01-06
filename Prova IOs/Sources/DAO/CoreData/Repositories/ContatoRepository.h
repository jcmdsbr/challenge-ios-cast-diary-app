//
//  ContatoRepository.h
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prova_IOs+CoreDataModel.h"


typedef NS_ENUM(NSUInteger, CGEnumAlfabeto) {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
    K,
    L,
    M,
    N,
    O,
    P,
    Q,
    R,
    S,
    T,
    U,
    V,
    W,
    X,
    Y,
    Z
};

@interface ContatoRepository : NSObject

-(NSDictionary<NSNumber *,NSArray<CGContato *> *> *)recuperarTodos;

-(CGContato*) recuperarInstancia;

-(void) persistirContexto;

-(void) deletar : (CGContato*) contato;

+ (NSString *) recuperarNomeSessao:(CGEnumAlfabeto) enumAlfabeto;

@end
