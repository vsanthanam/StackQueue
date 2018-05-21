//
//  Stack.h
//  stackqueue
//
//  Created by Varun Santhanam on 5/11/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

@import Foundation;

/**
 A LIFO Stack implemented in Objective-C, backed by an NSArray
 */
@interface Stack<__covariant ObjectType> : NSObject<NSSecureCoding, NSCopying, NSFastEnumeration>

NS_ASSUME_NONNULL_BEGIN

/**
 @name Factory Methods
 */

/**
 Create a empty stack
 
 @return The stack
 */
+ (nullable instancetype)stack;

/**
 Create a stack with a single object
 
 @param object The object
 @return The stack
 */
+ (nullable instancetype)stackWithObject:(ObjectType)object;

/**
 Create a stack with a list of objects (requires nil termination)
 
 @param firstObj The list of objects
 @return The stack
 */
+ (nullable instancetype)stackWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Create a stack with a C array
 
 @param objects The C array
 @param cnt The length of the C array
 @return The stack
 */
+ (nullable instancetype)stackWithObjects:(ObjectType const *)objects count:(NSUInteger)cnt;

/**
 Create a stack with an NSArray
 
 @param array The NSArray
 @return The stack
 */
+ (nullable instancetype)stackWithArray:(NSArray<ObjectType> *)array;

/**
 @name Initializers
 */

/**
 Create a stack with an object

 @param object The object
 @return The stack
 */
- (nullable instancetype)initWithObject:(ObjectType)object;

/**
 Create a stack with a list of objects (requires nil termination)

 @param firstObj List of objects
 @return The stack
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
 @name Push, Peek, Pop
 */

/**
 Add an object to the top of the stack

 @param object The object to add
 */
- (void)push:(ObjectType)object;

/**
 Add objects to the top of the stack

 @param objects The objects to add t othe stack
 */
- (void)pushObjects:(NSArray<ObjectType> *)objects;

/**
 View the item at the top of the stack

 @return The item at the top of the stack
 */
- (nullable ObjectType)peek;

/**
 Remove the item from the top of the stack and return it

 @return The item formerly at the top of the stack
 */
- (nullable ObjectType)pop;

/**
 @name Equality & Content Checking
 */

/**
 The number of items in the stack
 */
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger count;

/**
 Compare two stacks for equality
 
 @param stack The other stack to compare
 @return YES if the stacks are equivelent, otherwise NO.
 */
- (BOOL)isEqualToStack:(nullable Stack<ObjectType> *)stack;

/**
 Check if a stack ontains an object
 
 @param object The object to search for in the stack
 @return YES if the stack contains the object, otherwise NO.
 */
- (BOOL)containsObject:(ObjectType)object;

/**
 @name Get Objects
 */

/**
 Get the object in the stack at the given index

 @param index The index
 @return The item at the index
 */
- (ObjectType)objectAtIndex:(NSUInteger)index;

/**
 Get the objects at the given indexes in the stack

 @param indexes The indexes
 @return The items at the indexes
 */
- (NSArray<ObjectType> *)objectsAtIndexes:(NSIndexSet *)indexes;

/**
 Get the object at the given index of the stack, via subscript.

 @note You don't need to invoke this method explicitly. `myStack[3]` is compiled to `[myStack objectAtIndexedSubscript:3]`
 @param idx The index
 @return The item at the index
 */
- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;

/**
 @name Get Index Of Object
 */

/**
 Get the index of a given object

 @note if the stack contains duplicates, the index of the first one will be used
 @param object The object
 @return The index of the object, if it exists, otherwise NSNotFound.
 */
- (NSUInteger)indexOfObject:(ObjectType)object;

/**
 Get the index of a given object, if it exists within a specific range
 
 @note if the stack contains duplicates within the specified range, the index of the first one will be used
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
 Perform a selector on every object in the stack

 @param aSelector The selector to perform
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector;

/**
 Perform a selector on every object in the stack, with a given object

 @param aSelector The selector to perform
 @param argument The object
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;

/**
 @name Enumeration
 */

/**
 Enumerate over the contents of the stack with a block

 @param block The block to execute over each object in the stack
 */
- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 Enumerate over the contents of the stack with a block and enumneration control

 @param opts The options to control enumeration
 @param block The block to execute over each object
 */
- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 Enumerate over the contents of the stack over a given set of indexes

 @param s The set of indexes to enumerate over
 @param opts The options used to control enumeration
 @param block The block to execute over each object
 */
- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

/**
 Create an NSEnumerator to enumerate over the stack

 @return The NSEnumerator object specific to this stack instance
 */
- (NSEnumerator *)objectEnumerator;

/**
 @name Deriving Stacks
 */

