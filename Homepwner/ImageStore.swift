//
//  ImageStore.swift
//  Homepwner
//
//  Created by Sean Melnick Kelly on 3/29/17.
//  Copyright © 2017 Sean Melnick Kelly. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    
    let cache = NSCache<NSString, UIImage>()
    // let cache = NSCache()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        // Create full URL for image - pg. 296
        let url = imageURL(forKey: key)
        
        if let data = UIImagePNGRepresentation(image) { // pg. 300
            // Changed from JPEG to PNG for Chap. 16 bronze challenge
            
            // Write it to full URL
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) { // pg. 296
            return existingImage
        }
        
        let url = imageURL(forKey: key) // pg. 296
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString) // pg. 296
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url) // pg. 299
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURL(forKey key: String) -> URL { // pg. 295
        
        // Creates URL for the image in the documents directory
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
}
