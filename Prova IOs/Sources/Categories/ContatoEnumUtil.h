//
//  ContatoEnumUtil.h
//  Prova IOs
//
//  Created by Cast Group on 08/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>


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


@interface ContatoEnumUtil : NSObject

+ (NSNumber*)convertEnumEmString:(NSString*)letra;

+ (NSString*)recuperarNomeSessao:(CGEnumAlfabeto)enumAlfabeto;

@end
