This error occurs when you try to send a message to an object that has already been deallocated. This often happens when you have strong references to objects that are no longer needed, leading to memory leaks and crashes.  Here's an example:

```objectivec
@interface MyClass : NSObject
@property (strong, nonatomic) NSString *myString;
@end

@implementation MyClass
- (void)dealloc {
    NSLog (@"MyClass deallocated");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyClass *obj = [[MyClass alloc] init];
        obj.myString = "Hello";

        // ... some code ... 

        // obj is deallocated here
        [obj release]; // In manual memory management 
        obj = nil; // Or in ARC, obj goes out of scope

        // ... more code ...

        // Crash!  Attempting to use a deallocated object
        NSLog (@"MyString: %@
", obj.myString); 
    }
    return 0;
}
```