//
//  MacChessTests.swift
//  MacChessTests
//
//  Created by Golden Thumb on 2020-11-03.
//

import XCTest
@testable import MacChess

class MacChessTests: XCTestCase {
    
    func testMovePiece() {
        var chessBoard = ChessBoard()
        chessBoard.initBoard()
        XCTAssertNil(chessBoard.pieceAt(col: 1, row: 2))
        chessBoard.movePiece(fromCol: 1, fromRow: 1, toCol: 1, toRow: 2)
        XCTAssertNotNil(chessBoard.pieceAt(col: 1, row: 2))
        XCTAssertEqual(.pawn, chessBoard.pieceAt(col: 1, row: 2)?.rank)
        XCTAssertEqual(2, chessBoard.pieceAt(col: 1, row: 2)?.row)
        XCTAssertEqual(.white, chessBoard.pieceAt(col: 1, row: 2)?.player)
        print(chessBoard)
    }
    
    func testPrintingEmptyChessBoard() {
        var chessBoard = ChessBoard()
        chessBoard.initBoard()
        print(chessBoard)
    }

    func testPrinting() {
        // 1 + 2 + 3 + ... + 100
        var result = 0
        for i in 1...100 {
            result += i
        }
        XCTAssertEqual(5050, result)
    }

}
