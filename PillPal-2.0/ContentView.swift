import SwiftUI
import CoreML
import Vision

//func testModel() -> PillPalImageClassifier_1Output? {
//    do{
//        let config = MLModelConfiguration()
//        
//        let model = try PillPalImageClassifier_1(configuration: config)
//        
////        let prediction = try model.prediction(image: #imageLiteral(resourceName: "testImage"))
//    }
//    catch{
//        
//    }
//    return nil
//}
//
//struct MLView: View {
//    let predictedClass = testModel()!.class_type
//    
//    var body: some View {
//        Text("Pill Identifier")
//            .padding()
//        Text(String(predictedClass))
//    }
//}



//struct MLView: View {
//    @State private var showPicker = false
//    @State private var image: UIImage?
//    @State private var predictionLabel = "Pick an image to classify"
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//                    .cornerRadius(10)
//            }
//
//            Text(predictionLabel)
//                .padding()
//
//            Button("Pick Image") {
//                showPicker = true
//            }
//            .padding()
//        }
//        .sheet(isPresented: $showPicker) {
//            ImagePicker(image: $image, onImagePicked: classifyImage)
//        }
//    }
//
//    func classifyImage() {
//        guard let uiImage = image,
//              let cgImage = uiImage.cgImage else {
//            predictionLabel = "Invalid image"
//            return
//        }
//
//        do {
//            let model = try VNCoreMLModel(for: PillPalImageClassifier_1(configuration: MLModelConfiguration()).model)
//
//            let request = VNCoreMLRequest(model: model) { request, error in
//                if let results = request.results as? [VNClassificationObservation],
//                   let topResult = results.first {
//                    DispatchQueue.main.async {
//                        predictionLabel = "Prediction: \(topResult.identifier) (\(Int(topResult.confidence * 100))%)"
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        predictionLabel = "Could not classify"
//                    }
//                }
//            }
//
//            let handler = VNImageRequestHandler(cgImage: cgImage)
//            try handler.perform([request])
//
//        } catch {
//            predictionLabel = "Failed: \(error.localizedDescription)"
//        }
//    }
//}



