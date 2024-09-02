import SwiftUI

struct IlilceView: View {
    @ObservedObject var PviewModel = PharmacyViewModel()
    func currentDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .long // Örneğin: August 16, 2024
            return formatter.string(from: Date())
        }
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradyan arka plan
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.customRed]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea() // Tüm ekranı kaplayacak şekilde genişletir

                // VStack ile içerik
                VStack {
                    Text("Bugün: \(currentDate())")
                              .padding()
                        
                    Image("ecz")
                        .resizable() // Resmi boyutlandırılabilir yapar
                        .aspectRatio(contentMode: .fit) // Oran koruyarak resmi boyutlandırır
                        .frame(height: 250) // Yükseklik belirler, genişliği orantılı olarak ayarlanır
                        .padding(.bottom, 40)
                   
                        
                        .fontWeight(.bold)
                    // City için özelleştirilmiş TextField
                    TextField("İl girin", text: $PviewModel.city)
                        .padding() // İç boşluk
                        .frame(height: 50) // Yükseklik ayarı
                        .background(Color.white) // Arka plan rengi
                        .cornerRadius(10) // Köşe yuvarlama
                        .shadow(radius: 5) // Gölgelendirme
                        .padding()

                    // District için özelleştirilmiş TextField
                    TextField("İlçe girin(opsiyonel)", text: $PviewModel.district)
                        .padding() // İç boşluk
                        .frame(height: 50) // Yükseklik ayarı
                        .background(Color.white) // Arka plan rengi
                        .cornerRadius(10) // Köşe yuvarlama
                        .shadow(radius: 5) // Gölgelendirme
                        .padding()

                    // Eczaneleri getir butonu ve yönlendirme
                    NavigationLink(destination: PharmacyListView(viewModel: PviewModel)) {
                        Text("Eczaneleri Getir")
                            .padding()
                            .background(Color.customblue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        
                    }
                    
                }
               
                .padding()
                .navigationTitle("Eczane Bul")
            }
        }
    }
}

#Preview {
    IlilceView()
}
