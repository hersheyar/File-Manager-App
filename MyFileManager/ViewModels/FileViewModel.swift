//
//  FileViewModel.swift
//  MyFileManager
//
//  Created by Andrew Hershey on 10/18/25.
//

import Foundation
import CoreData

final class FileViewModel: ObservableObject {
    @Published var files: [MyFile] = []
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchFiles()
    }

    func fetchFiles() {
        let request: NSFetchRequest<MyFile> = MyFile.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MyFile.createdAt, ascending: false)]
        files = (try? context.fetch(request)) ?? []
    }

    func addFile(name: String, content: String = "Empty file") {
        let file = MyFile(context: context)
        file.name = name
        file.content = content
        file.createdAt = Date()
        save()
    }

    func deleteFile(at offsets: IndexSet) {
        for index in offsets {
            context.delete(files[index])
        }
        save()
    }

    func updateFile(_ file: MyFile, newContent: String) {
        file.content = newContent
        save()
    }

    private func save() {
        do {
            try context.save()
            fetchFiles()
        } catch {
            print("Save error:", error)
        }
    }
}
