//
//  LevelDB+FC.m
//  ObjcLevelDB
//
//  Created by Jarvis on 20/08/2017.
//  Copyright © 2017 JQTech. All rights reserved.
//

#import "LevelDB+FC.h"
#import "FastCoder.h"

@interface LevelDB (Internal)

- (void) enumerateKeysBackward:(BOOL)backward
                 startingAtKey:(id)key
           filteredByPredicate:(NSPredicate *)predicate
                     andPrefix:(id)prefix
                  withSnapshot:(LDBSnapshot *)snapshot
                    usingBlock:(LevelDBKeyBlock)block
                       decoder:(LevelDBDecoderBlock)decoder;

- (void) enumerateKeysAndObjectsBackward:(BOOL)backward
                                  lazily:(BOOL)lazily
                           startingAtKey:(id)key
                     filteredByPredicate:(NSPredicate *)predicate
                               andPrefix:(id)prefix
                            withSnapshot:(LDBSnapshot *)snapshot
                              usingBlock:(id)block
                                 decoder:(LevelDBDecoderBlock)decoder;

- (void) setObject:(id)value forKey:(id)key encoder:(LevelDBEncoderBlock)encoder;

- (id) objectForKey:(id)key withSnapshot:(LDBSnapshot *)snapshot decoder:(LevelDBDecoderBlock)decoder;

@end

@implementation LevelDB (FC)

- (void)fc_setObject:(id)value forKey:(id)key {
    [self setObject:value forKey:key encoder:^NSData *(LevelDBKey *key, id object) {
        return [FastCoder dataWithRootObject:object];
    }];
}

- (id)fc_objectForKey:(id)key {
    return [self objectForKey:key withSnapshot:nil decoder:^id(LevelDBKey *key, id data) {
        return [FastCoder objectWithData:data];
    }];
}

- (void)fc_enumerateKeysBackward:(BOOL)backward
                   startingAtKey:(id)key
             filteredByPredicate:(NSPredicate *)predicate
                       andPrefix:(id)prefix
                      usingBlock:(LevelDBKeyBlock)block {
    [self enumerateKeysBackward:backward startingAtKey:key filteredByPredicate:predicate andPrefix:predicate withSnapshot:nil usingBlock:block decoder:^id(LevelDBKey *key, id data) {
        return [FastCoder objectWithData:data];
    }];
}

- (void)fc_enumerateKeysAndObjectsBackward:(BOOL)backward
                                    lazily:(BOOL)lazily
                             startingAtKey:(id)key
                       filteredByPredicate:(NSPredicate *)predicate
                                 andPrefix:(id)prefix
                                usingBlock:(id)block {
    [self enumerateKeysAndObjectsBackward:backward lazily:lazily startingAtKey:key filteredByPredicate:predicate andPrefix:prefix withSnapshot:nil usingBlock:block decoder:^id(LevelDBKey *key, id data) {
        return [FastCoder objectWithData:data];
    }];
}

@end
