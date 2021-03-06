//
//  Communicator.swift
//  MacChess
//
//  Created by Golden Thumb on 2020-12-05.
//

import Foundation

class Communicator: NSObject {
    var inputStream: InputStream!
    var outputStream: OutputStream!
    var chessDelegate: MacChessDelegate?
    
    func setupSocketComm() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 50000, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
        
        inputStream.open()
        outputStream.open()
    }
    
    func sendMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        let moveStr = "\(fromCol),\(fromRow),\(toCol),\(toRow)\n"
        let data = moveStr.data(using: .utf8)!
        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("error sending chess move")
                return
            }
            outputStream.write(pointer, maxLength: data.count)
        }
    }
}

extension Communicator: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            print("endEncountered")
        case .errorOccurred:
            print("errorOccurred")
        case .hasSpaceAvailable:
            print("hasSpaceAvailable")
        case .openCompleted:
            print("openCompleted")
        default:
            print("other event code: \(eventCode)")
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
        let maxReadLength = 4096
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
            if numberOfBytesRead < 0, let error = stream.streamError {
                print(error)
                break
            }
            
            if var msg = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                if msg.last == "\n" { // in case the msg is like "6,7,7,5\n"
                    msg.removeLast()
                }
                let moveArr = msg.components(separatedBy: ",")
                if let fromCol = Int(moveArr[0]), let fromRow = Int(moveArr[1]), let toCol = Int(moveArr[2]), let toRow = Int(moveArr[3]) {
                    DispatchQueue.main.async {
                        self.chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
                    }
                }
            }
        }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> String? {
        guard let msg = String(bytesNoCopy: buffer, length: length, encoding: .utf8, freeWhenDone: true) else { return nil }
        return msg
    }
}
