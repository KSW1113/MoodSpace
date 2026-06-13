import UIKit

// MARK: - 무드 유형 enum
enum MoodType: String, CaseIterable, Codable {
    case warmSilence  = "Warm Silence"
    case coolMinimal  = "Cool Minimal"
    case naturalCalm  = "Natural Calm"
    case urbanEdge    = "Urban Edge"
    case romanticSoft = "Romantic Soft"
    case retroWarm    = "Retro Warm"
    case luxeDeep     = "Luxe Deep"
    case airyBright   = "Airy Bright"
}

// MARK: - 무드 데이터 모델
struct MoodData {
    let type: MoodType
    let subtitle: String
    let description: String
    let colors: [UIColor]
    let colorNames: [String]
    let materials: [String]
    let lightTemp: String
    let avoid: [String]
    let imageName: String

    static let all: [MoodType: MoodData] = [

        .warmSilence: MoodData(
            type: .warmSilence,
            subtitle: "따뜻하고 고요한 공간",
            description: "자연스러운 따뜻함과 절제된 고요함이 공존하는 공간입니다. 베이지와 우드 톤이 만들어내는 안정감 속에서 편안함을 느낍니다.",
            colors: [UIColor(hex: "#C4A882"), UIColor(hex: "#E8DDD0"), UIColor(hex: "#7C6E5E")],
            colorNames: ["Warm Sand", "Linen", "Bark Brown"],
            materials: ["오크 우드", "린넨 패브릭", "무광 세라믹"],
            lightTemp: "2700K - 따뜻한 간접조명",
            avoid: ["차가운 블루/그레이 계열", "광택 메탈 소재", "강한 원색"],
            imageName: "mood_warm_silence"
        ),

        .coolMinimal: MoodData(
            type: .coolMinimal,
            subtitle: "차갑고 절제된 공간",
            description: "불필요한 것을 모두 덜어낸 공간에서 명료함을 느낍니다. 화이트와 그레이의 조합이 만들어내는 깔끔함을 선호합니다.",
            colors: [UIColor(hex: "#F0F0F0"), UIColor(hex: "#B0B0B0"), UIColor(hex: "#2D2D2D")],
            colorNames: ["Pure White", "Cool Gray", "Charcoal"],
            materials: ["콘크리트", "유리", "크롬 메탈"],
            lightTemp: "5000K - 차가운 백색 조명",
            avoid: ["따뜻한 베이지 계열", "무거운 패브릭", "장식적인 소품"],
            imageName: "mood_cool_minimal"
        ),

        .naturalCalm: MoodData(
            type: .naturalCalm,
            subtitle: "자연 친화적인 공간",
            description: "자연에서 온 소재와 색감이 공간을 채울 때 편안함을 느낍니다. 그린과 어스 톤이 주는 생동감을 좋아합니다.",
            colors: [UIColor(hex: "#8B9E7A"), UIColor(hex: "#D4C5A9"), UIColor(hex: "#5C6B4E")],
            colorNames: ["Sage Green", "Earth Sand", "Forest"],
            materials: ["라탄", "황마", "천연석"],
            lightTemp: "3000K - 자연광 느낌 조명",
            avoid: ["플라스틱 소재", "형광색 계열", "과도한 메탈"],
            imageName: "mood_natural_calm"
        ),

        .urbanEdge: MoodData(
            type: .urbanEdge,
            subtitle: "도시적이고 강렬한 공간",
            description: "강렬하고 개성 있는 공간에서 에너지를 얻습니다. 블랙과 다크 톤이 만드는 도시적인 감성을 추구합니다.",
            colors: [UIColor(hex: "#1A1A1A"), UIColor(hex: "#4A4A4A"), UIColor(hex: "#C4845A")],
            colorNames: ["Jet Black", "Urban Gray", "Rust"],
            materials: ["블랙 스틸", "산업용 콘크리트", "가죽"],
            lightTemp: "4000K - 집중형 스팟 조명",
            avoid: ["파스텔 계열", "플로럴 패턴", "부드러운 소재"],
            imageName: "mood_urban_edge"
        ),

        .romanticSoft: MoodData(
            type: .romanticSoft,
            subtitle: "부드럽고 감성적인 공간",
            description: "부드럽고 여성스러운 감성이 공간에 흐를 때 행복함을 느낍니다. 파스텔과 로즈 톤이 만드는 따뜻한 분위기를 좋아합니다.",
            colors: [UIColor(hex: "#E8C4C4"), UIColor(hex: "#F5E6E6"), UIColor(hex: "#C49090")],
            colorNames: ["Dusty Rose", "Blush", "Mauve"],
            materials: ["벨벳", "시폰 커튼", "화이트 우드"],
            lightTemp: "2700K - 핑크빛 간접조명",
            avoid: ["딱딱한 소재", "강한 다크 컬러", "산업적인 소품"],
            imageName: "mood_romantic_soft"
        ),

        .retroWarm: MoodData(
            type: .retroWarm,
            subtitle: "빈티지 감성의 공간",
            description: "시간이 쌓인 듯한 빈티지 감성에서 포근함을 느낍니다. 브라운과 오렌지 톤이 만드는 레트로 분위기를 즐깁니다.",
            colors: [UIColor(hex: "#C4845A"), UIColor(hex: "#8B6347"), UIColor(hex: "#E8C49A")],
            colorNames: ["Terracotta", "Cognac", "Caramel"],
            materials: ["앤티크 우드", "구리 메탈", "울 패브릭"],
            lightTemp: "2400K - 황금빛 조명",
            avoid: ["모던한 소재", "차가운 무채색", "미니멀 가구"],
            imageName: "mood_retro_warm"
        ),

        .luxeDeep: MoodData(
            type: .luxeDeep,
            subtitle: "고급스럽고 깊이 있는 공간",
            description: "깊고 풍부한 색감 속에서 고급스러움을 느낍니다. 다크 네이비와 골드의 조합이 만드는 럭셔리한 분위기를 추구합니다.",
            colors: [UIColor(hex: "#1A2744"), UIColor(hex: "#C4A84A"), UIColor(hex: "#2D3D5C")],
            colorNames: ["Deep Navy", "Gold", "Midnight"],
            materials: ["마블", "골드 메탈", "벨벳"],
            lightTemp: "3000K - 은은한 골드 간접조명",
            avoid: ["캐주얼한 소재", "밝은 파스텔", "플라스틱"],
            imageName: "mood_luxe_deep"
        ),

        .airyBright: MoodData(
            type: .airyBright,
            subtitle: "밝고 개방적인 공간",
            description: "빛이 가득하고 시원하게 열린 공간에서 활력을 얻습니다. 화이트와 스카이 톤이 만드는 청량한 분위기를 좋아합니다.",
            colors: [UIColor(hex: "#E8F4F8"), UIColor(hex: "#B0D4E8"), UIColor(hex: "#FFFFFF")],
            colorNames: ["Sky Blue", "Ice", "Pure White"],
            materials: ["화이트 페인팅", "투명 유리", "면 소재"],
            lightTemp: "6500K - 자연광에 가까운 밝은 조명",
            avoid: ["어둡고 무거운 색상", "두꺼운 커튼", "과도한 소품"],
            imageName: "mood_airy_bright"
        ),
    ]
}

// MARK: - UIColor Hex 확장
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = CGFloat((int >> 16) & 0xFF) / 255.0
        let g = CGFloat((int >> 8) & 0xFF) / 255.0
        let b = CGFloat(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
