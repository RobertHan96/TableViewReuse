//MARK:- 소스 => 마크 기능을 통해 엘리먼트 바로가기에서 인덱싱 가능

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var todoList = [Todo]()
    var swtichStates = [Bool](repeating: false, count: 30)
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...30 {
            todoList.append(Todo(todo: "오늘의 할일은 바로\(i)", image: "idol1.png"))
        }
    }

}

extension ViewController :  UITableViewDataSource, UITableViewDelegate, SwitchControlDelegate {
    func didPressSwitch(cell: UITableViewCell, index: Int) {
        // 스위치 값 변경이 일어나는 시점에 인데스 값을 확인하고, Bool 부정형 값을 데이터 리스트에 대입
        print(index)
        swtichStates[index] = !swtichStates[index]
        // 테이블뷰 reload
        tableview.reloadData()
    }
    
    
    //MARK:- 테이블뷰 셋팅
    // 테이블뷰의 아이템 갯수를 반환함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // 테이블뷰에 셀뷰를 만들어서 반환함
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableview.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        cell.switchDelegate = self
        cell.index = indexPath.row
        let todo = todoList[indexPath.row]
        cell.imageview.image = UIImage(named: todo.image ?? "idol1.png")
        cell.labelName.text = todo.todo
        cell.mySwitch.isOn = swtichStates[indexPath.row]

        return cell
    }
    
}

//MARK:- 테이블뷰 데이터 무한로딩 구현 : 스크롤 델리게이트를 통해, 콘텐츠 필요여부를 파악해서, 계속 데이터를 추가함
extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height
        {
            if !fetchingMore
            {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch()
    {
        fetchingMore = true
        self.tableview.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            let newItems = self.todoList[0...10]
            let newSwtichStates = self.swtichStates[0...10]

            self.todoList.append(contentsOf: newItems)
            self.swtichStates.append(contentsOf: newSwtichStates)
            self.fetchingMore = false
            self.tableview.reloadData()
        })
    }
}
