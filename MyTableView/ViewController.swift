//MARK:- 소스 => 마크 기능을 통해 엘리먼트 바로가기에서 인덱싱 가능

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var cellViewModels = [CellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...30 {
            cellViewModels.append(CellViewModel(withText: "오늘의 할일\(i)", image: "idol1.png", isOn: true))
        }
    }

    func didChangeSwitchStateOnCell(_ cell: MyTableViewCell) {
        let indexPath = tableview.indexPath(for: cell)
        cellViewModels[indexPath?.row ?? 0].isOn = cell.mySwitch.isOn
    }

}

extension ViewController :  UITableViewDataSource, UITableViewDelegate {
    //MARK:- 테이블뷰 셋팅
    // 테이블뷰의 아이템 갯수를 반환함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    // 테이블뷰에 셀뷰를 만들어서 반환함
    // indexPath : Section(그룹의 개수) , Row(열의 인덱스)를 말함
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
//        cell.delegate = self
        let cellViewModel = cellViewModels[indexPath.row]
        cell.imageview.image = UIImage(named: cellViewModel.image)
        cell.labelName.text = cellViewModel.title
        cell.mySwitch.addTarget(self, action: #selector(switchChanged(_:index:)),  for: .valueChanged)
        switchChanged(cell.mySwitch, index: indexPath.row)
//        didChangeSwitchStateOnCell(cell)
//        cell.mySwitch.isOn = cellViewModel.isOn
        
        return cell
    }
    

    @objc func switchChanged(_ mySwitch: UISwitch, index : Int) {
        self.cellViewModels[index].isOn = mySwitch.isOn
        // Do something
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(indexPath.row)번째 셀이 선택됨")
    }

    
}
