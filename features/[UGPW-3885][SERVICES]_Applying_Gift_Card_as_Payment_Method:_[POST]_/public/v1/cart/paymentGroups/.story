[UGPW-3885][SERVICES] Applying Gift Card as Payment Method: [POST] /public/v1/cart/paymentGroups/
Meta:
@feature AddGiftCard, GiftCard
@acceptance UGPW-3885
@history UGPW-5249
@countryMeta US CA MX INTL
@auth
@guest
Scenario: Verify order total and payment amount recalculated after gift card is applied.
Meta:
@c1
Given aeSite header set as <aeSite>
And user type <userType>
When I add 'commerce' item 'without promotion' with quantity 1
Then there are no errors and status is success
When I add shipping address to cart: commerce/data/common/shippingAddress/<shippingAddress>
Then there are no errors and status is success
When I add gift card 'Gift_Card_25_USD_03'
Then there are no errors and status is success
When I view cart
Then payment response contains correct recalculated payment amount
When I add 'commerce' item 'without promotion' with quantity 1
When I view cart
Then payment response contains correct recalculated payment amount
Examples:
|Meta:                   |aeSite  |userType  |shippingAddress    |
|@countryMeta US   @auth |AEO_US  |registered|UsaAddress.table   |
|@countryMeta CA   @auth |AEO_CA  |registered|CanadaAddress.table|
|@countryMeta MX   @auth |AEO_MX  |registered|MexicoAddress.table|
|@countryMeta INTL @auth |AEO_INTL|registered|IndiaAddress.table |
|@countryMeta US   @guest|AEO_US  |guest     |UsaAddress.table   |
|@countryMeta CA   @guest|AEO_CA  |guest     |CanadaAddress.table|
|@countryMeta MX   @guest|AEO_MX  |guest     |MexicoAddress.table|
|@countryMeta INTL @guest|AEO_INTL|guest     |IndiaAddress.table |
Scenario: Gift card can be applied for the order with credit card.
Meta:
@c1
Given aeSite header set as <aeSite>
And user type <userType>
When I add 'commerce' item 'in-stock' with quantity 1
Then there are no errors and status is success
When I add shipping address to cart: commerce/data/common/shippingAddress/<shippingAddress>
Then there are no errors and status is success
When I remember billing address details: commerce/data/common/billingAddress/<billingAddress>
Then there are no errors and status is success
When I add 'active' 'visa' credit card with remembered billing address
Then there are no errors and status is success
When I add gift card with balance <balance>
Then there are no errors and status is success
When I view cart
Then payment response contains correct recalculated payment amount
Examples:
|Meta:                   |aeSite  |userType  |shippingAddress    |billingAddress |balance|
|@countryMeta US   @auth |AEO_US  |registered|UsaAddress.table   |valid_US.table |25     |
|@countryMeta CA   @auth |AEO_CA  |registered|CanadaAddress.table|valid_CA.table |50     |
|@countryMeta MX   @auth |AEO_MX  |registered|MexicoAddress.table|valid_MS.table |25     |
|@countryMeta INTL @auth |AEO_INTL|registered|IndiaAddress.table |valid_ROW.table|50     |
|@countryMeta US   @guest|AEO_US  |guest     |UsaAddress.table   |valid_US.table |25     |
|@countryMeta CA   @guest|AEO_CA  |guest     |CanadaAddress.table|valid_CA.table |50     |
|@countryMeta MX   @guest|AEO_MX  |guest     |MexicoAddress.table|valid_MS.table |25     |
|@countryMeta INTL @guest|AEO_INTL|guest     |IndiaAddress.table |valid_ROW.table|50     |
Scenario: If the gift card covers the orderTotal, than no any other payment methods can't be applied.
Meta:
@c2
Given aeSite header set as <aeSite>
And user type <userType>
When I add 'commerce' item 'without promotion' with quantity 1
Then there are no errors and status is success
When I add shipping address to cart: commerce/data/common/shippingAddress/<shippingAddress>
Then there are no errors and status is success
When I remember billing address details: commerce/data/common/billingAddress/valid_ROW.table
Then there are no errors and status is success
When I add gift card with balance 75
Then there are no errors and status is success
When I add 'active' 'visa' credit card with remembered billing address
Then there are the following errors in response:
|fields   |key                                                    |
|[payment]|error.checkout.payment.orderTotal.isSufficientlyCovered|
Examples:
|Meta:                   |aeSite  |userType  |shippingAddress    |
|@countryMeta US   @auth |AEO_US  |registered|UsaAddress.table   |
|@countryMeta CA   @auth |AEO_CA  |registered|CanadaAddress.table|
|@countryMeta MX   @auth |AEO_MX  |registered|MexicoAddress.table|
|@countryMeta INTL @auth |AEO_INTL|registered|IndiaAddress.table |
|@countryMeta US   @guest|AEO_US  |guest     |UsaAddress.table   |
|@countryMeta CA   @guest|AEO_CA  |guest     |CanadaAddress.table|
|@countryMeta MX   @guest|AEO_MX  |guest     |MexicoAddress.table|
|@countryMeta INTL @guest|AEO_INTL|guest     |IndiaAddress.table |
Scenario: Customer is allowed to apply upto 3 Gift card towards their order.
Meta:
@c2
@acceptance UGPW-4858
Given aeSite header set as <aeSite>
And user type <userType>
When I add 'commerce' item 'without promotion' with quantity 9
Then there are no errors and status is success
When I add shipping address to cart: commerce/data/common/shippingAddress/<shippingAddress>
Then there are no errors and status is success
When I add gift card 'Gift_Card_75_USD_01'
Then there are no errors and status is success
When I add gift card 'Gift_Card_25_USD_02'
Then there are no errors and status is success
When I add gift card 'Gift_Card_25_USD_03'
Then there are no errors and status is success
When I add gift card 'Gift_Card_25_USD_01'
Then there are the following errors in response:
|fields    |key                                     |
|[giftCard]|error.checkout.payment.giftCard.exceeded|
Examples:
|Meta:                   |aeSite  |userType  |shippingAddress    |
|@countryMeta US   @auth |AEO_US  |registered|UsaAddress.table   |
|@countryMeta CA   @auth |AEO_CA  |registered|CanadaAddress.table|
|@countryMeta MX   @auth |AEO_MX  |registered|MexicoAddress.table|
|@countryMeta INTL @auth |AEO_INTL|registered|IndiaAddress.table |
|@countryMeta US   @guest|AEO_US  |guest     |UsaAddress.table   |
|@countryMeta CA   @guest|AEO_CA  |guest     |CanadaAddress.table|
|@countryMeta MX   @guest|AEO_MX  |guest     |MexicoAddress.table|
|@countryMeta INTL @guest|AEO_INTL|guest     |IndiaAddress.table |