//
//  ContatoRepository.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "ContatoRepository.h"
#import "AppDelegate.h"
#import "ContatoEnumUtil.h"

@implementation ContatoRepository

- (NSManagedObjectContext*) coreDataContext{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

- (void) deletar:(Contato *)contato{
    [[self coreDataContext] deleteObject:contato];
}

-(Contato*) recuperarInstancia {
    return   [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contato class])
                                           inManagedObjectContext:[self coreDataContext]];
}


-(void) persistirContexto {
    NSError *error = nil;
    [[self coreDataContext] save:&error];
}

- (NSDictionary<NSNumber *,NSArray<Contato *> *> *)recuperarEmOrdemAlfabetica {
    
    NSMutableDictionary *resultado = [@{} mutableCopy];
    NSError *error = nil;
    NSFetchRequest *request =  [Contato fetchRequest];
    NSArray* contatos = [[self coreDataContext] executeFetchRequest:request error:&error];
    
    if(error) {
        return nil;
    }
    else {
        if(contatos && contatos.count > 0) {
            
            for (Contato *contato in contatos)
            {
                if(contato.nome.length > 0) {
                    
                    NSString * primeiraLetra = [contato.nome substringToIndex:1];
                    
                    NSString *key = [ primeiraLetra capitalizedString];
                    
                    NSNumber *n = [ContatoEnumUtil convertEnumEmString:key];
                    
                    NSMutableArray *contatosPorLetra = [resultado objectForKey: n];
                    
                    if (contatosPorLetra == nil)
                    {
                        contatosPorLetra = [@[] mutableCopy];
                        [resultado setObject:contatosPorLetra forKey: n];
                    }
                    
                    [contatosPorLetra addObject:contato];
                }
            }
            
        return resultado;
            
            
        } else {
            return nil;
        }
    }
    
}

-(NSArray<Contato*>*) recuperarTodosEmLista {

    NSError *error = nil;
    NSFetchRequest *request =  [Contato fetchRequest];
    NSArray<Contato*>* contatos = [[self coreDataContext] executeFetchRequest:request error:&error];
    
    if(error)
        return nil;
    
    return contatos;
    
}

@end
