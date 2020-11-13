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
    
    static func ==(lhs: ChessPiece, rhs: ChessPiece) -> Bool {
        return lhs.col == rhs.col && lhs.row == rhs.row && lhs.player == rhs.player && lhs.rank == rhs.rank
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(col)
        hasher.combine(row)
        hasher.combine(player)
        hasher.combine(rank)
    }
}
