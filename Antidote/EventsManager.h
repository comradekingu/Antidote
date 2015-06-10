//
//  EventsManager.h
//  Antidote
//
//  Created by Dmitry Vorobyov on 03.08.14.
//  Copyright (c) 2014 dvor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventObject.h"

@interface EventsManager : NSObject

- (void)addObject:(EventObject *)object;

- (void)handleLocalNotification:(UILocalNotification *)notification;

@end
