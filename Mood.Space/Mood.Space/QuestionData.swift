import Foundation

// MARK: - 답변 모델
struct Answer {
    let text: String
    let scores: [MoodType: Int]
}

// MARK: - 질문 모델
struct Question {
    let id: Int
    let text: String
    let answers: [Answer]
}

// MARK: - 질문 데이터
struct QuestionData {
    static let all: [Question] = [
        Question(
            id: 0,
            text: "집에 돌아왔을 때 어떤 공간이 당신을 맞이했으면 하나요?",
            answers: [
                Answer(text: "따뜻한 조명과 나무 향기가 나는 포근한 공간", scores: [.warmSilence: 3, .retroWarm: 1]),
                Answer(text: "깔끔하게 정돈된 하얀 공간", scores: [.coolMinimal: 3, .airyBright: 1]),
                Answer(text: "식물과 자연 소재로 가득한 공간", scores: [.naturalCalm: 3, .warmSilence: 1]),
                Answer(text: "개성 있고 강렬한 느낌의 공간", scores: [.urbanEdge: 3, .luxeDeep: 1]),
            ]
        ),
        Question(
            id: 1,
            text: "공간에서 가장 중요하게 생각하는 것은?",
            answers: [
                Answer(text: "편안함과 안정감", scores: [.warmSilence: 2, .romanticSoft: 2]),
                Answer(text: "깔끔함과 여백", scores: [.coolMinimal: 3, .airyBright: 1]),
                Answer(text: "자연스러움과 생동감", scores: [.naturalCalm: 3, .retroWarm: 1]),
                Answer(text: "개성과 고급스러움", scores: [.luxeDeep: 2, .urbanEdge: 2]),
            ]
        ),
        Question(
            id: 2,
            text: "선호하는 조명 분위기는?",
            answers: [
                Answer(text: "따뜻하고 은은한 간접조명", scores: [.warmSilence: 2, .romanticSoft: 2]),
                Answer(text: "밝고 환한 백색 조명", scores: [.coolMinimal: 2, .airyBright: 2]),
                Answer(text: "자연광이 잘 드는 환경", scores: [.naturalCalm: 3, .airyBright: 1]),
                Answer(text: "집중형 스팟 또는 골드 간접조명", scores: [.urbanEdge: 2, .luxeDeep: 2]),
            ]
        ),
        Question(
            id: 3,
            text: "어떤 소재가 가장 끌리나요?",
            answers: [
                Answer(text: "린넨, 면 같은 자연 패브릭", scores: [.warmSilence: 2, .romanticSoft: 2]),
                Answer(text: "콘크리트, 유리, 메탈", scores: [.coolMinimal: 2, .urbanEdge: 2]),
                Answer(text: "라탄, 황마, 천연석", scores: [.naturalCalm: 3, .retroWarm: 1]),
                Answer(text: "마블, 벨벳, 골드 메탈", scores: [.luxeDeep: 3, .romanticSoft: 1]),
            ]
        ),
        Question(
            id: 4,
            text: "공간에 색을 더한다면?",
            answers: [
                Answer(text: "베이지, 크림, 브라운 계열", scores: [.warmSilence: 3, .retroWarm: 1]),
                Answer(text: "화이트, 라이트 그레이 계열", scores: [.coolMinimal: 2, .airyBright: 2]),
                Answer(text: "그린, 어스 톤 계열", scores: [.naturalCalm: 3, .warmSilence: 1]),
                Answer(text: "블랙, 네이비, 다크 계열", scores: [.urbanEdge: 2, .luxeDeep: 2]),
            ]
        ),
        Question(
            id: 5,
            text: "인테리어 레퍼런스로 가장 끌리는 공간은?",
            answers: [
                Answer(text: "북유럽 감성의 따뜻한 카페", scores: [.warmSilence: 2, .retroWarm: 2]),
                Answer(text: "애플스토어처럼 깔끔한 쇼룸", scores: [.coolMinimal: 3, .airyBright: 1]),
                Answer(text: "식물원처럼 자연이 가득한 공간", scores: [.naturalCalm: 3, .airyBright: 1]),
                Answer(text: "호텔 스위트룸 같은 고급스러운 공간", scores: [.luxeDeep: 3, .romanticSoft: 1]),
            ]
        ),
        Question(
            id: 6,
            text: "공간에서 소품을 배치할 때 당신은?",
            answers: [
                Answer(text: "따뜻한 느낌의 소품을 곳곳에 배치한다", scores: [.warmSilence: 2, .retroWarm: 2]),
                Answer(text: "최소한의 소품만 놓고 여백을 즐긴다", scores: [.coolMinimal: 3, .urbanEdge: 1]),
                Answer(text: "식물과 자연 오브제를 적극 활용한다", scores: [.naturalCalm: 3, .warmSilence: 1]),
                Answer(text: "고급스럽고 포인트가 되는 소품을 선택한다", scores: [.luxeDeep: 2, .romanticSoft: 2]),
            ]
        ),
    ]
}
