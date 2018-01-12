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
#import "MensagensGeraisUtil.h"


@interface ContatoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtNome;

@property (weak, nonatomic) IBOutlet UITextField *txtSobrenome;

@property (weak, nonatomic) IBOutlet UIDatePicker *txtDataNascimento;

@property (weak, nonatomic) IBOutlet UITextField *txtCep;

@property (weak, nonatomic) IBOutlet UITextField *txtEnderecoCompleto;



@end

@implementation ContatoViewController
{
    UIActivityIndicatorView *_progress;
    NSString *_latitude;
    NSString *_longitude;
    BOOL _erroGoogleService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  criarLoading];
    
    _progress.center = self.view.center;
    
    if(self.contato) {
        [self preencherCamposTelaEditar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

#pragma marks - Funções de Configuração

-(void) criarLoading{
    
    _progress = [[UIActivityIndicatorView alloc]
                 initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray ];
    
    [self.view addSubview:_progress];
    
}

#pragma marks - Eventos de preenchimento

- (void) preencherCamposTelaEditar  {

    self.txtCep.text = self.contato.cep;
    self.txtEnderecoCompleto.text = self.contato.enderecoCompleto;
    self.txtDataNascimento.date = self.contato.dataNascimento;
    self.txtSobrenome.text = self.contato.sobreNome;
    self.txtNome.text = self.contato.nome;
    
    _latitude = self.contato.latitude;
    _longitude = self.contato.longitude;
    
    [self setTitle:self.contato.nome];

}

-(void) preencherAutoComplete:(NSDictionary*) request{
    
    NSArray *endereco = [[request valueForKey: @"results"] valueForKey: @"formatted_address"];
    
    NSArray *localizacao = [[[[request valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"] objectAtIndex: 0 ];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        _erroGoogleService = NO;
        
        self.txtEnderecoCompleto.text =  [endereco objectAtIndex:0];
        
        _latitude = [[localizacao valueForKey:@"lat"] stringValue];
        
        _longitude =[[localizacao valueForKey:@"lng"] stringValue];
        
        [_progress stopAnimating];
        
    });
    
}

#pragma marks - Alertas

-(void) criarAlertaDeAvisoAPI{
    
    _erroGoogleService = YES;
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !"
                                                                     message: MSG_ERRO_CONSUMO_GOOGLE_API preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:acaoOK];
    
    [self presentViewController: alert animated:YES completion:nil];
    
    [self limparCampoEndereco];
    
}


- (void) criarAlertaDeAvisoSalvar {
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !"
                                                                     message: MSG_ALERTA_AO_SALVAR preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *acaoCancelar = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleCancel handler: nil];
    
    
    UIAlertAction *acaoOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                       [self salvar];
                                                   }];
    
    [alert addAction:acaoOK];
    [alert addAction:acaoCancelar];
    [self presentViewController: alert animated:YES completion:nil];
   
}

-(void) criarAlertValidacao {
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !"
                                                                     message: MSG_NOME_OBRIGATORIO preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoOK =
    [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:acaoOK];
    
    [self presentViewController: alert animated:YES completion:nil];
    
}

#pragma marks - Ações

- (IBAction)cepFocusOut:(id)sender {
    
    [_progress startAnimating];
    
    if(self.txtCep.text.length == 8) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        GoogleService *service = [GoogleService new];
        
        NSMutableDictionary *request = [service recuperarEndereco: self.txtCep.text];
        
        if(!request || [request[@"status"] isEqualToString: @"ZERO_RESULTS"] )
            [self criarAlertaDeAvisoAPI];
        else
            [self preencherAutoComplete:request];
        
    } else if(self.txtCep.text.length != 0)
        [self criarAlertaDeAvisoAPI];
  
    [_progress stopAnimating];
}

-(void) limparCampoEndereco {
  self.txtEnderecoCompleto.text = @"";
}

- (IBAction)salvar:(id)sender {
    if([self.txtNome.text stringByTrimmingCharactersInSet:
        [NSCharacterSet whitespaceCharacterSet]].length > 0) {
        if(_erroGoogleService)
            [self criarAlertaDeAvisoSalvar];
        else
            [self salvar];
        
    } else {
        [self criarAlertValidacao];
    }
}


-(void) salvar {
    
    ContatoRepository *repository = [ContatoRepository new];
    
    if(self.isAlterar)
        [repository deletar:self.contato];
    
    
    Contato *contato =  [repository recuperarInstancia];
    
    contato.nome = self.txtNome.text;
    contato.sobreNome = self.txtSobrenome.text;
    contato.dataNascimento = self.txtDataNascimento.date;
    contato.cep = self.txtCep.text;
    contato.enderecoCompleto = self.txtEnderecoCompleto.text;
    contato.latitude = _latitude;
    contato.longitude = _longitude;
    
    [repository  persistirContexto];
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
