import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad() // 오타 수정 완료
        
        // 배경색을 기획안에 맞춘 AccentBrown(#7C6E5E)으로 설정
        view.backgroundColor = UIColor(hex: "#7C6E5E")
        
        // 2초 뒤에 메인 화면(Tab Bar Controller)으로 부드럽게 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.switchToMainScreen()
        }
    }
    
    private func switchToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainTabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            mainTabBarVC.modalPresentationStyle = .fullScreen
            mainTabBarVC.modalTransitionStyle = .crossDissolve
            self.present(mainTabBarVC, animated: true, completion: nil)
        }
    }
}
