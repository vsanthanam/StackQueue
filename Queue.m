//
//  Queue.m
//  StackQueue
//
//  Created by Varun Santhanam on 5/15/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

#import "Queue.h"

@interface QueueEnumerator : NSEnumerator {
    
    Queue *_queueToEnumerate;
    NSUInteger _currentIndex;
    
}

- (instancetype)initWithQueue:(Queue *)queue;

@end

@implementation QueueEnumerator

- (instancetype)initWithQueue:(Queue *)queue {
    
    self = [super init];
    
    if (self) {
        
        _queueToEnumerate = queue;
        
    }
    
    return self;
    
}

- (id)nextObject {
    
    if (_currentIndex >= _queueToEnumerate.count)
        return nil;
    
    return _queueToEnumerate[_currentIndex++];
    
}

@end

@interface Queue<ObjectType> ()

@property (nonatomic, copy) NSArray<ObjectType> *internalArray;

@end

@implementation Queue

#pragma mark - Public Class Methods

+ (instancetype)queue {
    
    return [[self alloc] init];
    
}

+ (instancetype)queueWithObject:(id)object {
    
    return [[self alloc] initWithObject:object];
    
}

+ (instancetype)queueWithObjects:(id)firstObj, ... {
    
    NSArray *objects = @[];
    va_list args;
    va_start(args, firstObj);
    
    for (id arg = firstObj; arg != nil; arg = va_arg(args, id)) {
        
        objects = [objects arrayByAddingObject:arg];
        
    }
    
    return [self queueWithArray:objects];
    
}

+ (instancetype)queueWithObjects:(const __autoreleasing id *)objects count:(NSUInteger)cnt {
    
    return [[self alloc] initWithObjects:objects count:cnt];
    
}

+ (instancetype)queueWithArray:(NSArray *)array {
    
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
        
    } else if (![object isKindOfClass:[Queue class]]) {
        
        return NO;
        
    }
    
    return [self isEqualToQueue:(Queue *)object];
    
}

- (NSString *)description {
    
    return self.internalArray.description;
    
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    [NSException raise:NSGenericException format:@"Queues are not observable"];
    
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    [NSException raise:NSGenericException format:@"Queues are not observable"];
    
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    
    [NSException raise:NSGenericException format:@"Queues are not observable"];
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [self.internalArray setValue:value forKey:key];
    
}

- (id)valueForKey:(NSString *)key {
    
    return [self.internalArray valueForKey:key];
    
}

#pragma mark - Property Access Methos

- (NSUInteger)count {
    
    return self.internalArray.count;
    
}

- (NSData *)sortedQueueHint {
    
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
    
    Queue *copy = [[[self class] alloc] init];
    copy->_internalArray = [self.internalArray copyWithZone:zone];
    
    return copy;
    
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len {
    
    return [self.internalArray countByEnumeratingWithState:state
                                                   objects:buffer
                                                     count:len];
    
}

#pragma mark - Public Instance Methods

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

#pragma - Enqueue Peek Dequeue

- (void)enqueue:(id)object {
    
    _internalArray = [self.internalArray arrayByAddingObject:object];
    
}

- (void)enqueueObjects:(NSArray *)objects {
    
    for (id object in objects) {
        
        [self queueByEnqueueing:object];
        
    }
    
}

- (id)peek {
    
    return self.internalArray.firstObject;
    
}

- (id)dequeue {
    
    id firstObj = [self peek];
    _internalArray = [self.internalArray subarrayWithRange:NSMakeRange(1, self.internalArray.count - 1)];
    
    return firstObj;
    
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
    
    return [[QueueEnumerator alloc] initWithQueue:self];
    
}

#pragma mark - Deriving Queues

- (Queue *)queueByEnqueueing:(id)object {
    
    Queue *queue = [self copy];
    [queue enqueue:object];
    
    return [[Queue alloc] initWithArray:queue.internalArray];
    
}

- (Queue *)queueByEnqueingObjects:(NSArray *)objects {
    
    Queue *queue = [self copy];
    [queue enqueueObjects:objects];
    
    return [[Queue alloc] initWithArray:queue.internalArray];
    
}

- (Queue *)queueByDequeueing {
    
    Queue *queue = [self copy];
    [queue dequeue];
    
    return [[Queue alloc] initWithArray:queue.internalArray];
    
}

- (Queue *)filteredQueueUsingPredicate:(NSPredicate *)predicate {
    
    NSArray *filtered = [self.internalArray filteredArrayUsingPredicate:predicate];
    
    return [[Queue alloc] initWithArray:filtered];
    
}

- (Queue *)subQueueWithRange:(NSRange)range {
    
    NSArray *filtered = [self.internalArray subarrayWithRange:range];
    
    return [[Queue alloc] initWithArray:filtered];
    
}

#pragma mark - Sorting

- (Queue *)sortedQueueUsingFunction:(NSInteger (*)(id  _Nonnull __strong, id  _Nonnull __strong, void * _Nonnull))comparator context:(void *)context {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingFunction:comparator
                                                           context:context];
    return [[Queue alloc] initWithArray:sorted];
    
}

- (Queue *)sortedQueueUsingFunction:(NSInteger (*)(id  _Nonnull __strong, id  _Nonnull __strong, void * _Nonnull))comparator context:(void *)context hint:(NSData *)hint {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingFunction:comparator
                                                           context:context
                                                              hint:hint];
    return [[Queue alloc] initWithArray:sorted];
    
}

- (Queue *)sortedQueueUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors {
 
    NSArray *sorted = [self.internalArray sortedArrayUsingDescriptors:sortDescriptors];
    return [[Queue alloc] initWithArray:sorted];
    
}

- (Queue *)sortedQueueUsingSelector:(SEL)comparator {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingSelector:comparator];
    return [[Queue alloc] initWithArray:sorted];
    
}

- (Queue *)sortedQueueUsingComparator:(NSComparator)cmptr {
    
    NSArray *sorted = [self.internalArray sortedArrayUsingComparator:cmptr];
    return [[Queue alloc] initWithArray:sorted];
    
}

- (Queue *)sortedQueueWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    
    NSArray *sorted = [self.internalArray sortedArrayWithOptions:opts
                                                 usingComparator:cmptr];
    return [[Queue alloc] initWithArray:sorted];
    
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

- (BOOL)isEqualToQueue:(Queue *)queue {
    
    if (!queue) {
        
        return NO;
        
    }
    
    return [self.internalArray isEqualToArray:self.internalArray];
    
}

- (BOOL)containsObject:(id)object {
    
    return [self.internalArray containsObject:object];
    
}

@end
