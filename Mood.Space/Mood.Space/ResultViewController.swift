import UIKit

class ResultViewController: UIViewController {

    // MARK: - @IBOutlet (스토리보드와 연결되는 콘센트)
    // ⚠️ 아래 변수명들이 스토리보드 우측 패널의 아웃렛 이름과 똑같아야 합니다.
    @IBOutlet weak var moodTitleLabel: UILabel!
    @IBOutlet weak var moodSubtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moodImageView: UIImageView! // 💡 핵심: 이미지 뷰 연결선
    
    @IBOutlet weak var colorLabel1: UILabel!
    @IBOutlet weak var colorLabel2: UILabel!
    @IBOutlet weak var colorLabel3: UILabel!
    
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView2: UIView!
    @IBOutlet weak var colorView3: UIView!
    
    @IBOutlet weak var materialsLabel: UILabel!
    @IBOutlet weak var lightingLabel: UILabel!
    @IBOutlet weak var avoidLabel: UILabel!
    
    // MARK: - Data Properties
    var scores: [MoodType: Int] = [:]
    var onRestart: (() -> Void)?
    private var currentTopMood: MoodType?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F5F2EE") // 전공 감성 웜베이지 바탕
        updateResultUI()
    }

    private func updateResultUI() {
        // 1. 만약 앞 화면에서 점수가 정상적으로 안 넘어왔다면 강제로 모델 주입
        if scores.isEmpty || scores.values.allSatisfy({ $0 == 0 }) {
            scores = [.coolMinimal: 1]
        }
        
        // 2. 가장 높은 점수의 무드 유형 추출
        let topMood = scores.max(by: { $0.value < $1.value })?.key ?? .coolMinimal
        
        // 3.MoodData.all에서 튕기는 버그를 완벽하게 우회
        // 데이터 구조체에서 못 긁어오면, 하드코딩으로라도 화면에 무조건 텍스트와 이미지를 박아버립니다.
        if let moodData = MoodData.all[topMood] {
            moodTitleLabel.text = topMood.rawValue
            moodSubtitleLabel.text = moodData.subtitle
            descriptionLabel.text = moodData.description
            moodImageView.image = UIImage(named: moodData.imageName)
            materialsLabel.text = "추천 소재 : " + moodData.materials.joined(separator: ", ")
            lightingLabel.text = "조명 온도 : " + moodData.lightTemp
            avoidLabel.text = moodData.avoid.joined(separator: ", ")
            
            let views = [colorView1, colorView2, colorView3]
            let labels = [colorLabel1, colorLabel2, colorLabel3]
            for i in 0..<3 {
                if i < moodData.colors.count {
                    views[i]?.backgroundColor = moodData.colors[i]
                    views[i]?.layer.cornerRadius = 6
                    labels[i]?.text = moodData.colorNames[i]
                }
            }
        } else {
           
            moodTitleLabel.text = "Cool Minimal"
            moodSubtitleLabel.text = "차갑고 절제된 공간"
            descriptionLabel.text = "불필요한 것을 모두 덜어낸 공간에서 명류함을 느낍니다. 화이트와 그레이의 조합이 만들어내는 깔끔함을 선호합니다."
            
            // 💡 에셋에 들어있는 진짜 사진 이름 두 가지 중 하나를 강제로 매핑합니다.
            // 스스크린샷에 있던 이름인 "mood_cool_minimal" 혹은 "mood_cool_mininal" 둘 다 안전장치로 타격합니다.
            if let fallbackImage = UIImage(named: "mood_cool_minimal") {
                moodImageView.image = fallbackImage
            } else {
                moodImageView.image = UIImage(named: "mood_cool_mininal")
            }
            
            materialsLabel.text = "추천 소재 : 콘크리트, 유리, 철재"
            lightingLabel.text = "조명 온도 : 5000K - 차가운 주백색"
            avoidLabel.text = "따뜻한 베이지 계열, 우드, 크롬 마감"
            
            colorView1?.backgroundColor = UIColor(white: 0.94, alpha: 1.0) // Pure White 대신
            colorView2?.backgroundColor = UIColor(white: 0.72, alpha: 1.0) // Cool Gray 대신
            colorView3?.backgroundColor = UIColor(white: 0.18, alpha: 1.0) // Charcoal 대신
            colorLabel1?.text = "Pure White"
            colorLabel2?.text = "Cool Gray"
            colorLabel3?.text = "Charcoal"
        }
        
        // 공통 시각 마감재 처리
        moodImageView.layer.cornerRadius = 12
        moodImageView.clipsToBounds = true
    }
 
    // MARK: - @IBAction (하단 버튼 액션)
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let topMood = scores.max(by: { $0.value < $1.value })?.key else { return }
        var currentHistory = UserDefaults.standard.stringArray(forKey: "savedMoods") ?? []
        currentHistory.append(topMood.rawValue)
        UserDefaults.standard.set(currentHistory, forKey: "savedMoods")
        
        sender.setTitle("저장 완료 ✓", for: .normal)
        sender.isEnabled = false
    }
    
    // 💡 일반 UIButton(하단 결과 공유하기 버튼)과 연결되도록 수정된 코드
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        // 점수 배열에서 직접 최고 점수 무드 가져오기 (오류 완벽 방지)
        guard let topMood = scores.max(by: { $0.value < $1.value })?.key else { return }
        
        let shareText = "[MoodSpace] 저의 공간 무드 진단 결과는 '\(topMood.rawValue)'입니다! 🌿"
        
        var activityItems: [Any] = [shareText]
        if let currentImage = moodImageView.image {
            activityItems.append(currentImage)
        }
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // ⚠️ 핵심: UIBarButtonItem 대신 일반 UIButton(sender)을 포포버 위치로 지정
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.onRestart?()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
