//
//  AgendaTableViewController.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "AgendaTableViewController.h"
#import "ContatoRepository.h"
#import "ContatoEnumUtil.h"

@interface AgendaTableViewController ()

@property (strong, nonatomic) NSDictionary<NSNumber *,NSArray<Contato *> *> * dicContatos;


@end

@implementation AgendaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dicContatos = [[ContatoRepository new] recuperarTodos];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 24;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray<Contato*>* contatos = [self.dicContatos objectForKey:@(section)];
    return contatos.count;
}

-(NSString*) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    return @"Excluir";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contatoCell" forIndexPath:indexPath];
    
    Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
    
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.sobreNome;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0)
        return nil;
    
    return [ContatoEnumUtil recuperarNomeSessao:(CGEnumAlfabeto)section ];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
        
        ContatoRepository *repository = [ContatoRepository new];
        
        [repository deletar:contato];
        [repository persistirContexto];
        
        self.dicContatos = [repository recuperarTodos];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    }
}

@end
