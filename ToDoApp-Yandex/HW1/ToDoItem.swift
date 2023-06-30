import Foundation

struct ToDoItem{
    let id: String
    let title: String
    let importance: priority
    let deadline: Date?
    let isCompleted: Bool
    let createdDate: Date
    let changedDate: Date?
}
enum priority: String, Codable{
    case unimportant = "неважная"
    case regular = "обычная"
    case important = "важная"
}




