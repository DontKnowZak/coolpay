# Coolpay App

This app allows you to:
- Authenticate to Coolpay API

  `Coolpay.login({username: "your_user", api_key: "your_api_key"})`
- Add recipients

  `Coolpay.add_recipient('recipient_name')`
- Send them money

  `Coolpay.make_payment(amount, "recipient_id", currency)`

  Currency defaults to GBP.
- Check whether a payment was successful

  `Coolpay.payment_status("payment_id")`

  Can only check payments made with the authenticated user.


Notes:

This app is a demonstration of integrating an API into a system. I set out with the 4 features above in mind and the app can accomplish all of them.

The app is proof of concept and due to time constraints some areas aren't fully fleshed out, I would be happy to discuss the progress and plans for the project; the next steps are likely as follows:

- More thorough testing for edge cases, missing or incorrect arguments etc.

- Error handling for issues arising from both errors on input from the user and errors from the API.

  Some checks needed are type and existence checks for arguments.

  Incorrect value arguments would be picked up by the API (or processed with the mistake but this would be the fault of the user and not the code base i.e. they make a payment of 50 GBP instead of 5 GBP)

  API error handling would involve checking the response and returning a relevant error if applicable.

  This would likely take the form a class that handles all requests and rescues on an error. It would then handle the error based on the response/error.

- Basic objects created to handle method returns i.e. creating a Payment class to handle the payment that is returned rather than just returning a PORO to user etc. However considering the scenario laid out the returns of the methods would provide the user with the means to integrate.

- Handling of timeouts when contacting the 3rd party API.
