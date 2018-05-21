//
//  Stack.m
//  stackqueue
//
//  Created by Varun Santhanam on 5/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

#import "Stack.h"

@interface StackEnumerator : NSEnumerator {
    
    Stack *_stackToEnumerate;
    NSUInteger _currentIndex;
    
}

- (instancetype)initWithStack:(Stack *)stack;

@end

@implementation StackEnumerator

- (instancetype)initWithStack:(Stack *)stack {
    
    self = [super init];
    
    if (self) {
        
        _stackToEnumerate = stack;
        
    }
    
    return self;
    
}

- (id)nextObject {
    
    if (_currentIndex >= _stackToEnumerate.count)
        return nil;
    
    return _stackToEnumerate[_currentIndex++];
    
}

@end

@interface Stack<ObjectType> ()

@property (nonatomic, copy) NSArray<ObjectType> *internalArray;

@end

@implementation Stack

#pragma mark - Public Class Methods

+ (instancetype)stack {
    
    return [[self alloc] init];
    
}

+ (instancetype)stackWithObject:(id)object {
    
    return [[self alloc] initWithObject:object];
    
}

+ (instancetype)stackWithObjects:(id)firstObj, ... {
    
    NSArray *objects = @[];
    va_list args;
    va_start(args, firstObj);
    
    for (id arg = firstObj; arg != nil; arg = va_arg(args, id)) {
        
        objects = [objects arrayByAddingObject:arg];
        
    }
    
    return [self stackWithArray:objects];
    
}

+ (instancetype)stackWithObjects:(id  _Nonnull const __autoreleasing *)objects count:(NSUInteger)cnt {
    
    return [[self alloc] initWithObjects:objects count:cnt];
    
}

+ (instancetype)stackWithArray:(NSArray *)array {
    
    return [[self alloc] initWithArray:array];
    
}

#pragma mark - Overridden Instance Methods

- (instancetype)init {
    
    self = [self initWithArray:@[]];
    
    return self;
    
}

- (NSUInteger)hash {
    
    return self.internalArray.hash;
    
}

- (BOOL)isEqual:(id)object {
    
    if (object == self) {
        
        return YES;
        
    } else if (![object isKindOfClass:[Stack class]]) {
        
        return NO;
        
    }
    
    return [self isEqualToStack:(Stack *)object];
    
}

- (NSString *)description {
    
    return self.internalArray.description;
    
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    [NSException raise:NSGenericException format:@"Stacks are not observable"];
    
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    [NSException raise:NSGenericException format:@"Stacks are not observable"];
    
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    
    [NSException raise:NSGenericException format:@"Stacks are not observable"];
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [self.internalArray setValue:value forKey:key];
    
}

- (id)valueForKey:(NSString *)key {
    
    return [self.internalArray valueForKey:key];
    
}

#pragma mark - Property Access Methods

- (NSUInteger)count {
    
    return self.internalArray.count;
    
}

- (NSData *)sortedStackHint {
    
    return self.internalArray.sortedArrayHint;
    
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    
    return YES;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.internalArray forKey:NSStringFromSelector(@selector(internalArray))];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [self init];
    
    if (self) {
        
        _internalArray = [aDecoder decodeObjectOfClass:[NSArray class] forKey:NSStringFromSelector(@selector(internalArray))];
        
    }
    
    return self;
    
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    
    Stack *copy = [[[self class] alloc] init];
    copy->_internalArray = [self.internalArray copyWithZone:zone];
    
    return copy;
    
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len {

    return [self.internalArray countByEnumeratingWithState:state
                                                   objects:buffer
                                                     count:len];
    
}

#pragma mark - Public Instnace Methods

#pragma mark - Initializers

- (instancetype)initWithObject:(id)object {
    
    self = [self initWithArray:@[object]];
    
    return self;
    
}

- (instancetype)initWithObjects:(id)firstObj, ... {
    
    NSArray *objects = @[];
    va_list args;
    va_start(args, firstObj);
    
    for (id arg = firstObj; arg != nil; arg = va_arg(args, id)) {
        
        objects = [objects arrayByAddingObject:arg];
        
    }
    
    self = [self initWithArray:objects];
    
    return self;
    
}

- (instancetype)initWithObjects:(id  _Nonnull const __autoreleasing *)objects count:(NSUInteger)cnt {
    
    NSArray *objs = @[];
    
    for (int i = 0; i < cnt; i++) {
        
        objs = [objs arrayByAddingObject:objects[i]];
        
    }
    
    self = [self initWithArray:objs];
    
    return self;
    
}

