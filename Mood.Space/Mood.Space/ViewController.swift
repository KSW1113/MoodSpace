import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // 8가지 무드 전체 케이스 가져오기
    private let allMoods = MoodType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F5F2EE") // WarmBeige
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
    }

    // MARK: - UITableView 데이터 소스
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCell", for: indexPath)
        let moodType = allMoods[indexPath.row]
        let moodData = MoodData.all[moodType]!
        
        // 대분류 및 소분류 가이드라인 적용
        cell.textLabel?.text = moodType.rawValue
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        cell.textLabel?.textColor = UIColor(hex: "#2D2D2D")
        
        cell.detailTextLabel?.text = moodData.subtitle
        cell.detailTextLabel?.textColor = UIColor(hex: "#7C6E5E")
        
        cell.backgroundColor = .white
        cell.accessoryType = .disclosureIndicator // 오른쪽 화살표 표시
        
        return cell
    }
    
    // 탐색 창에서 항목 선택 시 결과창으로 연결하는 프리패스
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMood = allMoods[indexPath.row]
        
        // 스토리보드에서 결과 화면을 직접 띄워줌
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
            // 더미 스코어로 선택한 무드가 만점이 되도록 강제 가공
            resultVC.scores = [selectedMood: 100]
            self.show(resultVC, sender: nil)
        }
    }
}
