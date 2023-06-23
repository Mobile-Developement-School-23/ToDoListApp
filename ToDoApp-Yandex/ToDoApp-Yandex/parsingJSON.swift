import Foundation

extension ToDoItem{
    //MARK: -makes ToDoItem from json
    static func parse(json: Any) -> ToDoItem {
        guard
            let jsonString = json as? String,
            let data = jsonString.data(using: .utf8) else {
            fatalError("Error")
        }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let id = json["id"] as? String
                guard
                      let title = json["title"] as? String,
                      let isCompleted = json["isCompleted"] as? Bool,
                      let createdDateString = json["createdDate"] as? String
                else {
                    fatalError("Error")
                }

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
                
                let deadlineString = json["deadline"] as? String ?? ""
                let deadline = dateFormatter.date(from: deadlineString) ?? Date()
                
                let createdDate = dateFormatter.date(from: createdDateString) ?? Date()
                
                let importanceString = json["importance"] as? String
                let importance = priority(rawValue: importanceString ?? "") ?? .regular
                
                let changedDateString = json["changedDate"] as? String
                let changedDate = dateFormatter.date(from: changedDateString ?? "")
                
                let item = ToDoItem(id: id ?? UUID().uuidString, title: title, importance: priority(rawValue: importance.rawValue) ?? .regular, deadline: deadline, isCompleted: isCompleted, createdDate: createdDate, changedDate: changedDate)

                return item
            }
        } catch {
            print(error)
        }

        fatalError("Error:Not Found #404")
    }
    
    //MARK: - json, that contains json as String
    var json: Any{
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"

        var jsonObject: [String: Any?] = [

            "title": title,
            "isCompleted": isCompleted,
            "createdDate": dateFormatter.string(from: createdDate),
            "changedDate": changedDate != nil ? dateFormatter.string(from: changedDate!) : nil ////
        ]
        if id.isEmpty{
            jsonObject["id"] = UUID().uuidString
        }else{
            jsonObject["id"] = id
        }
        if importance != .regular {
            jsonObject["importance"] = importance.rawValue
        }
        if let deadline = deadline{
            jsonObject["deadline"] = dateFormatter.string(from: deadline)
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject),
              let jsonString = String(data: jsonData, encoding: .utf8)
        else{
            fatalError("error")
        }
        return jsonString
    }
}
