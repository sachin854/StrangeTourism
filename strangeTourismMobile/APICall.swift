import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

struct APICall: View {
    
    @State var email = ""
    @State var password = ""
    @State var emailError = false
    @State var passwordError = false
    @State var errorMessage1 = ""
    @State var errorMessage2 = ""
    @State private var isNavigating = true
    @State private var phonAuth = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack(alignment: .leading) {
                    Color.black
                    VStack(alignment: .leading) {
                        
                        BackButton()
                        Group {
                            LoginTitle()
                            CustomLabel(labelText: "Email").padding(.top,10)
                            EmailTextField(email: $email, emailError: $emailError,errorMessage1: $errorMessage1)
                            if(emailError==true){
                                EmailValidation(labelText: errorMessage1)
                            }
                        }
                        Group {
                            CustomLabel(labelText: "Password").padding(.top,10)
                            PasswordTextField(password: $password,passwordError: $passwordError,errorMessage2: $errorMessage2)
                            if(passwordError==true){
                                PasswordValidation(labelText: errorMessage2)
                                
                            }
                        }
                        Group {
                            CustomLabel(labelText: "Forgot Password").padding(.top,10)
                            
                            LoginButton(email: $email, password:$password,emailError: $emailError,passwordError:$passwordError,errorMessage1:$errorMessage1,errorMessage2:$errorMessage2,isNavigating: $isNavigating)
                            
//                            if(isNavigating==true){
//                                NavigationLink(destination: HomeView(), isActive: $isNavigating) {
//                                    EmptyView()
//                                }.padding(.horizontal,10)
//                                    .background(Color.red)
//                            }
                            
                            Text("Phone Auth")
                                            .foregroundColor(.red)
                                            .background(Color.green) // Reversed the order of modifiers
                                            .onTapGesture {
                                                phonAuth = true // Activate the navigation
                                            }
                            if phonAuth {
                                            NavigationLink(destination: PhoneAuth(), isActive: $phonAuth) {
                                                EmptyView() // Not necessary if using onTapGesture directly on the Text
                                            }
                                            .padding(.horizontal, 10)
                                            .background(Color.red)
                                        }
                            
                            GoogleSignUpButton()
                            
                            AppleSignUpButton()
                            
                        }
                        
                        
                    }.padding(25)
                        .frame(maxHeight: .infinity)
                }.navigationBarItems(leading: backButton)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                
            }
        }
    }
    
    
    
    private var backButton: some View {
        Button(action: {
            print("Back tapped")
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        APICall()
    }
}


struct BackButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.3))
                .frame(width: 40, height: 40)
            
            Button(action: {
                print("Back tapped")
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
        }
    }
}

struct LoginTitle: View {
    var body: some View {
        Text("Log in to your PMTool")
            .foregroundColor(.white)
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 5)
    }
}

struct CustomLabel: View {
    var labelText: String
    var body: some View {
        Text(labelText)
            .foregroundColor(.green)
            .font(.headline)
            .cornerRadius(5.0)
    }
}

struct EmailValidation: View {
    var labelText: String
    var body: some View {
        Text(labelText)
            .foregroundColor(.red)
            .font(.subheadline)
            .cornerRadius(5.0)
    }
}

struct PasswordValidation: View {
    var labelText: String
    var body: some View {
        Text(labelText)
            .foregroundColor(.red)
            .font(.subheadline)
            .cornerRadius(5.0)
    }
}



struct EmailTextField: View {
    @Binding var email: String
    @Binding var emailError: Bool
    @Binding var errorMessage1: String
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("Please enter the Email", text: $email)
                .padding(.trailing,5)
                .foregroundColor(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2)
                )
                .textContentType(.emailAddress)
            
                .onChange(of: email) { _ in
                                   if email.isEmpty {
                                       errorMessage1 = "Email is empty..!!!"
                                       emailError = true
                                   } else if !isValidEmail(email) {
                                       errorMessage1 = "Invalid Email..!!!"
                                       emailError = true
                                   } else {
                                       errorMessage1 = ""
                                       emailError = false
                                   }
                               }
        }.foregroundColor(Color.red)
            .cornerRadius(8)
        
    }
   
    
}
 func isValidEmail(_ email: String) -> Bool {
       let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
       return emailPredicate.evaluate(with: email)
   }

