//
//  ContentView.swift
//  AlertKitDemo
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI
import AlertKit

struct ContentView: View {
    
    @StateObject var alertManager = AlertManager()
    @ObservedObject private var viewModel = ContentViewModel()
    
    @State private var customAlertText: String = ""
    
    @StateObject var customAlertManager = CustomAlertManager()
    @StateObject var customAlertManager2 = CustomAlertManager()
    @StateObject var customAlertManager3 = CustomAlertManager()
    
    var body: some View {
        VStack(spacing: 12) {
            Button("Show dismiss Alert") {
                //                alertManager.show(dismiss: .custom(title: "AlertKit", message: "This is an alert", dismissButton: .cancel()))
                alertManager.show(dismiss: .success(message: "AlertKit is awesome"))
                //                alertManager.show(dismiss: .error(message: "AlertKit is awesome"))
                //                alertManager.show(dismiss: .warning(message: "AlertKit is awesome"))
                //                alertManager.show(dismiss: .info(message: "AlertKit is awesome"))
            }
            
            Button("Show primarySecondary Alert") {
                alertManager.show(primarySecondary: .custom(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
                //                alertManager.show(primarySecondary: .success(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
                //                alertManager.show(primarySecondary: .error(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
                //                alertManager.show(primarySecondary: .warning(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
                //                alertManager.show(primarySecondary: .info(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
            }
            
            Button("Show Action Sheet") {
                let buttons: [ActionSheet.Button] = [
                    .destructive(Text("Do some work"), action: {
                        fetchData()
                    }),
                    .default(Text("Nothing")),
                    .cancel()
                ]
                alertManager.showActionSheet(.custom(title: "Action Sheet", message: "What do you want to do next?", buttons: buttons))
            }
            
            
            Button(action: {
                customAlertManager.show()
            }, label: {
                Text("Show custom alert")
            })
            
            Button(action: {
                customAlertManager2.show()
            }, label: {
                Text("Show custom alert 2")
            })
            
            Button(action: {
                customAlertManager3.show()
            }, label: {
                Text("Show custom alert 3")
            })
            
            Spacer()
        }
        .padding()
        .uses(alertManager)
        .customAlert(manager: customAlertManager, content: {
            VStack {
                Text("Hello Custom Alert").bold()
                TextField("Enter email", text: $customAlertText).textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }, buttons: [
            .cancel(content: {
                Text("Cancel").bold()
            }),
            .regular(content: {
                Text("Send")
            }, action: {
                print("Sending email: \(customAlertText)")
            })
        ])
        .customAlert(manager: customAlertManager2, content: {
            VStack(spacing: 12) {
                Text("Hello Custom Alert 2").bold()
                Text("Some message here")
            }
        }, buttons: [
            .regular(content: {
                Text("Go")
            }, action: {
                print("Go")
            }),
            .cancel(content: {
                Image(systemName: "bell.slash.fill").resizable().frame(width: 33, height: 33).foregroundColor(Color(.systemPurple))
            }),
            .cancel(content: {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.").bold()
            })
        ])
        .customAlert(manager: customAlertManager3, content: {
            Text("Must provide at least one button")
        }, buttons: [
//            .regular(content: {
//                Text("Go")
//            }, action: {
//                print("go")
//            })
        ])
        .onAppear {
            fetchData()
        }
//        .universalAlert(isShowing: $isShowingErrorUniversalAlert, content: {
//            Text("Error")
//            Text(universalAlertError)
//        }, actions: [
//            .cancel(content: {
//                Text("OK").bold()
//            })
//        ])
//        .universalAlert(isShowing: $isShowingUniversalAlert, content: {
//            Text("title")
//            Image(systemName: "phone")
//                .scaleEffect(3)
//                .frame(width: 100, height: 100)
//            TextField("enter text here", text: $text).textFieldStyle(RoundedBorderTextFieldStyle())
//            Text("description")
//        }, actions: [
//            .regular(content: {
//                Text("Hey")
//            }, action: {
//                print("Hey")
//            }),
//            .cancel(content: {
//                Text("Cancel").bold()
//            })
//        ])
        
    }
    
    func fetchData() {
        // to see all cases please modify the Result in ContentViewModel
        self.viewModel.fetchData { (result) in
            switch result {
            case .success(let finished):
                if finished {
                    alertManager.show(dismiss: .info(message: "Successfully fetched data", dismissButton: Alert.Button.default(Text("Alright"))))
                } else {
                    alertManager.show(primarySecondary: .error(title: "🤔", message: "Something went wrong", primaryButton: Alert.Button.default(Text("Try again"), action: {
                        fetchData()
                    }), secondaryButton: .cancel()))
                }
            case .failure(let err):
                alertManager.show(dismiss: .error(message: err.localizedDescription))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//
//
//
//public struct UniversalAlertViewModel {
//    public let backgroundColor: Color = Color.gray.opacity(0.4)
//    public let contentBackgroundColor: Color = Color.white.opacity(0.95)
//    public let contentPadding: CGFloat = 12
//    public let contentCornerRadius: CGFloat = 13
//
//    public init() { }
//}
//
//struct UniversalAlert<Presenter, Content>: View where Presenter: View, Content: View {
//
//    @Binding private (set) var isShowing: Bool
//
//    let displayContent: Content
//    let buttons: [CustomAlertButton]
//    let presentationView: Presenter
//    let viewModel: UniversalAlertViewModel
//
//    private var requireHorizontalPositioning: Bool {
//        let maxButtonPositionedHorizontally = 2
//        return buttons.count > maxButtonPositionedHorizontally
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                backgroundColor()
//
//                VStack {
//                    Spacer()
//
//                    ZStack {
//                        presentationView.disabled(isShowing)
//                        let expectedWidth = geometry.size.width * 0.7
//
//                        VStack {
//                            displayContent.padding(viewModel.contentPadding)
//                            buttonsPad(expectedWidth)
//                        }
//                        .background(viewModel.contentBackgroundColor)
//                        .cornerRadius(viewModel.contentCornerRadius)
//                        .shadow(radius: 1)
//                        .opacity(self.isShowing ? 1 : 0)
//                        .frame(
//                            minWidth: expectedWidth,
//                            maxWidth: expectedWidth
//                        )
//                    }
//
//                    Spacer()
//                }
//            }
//        }
//    }
//
//    private func backgroundColor() -> some View {
//        viewModel.backgroundColor
//            .edgesIgnoringSafeArea(.all)
//            .opacity(self.isShowing ? 1 : 0)
//    }
//
//    private func buttonsPad(_ expectedWidth: CGFloat) -> some View {
//        VStack(spacing: 0) {
//            if requireHorizontalPositioning {
//                verticalButtonPad()
//            } else {
//                Divider().padding([.leading, .trailing], -viewModel.contentPadding)
//                horizontalButtonsPadFor(expectedWidth)
//            }
//        }
//    }
//
//    private func verticalButtonPad() -> some View {
//        VStack {
//            ForEach(0..<buttons.count) {
//                Divider().padding([.leading, .trailing], -viewModel.contentPadding)
//                let current = buttons[$0]
//
//                Button(action: {
//                    if !current.isCancel {
//                        current.action()
//                    }
//
//                    withAnimation {
//                        self.isShowing.toggle()
//                    }
//                }, label: {
//                    current.content.frame(height: 35)
//                })
//            }
//        }
//    }
//
//    private func horizontalButtonsPadFor(_ expectedWidth: CGFloat) -> some View {
//        HStack {
//            let sidesOffset = viewModel.contentPadding * 2
//            let maxHorizontalWidth = requireHorizontalPositioning ?
//                expectedWidth - sidesOffset :
//                expectedWidth / 2 - sidesOffset
//
//            Spacer()
//
//            if !requireHorizontalPositioning {
//                ForEach(0..<buttons.count) {
//                    if $0 != 0 {
//                        Divider().frame(height: 44)
//                    }
//                    let current = buttons[$0]
//
//                    Button(action: {
//                        if !current.isCancel {
//                            current.action()
//                        }
//
//                        withAnimation {
//                            self.isShowing.toggle()
//                        }
//                    }, label: {
//                        current.content
//                    })
//                    .frame(maxWidth: maxHorizontalWidth, minHeight: 44)
//                }
//            }
//            Spacer()
//        }
//    }
//}
//
//extension View {
//    func universalAlert<Content>(isShowing: Binding<Bool>, viewModel: UniversalAlertViewModel = UniversalAlertViewModel(), @ViewBuilder content: @escaping () -> Content, actions: [CustomAlertButton]) -> some View where Content: View {
//        UniversalAlert(isShowing: isShowing, displayContent: content(), buttons: actions, presentationView: self, viewModel: viewModel)
//    }
//}
//
//extension Bool {
//    mutating func toggleWithAnimation() {
//        withAnimation {
//            self.toggle()
//        }
//    }
//
//    mutating func trueWithAnimation() {
//        withAnimation {
//            self = true
//        }
//    }
//
//    mutating func falseWithAnimation() {
//        withAnimation {
//            self = false
//        }
//    }
//}
