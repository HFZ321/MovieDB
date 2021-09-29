//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Hongfei Zheng on 9/24/21.
//

import XCTest
@testable import MovieDB

class MovieDBTests: XCTestCase {


    var loginController: LoginController?
    override func setUp() {
        loginController = LoginController()
    }
    override func tearDown() {
        loginController = nil
    }
    func testEmailValidate(){
        let result = loginController?.userValidate("123456")
        XCTAssertEqual(result, true)
        let result2 =  loginController?.userValidate("12345")
        XCTAssertEqual(result2, false)
    }
    func testPasswordValidate(){
        let result = loginController?.passwordValidate("123456")
        XCTAssertEqual(result, true)
        let result2 =  loginController?.passwordValidate("12345")
        XCTAssertEqual(result2, false)
    }

}
