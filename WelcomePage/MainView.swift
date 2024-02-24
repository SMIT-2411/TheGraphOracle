//
//  MainView.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 17/02/24.
//




import SwiftUI
import UIKit

struct MainView: View {
    
    
    @Binding var currentPage: Page
    @State var selectedPage = 0
    @State private var create = false
    @State private var login = false
    @State var isLogedIn: Bool = false
    @State var isCreated: Bool = false
    var body: some View {
        
        // Main Stack
                ZStack{
                    Color("cream")
                        .edgesIgnoringSafeArea(.all)
                    
                    Circle()
                        .frame(width: 1200, height: 1200)
                        .foregroundColor(Color("blue1"))
                        .offset(x: 0, y: -370)
                    
                    
                    Circle()
                        .frame(width:1150 , height: 1150)
                        .foregroundColor(Color("blue2").opacity(0.4))
                        .offset(x: 0, y: -400)
                    
                    
                    TabView(selection: $selectedPage)
                    {
                        ForEach(0..<2){
                            index in CardView(card : testData[index]).tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    
                    
                    
                    
                    
                    
                    
                    //Selected Pages
                    if (selectedPage == 1)
                    {
                        
                        ZStack{
                            
                            CircleView().offset(x: -100, y: -130)
                            
                            Image("happy")
                                .resizable()
                                .frame(width: 550, height: 550)
                                .offset(x:-100 , y:-120)
                            
                            
                            ZStack{
                                Image(systemName: "message.fill")
                                    .foregroundColor(Color("cream"))
                                    .font(.system(size: 120))
                                    .scaleEffect(login ? 1 : 0)
                                
                                Text("Easy 🧐!")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                    .opacity(0.65)
                                    .scaleEffect(create ? 1 : 0)
                                    .opacity(create ? 1 : 0)

                                
                            }
                            .animation(.easeOut(duration: 2), value:create)
                            .onAppear(perform: {
                                create = true
                            })
                            .offset(x: 50, y: -350)
                            
                        }
                        .offset(x: 100, y: -150)
                        
                      Button {
                          self.currentPage = .homePage
                        } label: {
                            Text("Tap for Graph Insights")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("blue2").opacity(1))
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color("blue2").opacity(1),lineWidth:3).frame(width: 400,height:40))
                        } .offset(y: 580)
                        
                    }
                    
                    
                    if (selectedPage == 0)
                    {
                        ZStack{
                            
                            CircleView()  .offset(x: -100, y: -130)
                            
                            Image("work")
                                .resizable()
                                .frame(width: 550, height: 550)
                                .offset(x:-100 , y:-120)
                            
                            ZStack{
                                Image(systemName: "message.fill")
                                    .foregroundColor(Color("cream"))
                                    .font(.system(size: 120))
                                    .scaleEffect(login ? 1 : 0)
                                
                                Text("Graph🤯!")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                    .opacity(0.65)
                                    .scaleEffect(create ? 1 : 0)
                                    .opacity(create ? 1 : 0)

                            }
                            .animation(.easeOut(duration: 2), value: login)
                            .onAppear(perform: {
                               login = true
                            })
                            .offset(x: 50, y: -350)
                            
                            
                            
                        }
                        .offset(x: 100, y: -150)
                        
        
                    }
                }
        }
    
   
        
    }

#Preview {
    MainView(currentPage: .constant(.welcomePage)).preferredColorScheme(.light)
}


