//
//  KiniCuacaUITests.swift
//  KiniCuacaUITests
//
//  Created by Benjamin Purbowasito on 22/12/21.
//

import XCTest

class KiniCuacaUITests: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false


    }

    
    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        //temperature label test
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
        
        let tempLabel = app.staticTexts["temperatureLabel"]
        
        XCTAssertEqual("19", tempLabel.label)

        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
