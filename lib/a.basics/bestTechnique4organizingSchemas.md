Probably the best technique for organizing your form schemas and making them available as helpers is to add all SimpleSchema instances to a Schemas object and register that object as a helper:

common.js:

Schemas = {};

Schemas.ContactForm = new SimpleSchema({
  name: {
    type: String,
    label: "Your name",
    max: 50
  },
  email: {
    type: String,
    regEx: SimpleSchema.RegEx.Email,
    label: "E-mail address"
  },
  message: {
    type: String,
    label: "Message",
    max: 1000
  }
});

//... define all schemas

client.js:

UI.registerHelper("Schemas", Schemas);


html:

<template name="contactForm">
  {{#autoForm schema=Schemas.ContactForm id="contactForm" type="method" meteormethod="sendEmail"}}
  <!-- etc. -->
  {{/autoForm}}
</template>