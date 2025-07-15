import SwiftUI

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
                
                VStack(spacing: 40) {
                    Text("PillPal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    
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
                Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                Text("Camera")
            }
            TabView()
        }
    }
    
    struct PillScreen: View {
        var body: some View {
            ZStack{
                Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                Text("Pill")
            }
            TabView()
        }
    }
    
    struct SearchScreen: View {
        var body: some View {
            ZStack{
                Color(red: 122/255, green: 198/255, blue: 227/255)
                    .ignoresSafeArea()
                Text("Search")
            }
            TabView()
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
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    Text("       ")
                })
                .navigationDestination(isPresented: $navigateToPillScreen) {
                    PillScreen()
                }
                
                Button(action: {
                    navigateToCameraScreen = true
                }, label: {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    Text("       ")
                })
                .navigationDestination(isPresented: $navigateToCameraScreen) {
                    CameraScreen()
                }
                
                Button(action: {
                    navigateToSearchScreen = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
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
                ZStack {
                    Color.white.ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Text("Log In")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading, spacing: 15) {
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
                    }
                }
                //  Modern navigationDestination
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

    
//    struct MyMedicationsView: View {
//        @ObservedObject var viewModel: MedicationViewModel
//        @State private var showingAddMedication = false
//        //@State private var navigateToAddMedication = false
//        
//        var body: some View {
//            ZStack {
//                Color(red: 122/255, green: 198/255, blue: 227/255)
//                    .ignoresSafeArea()
//                
//                VStack {
//                    Text("My Medications")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(.top, 50)
//                    
//                    List {
//                        ForEach(viewModel.medications) { med in
//                            VStack(alignment: .leading) {
//                                Text(med.name)
//                                    .font(.headline)
//                                Text("Frequency: \(med.frequency)")
//                                    .font(.subheadline)
//                                ForEach(med.reminderTimes, id: \.self) { time in
//                                    Text("⏰ \(time.formatted(date: .omitted, time: .shortened))")
//                                        .font(.caption)
//                                }
//                            }
//                        }
//                    }
//                    
//                    //Spacer()
//                    
//                    
//                        //Spacer()
//                        Button(action: {
//                            showingAddMedication = true
//                            //navigateToAddMedication = true
//                        }) {
//                            Image(systemName: "plus.circle.fill")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(.white)
//                                .shadow(radius: 4)
//                                .position(x: 350, y: -400)
//                        }
//                        //TabView()
//                        .padding()
//                    
////                    .navigationDestination(isPresented: $navigateToAddMedication) {
////                        AddMedicationView(viewModel: viewModel)
////                    }
//                    .sheet(isPresented: $showingAddMedication) {
//                                AddMedicationView(viewModel: viewModel)
//                            }
//                }
//            }
//        }
//    }

struct MyMedicationsView: View {
    @ObservedObject var viewModel: MedicationViewModel
    @State private var showingAddMedication = false

    var body: some View {
        ZStack {
            Color(red: 122/255, green: 198/255, blue: 227/255)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        showingAddMedication = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 50)
                }

                Text("My Medications")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)


                List {
                    ForEach(viewModel.medications) { med in
                        VStack(alignment: .leading) {
                            Text(med.name)
                                .font(.headline)
                            Text("Frequency: \(med.frequency)")
                                .font(.subheadline)
                            ForEach(med.reminderTimes, id: \.self) { time in
                                Text("⏰ \(time.formatted(date: .omitted, time: .shortened))")
                                    .font(.caption)
                            }
                        }
                    }
                }
                TabView()
            }
        }
        .sheet(isPresented: $showingAddMedication) {
            AddMedicationView(viewModel: viewModel)
        }
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
