import UIKit

class HomeVC: UIViewController {
    
    var items: [ProductsModel] = []
    private let viewModel = HomeVM()
    
    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()

        viewModel.obsSuccess.bind { [weak self] data in
            guard let self else { return}
            if let ele = data {
                self.items = ele
                self.tbl.reloadData()
            }
        }
        
        viewModel.error.bind { err in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                if let errorValue = err {
                    AlertViewManager.show(alertWithTitle: ConstantString.ERROR_TITLE, subTitle: errorValue )
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setupTable() {
        tbl.delegate = self
        tbl.dataSource = self
        viewModel.getProductData()
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.REUSE, for: indexPath) as! DataCell
        let model = items[indexPath.row]
        cell.setup(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbl.deselectRow(at: indexPath, animated: false)
        let viewController = MainModule.getDetailVC()
        viewController.item = items[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
