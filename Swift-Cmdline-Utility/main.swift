import Foundation

var german = TransformativeOutputStream.translating(to: "de")
print("\"I am a jelly donut.\" ✌️", to: &german)
