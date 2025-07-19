//
//  Extension+View.swift
//  KycFlow
//
//  Created by Zuhaib Imtiaz on 19/07/2025.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        modifier(TitleLabelStyle())
    }
    
    func subTitleStyle() -> some View {
        modifier(SubTitleLabelStyle())
    }
}
