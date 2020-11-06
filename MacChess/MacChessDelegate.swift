//
//  MacChessDelegate.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-11-03.
//

import Foundation

protocol MacChessDelegate {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
    func pieceAt(col: Int, row: Int) -> ChessPiece?
}
