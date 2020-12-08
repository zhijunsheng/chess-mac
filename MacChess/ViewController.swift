//
//  ViewController.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-11-02.
//

import Cocoa

class ViewController: NSViewController, MacChessDelegate {

    let communicator = Communicator()
    
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
        boardView.shadowPiecesBox = chessBoard.piecesBox
        boardView.setNeedsDisplay(boardView.bounds)
        
        communicator.chessDelegate = self
        communicator.setupSocketComm()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessBoard.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPiecesBox = chessBoard.piecesBox
        boardView.setNeedsDisplay(boardView.bounds)
        communicator.sendMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        chessBoard.pieceAt(col: col, row: row)
    }
}