struct ContentView: View {
    @StateObject var medViewModel = MedicationViewModel()
    init() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Notification permission granted!")
                } else {
                    print("Notification permission denied.")
                }
            }
        }
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("PillPal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    
                    Image("pillpal4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        
                    
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: LoginView(viewModel: medViewModel)) {
                            Text("Log in")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 40)
                        
                        NavigationLink(destination: SignUpView(viewModel: medViewModel)) {
                            Text("Sign up")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 40)
                        
                        }

                        
                    }
                }
            }
        }
    }
    

    struct CameraScreen: View {
        var body: some View {
            ZStack{
                @State var camColor = Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                Color("MedCol").ignoresSafeArea()
                Image(systemName: "camera")
                    .resizable()
                    .frame(width: 150, height: 120)
                    .foregroundColor(.black)
                    .offset(y: -170)
                
                CameraConetntView()
            }
            TabView()
        }
    }
    
    struct PillScreen: View {
        @StateObject var medViewModel = MedicationViewModel()
        var body: some View {
            ZStack{
                Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                Text("Pill")
            }
            //TabView()
            MyMedicationsView(viewModel: medViewModel)
        }
    }
    
    struct SearchScreen: View {
        @State private var messageText = ""
        @State var messages: [String] = ["Welcome to Chat Bot 2.0"]
        var body: some View {
            VStack{
                
                HStack{
                    Text("iBot")
                        .font(.largeTitle)
                        .bold()
                    
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 26))
                        .foregroundColor(Color.blue)
                    
                    
                }
                
                // Scrollable view to display chat messages
                ScrollView {
                    // Loop through each message in the messages array
                    ForEach(messages, id: \.self) { message in
                        
                        // Check if the message is from the user (marked with [USER] prefix)
                        if message.contains("[USER]") {
                            // Remove the [USER] prefix to display a cleaner message
                            let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                            
                            // Right-aligned user message bubble
                            HStack {
                                Spacer() // Pushes content to the right side
                                Text(newMessage)
                                    .padding()
                                    .foregroundColor(.white) // White text
                                    .background(.blue.opacity(0.8)) // Blue bubble background
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                        } else {
                            // Left-aligned bot (or system) message bubble
                            HStack {
                                Text(message)
                                    .padding()
                                    .background(.gray.opacity(0.15)) // Light gray bubble
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer() // Pushes content to the left side
                            }
                        }
                    }
                    // Flip the message list vertically to make new messages appear at the bottom
                    .rotationEffect(.degrees(180))
                }
                // Re-flip the entire scroll view so the layout looks normal to the user
                .rotationEffect(.degrees(180))
                .background(Color.gray.opacity(0.1)) // Light background for chat area
                
                // Input field and send button at the bottom
                HStack {
                    // Text field for typing messages
                    TextField("Type something", text: $messageText)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .onSubmit {
                            // Send the message when the user presses return
                            sendMessage(message: messageText)
                        }
                    
                    // Send button (paper plane icon)
                    Button {
                        sendMessage(message: messageText) // Send message on button tap
                    } label: {
                        Image(systemName: "paperplane.fill") // SF Symbol for the paper plane
                    }
                    .font(.system(size: 26)) // Icon size
                    .padding(.horizontal, 10)
                }
                .padding() // Padding around the entire HStack
            }

            TabView()
        }
        func sendMessage(message: String){
            withAnimation{
                messages.append("[USER]" + message)
                self.messageText = ""
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation {
                    messages.append(getBotResponse(message: message))
                }
                
            }
        }

    }
    
    struct TabView: View {
        @State private var navigateToPillScreen = false
        @State private var navigateToCameraScreen = false
        @State private var navigateToSearchScreen = false

        
        
        var body: some View {
            HStack{
                Button(action: {
                    navigateToPillScreen = true
                }, label: {
                    Image(systemName: "pill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                    Text("                    ")
                })
                .navigationDestination(isPresented: $navigateToPillScreen) {
                    MyMedicationsView(viewModel: MedicationViewModel())
                }
                
                Button(action: {
                    navigateToCameraScreen = true
                }, label: {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                    Text("                    ")
                })
                .navigationDestination(isPresented: $navigateToCameraScreen) {
                    CameraScreen()
                }
                
                Button(action: {
                    navigateToSearchScreen = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                })
                .navigationDestination(isPresented: $navigateToSearchScreen) {
                    SearchScreen()
                }
                
            }
        }
    }
    
struct LoginView: View {
    @ObservedObject var viewModel: MedicationViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToMedications = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image("LogInPic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)

                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 40)

                Button(action: {
                    // Log in logic
                    print("Email: \(email)")
                    print("Password: \(password)")
                    navigateToMedications = true
                }) {
                    Text("Log in")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 40)

                Spacer()
                
                Text("""
Disclaimer: PillPal is designed for informational and educational purposes only. This app does not provide medical diagnosis, treatment, or professional medical advice. Always consult a qualified healthcare provider, pharmacist, or doctor with any questions you may have regarding a medical condition, medication, or treatment plan.
""")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
            }
            .background(Color.white.ignoresSafeArea())
            .navigationDestination(isPresented: $navigateToMedications) {
                MyMedicationsView(viewModel: viewModel)
            }
        }
    }
}

    
    struct SignUpView: View {
        @State private var firstName: String = ""
        @State private var lastName: String = ""
        @State private var dateOfBirth: Date = Date()
        @State private var email: String = ""
        @State private var phoneNumber: String = ""
        @State private var navigateToLogin = false
        
        @ObservedObject var viewModel: MedicationViewModel
        
        var body: some View {
            NavigationStack {
                ZStack {
                    Color.white.ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            Text("Sign Up")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                TextField("First Name", text: $firstName)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Last Name", text: $lastName)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Email", text: $email)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                
                                TextField("Phone Number", text: $phoneNumber)
                                    .keyboardType(.phonePad)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 40)
                            
                            Button(action: {
                                print("First Name: \(firstName)")
                                print("Last Name: \(lastName)")
                                print("Date of Birth: \(dateOfBirth)")
                                print("Email: \(email)")
                                print("Phone Number: \(phoneNumber)")
                                navigateToLogin = true
                            }) {
                                Text("Sign up")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 40)
                        }
                    }
                }
                .navigationDestination(isPresented: $navigateToLogin) {
                    LoginView(viewModel: viewModel)
                }
            }
        }
    }


