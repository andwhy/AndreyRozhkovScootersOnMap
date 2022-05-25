//
//  ToastView.swift
//  AndreyRozhkovScootersOnMap
//
//  Created by an.rozhkov on 25.05.2022.
//

import SwiftUI

struct ToastView<Presenting, Content>: View where Presenting: View, Content: View {

    enum PaddingState: Double {
        case show = 0.0
        case hide = -200.0
    }
    
    @Binding var isShowing: Bool
    @State var padding = 0.0
    
    let presenting: () -> Presenting
    let contentView: Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenting()
                VStack {
                    contentView
                }
                .frame(width: geometry.size.width - 44,
                       height: geometry.size.height / 5)
                .background(Color.primary.colorInvert())
                .cornerRadius(20)
                .padding(.bottom, padding)
                .ignoresSafeArea()
                .onAppear() {
                    padding = PaddingState.hide.rawValue
                }
                .onChange(of: isShowing, perform: { _ in
                    padding = isShowing ? PaddingState.hide.rawValue :  PaddingState.show.rawValue
                    withAnimation(.easeInOut(duration: 0.5)) {
                        padding = isShowing ? PaddingState.show.rawValue : PaddingState.hide.rawValue
                    }
                })
            }
        }
    }
}

extension View {
    func toast<Content: View>(isShowing: Binding<Bool>, contentView: Content) -> some View {
        ToastView(
            isShowing: isShowing,
            presenting: { self },
            contentView: contentView
        )
    }
}
