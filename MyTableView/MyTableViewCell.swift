import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    weak var delegate: CellActionDelegate?

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if mySwitch.isOn {
            print("On")
        } else {
            print("Off")
        }
    }
    
    func didChangeSwitchStateOnCell(_ viewModel: CellViewModel) {
        viewModel.isOn = mySwitch.isOn
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        delegate?.didChangeSwitchStateOnCell(self)

        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mySwitch.setOn(true, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