- (instancetype)initWithArray:(NSArray *)array {
    
    self = [super init];
    
    if (self) {
        
        self.internalArray = array;
        
    }
    
    return self;
    
}

#pragma mark - Push Peek Pop

- (void)push:(id)object {
    
    _internalArray = [self.internalArray arrayByAddingObject:object];
    
}

- (void)pushObjects:(NSArray *)objects {
    
    for (id object in objects) {
        
        [self push:object];
        
    }
    
}

- (id)peek {
    
    return self.internalArray.lastObject;
    
}

- (id)pop {
    
    id lastObj = [self peek];
    _internalArray = [self.internalArray subarrayWithRange:NSMakeRange(0, self.internalArray.count - 1)];
    
    return lastObj;
    
}

#pragma mark - Get Objects

- (id)objectAtIndex:(NSUInteger)index {
    
    return self.internalArray[index];
    
}

- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes {
    
    return [self.internalArray objectsAtIndexes:indexes];
    
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    
    return [self objectAtIndex:idx];
    
}

#pragma mark - Get Index Of Object

- (NSUInteger)indexOfObject:(id)object {
    
    return [self.internalArray indexOfObject:object];
    
}

- (NSUInteger)indexOfObject:(id)object inRange:(NSRange)range {
    
    return [self.internalArray indexOfObject:object
                                     inRange:range];
    
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)object {
    
    return [self.internalArray indexOfObjectIdenticalTo:object];
    
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)object inRange:(NSRange)range {
    
    return [self.internalArray indexOfObjectIdenticalTo:object
                                                inRange:range];
    
}

- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))predicate {
    
    return [self.internalArray indexOfObjectPassingTest:predicate];
    
}

- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))predicate {
    
    return [self.internalArray indexOfObjectWithOptions:opts
                                            passingTest:predicate];
    
}

- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))predicate {
    
    return [self.internalArray indexOfObjectAtIndexes:s
                                              options:opts
                                          passingTest:predicate];
    
}

- (NSUInteger)indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp {
    
    return [self.internalArray indexOfObject:obj
                               inSortedRange:r
                                     options:opts
                             usingComparator:cmp];
    
}

#pragma mark - Get Indexes Of Objects

- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))predicate {
    
    return [self.internalArray indexesOfObjectsPassingTest:predicate];
    
}

- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))predicate {
    
    return [self.internalArray indexesOfObjectsWithOptions:opts
                                               passingTest:predicate];
    
}

- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))predicate {
    
    return [self.internalArray indexesOfObjectsAtIndexes:s
                                                 options:opts
                                             passingTest:predicate];
    
}

#pragma mark - Make Objects Perform Selector

- (void)makeObjectsPerformSelector:(SEL)aSelector {
    
    [self.internalArray makeObjectsPerformSelector:aSelector];
    
}

- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument {
    
    return [self.internalArray makeObjectsPerformSelector:aSelector withObject:argument];
    
}

#pragma mark - Enumeration

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    
    [self.internalArray enumerateObjectsUsingBlock:block];
    
}

- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    
    [self.internalArray enumerateObjectsWithOptions:opts
                                         usingBlock:block];
    
}

- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    
    return [self.internalArray enumerateObjectsAtIndexes:s
                                                 options:opts
                                              usingBlock:block];
    
}

- (NSEnumerator *)objectEnumerator {
    
    return [[StackEnumerator alloc] initWithStack:self];
    
}

#pragma mark - Deriving Stacks

- (Stack *)stackByPushing:(id)object {
    
    Stack *stack = [self copy];
    [stack push:object];
    
    return [[Stack alloc] initWithArray:stack.internalArray];
    
}

- (Stack *)stackByPushingObjects:(NSArray *)objects {
    
    Stack *stack = [self copy];
    [stack pushObjects:objects];
    
    return [[Stack alloc] initWithArray:stack.internalArray];
    
}

- (Stack *)stackByPopping {
    
    Stack *stack = [self copy];
    [stack pop];
    
    return [[Stack alloc] initWithArray:stack.internalArray];
    
}

- (Stack *)filteredStackUsingPredicate:(NSPredicate *)predicate {
    
    NSArray *filtered = [self.internalArray filteredArrayUsingPredicate:predicate];
    
    return [[Stack alloc] initWithArray:filtered];
    
}

