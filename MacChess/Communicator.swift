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
}
