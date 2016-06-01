//
//  RappersUITests.swift
//

import XCTest
import Floater_

class RappersUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testExample() {
        wait(0.5)

        let app = XCUIApplication()
        let cell10 = app.tables.elementBoundByIndex(0).cells.elementBoundByIndex(5)
        cell10.float💩()
        cell10.tap()

        let backButton = app.navigationBars.elementBoundByIndex(0).buttons.elementBoundByIndex(0)
        backButton.float💩()
        backButton.tap()
        
        let cell6 = app.tables.elementBoundByIndex(0).cells.elementBoundByIndex(6)
        cell6.float💩()
        cell6.tap()

        backButton.float💩()
        backButton.tap()
        
        // Additions
        
        cell10.float💩()
        cell10.tap()
        
        backButton.float💩()
        backButton.tap()
        
        cell6.float💩()
        cell6.tap()
        
        backButton.float💩()
        backButton.tap()
        
        wait(1)
    }
    
    private func wait(duration: NSTimeInterval) {
        NSThread.sleepForTimeInterval(duration)
    }
}
