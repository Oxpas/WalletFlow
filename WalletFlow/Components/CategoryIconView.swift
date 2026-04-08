import SwiftUI

struct CategoryIconView: View {
    let category: Category
    var size: CGFloat = 44
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28)
                .fill(category.color.opacity(0.12))
                .frame(width: size, height: size)
            
            Image(systemName: category.icon)
                .font(.system(size: size * 0.4))
                .foregroundColor(category.color)
        }
    }
}
