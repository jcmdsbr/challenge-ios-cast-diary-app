//
//  ContatoRepository.h
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prova_IOs+CoreDataModel.h"



@interface ContatoRepository : NSObject

-(NSDictionary<NSNumber *,NSArray<Contato *> *> *)recuperarEmOrdemAlfabetica;

-(NSArray<Contato*>*) recuperarTodosEmLista;

-(Contato*) recuperarInstancia;

-(void) persistirContexto;

-(void) deletar : (Contato*) contato;

@end
