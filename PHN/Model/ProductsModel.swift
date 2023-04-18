import Foundation

struct ProductsModel: Codable{
    let id: Int?
    let title: String?
    let price: Int?
    let description: String?
    let images: [String]?
    let category: CategoryModel?
    
    func getPrice() -> String {
        if let amount = price {
            return "Rs. \(amount)"
        } else {
            return ""
        }
    }
}

struct CategoryModel: Codable{
    let id: Int?
    let name: String?
    let image: String?
}