struct MyMedicationsView: View {
    @StateObject var viewModel = MedicationViewModel()
    @State private var showingAddMedication = false

    var body: some View {
        ZStack {
            Color("MedCol")
                .ignoresSafeArea()
            @State var appColor =  Color(red: 122/255, green: 198/255, blue: 227/255)
                

            VStack {
                Image("Paper")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 200)
                Text("My Medications")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                HStack {
                    
                    Spacer()

                    Button(action: {
                        showingAddMedication = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                            .shadow(radius: 4)
                            //.offset(y: -150)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 50)
                }


                if viewModel.medications.isEmpty {
//                    Text("No medications added yet")
//                        .foregroundColor(.black)
//                        .padding(.top, 50)
                } else {
                    List {
                        ForEach(viewModel.medications) { med in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(med.name)
                                    .font(.headline)
                                Text("Frequency: \(med.frequency)")
                                    .font(.subheadline)
                                ForEach(med.reminderTimes, id: \.self) { time in
                                    Text("⏰ \(time.formatted(date: .omitted, time: .shortened))")
                                        .font(.caption)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete(perform: deleteMedication)
                    }
//                    .scrollContentBackground(.hidden) // transparent background
//                    .frame(maxHeight: .infinity)
                }

                Spacer()
                TabView()

            }
        }
        .sheet(isPresented: $showingAddMedication) {
            AddMedicationView(viewModel: viewModel)
        }
    }

    private func deleteMedication(at offsets: IndexSet) {
        viewModel.medications.remove(atOffsets: offsets)
    }
}


   
    
    //import UserNotifications

    struct AddMedicationView: View {
        @Environment(\.dismiss) var dismiss
        @ObservedObject var viewModel: MedicationViewModel
        
        @State private var medicationName: String = ""
        @State private var selectedFrequency: String = "Daily"
        
        let frequencies = [
            "Three times a day",
            "Twice a day",
            "Daily",
            "Three times a week",
            "Twice a week",
            "Once a week"
        ]
        
        @State private var reminderTimes: [Date] = [Date()]
        
        var body: some View {
            NavigationStack {
                Form {
                    Section(header: Text("Medication Details")) {
                        TextField("Medication Name", text: $medicationName)
                        
                        Picker("Frequency", selection: $selectedFrequency) {
                            ForEach(frequencies, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Reminder Times")) {
                        ForEach(reminderTimes.indices, id: \.self) { index in
                            HStack {
                                DatePicker(
                                    "Time \(index + 1)",
                                    selection: Binding(
                                        get: { reminderTimes[index] },
                                        set: { reminderTimes[index] = $0 }
                                    ),
                                    displayedComponents: .hourAndMinute
                                )
                                if reminderTimes.count > 1 {
                                    Button(action: {
                                        reminderTimes.remove(at: index)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        
                        Button(action: {
                            reminderTimes.append(Date())
                        }) {
                            Label("Add Time", systemImage: "plus.circle")
                        }
                    }
                    
                    Button(action: {
                        let newMed = Medication(name: medicationName, frequency: selectedFrequency, reminderTimes: reminderTimes)
                        viewModel.medications.append(newMed)
                        
                        scheduleNotifications(for: newMed)
                        
                        dismiss()
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.blue)
                    }
                }
                .navigationTitle("Add Medication")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
        
        func scheduleNotifications(for medication: Medication) {
            let center = UNUserNotificationCenter.current()
            
            // Request permission first (only once in real app!)
            center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                if granted {
                    for time in medication.reminderTimes {
                        let content = UNMutableNotificationContent()
                        content.title = "Time to take \(medication.name)"
                        content.body = "Frequency: \(medication.frequency)"
                        content.sound = UNNotificationSound.default
                        
                        let calendar = Calendar.current
                        let dateComponents = calendar.dateComponents([.hour, .minute], from: time)
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                        
                        let id = UUID().uuidString
                        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                        
                        center.add(request)
                    }
                } else {
                    print("Notifications permission not granted: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
    


//making this to store medicine information
struct Medication: Identifiable {
    let id = UUID()
    let name: String
    let frequency: String
    let reminderTimes: [Date]
}

class MedicationViewModel: ObservableObject {
    @Published var medications: [Medication] = []
}

//@Published changes UI automatically



#Preview {
    ContentView()
}
