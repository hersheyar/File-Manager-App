//
//  FileDetailView.swift
//  MyFileManager
//
//  Created by Andrew Hershey on 10/18/25.
//

import SwiftUI

struct FileDetailView: View {
    @ObservedObject var file: MyFile
    @ObservedObject var vm: FileViewModel
    @State private var text: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .padding()
                .border(Color.gray.opacity(0.4))
                .onAppear {
                    text = file.content ?? ""
                }

            Button("Save Changes") {
                vm.updateFile(file, newContent: text)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .navigationTitle(file.name ?? "Untitled")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let vm = FileViewModel(context: context)
    let sample = MyFile(context: context)
    sample.name = "Example"
    sample.content = "Hello, world!"
    sample.createdAt = Date()
    return NavigationView {
        FileDetailView(file: sample, vm: vm)
    }
}

