//
//  Constants.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import Foundation

//URLs
let BASE_LOGIN_URL = "http://admin.4like.rs/admin/api/login.php"
let BASE_SURVEY_LIST_URL = "http://admin.4like.rs/admin/api/read.php?id="
let BASE_LOCATION_URL = "http://admin.4like.rs/admin/api/lokacija.php"
let BASE_COMMENTS_URL = "http://admin.4like.rs/admin/api/create.php"

//Notifications
let WRONG_LOGIN_PARAMS = "WRONG_LOGIN_PARAMS"
let NO_SURVEYS = "NO_SURVEYS"
let LOCATION_DETERMINED = "LOCATION_DETERMINED"
let HTTP_ERROR = "HTTP_ERROR"
let COMMENTS_ERROR = "COMMENTS_ERROR"
let SENT_COMMENT_RESPONSE = "SENT_COMMENT_RESPONSE"

//Segues
let LIST_SEGUE = "ListSegue"
let SURVEY_SEGUE = "SurveySegue"
let COMMENT_SEGUE = "CommentSegue"

//UserDefaults
let USER = "User"

//UITableViewCells
let CELL_IDENTIFIER = "Cell"

//UserDefaults
let WAITING_DATE = "WAITING_DATE"
