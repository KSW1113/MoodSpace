import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - @IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var emptyLabel: UILabel!
    
    private var savedMoods: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F5F2EE")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHistory()
    }
    
    private func loadHistory() {
        savedMoods = UserDefaults.standard.stringArray(forKey: "savedMoods") ?? []
        
        if savedMoods.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
            emptyLabel.text = "아직 진단 결과가 없어요.\n진단 탭에서 테스트를 시작해보세요! 🌿"
        } else {
            tableView.isHidden = false
            emptyLabel.isHidden = true
            tableView.reloadData()
        }
    }

    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let moodName = savedMoods.reversed()[indexPath.row]
        
        // 1. 텍스트 라벨링 매핑
        cell.textLabel?.text = moodName
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        cell.textLabel?.textColor = UIColor(hex: "#2D2D2D")
        
        // 2. 세부 데이터 및 썸네일 이미지 매핑 (VMD 시각디자인 핵심 보정)
        if let data = MoodType(rawValue: moodName), let moodData = MoodData.all[data] {
            cell.detailTextLabel?.text = moodData.subtitle
            cell.detailTextLabel?.textColor = UIColor(hex: "#7C6E5E")
            
            // 🛠️ 버그 해결: Assets에 있는 공간 이미지를 셀의 기본 이미지 뷰에 얹어줌
            if let spaceImage = UIImage(named: moodData.imageName) {
                cell.imageView?.image = spaceImage
                
                // 전공자 감성을 위한 팁: 이미지 뷰 모서리를 둥글게 깎아 디자인 퀄리티 업그레이드
                cell.imageView?.layer.cornerRadius = 6
                cell.imageView?.clipsToBounds = true
            }
        }
        
        cell.backgroundColor = .white
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let moodName = savedMoods.reversed()[indexPath.row]
        guard let moodType = MoodType(rawValue: moodName) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
            resultVC.scores = [moodType: 100]
            self.show(resultVC, sender: nil)
        }
    }
}
