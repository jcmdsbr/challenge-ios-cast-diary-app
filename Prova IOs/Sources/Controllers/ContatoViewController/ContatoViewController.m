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



@end

@implementation ContatoViewController
{
    UIActivityIndicatorView *_progress;
    BOOL _erroGoogleService;
    NSString *_latitude;
    NSString *_longitude;
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
        self.txtNome.text = self.contato.nome;
        
        _latitude = self.contato.latitude;
        _longitude = self.contato.longitude;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)cepFocusOut:(id)sender {
    
    [_progress startAnimating];
    
    if(self.txtCep.text.length == 8) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        GoogleService *service = [GoogleService new];
        
        NSMutableDictionary *request = [service recuperarEndereco: self.txtCep.text];
        
        if(!request || [request[@"status"] isEqualToString: @"ZERO_RESULTS"] )
            [self criarAlertaDeAviso];
        else
            [self preencherCamposTela:request];
        
    } else {
        [self criarAlertaDeAviso];
    }
}

-(void) preencherCamposTela:(NSDictionary*) request{
    
    NSArray *endereco = [[request valueForKey: @"results"] valueForKey: @"formatted_address"];
    
    NSArray *localizacao = [[[[request valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"] objectAtIndex: 0 ];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.txtEnderecoCompleto.text =  [endereco objectAtIndex:0];
        
        _latitude = [[localizacao valueForKey:@"lat"] stringValue];
        
        _longitude =[[localizacao valueForKey:@"lng"] stringValue];
        
        [_progress stopAnimating];
        
    });
    
}
-(void) criarAlertaDeAviso{
    
    _erroGoogleService = YES;
    
    NSString* mensagem = @"Não foi possivel preencher automaticamente o endereço, por favor preencher manualmente.";
    
    UIAlertController *alert = [ UIAlertController  alertControllerWithTitle:@"Alerta !" message: mensagem
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:acaoOK];
    
    [self presentViewController: alert animated:YES completion:nil];
    
    [_progress stopAnimating];
    
}

-(void) criarLoading{
    
    _progress = [[UIActivityIndicatorView alloc]
                 initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray ];
    
    [self.view addSubview:_progress];
    
}

- (IBAction)salvar:(id)sender {
    
    ContatoRepository *repository = [ContatoRepository new];
    
    
    if(self.isAlterar) {
        [repository deletar:self.contato];

    }
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

@end
