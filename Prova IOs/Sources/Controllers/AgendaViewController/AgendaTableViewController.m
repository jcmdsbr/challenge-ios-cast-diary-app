//
//  AgendaTableViewController.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "AgendaTableViewController.h"
#import "ContatoRepository.h"

@interface AgendaTableViewController ()

@property (strong, nonatomic) NSDictionary *dicContatos;


@end

@implementation AgendaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ContatoRepository *repository = [ContatoRepository new];
    
    self.dicContatos = [repository recuperarTodos];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dicContatos.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray<CGContato*>* contatos = [self.dicContatos objectForKey:@(section)];
    return contatos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contatoCell" forIndexPath:indexPath];
    
    CGContato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
    
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.sobreNome;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [ContatoRepository recuperarNomeSessao:(CGEnumAlfabeto)section ];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        CGContato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
        ContatoRepository *repository = [ContatoRepository new];
        [repository deletar:contato];
        [repository persistirContexto];
        
        self.dicContatos = [repository recuperarTodos];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
