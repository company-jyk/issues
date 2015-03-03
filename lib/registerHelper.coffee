if Meteor.isClient
  Template.registerHelper 'AppName', -> AppName
  Template.registerHelper 'Issues', -> Issues
  Template.registerHelper 'Schemas', Schemas
  #Template.splash.helpers
  #  AppName: -> 'AppName'
