// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Notetaker",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(name: "Notetaker", path: "Sources/Notetaker")
    ]
)
