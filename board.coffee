@Board = new Mongo.Collection 'Board'
Board.allow
  insert: (userId)->
    userId?

Schemas.Board = new SimpleSchema [


    "主題":
      type: String
      label: '主題'
      max:80
      optional:true

    "內容":
      type: String
      label: '內容'
      min: 2
      max: 580

    "提交者":
      type: String
      regEx: SimpleSchema.RegEx.Id
      autoValue: ->
        if this.isInsert
          return Meteor.userId()
      autoform:
        options: ->
          _.map Meteor.users.find().fetch(), (user)->
            label: user.emails[0].address
            value: user._id

    "提交日期":
      type: Date
      label: '提交日期'
      autoValue: ->
        if this.isInsert
          return new Date()



  ]

Board.attachSchema Schemas.Board

AdminConfig.collections.Board =
  label: 'Board'
  #icon: 'pencil'
  tableColumns: [
    {label: '主題',name:'主題'}
    {label:'內容',name:'內容'}
    {label: '提交日期',name:'提交日期'}
    {label:'提交者',name:'提交者', collection: 'Users'}
  ]

if Meteor.isClient
  Meteor.subscribe "BoardChannel"

  Template.board.helpers
    fields: ['主題','內容']

if Meteor.isServer
  Meteor.publish "BoardChannel" , ()->
    Board.find()
