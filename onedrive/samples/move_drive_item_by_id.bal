// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
import ballerinax/microsoft.onedrive;

configurable string & readonly refreshUrl = ?;
configurable string & readonly refreshToken = ?;
configurable string & readonly clientId = ?;
configurable string & readonly clientSecret = ?;

public function main() returns error? {
    onedrive:Configuration configuration = {
        clientConfig: {
            refreshUrl: refreshUrl,
            refreshToken : refreshToken,
            clientId : clientId,
            clientSecret : clientSecret
        }
    };
    onedrive:Client driveClient = check new(configuration);

    log:printInfo("Move drive item by item ID");

    string itemId = "<ITEM_ID>";
    string parentFolderId = "root";
    onedrive:DriveItem replacement = {
        name: "Moved_to_Canva",
        parentReference : {
            id: parentFolderId
        }
    };
    onedrive:DriveItemData|onedrive:Error driveItem = driveClient->updateDriveItemById(itemId, replacement);
    if (driveItem is onedrive:DriveItemData) {
        log:printInfo("Item moved " + driveItem.toString());
        log:printInfo("Success!");
    } else {
        log:printError(driveItem.message());
    }
}
