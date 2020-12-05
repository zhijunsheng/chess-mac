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
    
}

extension Communicator: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            print("hasBytesAvailable")
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            print("endEncountered")
        case .errorOccurred:
            print("errorOccurred")
        case .hasSpaceAvailable:
            print("hasSpaceAvailable")
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
            
            if let msg = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                print(msg)
            }
        }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> String? {
        guard let msg = String(bytesNoCopy: buffer, length: length, encoding: .utf8, freeWhenDone: true) else { return nil }
        return msg
    }
}
