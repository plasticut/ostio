mediator = require 'mediator'
utils = require 'chaplin/lib/utils'

# Application-specific view helpers
# ---------------------------------

# http://handlebarsjs.com/#helpers

# Conditional evaluation
# ----------------------

# Choose block by user login status
Handlebars.registerHelper 'if_logged_in', (options) ->
  if mediator.user
    options.fn(this)
  else
    options.inverse(this)

# Map helpers
# -----------

# Make 'with' behave a little more mustachey
Handlebars.registerHelper 'with', (context, options) ->
  if not context or Handlebars.Utils.isEmpty context
    options.inverse(this)
  else
    options.fn(context)

# Inverse for 'with'
Handlebars.registerHelper 'without', (context, options) ->
  inverse = options.inverse
  options.inverse = options.fn
  options.fn = inverse
  Handlebars.helpers.with.call(this, context, options)

# Evaluate block with context being current user
Handlebars.registerHelper 'with_user', (options) ->
  context = mediator.user.getAttributes()
  Handlebars.helpers.with.call(this, context, options)

Handlebars.registerHelper 'gravatar', (options) ->
  "https://secure.gravatar.com/avatar/#{options.fn this}?s=140&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png" 

Handlebars.registerHelper 'date', (options) ->
  date = new Date options.fn this
  new Handlebars.SafeString moment(date).fromNow()

Handlebars.registerHelper 'markdown', (options) ->
  new Handlebars.SafeString marked options.fn this
