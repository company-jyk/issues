if Meteor.isClient
  Template.registerHelper 'AppName', -> AppName
  Template.registerHelper 'Issues', -> Issues
  Template.registerHelper 'bulletin', -> Board
  Template.registerHelper 'Schemas', Schemas
  #Template.splash.helpers
  #  AppName: -> 'AppName'
