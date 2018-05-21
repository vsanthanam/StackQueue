//
//  Queue.h
//  StackQueue
//
//  Created by Varun Santhanam on 5/15/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

@import Foundation;

/**
 A FIFO Queue in Objective-C, backed by an NSArray
 */
@interface Queue<__covariant ObjectType> : NSObject<NSSecureCoding, NSCopying, NSFastEnumeration>

NS_ASSUME_NONNULL_BEGIN

/**
 @name Factory Methods
 */

/**
 Create an empty queue

 @return The queue
 */
+ (nullable instancetype)queue;

/**
 Create a queue with a single object

 @param object The object
 @return The queue
 */
+ (nullable instancetype)queueWithObject:(ObjectType)object;

/**
 Create a queue with a list of objects (requires nil termination)

 @param firstObj The list of objects
 @return The queue
 */
+ (nullable instancetype)queueWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Create a queue with a C array

 @param objects The C array
 @param cnt The length of the C array
 @return The queue
 */
+ (nullable instancetype)queueWithObjects:(ObjectType const *)objects count:(NSUInteger)cnt;

/**
 Create a queue with an NSArray

 @param array The NSArray
 @return The queue
 */
+ (nullable instancetype)queueWithArray:(NSArray<ObjectType> *)array;

/**
 @name Initializers
 */

/**
 Create a queue with an object

 @param object The object
 @return The queue
 */
- (nullable instancetype)initWithObject:(ObjectType)object;

/**
 Create a queue with a list of objects (requires nil termination)
 
 @param firstObj The list of objects
 @return The queue
 */
- (nullable instancetype)initWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Create a list of objects with a C array
 
 @param objects The C array
 @param cnt The length of the C array
 @return The stack
 */
- (nullable instancetype)initWithObjects:(ObjectType const *)objects count:(NSUInteger)cnt;

/**
 Create a stack with an NSArray
 
 @param array The NSArray
 @return The stack
 */
- (nullable instancetype)initWithArray:(NSArray<ObjectType> *)array NS_DESIGNATED_INITIALIZER;

/**
 @name Enqueue, Peek, Dequeue
 */

/**
 Enqueue an object

 @param object The objects
 */
- (void)enqueue:(ObjectType)object;

/**
 Enqueue an array of objects

 @param objects The array
 */
- (void)enqueueObjects:(NSArray<ObjectType> *)objects;

/**
 View the item in the front of the queue

 @return The item at the front of the queue
 */
- (nullable ObjectType)peek;

/**
 Dequeue an item from the front of the queue

 @return The item
 */
- (nullable ObjectType)dequeue;

/**
 @name Equality & Content Checking
 */

/**
 The number of items in the queue
 */
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger count;

/**
 Compare two queues for equality

 @param queue The other queue to compare
 @return YES of the queues are equivelent, otherwise NO.
 */
- (BOOL)isEqualToQueue:(nullable Queue<ObjectType> *)queue;

/**
 Check if a queue contains an object

 @param object The object to search for in the queue
 @return YES if the queue contains the object, otherwise NO.
 */
- (BOOL)containsObject:(ObjectType)object;

/**
 @name Get Objects
 */

/**
 Get the object in the queue at the given index
 
 @param index The index
 @return The item at the index
 */
- (ObjectType)objectAtIndex:(NSUInteger)index;

/**
 Get the objects at the given indexes in the queue
 
 @param indexes The indexes
 @return The items at the indexes
 */
- (NSArray<ObjectType> *)objectsAtIndexes:(NSIndexSet *)indexes;

/**
 Get the object at the given index of the queue, via subscript.
 
 @discussion You don't need to invoke this method explicitly. `myStack[3]` is compiled to `[myStack objectAtIndexedSubscript:3]`
 @param idx The index
 @return The item at the index
 */
- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;

/**
 @name Get Index Of Objects
 */

/**
 Get the index of a given object
 
 @note if the queue contains duplicates, the index of the first one will be used
 @param object The object
 @return The index of the object, if it exists, otherwise NSNotFound.
 */
- (NSUInteger)indexOfObject:(ObjectType)object;

/**
 Get the index of a given object, if it exists within a specific range
 
 @note if the queue contains duplicates within the specified range, the index of the first one will be used
 @param object The object
 @param range The range limit
 @return The index of the object, if it exists within the given range, otherwise NSNotFound.
 */
- (NSUInteger)indexOfObject:(ObjectType)object inRange:(NSRange)range;

