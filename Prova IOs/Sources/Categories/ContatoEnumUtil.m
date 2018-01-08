//
//  ContatoEnumUtil.m
//  Prova IOs
//
//  Created by Cast Group on 08/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "ContatoEnumUtil.h"

@implementation ContatoEnumUtil

+ (NSNumber*)convertEnumEmString:(NSString*)letra{
    
    if([letra isEqualToString:@"A"]) {
        return @(A);
    }
    if([letra isEqualToString:@"B"]) {
        return @(B);
    }
    if([letra isEqualToString:@"C"]) {
        return @(C);
    }
    if([letra isEqualToString:@"D"]) {
        return @(D);
    }
    if([letra isEqualToString:@"E"]) {
        return @(E);
    }
    if([letra isEqualToString:@"F"]) {
        return @(F);
    }
    if([letra isEqualToString:@"G"]) {
        return @(G);
    }
    if([letra isEqualToString:@"H"]) {
        return @(H);
    }
    if([letra isEqualToString:@"I"]) {
        return @(I);
    }
    if([letra isEqualToString:@"J"]) {
        return @(J);
    }
    if([letra isEqualToString:@"K"]) {
        return @(K);
    }
    if([letra isEqualToString:@"L"]) {
        return @(L);
    }
    if([letra isEqualToString:@"M"]) {
        return @(M);
    }
    if([letra isEqualToString:@"N"]) {
        return @(N);
    }
    if([letra isEqualToString:@"O"]) {
        return @(O);
    }
    if([letra isEqualToString:@"P"]) {
        return @(P);
    }
    if([letra isEqualToString:@"Q"]) {
        return @(Q);
    }
    if([letra isEqualToString:@"R"]) {
        return @(R);
    }
    if([letra isEqualToString:@"S"]) {
        return @(S);
    }
    if([letra isEqualToString:@"T"]) {
        return @(T);
    }
    if([letra isEqualToString:@"U"]) {
        return @(U);
    }
    if([letra isEqualToString:@"V"]) {
        return @(V);
    }
    if([letra isEqualToString:@"W"]) {
        return @(W);
    }
    if([letra isEqualToString:@"X"]) {
        return @(X);
    }
    if([letra isEqualToString:@"Y"]) {
        return @(Y);
    }
    if([letra isEqualToString:@"Z"]) {
        return @(Z);
    }
    
    return @(0);
}

+ (NSString *)recuperarNomeSessao:(CGEnumAlfabeto)enumAlfabeto{
    
    switch (enumAlfabeto) {
        case A:return @"A";
        case B:return @"B";
        case C:return @"C";
        case D:return @"D";
        case E:return @"E";
        case F:return @"F";
        case G:return @"G";
        case H:return @"H";
        case I:return @"I";
        case J:return @"J";
        case K:return @"K";
        case L:return @"L";
        case M:return @"M";
        case N:return @"N";
        case O:return @"O";
        case P:return @"P";
        case Q:return @"Q";
        case R:return @"R";
        case S:return @"S";
        case T:return @"T";
        case U:return @"U";
        case V:return @"V";
        case W:return @"W";
        case X:return @"X";
        case Y:return @"Y";
        case Z:return @"Z";
        default:return @"";
    }
}


@end
