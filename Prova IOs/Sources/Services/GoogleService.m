//
//  GoogleService.m
//  Prova IOs
//
//  Created by Cast Group on 06/01/18.
//  Copyright © 2018 Cast Group. All rights reserved.
//

#import "GoogleService.h"

static NSString* const API_KEY = @"";

static NSString* const GOOGLE_SERVICE_API = @"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@";

@implementation GoogleService

-(NSMutableDictionary *)recuperarEndereco:(NSString *)cep {
    
    NSString *url = [NSString stringWithFormat: GOOGLE_SERVICE_API, cep, API_KEY];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *jsonError = nil;
    
    NSMutableDictionary *json =
    [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    
    if(jsonError)
        return nil;
    
    return json;
}

@end
