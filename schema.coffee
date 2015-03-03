@Issues = new Mongo.Collection "Issues"

Schemas.Issues = new SimpleSchema [
  "緩急":
    type: String
    allowedValues:['待定','急','中','緩']

  "狀態":
    type: String
    allowedValues: ['未解決','待測試','解決','解決不了']

  "一級目錄":
    type: String
    label: '一級目錄'
    max:20

  "二級目錄":
    type: String
    label: '二級目錄'
    max:40
    #optional: true

  "詳細位置":
    type: String
    label: '詳細位置'
    max:80
    #optional:true

  "問題描述":
    type: String
    label: '問題描述'
    min: 4
    max: 180


  "備註":
    type: String
    label: '備註'
    max:100

  "提交日期":
    type: Date
    label: '提交日期'
    autoValue: ->
      if this.isInsert
        return new Date()

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


]


Issues.attachSchema Schemas.Issues


AdminConfig.collections.Issues = {
  label: 'Issues'
  #icon: 'pencil'

  tableColumns: [
    {label: '緩急',name:'緩急'}
    {label:'狀態',name:'狀態'}
    {label: '一級目錄', name:'一級目錄'}
    {label: '二級目錄', name:'二級目錄'}
    {label: '詳細位置', name:'詳細位置'} #模仿 提交者但不行?
    {label: '問題描述',name:'問題描述'}
    {label: '備註',name:'備註'}
    {label: '提交日期',name:'提交日期'}
    {label:'提交者',name:'提交者', collection: 'Users'}
  ]
  ###

  templates:
    new:
      name: 'postWYSIGEditor'
      data:
        post: Session.get 'admin_doc'
    edit:
      name: 'postWYSIGEditor'
      data:
        post: Session.get 'admin_doc'
  ###
}


if Meteor.isClient
  Meteor.subscribe "issuesChannel"
  Template.home.helpers
    fields:['狀態','一級目錄','二級目錄','詳細位置','問題描述','備註','提交日期']

if Meteor.isServer
  Meteor.publish "issuesChannel" , ()->
    Issues.find()
