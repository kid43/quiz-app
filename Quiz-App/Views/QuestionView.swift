//
//  QuestionView.swift
//  Quiz-App
//
//  Created by Phong Le on 14/04/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct QuestionView: View {
    @State private var offset_bar: CGFloat = 0
    @State private var index = 0
    @State private var win = 0
    @State private var lose = 0
    @State private var showResult = false
    @Binding var showQuestion: Bool
    @Binding var data: [Question]
    
    var body: some View {
        if self.showResult {
            VStack(spacing: 25) {
                Image("cup")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text("Well Done !!!")
                    .font(.title2)
                    .bold()
                
                HStack(spacing: 15) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .font(.system(size: 22, weight: .bold))
                            
                    Text("\(self.win)")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .font(.system(size: 22, weight: .bold))
                    
                    Text("\(self.lose)")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .padding()
                
                Button(action: { self.showQuestion.toggle() }) {
                    Text("Goto home")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical)
                        .padding(.horizontal, 35)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        } else {
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 6)
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: CGFloat(self.offset_bar), height: 6)
                        .foregroundColor(.green)
                }
                .padding(.vertical)
                
                HStack {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .font(.system(size: 22, weight: .bold))
                            
                    Text("\(self.win)")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .font(.system(size: 22, weight: .bold))
                    
                    Text("\(self.lose)")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .padding()
                
                ZStack {
                    ForEach(self.data.reversed()) { quiz in
                        QuestionItem(index: self.$index, win: self.$win, lose: self.$lose, showResult: self.$showResult, offset_bar: self.$offset_bar, quiz: quiz, data: self.data)
                    }
                }
                
                
                Spacer()
            }
        }
    }
}

struct QuestionItem: View {
    @State private var offset_next: CGFloat = 0
    @Binding var index: Int
    @Binding var win: Int
    @Binding var lose: Int
    @Binding var showResult: Bool
    @Binding var offset_bar: CGFloat
    
    var quiz: Question
    var data: [Question]
    
    @State private var answer = ""
    @State private var success = false
    @State private var answer_right = ""
    @State private var isNext = false
    
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("\(quiz.question)")
                        .font(.title3)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding()
                .padding(.vertical)
                
                VStack(spacing: 20) {
                    VStack {
                        Text(quiz.a)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(self.answer == "a" ? (self.success ? Color.green : Color.blue) : (!self.success && self.answer_right == "a" ? Color.red : Color.black), lineWidth: 1)
                    )
                    .onTapGesture {
                        self.answer = "a"
                    }
                    
                    VStack {
                        Text(quiz.b)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(self.answer == "b" ? (self.success ? Color.green : Color.blue) : (!self.success && self.answer_right == "b" ? Color.red : Color.black), lineWidth: 1)
                    )
                    .onTapGesture {
                        self.answer = "b"
                    }
                    
                    VStack {
                        Text(quiz.c)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(self.answer == "c" ? (self.success ? Color.green : Color.blue) : (!self.success && self.answer_right == "c" ? Color.red : Color.black), lineWidth: 1)
                    )
                    .onTapGesture {
                        self.answer = "c"
                    }
                }

                Spacer()
                HStack(spacing: 15) {
                    Button(action: {
                        if self.answer == quiz.answer {
                            self.success = true
                            self.win += 1
                            self.isNext.toggle()

                            withAnimation {
                                self.offset_bar = self.offset_bar + ((UIScreen.main.bounds.width - 20) / CGFloat(self.data.count))
                            }
                        } else {
                            self.success = false
                            self.answer_right = quiz.answer
                            self.lose += 1
                            self.isNext.toggle()
                        }
                        
                        
                    }) {
                        Text("Submit")
                            .bold()
                            .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .background(!self.isNext ? Color.blue : Color.blue.opacity(0.5))
                            .cornerRadius(15)
                    }
                    .disabled(!self.isNext ? false : true)
                    
                    Button(action: {
                        self.index += 1
                        
                        if self.index > self.data.count - 1 {
                            self.showResult = true
                        }
                        
                        self.isNext.toggle()

                        
                        withAnimation {
                            self.offset_next = 1000
                        }
                        
                        self.answer = ""
                        self.success = false
                        self.answer_right = ""
                        
                    }) {
                        Text("Next")
                            .bold()
                            .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .background(self.isNext ? Color.blue : Color.blue.opacity(0.5))
                            .cornerRadius(15)
                    }
                    .disabled(self.isNext ? false : true)

                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 250)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        }
        .offset(x: (self.offset_next != 0 && self.data[self.index - 1].id! == quiz.id!) ? self.offset_next : 0)
        .rotationEffect(.init(degrees: (self.offset_next != 0 && self.data[self.index - 1].id! == quiz.id!) ? 10 : 0))
    }
}

