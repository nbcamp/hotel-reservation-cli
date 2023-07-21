import Foundation

protocol Command {
    var name: String { get }
    
    func execute();
}
