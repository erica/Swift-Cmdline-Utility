//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation

public extension Utility {
    static func requestSynchronousData(_ request: URLRequest) throws -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Data, Error>?
        let task = URLSession.shared.dataTask(with: request) { data, _, error -> Void in
            result = Result(data, error)
            semaphore.signal()
        }
        task.resume()
        let _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return try result?.get()
    }

}
