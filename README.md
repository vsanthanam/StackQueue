# Stack + Queue

[![language](https://img.shields.io/badge/language-Objective--C-blue.svg)](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)
[![license](https://img.shields.io/github/license/vsanthanam/StackQueue.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![documentation](https://code.vsanthanam.com/StackQueue/Documentation/badge.svg)](https://code.vsanthanam.com/VSAlert/Documentation/)

## Usage

### Stack
```
Stack *myStack = [[Stack alloc] init];              // []

[myStack push:@"A"];                                // ["A"]
[myStack push:@"B"];                                // ["A", "B"]

[myStack pushObjects:@[@"C", @"D", @"E"]];          // ["A", "B", "C", "D", "E"]

NSString *last = [myStack peek];                    // "E"

[myStack pop];                                      // ["A", "B", "C", "D"]
```

### Queue
```
Queue *myQueue = [[Queue alloc] init];              // []

[myStack enqueue:@"A"];                             // ["A"]
[myStack enqueue:@"B"];                             // ["A", "B"]

[myStack enqueueObjects:@[@"C", @"D", @"E"]];       // ["A", "B", "C", "D", "E"]

NSString *first = [myStack peek];                   // "A"

[myStack dequeue];                                  // ["B", "C", "D", "E"]
```

## Features

### Objective-C Lightweight Generics
```
Stack<NSString *> *myStack = [Stack<NSString *> stack];     // Generic String Stack

[stack push:@"1"];                                          // OK
[stack push:@1];                                            // NOT OK
```

### Objective-C Fast Enumeration
```
Queue<NSNumber *> *myQueue = [Queue queueWithObjects:@1, @2, @3, @4, nil];

for (NSNumber *number in myQueue) {

    // iterate

}

```

### Subscripting
```
Stack<NSString *> *myStack = [Stack stackWithArray:@[@"A", @"B", @"C", @"D"]];

NSString *first = myStack[0]                        // "A"
NSString *second = myStack[1]                       // "B"

```

### Equality, Hashability, Encodability
```
Queue<NSNumber *> *myQueue = [Queue queueWithArray:@[@1, @2, @3, @4]];
Queue<NSNumber *> *myQueue2 = [Queue queueWithArray:@[@1, @2, @3, @4]];

[myQueue isEqualToQueue:myQueue2]                   // YES
[myQueue2 isEqual:myQueue]                          // YES
myQueue.hash == myQueue2.hash                       // YES

NSData *myQueueData = [NSKeyedArchiver archivedDataWithRootObject:myQueue];
Queue<NSNumber *> *myQueue3 = (Queue<NSNumber *> *)[NSKeyedUnarchiver unarchiveObjectWithData:myQueueData];

[myQueue3 isEqual:myQueue]                          // YES
```
### Mass Key-Value Observation
You can observe every object in a stack or a queue using: 
`-addObserver:toObjectsAtIndexes:forKeyPath:options:context:`

You can remove observers using: 
`-removeObserver:fromObjectsAtIndexes:forKeyPath:`

### Sorting & Filtering
See the documentation for details on the various methods for deriving or mutating sorted / filtered stacks & queues.

## Documentation

Documentation is made with Jazzy, and is hosted on GitHub pages. You can find it [here](https://code.vsanthanam.com/StackQueue/Documentation)
