import UIKit

protocol SwitchControlDelegate {
    func didPressSwitch(cell : UITableViewCell,  index: Int)
}

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    // 스위치 동작이 발생한 인덱스 위치 저장용 변수
    var index:Int = 0
    var switchDelegate: SwitchControlDelegate?
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        switchDelegate?.didPressSwitch(cell: self, index: index)
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // 뷰 재사용시 디폴트로 off상태의 스위치 버튼 제공
    override func prepareForReuse() {
        super.prepareForReuse()
        mySwitch.setOn(false, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