/**
 Get the index of the object who responds YES when sent an -isEqual: message with a given object
 
 @note if multiple objects exist that would respond YES to the -isEqual: message, the index of the first one will be used
 @param object The object to send along with the -isEqual: message
 @return The index of the object, if it exists, otherwise NSNotFound.
 */
- (NSUInteger)indexOfObjectIdenticalTo:(ObjectType)object;

/**
 Get the index of the object who responds YES when sent an -isEqual: message with a given object, if it exists within a specific range
 
 @note if multiple objects exist that would respond YES to the -isEqual: message within the specified range, the index of the first one will be used
 @param object The object to send along with the -isEqual: message
 @param range The index of the object, if it exists, otherwise NSNotFound.
 @return The index of the object, if it exists within the given range, otherwise NSNotFound
 */
- (NSUInteger)indexOfObjectIdenticalTo:(ObjectType)object inRange:(NSRange)range;

/**
 Get the index of the object who returns YES when a passed as a paramater to a testing block
 
 @note if multiple objects exist that would pass the testing block, the index of the first one will be used
 @param predicate The block used to test objects
 @return The index of the object, if it exists, otherwise NSNotFound.
 */
- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/**
 Get the index of the object who returns YES when passed as a paramater to a testing block, with control over enumeration.
 
 @note if multiple objects exist that would pass the testing block, the index of the first item to pass the test will be used
 @param opts The options used to configure the enumeration of tests
 @param predicate The block used to test objects
 @return The index of the object, if it exists, otherwise NSNotFound
 */
- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/**
 Get the index of the object who returns YES when passed a paramater to a testing block, within a set of indexes
 
 @note if multiple objects exist in the given index set that would pass the testing block, the index of the first item to pass the test will be used
 @param s The indexes to test
 @param opts The enumeration options to test objects within the index set
 @param predicate The block used to test objects
 @return The index of the object, if it exists within the specified index set, otherwise NSNotFound
 */
- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/**
 Get the index, within a specified range, of an object compared with elements in the array using a given NSComparator block.
 
 @note if multiple objects exist in the created sorted array, the index of the first item in the sorted arary will be used (in terms of the stack)
 @param obj The object
 @param r The range
 @param opts The binary search options to apply over the given range
 @param cmp The comparison block used to sort objects over the given range
 @return The index of the index of the object (in terms of the stack), if it exists, otherwise NSNotFound
 */
- (NSUInteger)indexOfObject:(ObjectType)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp;

/**
 @name Get Indexes Of Objects
 */

/**
 Get the indexes of objects that would return YES when passed as a paramater to a testing block
 
 @param predicate The block used to test object
 @return The index set contain the indexes of all passing objects
 */
- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/**
 Get the indexes of objects that would return YES when passed as a paramater to a testing block, with control over enumeration
 
 @param predicate The block used to test object
 @return The index set contain the indexes of all passing objects
 */
- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/**
 Get the index objects within a given index set that would return YES when passed as a paramater to a testing block
 
 @param s The set of indexes to check
 @param opts The options used to enumerate over objects within the given index set
 @param predicate The block used to test objects
 @return The index set containing the indexes of all passing objects
 */
- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

/**
 @name Perform Selectors On Objects
 */

/**
 Perform a selector on every object in the queue
 
 @param aSelector The selector to perform
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector;

/**
 Perform a selector on every object in the queue, with a given object
 
 @param aSelector The selector to perform
 @param argument The object
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;

/**
 @name Enumeration
 */

/**
 Enumerate over the contents of the queue with a block
 
 @param block The block to execute over each object in the queue
 */
- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 Enumerate over the contents of the queue with a block and enumneration control
 
 @param opts The options to control enumeration
 @param block The block to execute over each object
 */
- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 Enumerate over the contents of the queue over a given set of indexes
 
 @param s The set of indexes to enumerate over
 @param opts The options used to control enumeration
 @param block The block to execute over each object
 */
- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 Create an NSEnumerator to enumerate over the queue
 
 @return The NSEnumerator object specific to this queue instance
 */
- (NSEnumerator *)objectEnumerator;

/**
 @name Deriving Queues
 */

/**
 Create a new queue by enqueing an object to this one

 @param object The object to enqueue
 @return The new queue
 */
- (Queue<ObjectType> *)queueByEnqueueing:(ObjectType)object;

