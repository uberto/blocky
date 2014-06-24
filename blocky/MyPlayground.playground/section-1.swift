// Playground - noun: a place where people can play

import UIKit


class Foo: NSObject{ func foo() -> String{return "foo"}}

class Bar {func bar() -> String{return "bar"}}


let b: AnyObject = Bar()
//fail b.bar()

let f: AnyObject = Foo()
f.foo()  //it works!



func create() -> AnyObject {
    return Foo()
}



let g : AnyObject = create()

g.foo()

























