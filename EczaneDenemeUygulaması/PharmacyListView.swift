import SwiftUI

struct PharmacyListView: View {
    @ObservedObject var viewModel = PharmacyViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradyan arka plan
                LinearGradient(
                    gradient: Gradient(colors: [Color.red, Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    
                    if viewModel.isLoading {
                        ProgressView("Yükleniyor...")
                    } else {
                        // List'i ZStack içinde sarmalıyoruz
                        ZStack {
                            // Arka planı burada tutmak için boş bir arka plan rengi ekliyoruz
                            Color.clear
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.white, Color.ortaRed]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .ignoresSafeArea()

                            List(viewModel.pharmacies) { pharmacy in
                                NavigationLink(destination: PharmacyMapView(pharmacy: pharmacy)) {
                                    VStack(alignment: .leading) {
                                        Text(pharmacy.name ?? "Bilinmiyor")
                                            .font(.headline)
                                        Text(pharmacy.dist ?? "Bilinmiyor")
                                            .font(.subheadline)
                                        Text(pharmacy.address ?? "Adres Bilinmiyor")
                                            .font(.caption)
                                        Text("tel no: \(pharmacy.phone!)")
                                            .bold()
                                    }
                                    .cornerRadius(12) // Köşeleri yuvarlat
                                    
                                    
                                }
                            }
                            
                            // List'in arka plan rengini temizliyoruz
                            .scrollContentBackground(.hidden)
                        }
                    }
                }
            }
            .navigationTitle("Nöbetçi Eczaneler")
            .onAppear {
                viewModel.fetchDutyPharmacies()
            }
        }
    }
}

#Preview {
    PharmacyListView()
}
