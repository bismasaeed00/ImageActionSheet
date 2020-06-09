# ImageActionSheet
iOS Native style action sheet with the option of showing icons

![alt text](https://user-images.githubusercontent.com/16186934/83187499-87f88480-a12e-11ea-8a12-19e08cebb4dc.png)

## How to use it
Copy classes folder in your project and you can use it like that in your UIViewController:

            let actionSheet = ImageActionSheet(title: "Upload a file", message: "Please choose a file.")
            actionSheet.add(action: AlertAction(title: "Camera", icon: UIImage(named: "camera"), action: {
                print("Camera clicked")
            }))
            actionSheet.add(action: AlertAction(title: "Gallery", icon: UIImage(named: "gallery"), action: {
                print("Gallery clicked")
            }))
            
            actionSheet.add(action: AlertAction(title: "Document", icon: UIImage(named: "file"), action: {
                print("Document clicked")
            }))
            
            actionSheet.show(in: self)
