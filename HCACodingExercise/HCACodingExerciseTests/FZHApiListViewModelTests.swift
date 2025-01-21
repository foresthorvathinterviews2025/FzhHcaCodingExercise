//
//  FZHApiListViewModelTests.swift
//  HCACodingExerciseTests
//
//  Created by Forest Horvath on 1/21/25.
//

import XCTest

final class FZHApiListViewModelTests: XCTestCase {


    var sut : FZHApiListViewModel!
    var mock = FZHApiListViewModelMockProvider()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        sut = FZHApiListViewModel(apiService: mock, view: mock)
        sut.username = "google"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_beforeFirstCall_shouldBeLoading() {
        sut.getData()
        XCTAssertTrue(sut.loading)
    }

    func test_beforeFirstResponse_shouldHaveMadeCall() {
        mock.state = .priorToFirstResponse
        sut.getData()
        XCTAssertTrue(sut.madeCall)
    }
    
    func test_beforeFirstResponse_shouldBeLoading() {
        mock.state = .priorToFirstResponse
        sut.getData()
        XCTAssertTrue(sut.fetching)
    }
    
    func test_afterFirstResponse_shouldNotBeFetching() {
        mock.state = .onePage
        sut.getData()
        XCTAssertFalse(sut.fetching)
    }
    
    func test_afterFirstResponse_shouldHaveTenApis() {
        mock.state = .onePage
        sut.getData()
        XCTAssertEqual(sut.apiList.count, 10)
    }
    
    func test_afterFirstResponse_shouldHaveFourLanguages() {
        mock.state = .onePage
        sut.getData()
        XCTAssertEqual(sut.languages.count, 4)
    }
    
    func test_afterFirstError_shouldNotBeFetching() {
        mock.state = .firstError
        sut.getData()
        XCTAssertFalse(sut.fetching)
    }
    
    
    func test_beforeSecondResponse_shouldBeFetching() {
        mock.state = .priorToSecondResponse
        sut.getData()
        sut.getData()
        XCTAssertTrue(sut.fetching)
    }
    
    func test_afterSecondResponse_shouldNotBeFetching() {
        mock.state = .twoPage
        sut.getData()
        sut.getData()
        XCTAssertFalse(sut.fetching)
    }
    
    func test_afterSecondResponse_shouldHaveFifteenApis() {
        mock.state = .twoPage
        sut.getData()
        sut.getData()
        XCTAssertEqual(sut.apiList.count, 15)
    }
    
    func test_afterSecondResponse_shouldHaveSixLanguange() {
        mock.state = .twoPage
        sut.getData()
        sut.getData()
        XCTAssertEqual(sut.languages.count, 6)
    }
    
    func test_afterSecondError_shouldNotBeFetching() {
        mock.state = .secondError
        sut.getData()
        sut.getData()
        XCTAssertFalse(sut.fetching)
    }
    
    func test_afterSecondResponse_shouldHaveFiveCApis() {
        mock.state = .twoPage
        sut.getData()
        sut.getData()
        sut.languageFilter = "C"
        XCTAssertEqual(sut.filteredList.count, 5)
    }
}
