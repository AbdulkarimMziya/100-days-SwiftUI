//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Abdulkarim Mziya on 2026-05-08.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        List {
            // Section 1: User Overview
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.about)
                        .padding(.vertical, 5)
                    
                    HStack {
                        Label("Age: \(user.age)", systemImage: "calendar")
                        Spacer()
                        Label(user.company, systemImage: "building.2")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            } header: {
                Text("About")
            }

            // Section 2: Contact Info
            Section("Contact Information") {
                LabeledContent("Email", value: user.email)
                LabeledContent("Address", value: user.address)
                LabeledContent("Registered", value: user.formattedDate)
            }

            // Section 3: Friends List
            Section("Friends (\(user.friends.count))") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Visual indicator of activity status in the corner
            ToolbarItem(placement: .topBarTrailing) {
                Circle()
                    .fill(user.isActive ? .green : .red)
                    .frame(width: 16, height: 16)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 2)
                    }
            }
        }
    }
}


#Preview {
    let sampleUser = User(
        id: "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
        isActive: true,
        name: "Gale Dyer",
        age: 28,
        company: "Cemention",
        email: "galedyer@cemention.com",
        address: "652 Gatling Place, Kieler, Arizona, 1705",
        about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
        registered: "2014-07-05T04:25:04-01:00",
      
        friends: [
            User.Friend(
                id: "1c18ccf0-2647-497b-b7b4-119f982e6292",
                name: "Daisy Bond"
            ),
            User.Friend(
                id: "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9",
                name: "Tanya Roberson"
            )
        ]
    )
    UserDetailView(user: sampleUser)
}
