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

-(NSArray *)tableView:(UITableView *)tableView  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Editar" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
        
        ContatoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContatoViewControllerIdentifier"];
        
        [vc setContato:contato];
        [vc setIsAlterar: YES];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Excluir"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self deletarLinha:tableView indexPath:indexPath];
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    editAction.backgroundColor = [UIColor blueColor];
    
    
    return @[deleteAction,editAction];
}



- (void) deletarLinha: (UITableView *)tableView indexPath:(NSIndexPath *)indexPath  {
    Contato *contato = [self.dicContatos objectForKey: @(indexPath.section)][indexPath.row];
    
    ContatoRepository *repository = [ContatoRepository new];
    
    [repository deletar:contato];
    [repository persistirContexto];
    
    self.dicContatos = [repository recuperarTodos];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
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


@end
