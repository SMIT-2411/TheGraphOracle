//
//  Algo_Detail_View.swift
//  TheGraphOracle
//
//  Created by Smit Patel on 22/02/24.
//

import SwiftUI

struct Algo_Detail_View: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var model: CarouselViewModel
    @State private var showGenericInstructionPopup = true
    @Binding var currentPage: Page
    var animation: Namespace.ID

    var body: some View {
        NavigationView{
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Text("Monday 28 December")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.85))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.top, 10)
                        .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)
                    
                    HStack {
                        Spacer()
                        Text(model.selectedCard.title)
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(Color("cream"))
                            .frame(width: 500, alignment: .center)
                            .padding()
                            .matchedGeometryEffect(id: "Title-\(model.selectedCard.id)", in: animation)
                        
                        Spacer()
                    }
                    
                    
                    if model.showContent
                    {
                        Text(model.selectedCard.description)
                            .fontWeight(.semibold)
                            .font(.system(size: 35))
                            .foregroundColor(Color("cream"))
                            .padding()
                    }
                    
                    Spacer(minLength: 0)
                    
                    
                    NavigationLink{
                        destinationView()
                    }label: {
                        Text("Press to start the Algo!!")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("cream").opacity(1))
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color("cream").opacity(1),lineWidth:3).frame(width: 400,height:40))
                    }
                    
                    
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    model.selectedCard.cardColor
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                        .ignoresSafeArea(.all, edges: .bottom)
                )
                
                // Close button
                VStack {
                    Spacer()
                    
                    if model.showContent {
                        Button(action: closeView, label: {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                                .padding(5)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        })
                        .padding(.bottom)
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            
    }
    
    func destinationView() -> some View {
        switch model.selectedCard.title {
        case "Breadth First Search":
            return AnyView(BFS_View(showPopupAgain: $showGenericInstructionPopup))
        case "Depth First Search":
            return AnyView(DFS_View(showPopupAgain: $showGenericInstructionPopup))
        // Add more cases for other titles as needed
        default:
            return AnyView(EmptyView()) // Default empty view or handle unrecognized titles
        }
    }
    
    
    

    func closeView() {
        withAnimation(.spring()) {
            model.showCard.toggle()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeIn) {
                    model.showContent = false
                }
            }
        }
    }
}
