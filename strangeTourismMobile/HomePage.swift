import SwiftUI

struct HomeView: View {
    @StateObject  var vm = SignIn_withGoogle_VM()
    @State var labelColor=false
    @ObservedObject var viewModelfeeds = ViewModelFeeds()

    var body: some View {
        
//        VStack{
//            ScrollView{
//                VStack(spacing: 0, content: {
//                    ForEach(0..<10) { _ in
//                        HStack(alignment: .top,spacing: 0, content: {
//                            PostDetails()
//
//                        })
//                    }
//
//
//                })
//                .navigationBarItems(leading: NavBarLeadingItems())
//                .statusBar(hidden: true)
//
//            }
//            BottomTabBar()
//        }
        
        

        NavigationView {
            List(viewModelfeeds.feeds, id: \._id) { feeds in
                FeedView(feeds: feeds)
                // Extract the inner view to a separate sub-expression
            }
            .navigationBarTitle("Posts")

        }
        .onAppear {
            viewModelfeeds.feedPosts(
                token:vm.token
            )
    
        }

        
    }
}

struct FeedView: View {
    var feeds: FeedsViewModelElement // Assuming FeedsViewModelElement is your model
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(feeds.user!.profilePic)
            
            Text(feeds.location).foregroundColor(.red)
                .background(.red)
            Text(feeds.postDate).foregroundColor(.red)
                .background(.red)
            Text(feeds.postText!).foregroundColor(.red)
                .background(.red)
            
            TabView {
                ForEach(feeds.media, id: \.id) { media in
                    ImageView(media: media) // Extract the image view to a separate sub-expression
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(width: 400, height: 400)
        }.background(.red)
    }
}

struct ImageView: View {
    var media: Media
    
    var body: some View {
        Image(media.mediaFile) // Assuming 'media' has a 'mediaFile' property
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.top, 6)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct NavBarLeadingItems: View {
    @State var isHeartTapped = false
    var body: some View {
        HStack(content: {
            Image("home_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 50)
                .padding(.top,6)
                .padding(.bottom,10)
            Spacer()
            HStack(spacing: 0) {
                Image("heart_img")
                              .foregroundColor(isHeartTapped ? .red : .gray)
                              .font(.title2)
                              .padding(.leading, 190)
                              .onTapGesture {
                                  isHeartTapped.toggle()
                              }
                
                Image("chat").background(.gray)
                            .font(.title2)
            }
            
        })
    }
}

struct PostDetails: View {
    @StateObject  var vm = SignIn_withGoogle_VM()
//    @StateObject private var viewModelfeeds = ViewModelFeeds()
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image("Image")
                    .resizable()
                    .background(Color.black)
                    .frame(width: 50, height: 50)
                    .cornerRadius(36)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                    
                VStack(alignment: .leading) {
                    Text("Vignesh").bold()
                    Text("Jul 13 at 10:24 AM")
                }.padding(.leading,5)
            }.padding(.leading)
                .padding(.top)
            Text("Captions")
                .padding(.horizontal, 10)
            ImageSlider()
            HStack(spacing: 0) {
                Image("heart_img")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Text("2 Likes")
                
                Spacer()
                
                Image("comment_img")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Image("save_img")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Image("share_img")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }.frame( height: 50)
                .padding(.trailing)
        }
                .onAppear {
//                    viewModelfeeds.feedPosts(withUID:vm.uid )
//                    ViewModel().fetchPosts(withUID: vm.uid)
                }
        .padding(.leading)
        
    }
}

struct ImageSlider: View {
    var body: some View {
        TabView {
            ForEach(0..<3) { index in
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 6)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(width: 400,height: 400)
    }
}

struct BottomTabBar: View {
    @State private var selectedTab: Int = 0
    
    var tabItems: [(imageName: String, text: String)] = [
        ("home", "Home"),
        ("map", "Plan"),
        ("add", "Post"),
        ("search", "Search"),
        ("user", "Profile")
    ]
    
    var body: some View {
        HStack {
            
            ForEach(0..<tabItems.count) { tabIndex in
                Spacer()
                TabBarButton(
                    imageName: tabItems[tabIndex].imageName,
                    text: tabItems[tabIndex].text,
                    tabIndex: tabIndex,
                    selectedTab: $selectedTab
                )
                .onTapGesture {
                    selectedTab = tabIndex
                }
                Spacer()
                
            }
        }
        .background(CustomColor.customColor)
    }
}

struct TabBarButton: View {
    var imageName: String
    var text: String
    var tabIndex: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            
            Text(text)
                .foregroundColor(selectedTab == tabIndex ? CustomColor.labelColor : .white)
        }
        .padding(.top)
    }
}

