//
//  PrivacyView.swift
//  Task
//
//  Created by Andrey on 06.07.2023.
//

import SwiftUI

struct PrivacyView: View {
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Image("PrivacyImage")
                        .padding(.bottom, 32)
                    VStack(alignment: .leading) {
                        Text("Privacy Policy")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("This Privacy Policy describes how we handle and protect the data collected and stored in the Goal Tracker application. We value your privacy and strive to ensure the security of your data.")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("Data Collection")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("The Goal Tracker application does not collect personal information and does not require user registration. All data related to your tasks and goals are stored locally on your device and are not transmitted to our servers or third parties.")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("Data Usage")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("We solely use the data collected in the Goal Tracker application for the purpose of displaying and managing your tasks and goals. Your data is not used for commercial purposes, advertising, or shared with third parties.")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("Data Security")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        Text("We implement reasonable security measures to protect your data from unauthorized access, loss, or theft. However, please be aware that no data storage or transmission system over the internet is entirely secure, and we cannot guarantee the complete protection of your data.")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        VStack(alignment: .leading) {
                            
                            Text("Changes to the Privacy Policy")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.bottom, 16)
                            Text("We reserve the right to make changes to this Privacy Policy from time to time. Any changes will be posted within the application or updated in this document. Continued use of the Goal Tracker application after the changes will signify your agreement to the updated Privacy Policy.")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.bottom, 16)
                            Text("Contact Us")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.bottom, 16)
                            Text("If you have any questions or concerns regarding the privacy policy or the use of the Goal Tracker application, please contact us at:")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            Text("goal_team_tracker@gmai.com")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.top, 12)
                                .foregroundColor(Color.greenColor)
                        }
                    }
                    
                }
            }.padding(16)
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
        
    }
}
