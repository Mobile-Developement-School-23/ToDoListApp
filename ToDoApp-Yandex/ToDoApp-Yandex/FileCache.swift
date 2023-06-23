import Foundation

final class FileCache {
    let item1 = ToDoItem(id: UUID().uuidString, title: "Walk the dog", importance: .regular, deadline: Date(), isCompleted: false, createdDate: Date(), changedDate: nil)
    let item2 = ToDoItem(id: UUID().uuidString, title: "Buy groceries", importance: .important, deadline: Date(), isCompleted: false, createdDate: Date(), changedDate: nil)
    let item3 = ToDoItem(id: UUID().uuidString, title: "Do laundry", importance: .unimportant, deadline: nil, isCompleted: false, createdDate: Date(), changedDate: nil)
    enum Constants {
        static let documentDirectory =  FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
    }
    
        //private(set)
    var items: [ToDoItem] = []

    private let fileManager = FileManager.default
    
    func addItem(item: ToDoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        } else {
            items.append(item)
        }
    }
    
    func removeItem(id: String) {
        items.removeAll { $0.id == id }
    }
    
    func saveToJSONFile(named fileName: String = "Items") {
        let fileURL = Constants.documentDirectory[0].appendingPathComponent(fileName)
        let jsonArray = items.map { item -> [String : Any] in
            guard
                let jsonData = item.json as? Data,
                let jsonObject = try? JSONSerialization.jsonObject(with: jsonData),
                let jsonDict = jsonObject as? [String : Any]
            else {
                return [:]
            }
            
            return jsonDict
        }
        
        guard let fileData = try? JSONSerialization.data(withJSONObject: jsonArray) else {
            return
        }
        
        try? fileData.write(to: fileURL)
    }
    
    func uploadJSONFile(named fileName: String = "Items") {
        let filePath = Constants.documentDirectory[0].appendingPathComponent(fileName)
        
        guard
            let fileData = try? Data(contentsOf: filePath),
            let jsonObject = try? JSONSerialization.jsonObject(with: fileData),
            let jsonArray = jsonObject as? [[String : Any]]
        else {
            return
        }
        
        let newItems = jsonArray.compactMap { jsonDict -> ToDoItem? in
            guard
                let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict)
            else {
                return nil
            }
            return ToDoItem.parse(json: jsonData)
        }
        
        items = items.filter { item in
            !newItems.contains(where: { $0.id == item.id } )
        }
        
        items.append(contentsOf: newItems)
    }
    func saveItemsToCSVFile(named fileName: String) {
        let csvRows = items.map { $0.csv
        }
        let csvString = csvRows.joined(separator: "\n")
        let filePath = Constants.documentDirectory[0].appendingPathComponent(fileName)
        print(filePath)
        do {
            try csvString.write(to: filePath, atomically: true, encoding: .utf8)
            print("Items saved to CSV file successfully.")
        } catch {
            print("Error saving items to CSV file: \(error)")
        }
    }
    func uploadCSVFile(named fileName: String){
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "csv") else {
            print("CSV file not found.")
            return
        }
        
        guard let csvString = try? String(contentsOf: fileURL, encoding: .utf8) else {
            print("Failed to read CSV file.")
            return
        }
        let rows = csvString.components(separatedBy: "\n")
        
        for row in rows{
            let item = ToDoItem.parse(csv: row)
                if let item = item {
                    items.append(item)
                }
        }
    }

}















//import Foundation
//
//final class FileCache {
//    private(set) var items: [ToDoItem] = []
//    private let fileManager = FileManager.default
//
//    func addItem(item: ToDoItem) {
//        if let index = items.firstIndex(where: { $0.id == item.id }) {
//            items[index] = item
//        } else {
//            items.append(item)
//        }
//    }
//
//    func removeItem(id: String) {
//        items.removeAll { $0.id == id }
//    }
//
//    func saveToFile(named fileName: String = "Items") {
//        let fileManager = FileManager.default
//        let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        guard let fileURL = documentDirectory?.appendingPathComponent(fileName) else { fatalError("error while creating fileURL") }
//        print(fileURL)
//
//        let jsonArray = items.map { item -> [String: Any] in
//            guard
//                let jsonString = item.json as? String,
//                let jsonData = jsonString.data(using: .utf8),
//                let jsonObject = try? JSONSerialization.jsonObject(with: jsonData),
//                let jsonDictionary = jsonObject as? [String: Any]
//            else{
//                return [:]
//            }
//            return jsonDictionary
//        }
//
//        guard let fileData = try? JSONSerialization.data(withJSONObject: jsonArray) else {
//            return
//        }
//
//        try? fileData.write(to: fileURL)
//    }
//    func readFile(named fileName: String){
//        let fileManager = FileManager.default
//        let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        guard let fileURL = documentDirectory?.appendingPathComponent(fileName) else { fatalError("error while creating fileURL") }
//        print(fileURL)
//        guard
//            let fileData = try? Data(contentsOf: fileURL),
//            let jsonObject = try? JSONSerialization.jsonObject(with: fileData),
//            let jsonArray = jsonObject as? [[String: Any]]
//        else{
//            fatalError("Found an error while converting file data to an array")
//        }
//        let newItems = jsonArray.compactMap { jsonDictionary -> ToDoItem? in
//            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary)
//            else{
//                fatalError("Error while converting jsonDictionary to jsonData")
//            }
//            return ToDoItem.parse(json: jsonData)
//        }
//    }
//
//
//}
