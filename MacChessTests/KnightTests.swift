//
//  KnightTests.swift
//  MacChessTests
//
//  Created by Golden Thumb on 2020-11-06.
//

import XCTest
@testable import MacChess

class KnightTests: XCTestCase {

    func testCanKnightMove() {
        var chessBoard = ChessBoard()
        chessBoard.initBoard()
        
//        chessBoard.movePiece(fromCol: 1, fromRow: 0, toCol: 2, toRow: 2)
//        
//        print(chessBoard)
        
        XCTAssertTrue(chessBoard.canKnightMove(fromCol: 1, fromRow: 0, toCol: 2, toRow: 2))
        
        
    }

}
