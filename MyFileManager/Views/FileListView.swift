//
//  FileListView.swift
//  MyFileManager
//
//  Created by Andrew Hershey on 10/18/25.
//

import SwiftUI

struct FileListView: View {
    @StateObject private var vm = FileViewModel()
    @State private var newName = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New file name", text: $newName)
                        .textFieldStyle(.roundedBorder)
                    Button("Add") {
                        guard !newName.isEmpty else { return }
                        vm.addFile(name: newName)
                        newName = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()

                List {
                    ForEach(vm.files, id: \.objectID) { file in
                        NavigationLink(destination: FileDetailView(file: file, vm: vm)) {
                            VStack(alignment: .leading) {
                                Text(file.name ?? "Untitled")
                                    .font(.headline)
                                Text(file.createdAt?.formatted() ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteFile)
                }
            }
            .navigationTitle("My Files")
        }
    }
}

#Preview {
    FileListView()
}
