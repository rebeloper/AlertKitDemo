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
            
            Spacer()
        }
        .padding()
        .uses(alertManager)
        .onAppear {
            fetchData()
        }
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
