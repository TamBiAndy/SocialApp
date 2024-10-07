//
//  Mock.swift
//  SocialApp
//
//  Created by Andy on 23/09/2024.
//

import UIKit

let mock = """
{
  "segmented": [
    {
      "id": 1,
      "title": "Popular"
    },
    {
      "id": 2,
      "title": "Trending"
    },
    {
      "id": 3,
      "title": "Following"
    }
  ],
  "data": {
    "Popular": [
      {
        "userId": 301,
        "userName": "Tom Johnson",
        "userImage": "https://i.imgur.com/A3q45Jf.jpeg",
        "onlineStatus": "Online 10 minutes ago",
        "statusImage": "https://i.imgur.com/vf5rBty.jpeg",
        "commentCount": 34,
        "likeCount": 200
      },
      {
        "userId": 301,
        "userName": "Alex Hong",
        "userImage": "https://i.imgur.com/l3Tokt8.jpeg",
        "onlineStatus": "Online 30 minutes ago",
        "statusImage": "https://i.imgur.com/fiDfloW.jpeg",
        "commentCount": 35,
        "likeCount": 100
      },
      {
        "userId": 302,
        "userName": "Sarah Williams",
        "userImage": "https://i.imgur.com/tAxblC5.jpeg",
        "onlineStatus": "Online 1 hour ago",
        "statusImage": "https://i.imgur.com/01jDewB.jpeg",
        "commentCount": 12,
        "likeCount": 98
      }
    ],
    "Trending": [
      {
        "userId": 303,
        "userName": "Alice Brown",
        "userImage": "https://i.imgur.com/KSindRG.jpeg",
        "onlineStatus": "Online 5 minutes ago",
        "statusImage": "https://i.imgur.com/qGOdloN.jpeg",
        "commentCount": 45,
        "likeCount": 150
      },
      {
        "userId": 304,
        "userName": "Robert Green",
        "userImage": "https://i.imgur.com/OHmzMSD.jpeg",
        "onlineStatus": "Online 2 hours ago",
        "statusImage": "https://i.imgur.com/XvrlZFP.jpeg",
        "commentCount": 25,
        "likeCount": 300
      }
    ],
    "Following": [
      {
        "userId": 305,
        "userName": "Emily White",
        "userImage": "https://i.imgur.com/oy3NbFW.jpeg",
        "onlineStatus": "Online just now",
        "statusImage": "https://i.imgur.com/65MP76Q.jpeg",
        "commentCount": 10,
        "likeCount": 75
      },
      {
        "userId": 306,
        "userName": "Michael Black",
        "userImage": "https://i.imgur.com/6YKgUHv.jpeg",
        "onlineStatus": "Online yesterday",
        "statusImage": "https://i.imgur.com/BK8RJqM.jpeg",
        "commentCount": 5,
        "likeCount": 50
      }
    ]
  }
}
"""

let mock1 = """
{
"id": 12,
"topic": [
{
"id": 1,
"image": "https://www.pexels.com/photo/winter-wonderland-by-a-frozen-river-28518049/",
"title": "PHOTOGRAPHY"
},
{
"id": 2,
"image": "https://www.pexels.com/photo/bay-at-dawn-20451736/",
"title": "UI DESIGN"
},
{
"id": 3,
"image": "https://www.pexels.com/photo/scenic-view-of-the-desert-at-sunset-25972563/",
"title": "IILUSTRATION"
},
{
"id": 4,
"image": "https://www.pexels.com/photo/wooden-shed-near-water-in-countryside-17514561/",
"title": "MAKING VIDEO"
}
]
}
"""

let mock2 = """
{
"id": 12,
"topic": [
{
"id": 1,
"image": "https://www.pexels.com/photo/winter-wonderland-by-a-frozen-river-28518049/",
"title": "PORTRAIT
PHOTOGRAPHY",
"quantity": 70 photos
},
{
"id": 2,
"image": "https://www.pexels.com/photo/bay-at-dawn-20451736/",
"title": "MUSIC VIDEO",
"quantity": 10 videos
},
{
"id": 3,
"image": "https://www.pexels.com/photo/scenic-view-of-the-desert-at-sunset-25972563/",
"title": "MUSIC VIDEO",
"quantity": 10 videos
},
{
"id": 4,
"image": "https://www.pexels.com/photo/wooden-shed-near-water-in-countryside-17514561/",
"title": "MUSIC VIDEO",
"quantity": 10 videos
}
]
}
"""

