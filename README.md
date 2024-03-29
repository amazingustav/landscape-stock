# Landscape Stock
This is a Ruby on Rails application that fetches stock data from the Polygon API and exposes it to clients through a RESTful API. It provides stock data for a given ticker symbol and date range.

## Libraries Used
Ruby 3.3
Rails 7
HTTParty (HTTP client)
RSpec (Testing library)

### Features
- Validate input parameters, ensuring correct date formats and logical date ranges.
- Handle errors gracefully and provide meaningful error messages.

## Prerequisites
The application is containerized using Docker. That's the only thing you need.

## How to Run
To execute the application using Docker Compose, following these steps:

- Open a terminal window 
- Navigate to the project directory where the `docker-compose.yml` file is located

Build the Docker containers and execute it by running the following command:

```shell
$ docker-compose build --no-cache
$ docker-compose up web
```
Access the application by opening a web browser and navigating to http://localhost:3000.

To run the tests only, use (after the `build` command):
```shell
$ docker-compose run test
```

## Architecture
This application follows the Clean Architecture principles, which separates the application into different layers:

- **Controllers**: Handle HTTP requests and responses. In this case, the `StocksController` handles stock data requests.
- **Services**: Contain the business logic. The `StockService` is responsible for interacting with external APIs and handling data processing.
- **DTOs (Data Transfer Objects)**: Used for mapping and representing data. `GetStockDto` and `GetStockRequest` are used to structure and transfer data between layers.
- **Validators**: Validate input parameters and enforce business rules. The `StockRequest` class ensures that date formats and date ranges are correct.
- **Third Party**: Contains third-party libraries and APIs. The `PolygonClientService` class is responsible for fetching stock data from the Polygon API.

## Example Request and Response
### Request
- **Endpoint**: `GET /api/v1/stocks`
- **Parameters**:
  - **ticker**: The stock ticker symbol (e.g., AAPL)
  - **start_date**: The start date in YYYY-MM-DD format (e.g., 2023-01-01)
  - **end_date**: The end date in YYYY-MM-DD format (e.g., 2023-12-31)

Example:

```shell
curl -X GET "http://localhost:3000/api/v1/stocks?ticker=AAPL&start_date=2023-01-01&end_date=2023-12-31"
```
### Response
Example Response (Success):

```json
{
  "max_price": 199.62,
  "min_price": 124.17,
  "average_price": 172.55,
  "max_volume": 154338835.0,
  "min_volume": 24018404.0
}
```

Example Response (Error):

```json
// Response status: 400
{
  "error": "Start date must be before end date"
}

// Response status: 404
{
  "error": "No stock data found for ticker TEST"
}
```
