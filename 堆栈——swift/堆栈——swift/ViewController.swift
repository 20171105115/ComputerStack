//
//  ViewController.swift
//  堆栈——swift
//
//  Created by 朱博宇 on 2018/11/1.
//  Copyright © 2018 朱博宇. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var number: UITextField!
    
    
    var str = [String]()
    var out = [String]()
    var len:Int = 0
    var cnt = 0
    
    public struct Stack<String> {
        fileprivate var array = [String]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func push(_ element: String) {
            array.append(element)
        }
        
        public mutating func pop() -> String? {
            return array.popLast()
        }
        
        public func peek() -> String? {
            return array.last
        }
    }
    
    public struct NumberStack<T> {
        fileprivate var array = [Double]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func push(_ element: Double) {
            array.append(element)
        }
        
        public mutating func pop() -> Double? {
            return array.popLast()
        }
        
        public func peek() -> Double? {
            return array.last
        }
    }
    
    var st:Stack<String>?
    var nst:NumberStack<Int>?
    
    func isnumber(ch:String) -> Bool {
        if "0"<=ch&&ch<="9"{
            return true
        }else{
            return false
        }
    }
    
    func priority(ch:String) -> Int {
        switch ch {
        case "(":
            return 0
        case "+":
            return 1
        case "-":
            return 1
        case "*":
            return 2
        case "/":
            return 2
        case "^":
            return 2
        default:
            return 0
        }
    }
    
    @IBAction func equal(_ sender: Any) {
        if (number.text?.isEmpty)! {
            print("无运算式，请重新输入\n")
        }else{
            str = [number.text!]
        }
        len = str.count
        for i in 0...len{
            if isnumber(ch: str[i]){//如何将字符串中的单个字符放在out数组里面成为了一个难题
                
                cnt += 1
            }else{
                if str[i]=="("&&st!.isEmpty{
                    st!.push(str[i])
                    continue
                }
                if str[i]==")"{
                    while(st!.peek() != "("){
                        out[cnt] = st!.peek()!
                        cnt += 1
                        st!.pop()
                    }
                    st!.pop()
                }
                while((st!.isEmpty != true)&&(st!.peek() != "(")&&(priority(ch: st!.peek()!))<(priority(ch: str[i]))){
                    st!.push(st!.peek()!)
                    st!.pop()
                }
                st!.push(str[i])
            }
        }
        out[cnt] = "\0"
        var temp:Double = 0.0
        for i in 0...cnt{
            if isnumber(ch: out[i]){
                nst!.push(Double(out[i])!)
            }else if out[i] == "+"{
                temp += nst!.peek()!
                nst!.pop()
            }else if out[i] == "-"{
                temp -= nst!.peek()!
                nst!.pop()
            }else if out[i] == "*"{
                temp *= nst!.peek()!
                nst!.pop()
            }else if out[i] == "/"{
                temp /= nst!.peek()!
                nst!.pop()
            }else if out[i] == "^"{
                pow(temp, nst!.peek()!)
                nst!.pop()
            }
        }
        number.text = "\(temp)"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    

}