struct PasswordTextField: View {

@FocusState var focus1: Bool
@FocusState var focus2: Bool
@State var showPassword: Bool = false
@Binding var password: String

    
    @Binding var passwordError: Bool
    @Binding var errorMessage2: String
    
var body: some View {
    HStack {
        ZStack(alignment: .trailing) {
            TextField("Please enter the password", text: $password)
                .padding(.trailing,5)
                .foregroundColor(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )
                .textContentType(.password)
                .focused($focus1)
                .opacity(showPassword ? 1 : 0)
            SecureField("Please enter the password", text: $password)
                .padding(.trailing,5)
                .foregroundColor(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )
                .textContentType(.password)
                .focused($focus2)
                .opacity(showPassword ? 0 : 1)
                .onChange(of: password) { _ in
                    if password.isEmpty {
                        errorMessage2 = "Password is empty..!!!"
                        passwordError = true
                    } else {
                        errorMessage2 = ""
                        passwordError = false
                    }
                    }
            Button(action: {
                showPassword.toggle()
                if showPassword { focus1 = true } else { focus2 = true }
            }, label: {
                Image(systemName: self.showPassword ? "eye.fill" : "eye.slash.fill").font(.system(size: 16, weight: .regular))
                    .padding()
            })
        }
    }
}
}




struct LoginButton: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var emailError: Bool
    @Binding var passwordError: Bool
    @Binding var errorMessage1: String
    @Binding var errorMessage2: String
    @Binding var isNavigating: Bool
    
    @State private var selection: String? = nil
    var body: some View {
            VStack {
                
                Button(action: {
                    print("Login tapped")
                    
                    
                    if email.isEmpty {
                        errorMessage1 = "Email is empty..!!!"
                        emailError = true
                    } else if !isValidEmail(email) {
                        errorMessage1 = "Invalid Email..!!!"
                        emailError = true
                    } else {
                        errorMessage1 = ""
                        emailError = false
                    }
                    
                    
                    if password.isEmpty {
                        errorMessage2 = "Password is empty..!!!"
                        passwordError = true
                    } else {
                        errorMessage2 = ""
                        passwordError = false
                    }
                    
                    if !email.isEmpty && !password.isEmpty {
                        self.isNavigating = true
                    }
                    
                    
                    
                }) {
                    Text("Login")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .greatestFiniteMagnitude)
                        .background(Color.white)
                        .cornerRadius(5.0)
                }
                
                .cornerRadius(10.0)
                .padding(.top, 15)
                .shadow(color: Color.white.opacity(0.4), radius: 5, x: 5, y: 5)
                
                
                Divider().background(Color.white).padding(.top,15)
                Text("OR").foregroundColor(.white).fontWeight(Font.Weight.medium).font(.caption2)
                Divider().background(Color.white)
            
            
        }}
    
}

struct GoogleSignUpButton: View {
    @StateObject  var vm = SignIn_withGoogle_VM()
    @State private var isNavigating = true
    var body: some View {
        Button(action: {
            vm.signInWithGoogle()
               
                    NavigationLink(destination: HomeView(), isActive: self.$isNavigating) {
                        EmptyView()
                    }.padding(.horizontal,10)
                        .background(Color.red)

    
            print("Google SignUp tapped")
        }) {
            ZStack(alignment: .leading) {
                Image("google-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 20)
                Text("Continue with Google")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.leading, 40)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(10.0)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 0.5)
        )
        .padding(.top, 40)
    }
}

struct AppleSignUpButton: View {
    var body: some View {
        Button(action: {
            // Handle login button tap here
            print("Apple SignUp tapped")
        }) {
            ZStack(alignment: .leading) {
                Image("apple-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 20)
                
                Text("Continue with Apple") 
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.leading, 40)
            }
        }
        .buttonStyle(PlainButtonStyle()) // Remove default button style to remove additional padding
        .cornerRadius(10.0)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 0.5)
        )
        .padding(.top, 20)
    }
}

