//
//  LocationViewController.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    
    // Notification 1.
    let notification = UNUserNotificationCenter.current()
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Font
        // 이건 그냥 스피넷 저장하고 사용해도 갠춘 똑같이 씀
        // 폰트이름 찾기.
        for family in UIFont.familyNames {
            print("=======\(family)=======")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
        
        requestAuthorization()
    }

    
    // MARK: - Methods
    
    // Notification 2. 권한 요청
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notification.requestAuthorization(options: authorizationOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청 (언제? 어떤 컨텐츠?)
    // iOS 시스템에서 알림을 담당 > 알림 등록
    
    /*
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구는 시스템적으로 최초 한 번 만 뜬다.
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성 해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서는 60초 이상일 경우에만 반복이 가능하다. / 개수 제한 64개 / 커스텀 사운드
     
     1. 뱃지 제거 > 
     2. 노티 제거 > 노티의 유효기간은 기본값이 4주? > 노티 제거 시점은 너무 다양함 (서비스마다)
     3. 포그라운드 수신 >
     
     +a
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
     - iOS 집중모드 등 5~6가지의 우선순위 존재! (알림)
     */
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...99))입니다."
        notificationContent.body = "저는 따끔따금 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가? 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능.
        // 시간 간격은 60초 이상 설정해야 "반복" 가능
        
        // 60초마다 알림 (60초 이상으로 설정해야 반복 가능)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        // 매 시각의 10분마다 알림 (ex- 1시 10분, 2시 10분)
        var dateComponents = DateComponents()
        dateComponents.minute = 10
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 알림 요청
        // identifier : 같은 identifier를 사용하면 알림이 대체됨 > 여러 identifier이면 계속 쌓임 (알림창에)
        // identifier : 대체되지 않고 계속 쌓이게 하려면 날짜를 찍어서 관리하면 됨
        // 알림 관리할 필요 X -> 알림 클릭하면 앱을 켜주는 정도
        // 알림 관리할 필요 O -> +1, 고유 이름, 규칙 등 : ex)카톡알림
        let request = UNNotificationRequest(identifier: "dong", content: notificationContent, trigger: trigger)
        
        notification.add(request)
    }
    
    
    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        sendNotification()
    }
    
}