- (Stack *)subStackWithRange:(NSRange)range {
    
    NSArray *filtered = [self.internalArray subarrayWithRange:range];
    
    return [[Stack alloc] initWithArray:filtered];
    
}

#pragma mark - Sorting

- (Stack *)sortedStackUsingFunction:(NSInteger (*)(id  _Nonnull __strong, id  _Nonnull __strong, void * _Nonnull))comparator context:(void *)context {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingFunction:comparator
                                                           context:context];
    return [[Stack alloc] initWithArray:sorted];
    
}

- (Stack *)sortedStackUsingFunction:(NSInteger (*)(id  _Nonnull __strong, id  _Nonnull __strong, void * _Nonnull))comparator context:(void *)context hint:(NSData *)hint {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingFunction:comparator
                                                           context:context
                                                              hint:hint];
    return [[Stack alloc] initWithArray:sorted];
    
}

- (Stack *)sortedStackUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingDescriptors:sortDescriptors];
    return [[Stack alloc] initWithArray:sorted];
            
}

- (Stack *)sortedStackUsingSelector:(SEL)comparator {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingSelector:comparator];
    return [[Stack alloc] initWithArray:sorted];
    
}

- (Stack *)sortedStackUsingComparator:(NSComparator)cmptr {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingComparator:cmptr];
    return [[Stack alloc] initWithArray:sorted];
    
}

- (Stack *)sortedStackWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    
    NSArray *sorted = [self.internalArray sortedArrayWithOptions:opts
                                                 usingComparator:cmptr];
    return [[Stack alloc] initWithArray:sorted];
    
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    
    if (idx1 == idx2)
        return;
    
    NSUInteger firstIndex = MIN(idx1, idx2);
    NSUInteger secondIndex = MAX(idx1, idx2);
    
    NSArray *firstSub = [self.internalArray subarrayWithRange:NSMakeRange(0, firstIndex)];
    id first = self.internalArray[firstIndex];
    NSUInteger secondLen = secondIndex - firstIndex - 1;
    NSArray *secondSub = [self.internalArray subarrayWithRange:NSMakeRange(firstIndex + 1, secondLen == -1 ? 0 : secondLen)];
    id second = self.internalArray[secondIndex];
    NSUInteger finalLen = self.internalArray.count - secondIndex - 1;
    NSArray *finalSub = [self.internalArray subarrayWithRange:NSMakeRange(secondIndex + 1, finalLen)];
    
    _internalArray = [[[[firstSub arrayByAddingObject:second] arrayByAddingObjectsFromArray:secondSub] arrayByAddingObject:first] arrayByAddingObjectsFromArray:finalSub];
    
}

- (void)sortUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors {
    
    _internalArray = [self.internalArray sortedArrayUsingDescriptors:sortDescriptors];
    
}

- (void)sortUsingComparator:(NSComparator)cmptr {
    
    _internalArray = [self.internalArray sortedArrayUsingComparator:cmptr];
    
}

- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    
    _internalArray = [self.internalArray sortedArrayWithOptions:opts
                                                    usingComparator:cmptr];
    
}

- (void)sortUsingFunction:(NSInteger (*)(id  _Nonnull __strong, id  _Nonnull __strong, void * _Nonnull))compare context:(void *)context {
    
    _internalArray = [self.internalArray sortedArrayUsingFunction:compare
                                                              context:context];
    
}

- (void)sortUsingSelector:(SEL)aSelector {
    
    _internalArray = [self.internalArray sortedArrayUsingSelector:aSelector];
    
}

#pragma mark - Working With String Elements

- (NSString *)componentsJoinedByString:(NSString *)separator {
    
    return [self.internalArray componentsJoinedByString:separator];
    
}

#pragma mark - Contents Observation

- (void)addObserver:(NSObject *)observer toObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    [self.internalArray addObserver:observer
                 toObjectsAtIndexes:indexes
                         forKeyPath:keyPath
                            options:options
                            context:context];
    
}

- (void)removeObserver:(NSObject *)observer fromObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath {
    
    [self.internalArray removeObserver:observer
                  fromObjectsAtIndexes:indexes
                            forKeyPath:keyPath];
    
}

#pragma mark - Equality & Contents Checking

- (BOOL)isEqualToStack:(Stack *)stack {
    
    if (!stack) {
        
        return NO;
        
    }
    
    return [self.internalArray isEqualToArray:stack.internalArray];
    
}

- (BOOL)containsObject:(id)object {
    
    return [self.internalArray containsObject:object];
    
}

@end
