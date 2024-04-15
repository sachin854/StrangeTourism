//
//  PhoneAuth.swift
//  pmToolMobile
//
//  Created by Sachin on 22/08/23.
//

//import SwiftUI
//
//struct PhoneAuth: View {
//    var body: some View {
//        VStack(alignment:.leading,content: {
//            Text("Enter your Phone No")
//        })
//    }
//}
//
//struct PhoneAuth_Previews: PreviewProvider {
//    static var previews: some View {
//        PhoneAuth()
//    }
//}




//
//  Login.swift
//  SwiftUI OTP
//
//  Created by Luthfi Abdul Azis on 06/03/21.
//

import SwiftUI


struct PhoneAuth: View {
    @State private var phoneNumber = ""
    @State private var countryCode = "+91"
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Image("logo").resizable()
                    .frame(width: 200,height: 200)
                
                Text("OTP Verification")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(20)
                
                Text("We will send you an \(Text("One Time Password").fontWeight(.bold).foregroundColor(.black)) on this mobile number")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,5)
                
                Text("Enter Mobile Number")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding()
                
                HStack {
                    TextField("Country Code", text: $countryCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 45)
                        .padding() .keyboardType(.numberPad)
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
        
                }
                
                Divider()
                    .frame(maxWidth: UIScreen.main.bounds.width / 2, maxHeight: 1)
                    .padding(.bottom)
                
                Button(action: {
                    withAnimation {
                       
                    }
                }, label: {
                    Text("Send OTP")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color("Primary"))
                        .cornerRadius(6)
                        .shadow(color: Color("Primary").opacity(0.8), radius: 6, x: 1, y: 1)
                    
                }).padding()
            }
            
        }
        
    }
}

struct PhoneAuth_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuth()
    }
}


