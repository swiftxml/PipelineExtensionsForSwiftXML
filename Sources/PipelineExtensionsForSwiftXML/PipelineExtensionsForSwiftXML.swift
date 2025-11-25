import Pipeline
import Localization
import SwiftXML

@inline(__always)
func positionInfo(forNode node: XNode?) -> String? {
    (node as? XElement)?.xPath ?? node?.parent?.xPath
}

public extension XElement {
    
    /// Use this extension to `XElement` to set the attachments `xpath` and `element` to be used for error messages.
    /// If `forWholeSubtree: true` is set, the same is done for all descendants.
    func setElementInfo(forWholeSubtree: Bool = false) {
        if self.attached["xpath"] == nil { self.attached["xpath"] = self.xPath }
        if self.attached["element"] == nil { self.attached["element"] = self.description }
        if forWholeSubtree {
            for element in self.descendants {
                element.setElementInfo()
            }
        }
    }
    
}

/// The information about the position fo a node first searches for the attachment of name `xpath` for the XPath
/// and (optionally) for the attachment of name `element` for the description for the element up in the tree
/// (including the node itself) before constructing an informatuion based on the current tree.
///  You might use the extension `setElementInfo(forWholeSubtree:)` to `XElement` to set those attachments in the application.
func itemPositionInfo(for node: XNode?) -> String? {
    node?.ancestorsIncludingSelf.compactMap{ ($0.attached["xpath"] as? String)?.appending(($0.attached["element"] as? String)?.prepending(" (").appending(")")) }.first ??
    positionInfo(forNode: node)?.appending(((node as? XText)?.parent ?? node)?.description.prepending(" (")
        .appending((node is XText ? nil : node?.parent)?.description.prepending(" in ")).appending(")"))
}

extension Execution {
    
    public func log(_ type: InfoType, _ message: String, at node: XNode?) {
        self.log(type, message, at: itemPositionInfo(for: node))
    }
    
    public func log(_ type: InfoType, _ message: MultiLanguageText, at node: XNode?) {
        self.log(type, message, at: itemPositionInfo(for: node))
    }
    
    public func log(_ message: Message, node: XNode?, _ arguments: [String]) {
        log(message, at: itemPositionInfo(for: node), arguments)
    }
    
    public func log(_ message: Message, node: XNode?, _ arguments: String...) {
        log(message, at: itemPositionInfo(for: node), arguments)
    }
    
}

extension AsyncExecution {
    
    public func log(_ type: InfoType, _ message: String, at node: XNode?) async {
        await self.log(type, message, at: itemPositionInfo(for: node))
    }
    
    public func log(_ type: InfoType, _ message: MultiLanguageText, at node: XNode?) async {
        await self.log(type, message, at: itemPositionInfo(for: node))
    }
    
    public func log(_ message: Message, node: XNode?, _ arguments: [String]) async {
        await log(message, at: itemPositionInfo(for: node), arguments)
    }
    
    public func log(_ message: Message, node: XNode?, _ arguments: String...) async {
        await log(message, at: itemPositionInfo(for: node), arguments)
    }
    
}
