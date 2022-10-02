//
//  PostModel.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

public struct PostModel {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public static let posts = [
        PostModel(author: "Zero Cold",
                  description: "Zero Cold - The Spell of the North [2022] EP. \nLabel: Betrieb records (DE). \nGenre: Industrial techno/Experimental. \nRelease date: 03.01.2022",
                  image: "zerocoldPost1",
                  likes: 242,
                  views: 368),
        
        PostModel(author: "Zero Cold",
                  description: "Zero Cold - Make techno, not war [2021] EP. \nLabel: Betrieb records (DE). \nGenre: techno/industrial techno. \nRelease date: 20.12.2021",
                  image: "zerocoldPost2",
                  likes: 391,
                  views: 423),
        
        PostModel(author: "Zero Cold",
                  description: "Zero Cold - St.Petersburg Morning[2020] Single. \nLable: Zero Cold records. \nGenre: industrial techno. \nRelease date: 02.10.2020",
                  image: "zerocoldPost3",
                  likes: 122, views: 147),
        
        PostModel(author: "Zero Cold",
                  description: "Zero Cold - Technocracy[2020] EP. \nLabel: Zero Cold records. \nGenre: techno. \nRelease date: //22.03.2020",
                  image: "zerocoldPost4", likes: 95, views: 159),
    ]
}
