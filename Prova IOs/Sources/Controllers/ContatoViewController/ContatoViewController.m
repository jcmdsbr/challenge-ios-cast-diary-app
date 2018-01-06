//
//  ContatoViewController.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "ContatoViewController.h"
#import "ContatoRepository.h"
#import "GoogleService.h"


@interface ContatoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtNome;

@property (weak, nonatomic) IBOutlet UITextField *txtSobrenome;

@property (weak, nonatomic) IBOutlet UIDatePicker *txtDataNascimento;

@property (weak, nonatomic) IBOutlet UITextField *txtCep;

@property (weak, nonatomic) IBOutlet UITextField *txtEnderecoCompleto;

@property (weak, nonatomic) NSString *latitude;

@property (weak, nonatomic) NSString *longitude;

@end

@implementation ContatoViewController
{
    UIActivityIndicatorView *_progress;
    BOOL _erroGoogleService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  criarLoading];
    
    _progress.center = self.view.center;
    
    if(self.contato) {
            self.txtCep.text = self.contato.cep;
            self.txtEnderecoCompleto.text = self.contato.enderecoCompleto;
            self.txtDataNascimento.date = self.contato.dataNascimento;
            self.txtSobrenome.text = self.contato.sobreNome;
            self.txtNome.text = self.contato.sobreNome;
        }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)cepFocusOut:(id)sender {
    if(self.txtCep.text.length >= 8) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        [_progress startAnimating];
        
        GoogleService *service = [GoogleService new];
        
        NSDictionary *request = [service recuperarEndereco: self.txtCep.text];
        
        if(!request || [request[@"status"] isEqualToString: @"ZERO_RESULTS"] ) {
            [self criarAlertaDeAviso];
        } else {
            
            NSDictionary *results = request[@"results"];
            NSDictionary *geometry = results[@"geometry"];
            NSDictionary *location = geometry[@"location"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.txtEnderecoCompleto.text =  results[@"formatted_address"];
                self.latitude = [location[@"lat"] stringValue];
                self.longitude =[location[@"lng"] stringValue];
                [_progress stopAnimating];
                
            });
            
        }
        
    } else {
         [self criarAlertaDeAviso];
    }
}

-(void) criarAlertaDeAviso{
    
    _erroGoogleService = YES;

    NSString* mensagem = @"Não foi possivel preencher automaticamente o endereço, por favor preencher manualmente.";
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !" message: mensagem
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:acaoOK];
    
    [self presentViewController: alert animated:YES completion:nil];

}

-(void) criarLoading{
    
    _progress = [[UIActivityIndicatorView alloc]
                 initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge ];
    
    [self.view addSubview:_progress];
    
}

- (IBAction)salvar:(id)sender {
    
    ContatoRepository *repository   = [ContatoRepository new];
    
    CGContato *contato =  [repository recuperarInstancia];
    
    contato.nome = self.txtNome.text;
    contato.sobreNome = self.txtSobrenome.text;
    contato.dataNascimento = self.txtDataNascimento.date;
    contato.cep = self.txtCep.text;
    contato.enderecoCompleto = self.txtEnderecoCompleto.text;
    contato.latitude = self.latitude;
    contato.longitude = self.longitude;
    
    [repository  persistirContexto];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

@end
