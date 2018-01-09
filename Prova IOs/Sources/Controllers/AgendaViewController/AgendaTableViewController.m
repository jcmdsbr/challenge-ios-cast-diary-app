//
//  AgendaTableViewController.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "AgendaTableViewController.h"
#import "ContatoViewController.h"
#import "ContatoRepository.h"
#import "UserDefaultRepository.h"
#import "ContatoEnumUtil.h"

@interface AgendaTableViewController ()

@property (strong, nonatomic) NSDictionary<NSNumber *,NSArray<Contato *> *> * dicContatos;


@end

@implementation AgendaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *nome = [[UserDefaultRepository sharedInstance] nomeUsuario];
    self.title = [NSString stringWithFormat:@"Contatos de %@",nome];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dicContatos = [[ContatoRepository new] recuperarEmOrdemAlfabetica];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma marks - Ações TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray<Contato*>* contatos = [self.dicContatos objectForKey:@(section)];
    return contatos.count;
}

-(NSArray *)tableView:(UITableView *)tableView  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Editar" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self editarLinha:indexPath];
        
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Excluir"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self deletarLinha:tableView indexPath:indexPath];
        
    }];
    
    
    deleteAction.backgroundColor = [UIColor redColor];
    editAction.backgroundColor = [UIColor blueColor];
    
    
    return @[deleteAction,editAction];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contatoCell" forIndexPath:indexPath];
    
    Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
    
    cell.textLabel.text = [contato.nome capitalizedString];
    cell.detailTextLabel.text = [contato.sobreNome capitalizedString];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0)
        return nil;
    
    return [ContatoEnumUtil recuperarNomeSessao:(CGEnumAlfabeto)section ];
}


#pragma marks - Ações Linha

-(void) editarLinha : (NSIndexPath *)indexPath {
    
    Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
    
    ContatoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContatoViewControllerIdentifier"];
    
    [vc setContato:contato];
    [vc setIsAlterar: YES];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void) deletarLinha: (UITableView *)tableView indexPath:(NSIndexPath *)indexPath  {
    
    Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
    
    ContatoRepository *repository = [ContatoRepository new];
    
    [repository deletar:contato];
    [repository persistirContexto];
    
    self.dicContatos = [repository recuperarEmOrdemAlfabetica];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
}

@end
