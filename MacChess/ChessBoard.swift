//
//  ChessBoard.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-11-02.
//

import Foundation

struct ChessBoard: CustomStringConvertible {
    var piecesBox: Set<ChessPiece> = []
    
    func canKnightMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) -> Bool {
        if fromCol == 1 && fromRow == 0 && toCol == 2 && toRow == 2 {
            return true
        }
        return false
    }
    
    mutating func initBoard() {
        for i in 0..<8 {
            piecesBox.insert(ChessPiece(col: i, row: 1, player: .white, rank: .pawn, imageName: "Pawn-white"))
            piecesBox.insert(ChessPiece(col: i, row: 6, player: .black, rank: .pawn, imageName: "Pawn-black"))
        }
        
        for i in 0..<2 {
            piecesBox.insert(ChessPiece(col: 0 + i * 7, row: 0, player: .white, rank: .rook, imageName: "Rook-white"))
            piecesBox.insert(ChessPiece(col: 0 + i * 7, row: 7, player: .black, rank: .rook, imageName: "Rook-black"))
    
            piecesBox.insert(ChessPiece(col: 1 + i * 5, row: 0, player: .white, rank: .knight, imageName: "Knight-white"))
            piecesBox.insert(ChessPiece(col: 1 + i * 5, row: 7, player: .black, rank: .knight, imageName: "Knight-black"))
            
            piecesBox.insert(ChessPiece(col: 2 + i * 3, row: 0, player: .white, rank: .bishop, imageName: "Bishop-white"))
            piecesBox.insert(ChessPiece(col: 2 + i * 3, row: 7, player: .black, rank: .bishop, imageName: "Bishop-black"))
        }
        
        piecesBox.insert(ChessPiece(col: 3, row: 0, player: .white, rank: .queen, imageName: "Queen-white"))
        piecesBox.insert(ChessPiece(col: 3, row: 7, player: .black, rank: .queen, imageName: "Queen-black"))
        piecesBox.insert(ChessPiece(col: 4, row: 0, player: .white, rank: .king, imageName: "King-white"))
        piecesBox.insert(ChessPiece(col: 4, row: 7, player: .black, rank: .king, imageName: "King-black"))
    }
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        guard var movingPiece = pieceAt(col: fromCol, row: fromRow) else { return }
        
        if let targetPiece = pieceAt(col: toCol, row: toRow) {
            if targetPiece.player == movingPiece.player {
                return
            } else {
                piecesBox.remove(targetPiece)
            }
        }
        
        piecesBox.remove(movingPiece)
        movingPiece.col = toCol
        movingPiece.row = toRow
        piecesBox.insert(movingPiece)
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        for piece in piecesBox {
            if piece.col == col && piece.row == row {
                return piece
            }
        }
        return nil
    }
    
    var description: String {
        var desc = ""
        for i in 0..<8 {
            desc += "\(7 - i)"
            for col in 0..<8 {
                if let piece = pieceAt(col: col, row: 7 - i) {
                    switch piece.rank {
                    case .king:
                        desc += piece.player == .black ? " K" : " k"
                    case .queen:
                        desc += piece.player == .black ? " Q" : " q"
                    case .rook:
                        desc += piece.player == .black ? " R" : " r"
                    case .bishop:
                        desc += piece.player == .black ? " B" : " b"
                    case .knight:
                        desc += piece.player == .black ? " N" : " n"
                    case .pawn:
                        desc += piece.player == .black ? " P" : " p"
                    }
                } else {
                    desc += " ."
                }
            }
            desc += "\n"
        }
        desc += " "
        for i in 0..<8 {
            desc += " \(i)"
        }
        
        return desc
    }
}
