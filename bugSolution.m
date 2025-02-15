To fix this, ensure that you don't access objects after they've been deallocated.  In manual retain-release memory management, carefully manage object lifetimes using `retain`, `release`, and `autorelease`. In ARC (Automatic Reference Counting), ensure that strong references are correctly managed.  Use weak references where appropriate to avoid retaining objects beyond their necessary lifetime.  Here is an example of a solution:

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
        [obj release]; // In manual memory management. In ARC, the obj would be released automatically when it's out of scope
        obj = nil; //  Set the pointer to nil to prevent accidental use.

        //Corrected. Check for nil before accessing object's property
        if(obj != nil){
            NSLog (@"MyString: %@
", obj.myString);
        }
    }
    return 0;
}
```

In ARC, this is less likely due to automatic memory management, but it can still occur if you create circular references or hold onto objects indefinitely.  Use weak references where appropriate to break such cycles.