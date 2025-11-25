extension String {
    
    func appending(_ string: String?) -> String {
        if let string { self + string } else { self }
    }
    
    func prepending(_ string: String?) -> String {
        if let string { string + self } else { self }
    }
    
}
