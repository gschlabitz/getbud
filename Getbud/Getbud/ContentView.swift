//
//  ContentView.swift
//  Getbud
//
//  Created by Guido Schlabitz on 4/6/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var isProcessing = false
    @State private var spreadsheetURL: URL?
    
    var body: some View {
        VStack {
            
            Button("Create a new Getbud spreadsheet") {
                createNumbersFile()
            }
            .disabled(isProcessing)
            
            Button("Select an existing Getbud spreadsheet") {
                importNumbersFile()
            }
            .disabled(isProcessing)
            
            if spreadsheetURL != nil {
                Text("Selected: \(spreadsheetURL!.lastPathComponent)")
            }
        }
        .padding()
        
    }
    
    private func importNumbersFile() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [UTType(importedAs: "com.apple.iWork.Numbers.sffnumbers")]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false

        if panel.runModal() == .OK, let url = panel.url {
            spreadsheetURL = url
        }
    }

    private func createNumbersFile() {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [UTType(importedAs: "com.apple.iWork.Numbers.sffnumbers")]
        panel.nameFieldStringValue = "New Spreadsheet"

        if panel.runModal() == .OK, var url = panel.url {
            if url.pathExtension.lowercased() != "numbers" {
                url.appendPathExtension("numbers")
            }

            // Example: copy a starter template from your app bundle or create an empty file
            do {
                // For now, just create an empty file or placeholder zip
                try Data().write(to: url)
                spreadsheetURL = url
                print("Created new file at: \(url.path)")
            } catch {
                print("Failed to create file: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
