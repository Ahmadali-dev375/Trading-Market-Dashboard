# Crypto Dashboard

A Flutter cryptocurrency market dashboard featuring CoinGecko API integration, interactive candlestick charts, historical OHLC data, 7-day sparklines, and multi-timeframe chart exploration.

---

## Demo & Financial Disclaimer

> [!IMPORTANT]
> **This application is a portfolio demonstration project.**
> - **Real Market Data**: Coin prices, 24h changes, 7-day sparkline histories, and historical OHLC data are fetched dynamically from the public CoinGecko API.
> - **Simulated Demo Values**: Any token quantities or portfolio figures shown in the UI are strictly simulated for interface presentation.
> - **No Financial Services**: This application does NOT execute real trades, manage real money, connect to brokerage services, provide real wallet storage, or offer financial and investment advice.

---
---

## 🎨 UI/UX Design — Figma

The UI concept and design reference for **Crypto Dashboard** is available in Figma and was used as inspiration for the Flutter implementation.

👉 [**Open Crypto Dashboard Figma Design**](https://www.figma.com/design/kCIjMbFkgZ7nVaK3559cKX/Stock-Trading-App---UI-Concept--Community-?node-id=1-129&p=f&t=V66IYeSyr9bb1N9G-0)

---

## Features

- **Cryptocurrency Market Overview**: Live snapshot of top cryptocurrencies by market capitalization.
- **CoinGecko REST API Integration**: Clean HTTP client implementation consuming free-tier CoinGecko endpoints.
- **Interactive Candlestick (OHLC) Charts**: High-performance candlestick rendering powered by Syncfusion Flutter Charts.
- **7-Day Sparkline Trends**: Compact inline price momentum visualization using `chart_sparkline`.
- **Multi-Timeframe Exploration**: Seamless switching across intervals (`1D`, `1W`, `1M`, `3M`, `6M`, `1Y`) for historical analysis.
- **Interactive Gestures**: Pinch-to-zoom, horizontal chart panning, and tap-activated trackball tooltips.
- **API Rate-Limit Handling**: Client-side throttling and intuitive UI fallback indicators for free-tier CoinGecko request quotas.
- **Dark-Themed Interface**: Ergonomic, modern dark palette designed for data readability.

---

## Charts & Data Visualization

- **Syncfusion Cartesian Charts (`SfCartesianChart`)**:
  - `CandleSeries` mapping historical open, high, low, and close (OHLC) data.
  - `DateTimeAxis` horizontal time scaling based on CoinGecko Unix epoch timestamps.
  - Interactive `TrackballBehavior` displaying exact price metrics on touch interaction.
  - `ZoomPanBehavior` for horizontal chart scaling and inspection.
- **Mini Sparklines (`chart_sparkline`)**:
  - Micro-visualizations displaying 7-day trailing price trajectories directly in list items.
  - Conditional gradient fills based on positive or negative 24-hour price momentum.

---

## Real vs. Simulated Data

To maintain technical and financial integrity, this project strictly distinguishes between genuine API responses and user-interface demonstration values:

| Data Element | Type | Source |
| :--- | :--- | :--- |
| Coin Names & Symbols | **Real** | CoinGecko API (`/coins/markets`) |
| Current Prices (USD) | **Real** | CoinGecko API (`/coins/markets`) |
| 24h Percentage Changes | **Real** | CoinGecko API (`/coins/markets`) |
| 7-Day Sparklines | **Real** | CoinGecko API (`/coins/markets?sparkline=true`) |
| OHLC Candlestick Points | **Real** | CoinGecko API (`/coins/{id}/ohlc`) |
| Displayed Token Quantities | **Simulated** | Demo UI placeholder values |
| User Balance / Top Up | **Simulated** | Static UI placeholder |

---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Channel stable, SDK `>=3.4.3 <4.0.0`)
- **Language**: [Dart](https://dart.dev/)
- **Networking**: `http` (`^1.2.2`)
- **Charting**:
  - `syncfusion_flutter_charts` (`^26.2.4`)
  - `chart_sparkline` (`^1.0.15+1`)
- **Navigation**: `global_bottom_navigation_bar` (`^0.0.8`)
- **Icons**: `cupertino_icons` (`^1.0.6`)

---

## Architecture

This project is structured as a focused, lightweight Flutter application emphasizing clarity and simplicity:
- **State Management**: Reactive state handled via Flutter's native `setState` within stateful components.
- **API Communication**: Centralized HTTP service layer (`CoinGeckoService`) abstracting JSON deserialization and rate limiting.
- **Model Serialization**: Strongly-typed data models (`CoinModel`, `SparklineIn7D`, `ChartModel`) with null-safe JSON factory constructors.
- **Component Modularization**: Reusable UI components (`Item`, `Bit`) separating list item rendering from screen containers.

---

## Project Structure

```text
lib/
├── Components/
│   ├── Item.dart               # Trending list item with sparkline
│   └── bit.dart                # Explore market list item
├── Model/
│   ├── chart.dart              # OHLC candlestick data model
│   └── coin.dart               # Coin market & sparkline model
├── auth/
│   └── login.dart              # Demo settings & account placeholder
├── screens/
│   ├── Top.dart                # Top Up placeholder screen
│   ├── bottombar.dart          # Bottom navigation bar shell
│   ├── coin_detail.dart        # Candlestick chart & timeframe screen
│   ├── home.dart               # Explore / Market overview screen
│   ├── profile.dart            # User profile placeholder screen
│   └── trend.dart              # Trending screen
├── services/
│   └── coingecko_service.dart  # Centralized CoinGecko API service
└── main.dart                   # Application entry point
```

---

## Installation & Setup

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and added to your `PATH`.
- Active Internet connection (required for fetching CoinGecko market data).
- Android Studio / VS Code with Flutter extensions.

### Running Locally
```bash
# 1. Clone the repository
git clone https://github.com/Ahmadali-dev375/Trading-Market-Dashboard.git
cd crypto_dashboard

# 2. Install dependencies
flutter pub get

# 3. Run the application
flutter run
```

---

## Internet Requirement

An active internet connection is mandatory to retrieve market quotes, sparklines, and candlestick data from the public CoinGecko API. If requests exceed CoinGecko's free-tier rate limits, the app presents a clean rate-limit notice with pull-to-refresh capabilities.

---

## Known Limitations

- **Rate Limits**: The public free CoinGecko API restricts calls per minute. Repeated rapid refreshes may return HTTP 429 until the cooldown expires.
- **No WebSocket Streaming**: Prices are requested on demand over HTTP REST; real-time push tick streaming is not implemented.
- **Placeholder Screens**: Top Up and Profile screens are illustrative demo placeholders.
- **No Order Execution**: The app does not connect to exchanges, order books, or brokerages.

---

## Disclaimer

This application is a Flutter portfolio demonstration. Cryptocurrency price and OHLC data is fetched from the public CoinGecko API. Any simulated quantities or demo values do not represent real holdings, real profits, or real market positions. This app does not execute trades, manage real money, connect to a brokerage, or provide financial or investment advice.

---

## Acknowledgements

- **Market Data**: [CoinGecko API](https://www.coingecko.com/en/api)
- **Charts**: [Syncfusion Flutter Charts](https://pub.dev/packages/syncfusion_flutter_charts) (*used under Syncfusion Community License / evaluation terms*)
- **Sparklines**: [chart_sparkline](https://pub.dev/packages/chart_sparkline)

---

## Author

**Ahmad Ali**
