# JSDataStructures

![Version](https://img.shields.io/badge/SPM-v1.0.0-blue)
![CI](https://github.com/jaysack/JSDataStructures/workflows/status/badge.svg)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

**JSDataStructures** is a collection of production grade data structures for the Swift programming language.
- - - -
<br>

## Table Of Content
- [📥. Installation](#-installation)
<br>

- [📚. Simple Structures](#-simple-structures)
    * [Stack](#stack)
    * [Queue](#queue)
<br>

- [🔗. Lists](#-lists)
    * [Node](#node)
    * [DoublyLinkedList](#doubly-linked-list)
    * [LRU Cache](#lru-cache)
<br>

- [🌲. Trees](#-trees)
    * [Simple Tree](#simple-tree)
    * [Binary Search Tree](#binary-search-tree)
    * [AVL Tree](#avl-tree)
<br>

- [🛂. Tree Protocols](#-tree-protocols)
    * [Node Protocols](#node-protocols)
    * [Traversal Protocols](#traversal-protocols)
<br>

- [✅. Tests](#-tests)
<br>

- [✉️. Author](#-author)
<br>

- [🔏. License](#-license)
- - - -
<br>

## 📥 Installation
JSDataStructures is available through [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app). Simply add the line below in your Package.swift dependencies.
```swift
.package(url: "https://github.com/jaysack/JSDataStructures", from: "1.0.0"),
```
Once this is done, import the library as follow in your Swift file:
```swift
import JSDataStructures
```
<br>

## 📚 Simple Structures
### Stack
A **Stack** is what its name says it is: a stack!\
It does conform to Apple's `Sequence` protocol and as such, gives you access to a large number of operations that you can perform on any sequence.
```swift
var stack = Stack<Int>()

stack.push(4)
stack.push(8)
stack.push(9)

// Visual Representation ---> BOTTOM | 4 - 8 - 9 | TOP

stack.pop()

// Visual Representation ---> BOTTOM | 4 - 8 | TOP
```
<br>

Although this implementation works perfectly, you can take advantage of the `ExpressibleByArrayLiteral` protocol the stack conforms to and instantiate it with an array instead like in the example below:
```swift
var stack: Stack<Int> = [4, 8, 9]
```
- - - -
<br>

### Queue
A **Queue** is a pretty self-explanatory `Sequence` that allows you to:
- `enqueue(_ value: T)` an element are the end of the queue
- `dequeue()` an element from the beginning of the queue
```swift
var queue = Queue<String>()

queue.enqueue("Andre")
queue.enqueue("Kate")
queue.enqueue("Bob")
queue.enqueue("Tajea")

// Visual Representation ---> FRONT | Andre - Kate - Bob - Tajea | BACK

queue.dequeue()

// Visual Representation ---> FRONT | Kate - Bob - Tajea | BACK

```
- - - -
<br>

## 🔗 Lists
The lists structures in **JSDataStructures** are implemented on top of the `Node` class to create references between list items.
<br>
### Node
A node has the following properties:
- `value`   : its payload
- `prev`     : its reference to its previous node
- `next`     : its reference to its following node

Please note, the reference to the next node is a `weak` reference to avoid retain cycles.\
It makes it easier to detach the last node in the list by assigning it a `nil` value (as opposed to breaking both references between the nodes).

```swift
let aNode = Node<String>("A")
let bNode = Node<String>("B")

aNode.next = bNode

bNode = nil // No retain cycle here, the object is deallocated from memory 🙂
```
- - - -
<br>

### Doubly Linked List
The **DoublyLinkedList** implementation in **JSDataStructure** adds and removes its extremity nodes with a time complexity of *O(1)* while insertion a node at a specific index will give you a time complexity of *O(n)*.

#### Adding Elements
```swift
var list = DoublyLinkedList<Int>()

list.append(7)          // O(1)
// Visual Representation ---> | 7 |

list.push(4)            // O(1)
list.push(1)            // O(1)
// Visual Representation ---> | 1 - 4 - 7 |

list.insert(9, at: 2)   // O(n)
// Visual Representation ---> | 1 - 4 - 9 - 7 |
```
<br>

#### Removing Elements
```swift
let a = list.pop()        // O(1)
// a = 1
// Visual Representation ---> | 4 - 9 - 7 |

list.popLast()            // O(1)
// Visual Representation ---> | 4 - 9 |

list.remove(at: 1)        // O(n)
// Visual Representation ---> | 4 |
```
<br>

**DoublyLinkedList** conforms to the `ArrayLiteralElement` to make its instantiation more readable.
```swift
let list: DoublyLinkedList<String> = ["a", "b", "c"]
```
- - - -
<br>

### LRU Cache
**JSDataStructures** gives you a fast **LRU Cache** with O(1) operations for both checking and inserting values.
```swift
// Instantiate
lruCache = LRUCache<Int>(capacity: 2)

lruCache.insert(3)      // ---> 3
lruCache.insert(7)      // ---> 7 - 3
lruCache.insert(8)      // ---> 8 - 7

lruCache.contains(7)    // ---> 7 - 8
```
- - - -
<br>

## 🌲 Trees
A tree is a hierarchical data structure with a root value and subtrees of children with a parent node, represented as a set of **TreeNode** generic objects.
Each **TreeNode** owns a reference to its parent (if any) and its children

```swift
let root = TreeNode<Int>(4)
let one = TreeNode<Int>(1)
let seven = TreeNode<Int>(7)

root.insert(one)
root.insert(seven)

let childrenValue = root.children.map { $0.value }
print(childrenValue)        // ---> [1, 7]

print(seven.parent.value)   // ---> 4
print(root.parent)          // ---> nil
```

Trees in **JSDataStructures** comes in three different forms:
- Simple Tree: using a **TreeNode** as node object
- Binary Searh Tree: using a **BSTNode** as node object
- Self-balancing Binary Searh Tree: using an **AVLNode** as node object **(COMING SOON)**
<br>

### Simple Tree
A tree node has the following properties
- `value`    : its payload
- `parent`   : its reference to its parent node
- `children` : its reference to its children nodes

Please note, like in the linked node, that the reference to the parent node is a `weak` reference to avoid retain cycles.

### Binary Search Tree
A **BSTNode** is a node inheriting from the **TreeNode** class.
However, a BSTNode can only have at most two children:
- one **left** child with a value smaller than the node payload  
- one **right** child with a value higher than the node payload

This small but important distinction between the two, allows for a much faster interactions in Binary Search Trees
// TBD
- - - -

## ✅ Tests
All data structures in **JSDataStructures** have been thoroughly tested.
To learn more about unit tests used for each structure select the appropriate link below
- [Stack Tests](https://github.com/jaysack/JSDataStructures/blob/master/Tests/JSDataStructuresTests/StackTests.swift)
- [Queue Tests](https://github.com/jaysack/JSDataStructures/blob/master/Tests/JSDataStructuresTests/QueueTests.swift)
- [Doubly Linked List Tests](https://github.com/jaysack/JSDataStructures/blob/master/Tests/JSDataStructuresTests/DoublyLinkedListTests.swift)
- [LRU Cache Tests](https://github.com/jaysack/JSDataStructures/blob/master/Tests/JSDataStructuresTests/LRUCacheTests.swift)
- [Tree Node Tests](https://github.com/jaysack/JSDataStructures/blob/master/Tests/JSDataStructuresTests/TreeNodeTests.swift)
- [BST Node Tests](https://github.com/jaysack/JSDataStructures/blob/master/Tests/JSDataStructuresTests/BSTNodeTests.swift)
- - - -
<br>

## ✉️ Author
Jonathan Sack\
dev@jonathansack.io
- - - -
<br>

## 🔏 License
Copyright © 2021 Jonathan Sack

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
