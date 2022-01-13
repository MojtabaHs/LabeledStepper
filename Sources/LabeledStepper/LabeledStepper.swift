import SwiftUI

struct LabeledStepper: View {

    @EnvironmentObject private var style: Style
    @Binding var value: Int

    var title: String = ""
    var description: String = ""
    var range = 0...Int.max
    var longPressInterval = 0.3
    var repeatOnLongPress = true

    @State private var timer: Timer?
    private var isPlusButtonDisabled: Bool { value >= range.upperBound }
    private var isMinusButtonDisabled: Bool { value <= range.lowerBound }

    /// Perform the math operation passed into the function on the `value` and `1` each time the internal timer runs
    private func onPress(_ isPressing: Bool, operation: @escaping (inout Int, Int) -> ()) {

        guard isPressing else { timer?.invalidate(); return }

        func action(_ timer: Timer?) {
            operation(&value, 1)
            style.haptic.controls()
        }

        /// Instant action call for short press action
        action(timer)

        guard repeatOnLongPress else { return }

        timer = Timer.scheduledTimer(
            withTimeInterval: longPressInterval,
            repeats: true,
            block: action
        )
    }

    var body: some View {

        HStack {
            Text(title)

            Text(description)
                .foregroundColor(style.color.hint)

            Spacer()

            HStack(spacing: 0) {
                /// - Note: The action will be performed inside the `.onLongPressGesture` modifier.
                Button() { } label: { Image(systemName: "minus") }
                .onLongPressGesture(
                    minimumDuration: 0
                ) {} onPressingChanged: { onPress($0, operation: -=) }
                .frame(width: style.size.smallButtonHeight, height: style.size.smallButtonHeight)
                .disabled(isMinusButtonDisabled)
                .foregroundColor(isMinusButtonDisabled ? style.color.stepperInactiveForeground : style.color.stepperActiveForeground)
                .contentShape(Rectangle())

                Divider()
                    .padding([.top, .bottom], 8)

                Text("\(value)")
                    .frame(width: style.size.smallButtonHeight, height: style.size.smallButtonHeight)

                Divider()
                    .padding([.top, .bottom], 8)

                /// - Note: The action will be performed inside the `.onLongPressGesture` modifier.
                Button() { } label: { Image(systemName: "plus") }
                .onLongPressGesture(
                    minimumDuration: 0
                ) {} onPressingChanged: { onPress($0, operation: +=) }
                .frame(width: style.size.smallButtonHeight, height: style.size.smallButtonHeight)
                .disabled(isPlusButtonDisabled)
                .foregroundColor(isPlusButtonDisabled ? style.color.stepperInactiveForeground : style.color.stepperActiveForeground)
                .contentShape(Rectangle())
            }
            .background(style.color.stepperBackground)
            .clipShape(RoundedRectangle(cornerRadius: style.size.cornerRadius, style: style.shape.roundedCornerStyle))
            .frame(height: style.size.smallButtonHeight)
        }
        .lineLimit(1)
    }
}


// MARK: - Preview

struct LabeledStepper_Previews: PreviewProvider {

    static var previews: some View {
        LabeledStepper(value: .constant(5))
            .previewLayout(.sizeThatFits)
            .environmentObject(Style.system)
    }
}
