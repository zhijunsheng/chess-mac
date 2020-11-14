//
//  BoardView.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-11-02.
//

import Cocoa

class BoardView: NSView {
    var cellSide: CGFloat = -1
    var shadowPiecesBox: Set<ChessPiece> = []
    var fromCol: Int = -1
    var fromRow: Int = -1
    var chessDelegate: MacChessDelegate? = nil
    var movingPiece: ChessPiece?
    var movingPieceX: CGFloat = -1
    var movingPieceY: CGFloat = -1
    var keyImageNameValueImage: Dictionary<String, NSImage> = [:]

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if keyImageNameValueImage.isEmpty {
            for piece in shadowPiecesBox {
                keyImageNameValueImage[piece.imageName] = NSImage(named: piece.imageName)
            }
        }
        
        cellSide = bounds.width / 8

        #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).setFill()
        bounds.fill()
        
        drawBoard()
        drawPieces()
    }
    
    override func mouseDown(with event: NSEvent) {
        let loc = convert(event.locationInWindow, from: nil)
        fromCol = Int(loc.x / cellSide)
        fromRow = Int(loc.y / cellSide)
        movingPiece = chessDelegate?.pieceAt(col: fromCol, row: fromRow)
    }
    
    override func mouseUp(with event: NSEvent) {
        let loc = convert(event.locationInWindow, from: nil)
        let col: Int = Int(loc.x / cellSide)
        let row: Int = Int(loc.y / cellSide)
        chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: col, toRow: row)
        
        movingPiece = nil
    }
    
    override func mouseDragged(with event: NSEvent) {
        let loc = convert(event.locationInWindow, from: nil)
        movingPieceX = loc.x - cellSide/2
        movingPieceY = loc.y - cellSide/2
        setNeedsDisplay(bounds)
    }
    
    func drawPieces() {
        for piece in shadowPiecesBox where piece != movingPiece {
            drawPiece(piece: piece)
        }
        
        if let movingPiece = movingPiece {
            let img = NSImage(named: movingPiece.imageName)
            img?.draw(in: NSRect(x: movingPieceX, y: movingPieceY, width: cellSide, height: cellSide))
        }
    }
    
    func drawPiece(piece: ChessPiece) {
        keyImageNameValueImage[piece.imageName]?.draw(in: NSRect(x: CGFloat(piece.col) * cellSide, y: CGFloat(piece.row) * cellSide, width: cellSide, height: cellSide))
    }
    
    func drawBoard() {
        for j in 0..<4 {
            for i in 0..<4 {
                drawCell(col: i * 2, row: j * 2)
                drawCell(col: 1 + i * 2, row: 1 + j * 2)
            }
        }
    }
    
    func drawCell(col: Int, row: Int) {
        #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).setFill()
        NSBezierPath(rect: NSRect(x: CGFloat(col) * cellSide, y: CGFloat(row) * cellSide, width: cellSide, height: cellSide)).fill()
    }
}
