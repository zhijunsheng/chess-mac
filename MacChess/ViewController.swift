//
//  ViewController.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-11-02.
//

import Cocoa

class ViewController: NSViewController, MacChessDelegate {

    var chessBoard = ChessBoard()
    @IBOutlet weak var boardView: BoardView!
    
    /*
     MVC design pattern
     M: Model, ChessBoard
     V: View, BoardView
     C: Controller, ViewController
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.chessDelegate = self

        chessBoard.initBoard()
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay(boardView.bounds)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessBoard.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieceBox = chessBoard.pieceBox
        boardView.setNeedsDisplay(boardView.bounds)
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        chessBoard.pieceAt(col: col, row: row)
    }
}