let mock3 = """
{
"id": 12,
"activity": [
{
"id": 1,
"userImg": "https://images.pexels.com/users/avatars/1784033247/sergey-guk-723.jpg?auto=compress&fit=crop&h=130&w=130&dpr=1",
"userName": "Bruno Pham",
"action": "liked",
"status": "“Autumn in my heart”",
"image": "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"onlineTime": "2 minutes ago",
"follow": "Followed"
},
{
"id": 2,
"userImg": "https://images.pexels.com/users/avatars/3315593/jasmin-chew-200.jpeg?auto=compress&fit=crop&h=130&w=130&dpr=1",
"userName": "Michel Truong",
"action": "liked",
"status": "“Autumn in my heart”",
"image": "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"onlineTime": "2 minutes ago",
"follow": "Not yet Follow"
},
{
"id": 3,
"userImg": "https://images.pexels.com/users/avatars/3770809/abi-greer-428.jpeg?auto=compress&fit=crop&h=130&w=130&dpr=1",
"userName": "Yuna Vu",
"action": "liked",
"status": "“Autumn in my heart”",
"image": "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"onlineTime": "2 minutes ago",
"follow": "Followed"
},
{
"id": 4,
"userImg": "https://images.pexels.com/lib/avatars/purple.png?w=130&h=130&fit=crop",
"userName": "HooYeon",
"action": "added",
"status": "“Autumn in my heart”",
"image": "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"onlineTime": "2 minutes ago",
"follow": "Followed"
},
{
"id": 5,
"userImg": "https://images.pexels.com/users/avatars/121938/eberhard-grossgasteiger-522.jpeg?auto=compress&fit=crop&h=130&w=130&dpr=1",
"userName": "Andy Ngo",
"action": "liked",
"status": "“Autumn in my heart”",
"image": "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
"onlineTime": "2 minutes ago",
"follow": "Not yet Follow"
}
]
}
"""
let mock4 = """
{
"id": 12,
"shot": [
{
"id": 1,
"image": "https://images.pexels.com/photos/5724880/pexels-photo-5724880.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 2,
"image": "https://images.pexels.com/photos/5589865/pexels-photo-5589865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 3,
"image": "https://images.pexels.com/photos/5827880/pexels-photo-5827880.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 4,
"image": "https://images.pexels.com/photos/5838883/pexels-photo-5838883.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 5,
"image": "https://images.pexels.com/photos/5589865/pexels-photo-5589865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 6,
"image": "https://images.pexels.com/photos/235767/pexels-photo-235767.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 7,
"image": "https://images.pexels.com/photos/2682103/pexels-photo-2682103.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 8,
"image": "https://images.pexels.com/photos/235721/pexels-photo-235721.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 9,
"image": "https://images.pexels.com/photos/1389460/pexels-photo-1389460.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"id": 10,
"image": "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
}
],
"video": [
{
"title": "YOUR LIKES",
"video_Qty": "25 shots",
"image": "https://images.pexels.com/photos/772520/pexels-photo-772520.jpeg"
},
{
"title": "YOUR LIKES",
"video_Qty": "25 shots",
"image": "https://images.pexels.com/photos/773471/pexels-photo-773471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"title": "DOWNLOAD",
"video_Qty": "25 shots",
"image": "https://images.pexels.com/photos/3082731/pexels-photo-3082731.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
},
{
"title": "PORTRAIT PHOTOGRAPHY",
"video_Qty": "25 shots",
"image": "https://images.pexels.com/photos/772520/pexels-photo-772520.jpeg"
},
{
"title": "PORTRAIT PHOTOGRAPHY",
"video_Qty": "25 shots",
"image": "https://images.pexels.com/photos/772520/pexels-photo-772520.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
}
]
}
"""
