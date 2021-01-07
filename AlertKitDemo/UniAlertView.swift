////
////  UniAlertView.swift
////  AlertKitDemo
////
////  Created by Alex Nagy on 06.01.2021.
////
//
//import SwiftUI
//
//public struct CustomAlertViewModifier<AlertContent: View>: ViewModifier {
//    
//    @ObservedObject var customAlertManager: CustomAlertManager
//    var alertContent: () -> AlertContent
//    var buttons: [CustomAlertButton]
//    
//    private var requireHorizontalPositioning: Bool {
//        let maxButtonPositionedHorizontally = 2
//        return buttons.count > maxButtonPositionedHorizontally
//    }
//    
//    public func body(content: Content) -> some View {
//        ZStack {
//            content.disabled(customAlertManager.isPresented)
//            if customAlertManager.isPresented {
//                GeometryReader { geometry in
//                    Color.black.opacity(0.2).ignoresSafeArea()
//                    HStack {
//                        Spacer()
//                        VStack {
//                            let expectedWidth = geometry.size.width * 0.7
//                            
//                            Spacer()
//                            VStack(spacing: 0) {
//                                alertContent().padding()
//                                buttonsPad(expectedWidth)
//                            }
//                            .frame(
//                                minWidth: expectedWidth,
//                                maxWidth: expectedWidth
//                            )
//                            .background(Color(.systemBackground).opacity(0.95))
//                            .cornerRadius(13)
//                            Spacer()
//                        }
//                        Spacer()
//                    }
//                    
//                }
//            }
//            
//        }
//    }
//    
//    private func buttonsPad(_ expectedWidth: CGFloat) -> some View {
//        VStack(spacing: 0) {
//            if buttons.count < 1 {
//                fatalError("Please provide at least one button for your custom alert.")
//            }
//            if requireHorizontalPositioning {
//                verticalButtonPad()
//            } else {
//                Divider().padding([.leading, .trailing], -12)
//                horizontalButtonsPadFor(expectedWidth)
//            }
//        }
//    }
//    
//    private func verticalButtonPad() -> some View {
//        VStack(spacing: 0) {
//            ForEach(0..<buttons.count) {
//                Divider().padding([.leading, .trailing], -12)
//                let current = buttons[$0]
//                
//                Button(action: {
//                    if !current.isCancel {
//                        current.action()
//                    }
//                    
//                    withAnimation {
//                        self.customAlertManager.isPresented.toggle()
//                    }
//                }, label: {
//                    current.content
//                })
//                .padding(8)
//                .frame(minHeight: 44)
//            }
//        }
//    }
//    
//    private func horizontalButtonsPadFor(_ expectedWidth: CGFloat) -> some View {
//        
//        HStack(spacing: 0) {
//            let sidesOffset: CGFloat = 12 * 2
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
//                            self.customAlertManager.isPresented.toggle()
//                        }
//                    }, label: {
//                        current.content
//                    })
//                    .padding(8)
//                    .frame(maxWidth: maxHorizontalWidth, minHeight: 44)
//                }
//            }
//            
//            Spacer()
//        }
//    }
//    
//}
//
//public struct CustomAlertButton {
//
//    public enum Variant {
//        case cancel
//        case regular
//    }
//
//    public let content: AnyView
//    public let action: () -> Void
//    public let type: Variant
//
//    public var isCancel: Bool {
//        type == .cancel
//    }
//
//    public static func cancel<Content: View>(@ViewBuilder content: @escaping () -> Content) -> CustomAlertButton {
//        CustomAlertButton(content: content, action: { /* close */ }, type: .cancel)
//    }
//
//    public static func regular<Content: View>(@ViewBuilder content: @escaping () -> Content,
//        action: @escaping () -> Void) -> CustomAlertButton {
//        CustomAlertButton(content: content, action: action, type: .regular)
//    }
//
//    public init<Content: View>(@ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void, type: Variant ) {
//        self.content = AnyView(content())
//        self.type = type
//        self.action = action
//    }
//}
//
//
//extension View {
//    
//    public func customAlert<AlertContent: View>(manager: CustomAlertManager, content: @escaping () -> AlertContent, buttons: [CustomAlertButton]) -> some View {
//        self.modifier(CustomAlertViewModifier(customAlertManager: manager, alertContent: content, buttons: buttons))
//    }
//    
//}
//
//public class CustomAlertManager: ObservableObject {
//    @Published var isPresented: Bool
//    
//    init(isPresented: Bool = false) {
//        self.isPresented = isPresented
//    }
//    
//    func show() {
//        isPresented = true
//    }
//    
//    func dismiss() {
//        isPresented = false
//    }
//}