/**
 Create a new queue by enqueing objects to this one

 @param objects The objects to enqueue
 @return The new queue
 */
- (Queue<ObjectType> *)queueByEnqueingObjects:(NSArray<ObjectType> *)objects;

/**
 Create a new queue by dequeing an object from this one

 @return The new queue
 */
- (Queue<ObjectType> *)queueByDequeueing;

/**
 Create a queue by filtering out objects from this one using an NSPredicate

 @param predicate The predicate used to filter out objects
 @return The new queue
 */
- (Queue<ObjectType> *)filteredQueueUsingPredicate:(NSPredicate *)predicate;

/**
 Create a queue using a portion of this one

 @param range The range of the queue to use
 @return The new queue
 */
- (Queue<ObjectType> *)subQueueWithRange:(NSRange)range;

/**
 @name Sorting
 */

/**
 Hint used for speeding up / optimizing sorting
 */
@property (NS_NONATOMIC_IOSONLY, readonly) NSData *sortedQueueHint;

/**
 Create a new queue by sorting this one using a comparison function

 @param comparator The function used to sort the queue
 @param context The context
 @return The new queue
 */
- (Queue<ObjectType> *)sortedQueueUsingFunction:(NSInteger (*)(ObjectType, ObjectType, void *))comparator context:(void *)context;

/**
 Create a new queue by sorting this one using a comparison function and a hint

 @param comparator The function used to sort the queue
 @param context The context
 @param hint The hint used to sort the queue
 @return The new queue
 */
- (Queue<ObjectType> *)sortedQueueUsingFunction:(NSInteger (*)(ObjectType, ObjectType, void *))comparator context:(void *)context hint:(NSData *)hint;

/**
 Create a new queue by sorting this one using an array of sort descriptors

 @param sortDescriptors The sort descriptors used to sort the queue
 @return The new queue
 */
- (Queue<ObjectType> *)sortedQueueUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;

/**
 Create a new queue by sorting this one using a selector

 @param comparator The selector used to sort the queue
 @return The new queue
 */
- (Queue<ObjectType> *)sortedQueueUsingSelector:(SEL)comparator;

/**
 Create a new queue by sorting this one using an NSComparator

 @param cmptr The comparator used to sort the queue
 @return The new queue
 */
- (Queue<ObjectType> *)sortedQueueUsingComparator:(NSComparator)cmptr;

/**
 Create a new queue by sorting this ons using an NSComparator, with NSSortOptions

 @param opts The options used to sort the queue
 @param cmptr The comparator used to sort the queue
 @return The new queue
 */
- (Queue<ObjectType> *)sortedQueueWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

/**
 Exchange two objects in the stack by their indexes

 @param idx1 The index of the first object
 @param idx2 The index of the second object
 */
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

/**
 Sort this queue using an array of sort descriptors

 @param sortDescriptors The array of sort descriptors used to sort the queue
 */
- (void)sortUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;

/**
 Sort this queue using an NSComparator

 @param cmptr The comparator used to sort the queue
 */
- (void)sortUsingComparator:(NSComparator)cmptr;

/**
 Sort this queue using an NSComparator, with NSSortOptions

 @param opts The options used to sort the queue
 @param cmptr The comparator used to sort the queue
 */
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

/**
 Sort this queue using a function

 @param compare The function used to sort the queue
 @param context The context
 */
- (void)sortUsingFunction:(NSInteger (*)(ObjectType, ObjectType, void *))compare context:(void *)context;

/**
 Sort this queue using a selector

 @param aSelector The selector used to sort the queue
 */
- (void)sortUsingSelector:(SEL)aSelector;

/**
 @name Working With Strings
 */

/**
 Create a string out of components in the queue, separated by a string

 @param separator The separator used to join strings in the stack
 @return The combined string
 */
- (NSString *)componentsJoinedByString:(NSString *)separator;

/**
 @name Key-Value Observation
 */

/**
 Add an observer to objects in the queue

 @param observer The observer to add
 @param indexes The indexes in the queue to observe
 @param keyPath The key path to observe
 @param options The options to observe
 @param context The context
 */
- (void)addObserver:(NSObject *)observer toObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

/**
 Remove an observer from objects in the queue

 @param observer The observer to remove
 @param indexes The indexes in the queeu to stop observing
 @param keyPath The key path to stop observing
 */
- (void)removeObserver:(NSObject *)observer fromObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath;

NS_ASSUME_NONNULL_END

@end
