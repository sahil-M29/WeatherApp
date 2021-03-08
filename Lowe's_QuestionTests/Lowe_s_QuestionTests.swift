//
//  Lowe_s_QuestionTests.swift
//  Lowe's_QuestionTests
//
//  Created by Sahil Mirchandani on 3/08/21.
//

import XCTest
@testable import Lowe_s_Question

class Lowe_s_QuestionTests: XCTestCase {

    let networkClient = MockNetworkClient()
    let detailViewController = DetailViewController()
    
    func testModel(){
        let exp = expectation(description: "testing model")
        var result: DataModel? = nil
        self.networkClient.getData(city: "Chicago", completion: { (modelOutput) in
            result = modelOutput
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNil(result)
    }
    
    func test_SFSymbols() {
        XCTAssertEqual(UIImage(systemName: "sun.max.fill"), detailViewController.getSFSymbol(weather: .clear))
        XCTAssertEqual(UIImage(systemName: "cloud.sun.fill"), detailViewController.getSFSymbol(weather: .clouds))
        XCTAssertEqual(UIImage(systemName: "cloud.rain.fill"), detailViewController.getSFSymbol(weather: .rain))
    }
    

}
