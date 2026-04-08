import SwiftUI

// MARK: - Pie Chart (iOS 15 compatible, custom Shape)

struct PieChartView: View {
    let data: [(Category, Double)]
    let total: Double
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let radius = size / 2 - 10
            
            ZStack {
                ForEach(Array(slices.enumerated()), id: \.offset) { index, slice in
                    PieSlice(
                        startAngle: slice.start,
                        endAngle: slice.end
                    )
                    .fill(data[index].0.color)
                    .frame(width: radius * 2, height: radius * 2)
                    .position(center)
                }
                
                // Inner circle for donut effect
                Circle()
                    .fill(AppColors.backgroundLight)
                    .frame(width: radius * 1.1, height: radius * 1.1)
                    .position(center)
                
                // Center label
                VStack(spacing: 2) {
                    Text(total.asCurrency())
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("расходы")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.textSecondary)
                }
                .position(center)
            }
        }
    }
    
    private var slices: [(start: Angle, end: Angle)] {
        var currentAngle: Double = -90
        return data.map { _, amount in
            let degrees = (amount / total) * 360
            let start = Angle(degrees: currentAngle)
            let end = Angle(degrees: currentAngle + degrees)
            currentAngle += degrees
            return (start, end)
        }
    }
}

struct PieSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}
