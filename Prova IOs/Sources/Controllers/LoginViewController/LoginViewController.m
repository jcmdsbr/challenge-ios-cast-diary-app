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
    
    if([self.txtNomeUsuario.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0){
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
    
    NSString* mensagem = @"Preencha seu nome para prosseguir.";
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !"
                                                                     message: mensagem preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:acaoOK];
    
    [self presentViewController: alert animated:YES completion:nil];
}

@end
