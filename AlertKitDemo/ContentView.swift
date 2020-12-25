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
    
    var body: some View {
        VStack(spacing: 12) {
            Button("Show Dismiss Alert") {
                alertManager.show(dismiss: .success(message: "AlertKit is awesome"))
            }
            
            Button("Show Custom Alert") {
                alertManager.show(primarySecondary: .custom(title: "AlertKit", message: "This is an alert", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
            }
            
            Button("Show Error after 2 seconds") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    alertManager.show(dismiss: .error(message: "Something went wrong"))
                }
            }
            
            Button("Show Action Sheet") {
                let buttons: [ActionSheet.Button] = [
                    .destructive(Text("Do some work"), action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            alertManager.show(dismiss: .info(message: "Work done 🎉"))
                        }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
