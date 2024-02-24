import SwiftUI

@main
struct MyApp: App {
    @State private var currentPage: Page = .welcomePage
    @State private var showGenericInstructionPopup = true
    @StateObject var homeModel = CarouselViewModel()
    var body: some Scene {
        WindowGroup {
            
            if currentPage == .welcomePage {
                MainView(currentPage: $currentPage)
            } else if currentPage == .homePage {
                
                HomeView(currentPage: $currentPage).environmentObject(homeModel)
            }
//            else if currentPage == .graphPage {
//                Graph_Structure(page: $currentPage, showPopupAgain: $showGenericInstructionPopup)
//                    .transition(.scale)
//                    .transition(.opacity.animation(.easeInOut(duration: 0.25)))
//            }
            else { // .finalPage
                Showdown()
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
            }
            
            //BFS_View(showPopupAgain: $showGenericInstructionPopup)
            
        }
    }
}





