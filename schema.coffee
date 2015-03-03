###
Some commonly used schemas 常用法类,
凡可用于本类应用的放在此处
###
@AppName = "HQ-Share Issues Reporting"
@AdminConfig =
  name: AppName
  adminEmails: []
  collections:
      Issues: {}

@Schemas = {}

Schemas.Issues = new SimpleSchema
  "緩急":
    type: String
    label: '年度'
  "月份":
    type: Number
    label: '月份'

@Issues = new Mongo.Collection "Issues"
###
例如:
###
###
Schemas.CommitInfo = new SimpleSchema
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
###
# 例如医院等单位信息中有些部分是重复出现的可以提炼出来,等等
# 只要是重复出现的都可以提炼出来
