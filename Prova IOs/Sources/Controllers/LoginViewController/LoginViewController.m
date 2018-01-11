//
//  LoginViewController.m
//  Prova IOs
//
//  Created by Cast Group on 05/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "LoginViewController.h"
#import "AgendaTableViewController.h"
#import "UserDefaultRepository.h"
#import "MensagensGeraisUtil.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNomeUsuario;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.txtNomeUsuario.text = [[UserDefaultRepository sharedInstance] nomeUsuario];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)
senderx{
    
    if([self.txtNomeUsuario.text stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceCharacterSet]].length > 0){
        
        [self performSegueWithIdentifier:@"segueAvancar" sender:nil];
    }
    
    [self criarAlertAviso];
    
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)
sender{
    
    if([segue.identifier isEqualToString: @"segueAvancar"]){
        
       UserDefaultRepository *repository = [ UserDefaultRepository sharedInstance];
        
       [repository setNomeUsuario: self.txtNomeUsuario.text];
        
        [segue destinationViewController];
        
    }
}

-(void) criarAlertAviso {
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !"
                                                                     message: MSG_NOME_OBRIGATORIO preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:acaoOK];
    
    [self presentViewController: alert animated:YES completion:nil];
}

@end
