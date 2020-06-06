//
//  Created by Ilya Sakalou on 6/6/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import Foundation
import XCTest
@testable import Mini_Tool

class ColorProviderTest: XCTestCase {
  func test_classicColorProvider_returnsRightColor() {
    let sut = ClassicColorProvider()
    
    XCTAssertEqual(sut.color(for: .none), .clear)
    XCTAssertEqual(sut.color(for: .failed), .red)
    XCTAssertEqual(sut.color(for: .selected), .gray)
    XCTAssertEqual(sut.color(for: .passed), .green)
  }
}
