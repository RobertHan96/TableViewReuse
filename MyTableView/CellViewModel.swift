import Foundation

protocol CellActionDelegate: class {
    
    func didChangeSwitchStateOnCell(_ cell: MyTableViewCell)
    
}

class CellViewModel {
    let title: String
    let image: String
    var isOn: Bool

    init(withText text: String, image : String ,isOn: Bool = false) {
        self.title = text
        self.isOn = isOn
        self.image = image
    }
    
    func didChangeSwitchStateOnCell(_ cell: MyTableViewCell) {
        self.isOn = cell.mySwitch.isOn
    }

}

