import SwiftUI

struct InstrumentsView: View {

    @StateObject var viewModel: ViewModel
    
    static let tag: String? = "Instruments".localized

    init(dataController: DataController) {
        
        // Dependency injection here
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
        
    }
    
    var body: some View {
        
        NavigationView {
            
            List {                
                ForEach(viewModel.instruments) { instrument in
                    InstrumentsRow(instruments: instrument)

                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Guitars".localized)
            .toolbar {
                
                Button {
                    withAnimation {
                        viewModel.addNewProject()
                    }
                } label: {
                    Label("Add New Guitar".localized, systemImage: "plus")
                }
            }
            
        }
        .onDisappear(perform: viewModel.dataController.save)
        .navigationViewStyle(StackNavigationViewStyle())
        .refreshable {
            viewModel.fetch()
        }
        
    }
    
    
}

struct InstrumentsView_Previews: PreviewProvider {
    
    static var previews: some View {
        InstrumentsView(dataController: DataController.preview)
    }
}
