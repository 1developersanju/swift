//
//  ContentView.swift
//  Calculator
//
//  Created by Drole on 15/05/21.
//

import SwiftUI

enum calcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

    var buttonColor: Color{
        switch self {
        case .add,.subtract,.multiply,.divide,.equal:
            return .yellow
        case .clear ,.negative,.percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    var textColor: Color{
        switch self {
        case .add,.subtract,.multiply,.divide,.equal:
            return .black
        case .clear ,.negative,.percent:
            return Color(.white)
        default:
            return Color(.yellow)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var value1 = ""
    @State var Operator = ""
    @State var runningNumber = 0

   @State var currentOperation: Operation = .none
    
    let buttons: [[calcButton]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal],
    ]
    
    var body: some View{
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                
            HStack{
                    Text(Operator)
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                    
                    Spacer()
                    

                    Text(value)
                        .bold()
                        .foregroundColor(.yellow)
                        .font(.system(size: 80))
                     
                    }
                }
                .padding()
                Spacer()

                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) {item in
                            Button(action: {
                                self.buttonTapped(Button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .frame(
                                        width: self.buttonWidth(item: item)
                                        , height: self.buttonHeight()
                                        )
                                    .background(item.buttonColor)
                                    .foregroundColor(item.textColor)
                                    .cornerRadius(15)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
        }
        }
    }
    
    func buttonTapped(Button: calcButton) {
        switch Button {
        case .add,.subtract,.multiply,.divide,.equal:
            if Button == .add{
                self.Operator = "+"
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if Button == .subtract{
                self.Operator = "-"
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if Button == .multiply{
                self.Operator = "x"
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if Button == .divide{
                self.Operator = "/"
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if Button == .equal{
                self.Operator = "="
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"

                case .none:
                    break
                }
            }
            
            if Button != .equal{
                self.value = ""
            }
            
        case .clear:
            self.value = "0"
            self.value1 = ""
            self.Operator = ""

        case .decimal,.negative,.percent:
            break
            
        default:
            let number = Button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: calcButton) -> CGFloat{
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

