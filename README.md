# JSDataStructures

[![Version](https://img.shields.io/cocoapods/v/JSConstraints.svg?style=flat)](https://cocoapods.org/pods/JSConstraints)
![CI](https://github.com/jaysack/JSConstraints/workflows/status/badge.svg)
[![Platform](https://img.shields.io/cocoapods/p/JSConstraints.svg?style=flat)](https://cocoapods.org/pods/JSConstraints)
[![License](https://img.shields.io/cocoapods/l/JSConstraints.svg?style=flat)](https://cocoapods.org/pods/JSConstraints)

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
A **Stack** is what its name says it is: a stack!
It does conform to Apple's `Sequence` protocol and as such, gives you access to a large number of operations that you can perform on any sequence.
```swift
var stack = Stack<Int>()
stack.push(4)
stack.push(8)
stack.push(9)
// Visual Representation ---> BOTTOM - 4 - 8 - 9 - TOP
```

Although this implementation works perfectly, you can take advantage of the `ExpressibleByArrayLiteral` protocol the stack conforms to and instantiate it with an array instead like in the example below:
```swift
var stack: Stack<Int> = [4, 8, 9]
```
- - - -
<br>

### Queue
A **Queue** is a pretty self-explanatory `Sequence` that allows you to `enqueue()` and `dequeue()` elements.
- - - -
<br>

## 🔗 Lists
The lists structures in **JSDataStructures** are implemented on top of the `Node` class to create references between list items.
<br>
### Node
A list item with a `value`, a reference `prev` to the previous node, and a `next` reference to the following node.
Please note, the reference to the next node is a `weak` reference to avoid retain cycles.
It also makes it easier to detach the last node in the list by assigning it a `nil` value (as opposed to breaking both references between the nodes).
```swift
let aNode = Node<String>("A")
let bNode = Node<String>("B")

aNode.next = bNode
bNode.prev = aNode (Optional: you may not need this line depending on what you're working on)

bNode = nil // No retain cycle here, the object is deallocated from memory 🙂 
```
<br>

### DoublyLinkedList
The **DoublyLinkedList** implementation in **JSDataStructure** adds and removes its extremity nodes with a time complexity of *O(1)* while insertion a node at a specific index will give you a time complexity of *O(n)*.
```swift
var list = DoublyLinkedList<Int>()

list.append(7)          // O(1)
list.push(4)            // O(1)
list.push(1)            // O(1)

list.insert(9, at: 2)   // O(n)
```
<br>

**DoublyLinkedList** conforms to the `ArrayLiteralElement` to make its instantiation more readable.
```swift
let list: DoublyLinkedList<String> = ["a", "b", "c"]
```
<br>

### LRU Cache
**JSDataStructures** gives you a *doubly linked list implementation* of the **Least Recently Used (LRU) Cache**.
Hence, accessing the least recently used item is executed in O(1) time complexity while accessing any other item is a time complexity of O(n).
```swift
// Instantiate
lruCache = LRUCache<Int>(capacity: 2)
lruCache.insert(3)  // ---> 3
lruCache.insert(7)  // ---> 7 - 3
lruCache.insert(8)  // ---> 8 - 7
```
> 💡 While other implementations could give you a time complexity of O(1) to access any index this **LRU Cache** uses a Doubly Linked List as storage.

<br>

## 🌲 Trees
<img src="https://jaysack-github-readme.s3.us-east-2.amazonaws.com/jsconstraints/relative-constraints-example.png" alt="Pink constraints to left and bottom in Xcode simulator">

```swift
indigoView.setConstraints([
    .relWidth(view.widthAnchor) * .multiplier(0.4),
    .relHeight(pinkSquare.heightAnchor) * .multiplier(1.18)
])

// We're assuming here that the indigo view's in already in
// its superview's stack and has been constrained from its top and right sides.
```
<br>

#### What Just Happened?
We set the width of `indigoView` to be 0.4 times the size of  `view` width.\
We also set `indigoView` to be slightly taller than our `pinkSquare`.

> 💡 `multiplier` argument is optional and replaced by 1 if not provided.
- - - -
<br>

### Centering a View
<img src="https://jaysack-github-readme.s3.us-east-2.amazonaws.com/jsconstraints/centering-view-example.png" alt="Yellow circle in Xcode simulator">

```swift
yellowCircle.centerIn(superview: self.view)
```
<br>

#### What Just Happened?
We constrained `yellowCircle` in the **center** of the the screen.
- - - -
<br>


### Pin to Superview
<img src="https://jaysack-github-readme.s3.us-east-2.amazonaws.com/jsconstraints/pin-to-superview-example.png" alt="Indigo view pinned to superview in Xcode simulator">

```swift
indigoView.pinTo(superview: self.view, withPadding: 18)
```  

- - - -
<br>

## ⚠️ What About `UILayoutGuide` Cases?
Depending on your design, you may opt to pin your view to either your ViewController's `view` or it's `layoutGuide` as both are supported with JSConstraints.\
Using `layoutGuide` will automatically add a child view to the layout guide's owner view:
```swift
indigoView.pinTo(layoutGuide: view.safeAreaLayoutGuide)

// Indigo view was automatically added to `view` subviews
```
- - - -
<br>


## ♻️ How About Dynamic Constraints?
JSConstraints methods always return the collection of successfully activated constraints.\
We can use it to toggle between  `active` and `inactive` states.
<br>

### 1. Get Active Constraints
```swift
// Save returned constraints
var pinkOptionalConstraints = pinkSquare.setConstraints([ bottomConstraint, leadingConstraint ])
var indigoOptionalConstraints = indigoView.setConstraints([ topConstraint, trailingConstraint ])

// Append to array of dynamic constraints
dynamicConstraints.append(contentsOf: pinkOptionalConstraints)
dynamicConstraints.append(contentsOf: indigoOptionalConstraints)
```
Here, a list of activated constraints of type `[NSLayoutConstraint]` is returned to us. We can save the result in `dynamicConstraints` variable.\
<br>

### 2. Update Constraints
```swift
// Deactivate optional constraints
dynamicConstraints.deactivateAll()

// Set new constraints
[pinkSquare, indigoView].forEach { $0.centerIn(superview: view) }
```
Here, we’re deactivating our optional constraints, then, adding new constraints.
- - - -
<br>

### 3. Animation
<img src="https://jaysack-github-readme.s3.us-east-2.amazonaws.com/jsconstraints/dynamic-constraints-example.gif" alt=" Subviews animations" height>

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
