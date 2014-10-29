currencies = [
  {value: "EUR", description: "Euros"},
  {value: "$US", description: "$ US Dollars"},
  {value: "GBP", description: "£ Pound Sterling"}
]

selectedCurrency = currencies[0]

Template.budgetNew.created = () ->
  NavigationVent.subscribeToPrevious(_.bind(Template.budgetNew.cancel, this))
  NavigationVent.subscribeToNext(_.bind(Template.budgetNew.submit, this))

Template.budgetNew.helpers
  inputAttributes: ->
    {
      placeholder: "Amount you plan to spend"
      type: "number"
      name: "amount"
      id: "amount"
    }

  currencies: ->
    currencies

  selectedCurrency: ->
    selectedCurrency

Template.budgetNew.submit = ->
  amount = parseInt($('[name="amount"]').val())
  currency = $('[name="dropdown_selected"]').text()
  Trips.update { _id: getRouterParams()._id },
    $set:
      budgetAmount: amount,
      budgetCurrency: currency
  Router.go 'trips.show', { _id: getRouterParams()._id }

Template.budgetNew.cancel = ->
  Router.go 'users.new', { _id: getRouterParams()._id }

Template.budgetNew.events
  'submit': (e) ->
    e.preventDefault()
    Template.budgetNew.submit()
