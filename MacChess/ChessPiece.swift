//
//  ChessPiece.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-11-02.
//

import Foundation

struct ChessPiece: Hashable {
    let col: Int
    let row: Int
    let player: ChessPlayer
    let rank: ChessRank
    let imageName: String
}
