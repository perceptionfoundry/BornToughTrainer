//
//  chatViewController.swift
//  srchat
//
//  Created by Syed Shahrukh Haider on 12/07/2017.
//  Copyright © 2017 Syed Shahrukh Haider. All rights reserved.
//

import UIKit

// Library that handle MEDIA TYPE
import MobileCoreServices
//Library that handle AV stuff
import AVKit
// Library that handle JSQ-VC
import JSQMessagesViewController

// FIREBASE LIBRARY
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class chatViewController: JSQMessagesViewController {

    
    // Segue Variable
    
    var channelName = "Coach chat"
    var receiverID = "CMLS guy"
    var DP : UIImage!
    
    
    // VARIABLE THAT HOLD MESSAGE IN ARRAY FORMAT
    var messages = [JSQMessage]()
    
    // FIREBASE VARIABLE
    
    var FBref : DatabaseReference?
    var FBHandle : DatabaseHandle?
    
    var msgRef = Database.database().reference().child("Messages")
    var userRef = Database.database().reference().child("users")
    
    var currentUserId = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputToolbar.contentView.leftBarButtonItem.isHidden = true
        inputToolbar.contentView.leftBarButtonItemWidth = 0.0

        print (channelName + " " + receiverID)

// INITIALIZE VARIABLE REQUIRED BY THIS VC
        
        senderId = currentUserId
        senderDisplayName = ""
        
        
        // Retrieve User detatil
        
        print(senderId)
     FBHandle = userRef.observe(.childAdded, with: { (userSnap) in
      
        print(userSnap.key)
        let id = userSnap.key
        
        
        
        if self.senderId == id {
            
        if let detail = userSnap.value as? [String:Any]{
        
            
            let DName = detail["Name"] as! String
            self.senderDisplayName = DName
        }
            print(self.senderDisplayName)

        print("**********")
        }
     })

//        senderDisplayName = "ShahRukh"

        
        // RETRIEVE MESSAGE FROM DB
         obserMessage()
        
        
    }

    
    @IBAction func backButton(_ sender: Any) {
        
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "menu") as! menuVC
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    // LOGOUT FUCNTION
    
    
    @IBAction func logoutButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        do {
           try Auth.auth().signOut()

        }catch{print("")}
//        print (Auth.auth().currentUser)

    }
    
    
  
    // FUNCTION USE TO RETREIVE  INCOMING MESSAGE FROM FIREBASE SERVER
    
    func obserMessage(){
        
       FBHandle = msgRef.child(channelName).observe(.childAdded, with: { (snapshot) in
        
        if let value = snapshot.value as? [String : Any]{

            let text = value["text"] as? String
            let senderid = value["senderID"] as? String
            let senderName = value["senderDisplay"] as? String
            let mediatype = value["mediaType"] as! String
            let alert = value["alert"] as! String
            
            switch mediatype{
            
                case "TEXT":
                    self.messages.append(JSQMessage.init(senderId: senderid, displayName: senderName, text: text))

                case "PHOTO":
                    let fileUrl = value["fileURL"] as! String
                    let url = URL(string: fileUrl)
                    let data = NSData(contentsOf: url!)
                    let picture = UIImage(data: data! as Data)
                    let photo = JSQPhotoMediaItem(image: picture)
                    
                    
                    self.messages.append(JSQMessage(senderId: senderid, displayName: senderName, media: photo))
                 
                    // identify incoming OR outgoing photo
                    if self.senderId == senderid {
                        photo?.appliesMediaViewMaskAsOutgoing = true

                    }
                    else{
                photo?.appliesMediaViewMaskAsOutgoing = false
                }
                
                

                case "VIDEO":
                    let fileUrl = value["fileURL"] as! String
                    let url = URL(string: fileUrl)
                    let fetchvdo = JSQVideoMediaItem(fileURL: url, isReadyToPlay: true)
                    self.messages.append(JSQMessage(senderId: senderid, displayName: senderName, media: fetchvdo))
                
                    // identify incoming OR outgoing Video
                    if self.senderId == senderid {
                        fetchvdo?.appliesMediaViewMaskAsOutgoing = true
                        
                    }
                    else{
                        fetchvdo?.appliesMediaViewMaskAsOutgoing = false
                }
                
            
            default:
                print("UNKNOWN")
            }
            
            
            print(alert)
            
            if alert == "TRUE" && senderid != (Auth.auth().currentUser?.uid)!{
                let autoID = snapshot.key
                let newMessage = self.msgRef.child(self.channelName).child(autoID).child("alert")
                
                newMessage.setValue("FALSE")

            }

            self.collectionView.reloadData()

        }
       })
    
    }
    
    
                    /*
     
                        ------------- FUNCTIONS WHICH PLAYS VITAL ROLE IN RUNNING CHAT VIEW -------------
     
                    */
    
   
    
    
    // NUMBER OF COLLECTIONVIEW (LIKE TABLEVIEW )
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    // CELL FOR ITEM  INDEXPATH (LIKE TABLEVIEW)
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                // CREATE CELL VARIABLE AND LINKING PROTOTYPE VIEWCELL
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
//        print("number of cell :\(messages.count)" )
        return cell
    }
    
    
                        // ************************* UI *************************
    
    
    //  CREATING "messageData" ITEM
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    
    // CREATING messageBubble Image (CUSTOMIZABLE)
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()

        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
        
        return bubbleFactory?.outgoingMessagesBubbleImage(with:.blue)
        }
        else{
        return bubbleFactory?.incomingMessagesBubbleImage(with: .green)
        }
    }
    
    
    // CREATING Avatar Method
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId{
//        return JSQMessagesAvatarImageFactory.avatarImage(with: self.DP, diameter: 30)
            return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "btt-logo"), diameter: 30)

        }
        return JSQMessagesAvatarImageFactory.avatarImage(with: self.DP, diameter: 30)

//        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "btt-logo"), diameter: 30)
    }



    
    
     // ---------------------------------------------------------------------------------------
    
    
            /*
     
                    --------------------- ACTION ON PRESS "SEND" BUTTON ---------------------
     
            */
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        // SAVE MESSAGE ON FIREBASE
        let newMessage = msgRef.child(channelName).childByAutoId()
        let messageData = ["text": text, "senderID": senderId, "senderDisplay": senderDisplayName, "mediaType": "TEXT","alert": "TRUE"]
        
        newMessage.setValue(messageData)
        
        // ALERT = TRUE
//        msgRef.child(channelName).child("Alert").setValue("TRUE")
//
//       collectionView.reloadData()
//
        finishSendingMessage()
        
    

    }
    
    
 
}

