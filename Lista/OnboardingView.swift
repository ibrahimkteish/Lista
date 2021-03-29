//
//  OnboardingView.swift
//  Lista
//
//  Created by Ibrahim Koteish on 27/03/2021.
//

import SwiftUI

extension Color {
  init(hex: UInt, alpha: Double = 1) {
    self.init(.sRGB,
              red: Double((hex >> 16) & 0xff) / 255,
              green: Double((hex >> 08) & 0xff) / 255,
              blue: Double((hex >> 00) & 0xff) / 255,
              opacity: alpha)
    }
}

extension Color {
  static let offWhite = Color(red: 1.0, green: 1.0, blue: 245.0 / 255.0)
  static let electricViolet = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
  static let offElectricViolet = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))

}
extension LinearGradient {
  init(_ colors: Color...) {
    self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
  }
}


struct SimpleButtonStyle<S: Shape>: ButtonStyle {

  let shape: S

  let fillColor: Color
  let firstStrokeColor: Color
  let secondStrokeColor: Color

  let firstShadowColor: Color
  let secondShadowColor: Color
  let gradientColor: Color

  private func isPressed(configuration: Self.Configuration) -> Bool {
    return configuration.isPressed
  }

  private func getPressedView() -> some View {
    return self.shape
      .fill(self.fillColor)
      .overlay(
        self.shape
          .stroke(self.firstStrokeColor, lineWidth: 2)
          .blur(radius: 4)
          .offset(x: 2, y: 2)
          .mask(self.shape.fill(LinearGradient(self.gradientColor, Color.clear)))
      )
      .overlay(
        self.shape
          .stroke(self.secondStrokeColor, lineWidth: 8)
          .blur(radius: 4)
          .offset(x: -2, y: -2)
          .mask(self.shape.fill(LinearGradient(Color.clear, self.gradientColor)))
      )
  }

  private func getUnPressedView() -> some View {
    return self.shape
      .fill(self.fillColor)
      .shadow(color: self.firstShadowColor, radius: 10, x: 10, y: 10)
      .shadow(color: self.secondShadowColor, radius: 10, x: -5, y: -5)

  }

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
      .contentShape(self.shape)
      .background(
        Group {
          if configuration.isPressed {
            self.getPressedView()
          } else {
            self.getUnPressedView()
          }
        }
      )
  }
}

struct OnboardingView: View {
  var body: some View {

    ZStack {
      Color.white

      VStack {
        HStack {
          Spacer()
          Button(action: {}, label: {
            Text("Skip")
              .fontWeight(.medium)
          })
          .buttonStyle(SimpleButtonStyle(shape: Capsule(),
                                         fillColor: Color.offWhite,
                                         firstStrokeColor: Color.gray ,
                                         secondStrokeColor: Color.white,
                                         firstShadowColor: Color.black.opacity(0.2),
                                         secondShadowColor: Color.white.opacity(0.7),
                                         gradientColor: Color.black))
        }
        Spacer()
        Text("Manage Your Tasks")
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)


        Spacer()
      }
      .padding(EdgeInsets(top: 30, leading: 16, bottom: 30, trailing: 16))

    }
    .ignoresSafeArea(.all)
  } // body
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
