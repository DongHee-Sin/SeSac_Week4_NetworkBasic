//
//  ViewPresentbleProtocol.swift
//  SeSac4LectureNetworkBasic
//
//  Created by 신동희 on 2022/07/28.
//

import Foundation
import UIKit

// ~~~ Protocol
// ~~~ Delegate

// 프로토콜은 규약(규칙)이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다.
// 실질적인 구현은 프로토콜을 채택, 준수하는 타입이 구체적인 구현을 한다.
// 클래스, 구조체, 익스텐션, 열거형 .. 등등에 다 사용 가능하다.
// 클래스는 단일 상속만 지원하지만, 프로토콜은 채택 개수에 제한이 없다.
// @Objc optional > 선택적 요청(Optional Requirement)
// 프로토콜 프로퍼티, 프로토콜 메서드
@objc protocol ViewPresentableProtocol {
    
    // 프로토콜 프로퍼티 : 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다!
    // 구체적으로 명세하지 않기에, 구현을 하는 부분에서 프로퍼티를 연산이든 저장이든 자유롭게 사용할 수 있다.
    // 무조건 var(변수)로 선언해야 함 (사용하는 부분에서 let으로 구현하기 가능)
    // get, set 명시는 최소한의 요구사항임
    // get으로 명시했다면, get 기능만 최소한 구현되어 있으면 됨. (필요하면 set을 구현해도 괜찮음)
    
    //var navigationTitleString: String { get set }
    //var backgroundColor: UIColor { get }
    
    func configureView()
    
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}



/*
 ex) 테이블뷰
 */


@objc protocol DongTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    
    @objc optional func didSelectRowAt()
}
