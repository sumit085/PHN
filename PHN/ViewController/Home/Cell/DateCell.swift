import UIKit

class DataCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(model: ProductsModel){
       lblTitle.text = model.title ?? ""
       lblPrice.text = model.getPrice()
       lblCategoryName.text = model.category?.name ?? ""
       imgView.setImage(imgUrl: model.category?.image ?? "")
    }
}
