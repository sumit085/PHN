import UIKit

class DetailVC: UIViewController {
    
    var item: ProductsModel?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let model = item {
            lblTitle.text = model.title ?? ""
            lblPrice.text = model.getPrice()
            lblCategoryName.text = model.category?.name ?? ""
            lblDescription.text = model.description ?? ""
            imgView.setImage(imgUrl: model.category?.image ?? "")
        }
    }
}