/**
 Create a new stack by pushing an object to this one

 @param object The object to push
 @return The new stack, created by pushing an object to this stack
 */
- (Stack<ObjectType> *)stackByPushing:(ObjectType)object;

/**
 Create a new stack by pushing objects to this one

 @param objects The objects to push
 @return The new stack, created by pushing objects to this stack
 */
- (Stack<ObjectType> *)stackByPushingObjects:(NSArray<ObjectType> *)objects;

/**
 Create a new stack by popping this one

 @return The new stack, created by popping this one
 */
- (Stack<ObjectType> *)stackByPopping;

/**
 Create a stack by filtering out objects from this one using an NSPredicate

 @param predicate The predicate used to filter out objects
 @return The new stack
 */
- (Stack<ObjectType> *)filteredStackUsingPredicate:(NSPredicate *)predicate;

/**
 Create a stack using a portion of this one

 @param range The range of the stack to use
 @return The new stack
 */
- (Stack<ObjectType> *)subStackWithRange:(NSRange)range;

/**
 @name Sorting
 */

/**
 Hint used to speeding up / optimizing sorting
 */
@property (NS_NONATOMIC_IOSONLY, readonly) NSData *sortedStackHint;

/**
 Create a new stack by sorting this one using a comparison function

 @param comparator The function used to sort the stack
 @param context The context
 @return The new stack
 */
- (Stack<ObjectType> *)sortedStackUsingFunction:(NSInteger (*)(ObjectType, ObjectType, void *))comparator context:(void *)context;

/**
 Create a new stack by sorting this one using a comparison function and a hint

 @param comparator The function used to sort the stack
 @param context The context
 @param hint The hint used to sort the stack
 @return The new stack
 */
- (Stack<ObjectType> *)sortedStackUsingFunction:(NSInteger (*)(ObjectType, ObjectType, void *))comparator context:(void *)context hint:(NSData *)hint;

/**
 Create a new stack by sorting this one using an array of sort descriptors

 @param sortDescriptors The sort descriptors used to sort the stack
 @return The new stack
 */
- (Stack<ObjectType> *)sortedStackUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;

/**
 Create a new stack by sorting this one using a selector

 @param comparator The selector used to sort the stack
 @return The new stack
 */
- (Stack<ObjectType> *)sortedStackUsingSelector:(SEL)comparator;

/**
 Create a new stack by sorting this one using an NSComparator

 @param cmptr The comparator used to sort the stack
 @return The new stack
 */
- (Stack<ObjectType> *)sortedStackUsingComparator:(NSComparator)cmptr;

/**
 Create a new stack by sorting this one using an NSComparator, with NSSortOptions

 @param opts The options used to sort the stack
 @param cmptr The comparator used to sort the stack
 @return The new stack
 */
- (Stack<ObjectType> *)sortedStackWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

/**
 Exchange two objects in the stack by their indexes

 @param idx1 The index of the first object
 @param idx2 The index of the second object
 */
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

/**
 Sort this stack using an array of sort descriptors

 @param sortDescriptors The array of sort descriptors used to sort the stack
 */
- (void)sortUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;

/**
 Sort this stack using an NSComparator

 @param cmptr The comparator used to sort the stack
 */
- (void)sortUsingComparator:(NSComparator)cmptr;

/**
 Sort this stack using an NSComparator, with NSSortOptions

 @param opts The options used to sort the stack
 @param cmptr The comparator used to sort the stack
 */
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

/**
 Sort this stack using a function

 @param compare The function used to sort the stack
 @param context The context
 */
- (void)sortUsingFunction:(NSInteger (*)(ObjectType, ObjectType, void *))compare context:(void *)context;

/**
 Sort this stack using a selector

 @param aSelector The selector used to sort the stack
 */
- (void)sortUsingSelector:(SEL)aSelector;

/**
 @name Working With String Elements
 */

/**
 Create a string out of the compoments in the stack, separated by a string.

 @param separator The separator used to join the strings in the stack
 @return The combined string
 */
- (NSString *)componentsJoinedByString:(NSString *)separator;

/**
 @name Key-Value Observation
 */

/**
 Add an observer to objects in the stack

 @param observer The observer to add
 @param indexes The indexes in the stack to observe
 @param keyPath The key path to observe
 @param options The options to observe
 @param context The context
 */
- (void)addObserver:(NSObject *)observer toObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

/**
 Remove an ovserver from objects in the stack

 @param observer The observer to remove
 @param indexes The indexes in the stack to stop observing
 @param keyPath The key path to stop observing
 */
- (void)removeObserver:(NSObject *)observer fromObjectsAtIndexes:(NSIndexSet *)indexes forKeyPath:(NSString *)keyPath;

NS_ASSUME_NONNULL_END

@end
