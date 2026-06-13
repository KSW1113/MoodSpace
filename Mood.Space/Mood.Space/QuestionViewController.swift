import UIKit

class QuestionViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // 이 부분이 스토리보드 컬렉션 배열의 정확한 문법이야
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - 데이터 상태 변수
    private var currentIndex = 0
    private var scores: [MoodType: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateQuestion()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#F5F2EE")
        backButton.isHidden = true
    }
    
    private func updateQuestion() {
        let totalQuestions = QuestionData.all.count
        let currentQuestion = QuestionData.all[currentIndex]
        
        progressLabel.text = "질문 \(currentIndex + 1) / \(totalQuestions)"
        progressView.progress = Float(currentIndex + 1) / Float(totalQuestions)
        progressView.progressTintColor = UIColor(hex: "#7C6E5E")
        
        questionLabel.text = currentQuestion.text
        
        for (index, button) in answerButtons.enumerated() {
            if index < currentQuestion.answers.count {
                let answer = currentQuestion.answers[index]
                button.setTitle(answer.text, for: .normal)
                button.isHidden = false
                
                button.layer.cornerRadius = 12
                button.backgroundColor = .white
                button.setTitleColor(UIColor(hex: "#2D2D2D"), for: .normal)
                button.titleLabel?.numberOfLines = 0
                button.titleLabel?.textAlignment = .left
                
                button.layer.shadowColor = UIColor.black.cgColor
                button.layer.shadowOpacity = 0.06
                button.layer.shadowOffset = CGSize(width: 0, height: 2)
                button.layer.shadowRadius = 6
            } else {
                button.isHidden = true
            }
        }
        
        backButton.isHidden = (currentIndex == 0)
    }
    
    // MARK: - @IBAction
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = answerButtons.firstIndex(of: sender) else { return }
        let currentQuestion = QuestionData.all[currentIndex]
        let selectedAnswer = currentQuestion.answers[buttonIndex]
        
        for (moodType, score) in selectedAnswer.scores {
            scores[moodType, default: 0] += score
        }
        
        if currentIndex < QuestionData.all.count - 1 {
            currentIndex += 1
            updateQuestion()
        } else {
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            updateQuestion()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            if let resultVC = segue.destination as? ResultViewController {
                resultVC.scores = self.scores
                resultVC.onRestart = { [weak self] in
                    self?.currentIndex = 0
                    self?.scores = [:]
                    self?.updateQuestion()
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
