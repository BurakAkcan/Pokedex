# Pokedex App

<img width="856" alt="app_screenshot" src="https://user-images.githubusercontent.com/22526834/168495035-a6a5feb2-7a47-45de-9ece-53ba57fd7748.png">

An iOS application that shows pokemons and some information about them.  

## Requirements
- iOS 13.0+

## How to run
Pod files are already included in the repository, therefore the application can be run without pod installation.  

Open **Pokedex.xcworkspace** *(not Pokedex.xcodeproj)* with Xcode and run the application.

## API
Pokemon information is fetched from [PokeAPI](https://pokeapi.co/docs/v2).  
PokeAPI is publicly available, doesn't require authentication, and has no rate limit.  

*Application only fetches the first batch of pokemons for demonstration purposes.*  

## Pods
Application uses the following pods:  
- SnapKit
- SDWebImage
- SVProgressHUD
