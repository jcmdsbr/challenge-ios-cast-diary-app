//
//  MapaViewController.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "MapaViewController.h"
#import "ContatoRepository.h"
#import <MapKit/MapKit.h>


@interface MapaViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@end

@implementation MapaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
     NSArray<Contato*>* contatos = [[ContatoRepository new] recuperarTodosEmLista];
    
    if(contatos && contatos.count > 0) {
        for (Contato *contato in contatos) {
            
            
            CLLocationCoordinate2D location = CLLocationCoordinate2DMake([contato.latitude doubleValue],
                                                                         [contato.longitude doubleValue]);
            
            MKPointAnnotation *pin = [MKPointAnnotation new];
           
            [pin setCoordinate: location];
            
            [pin setTitle: contato.nome];
            
            [self.mapa addAnnotation:pin];
            
        }
    }
}


@end
