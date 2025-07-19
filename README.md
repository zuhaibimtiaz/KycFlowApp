# KycFlowApp

A modular and scalable SwiftUI application designed for a KYC (Know Your Customer) flow. The project demonstrates the implementation of **MVVM Clean Architecture**, with a clear separation of concerns across `Presentation`, `Domain`, and `Data` layers.

## 🌟 Features

- 🧭 Dynamic KYC form with configurable fields per country
- 🧱 Modular and testable **MVVM Clean Architecture**
- 🔄 Async state handling with loading and error states
- 📑 Reusable form components and validation
- 📡 Repository and UseCase-driven business logic
- 🧪 Comprehensive Unit Tests
- 🌐 SwiftUI navigation handled via Router
- 🌍 Country-specific behavior for NL with read-only fields fetched from a mocked API
- ✅ Form validation with inline error messages

---

## 🏗️ Architecture Overview

### Clean Architecture Layers:

#### 📁 Data
- Remote data source abstraction (simulated/mock for this demo)
- Data mappers to convert API models to domain models

#### 📁 Domain
- UseCases to encapsulate business logic
- Models that are platform-agnostic

#### 📁 Presentation
- SwiftUI Views and ViewModels (using Observable)
- Validations
- UI-level state management

#### 📁 Helpers
- Validator (uses Validator ProperWrapper) for input validation
- Localized strings and constants

#### 📁 ReusableViews
- ButtonView (primary, secondary buttons)

#### 📁 Router
- SwiftUI-based navigation coordinator for decoupled screen transitions

---

## 🧪 Testing

- Unit tests are implemented for core ViewModels
- Tests cover form validation, async state updates, and country-specific logic
- Mocked API responses are tested for NL-specific behavior

---
## 🚀 Getting Started

1. Clone the repo:
    ```bash
    git clone https://github.com/zuhaibimtiaz/KycFlowApp.git
    ```
2. Open `KycFlowApp.xcodeproj` in Xcode (15+)
3. Run on iOS 17+ simulator or device
4. To run tests, press `⌘U` or run the `KycFlowAppTests` target

---

## 🔧 Configuration

- Mocked configuration and profile data are dynamically loaded based on country
- You can easily extend support for new countries by updating the configuration JSON

---

## ✅ Assessment Highlights

This repo demonstrates:

- ✅ **Clean and testable architecture** using **MVVM** with **UseCases** and **Repositories**
- ⚙️ **Dynamic UI generation** based on **server-provided configuration**
- 🧪 **Test-driven development** practices with comprehensive **unit tests**
- ⚠️ **Form validation** with inline error messages for fields like **BSN**
- 📤 **Form submission** outputs collected data on **summary screen**
- 📚 **Code readability** with clear separation of concerns and consistent naming
- 🧭 **Decoupled navigation** using a **SwiftUI-compatible router**

---

## Handling NL-Specific Behavior Architecturally

The requirement for NL-specific behavior (fetching `first_name` and `last_name` from a mocked API and displaying them as read-only) is implemented using a **robust architectural approach**:

### 🗂 Data Layer

- **`FetchKycConfigRepository`** loads country-specific JSON configs (e.g., `kyc_config_nl.json`) using `Bundle.main.url` and decodes them into `KycCountryConfigDto`.
- **`FetchProfileRepository`** simulates the `/api/nl-user-profile` endpoint, returning a `ProfileDto` with hardcoded fields like `first_name: "Zuhaib"` and `last_name: "Imtiaz"`, including a simulated network delay.
- **Mappers** (`KycConfigModelMapper`, `ProfileModelMapper`) transform DTOs into domain models.
    - `KycConfigModelMapper` sets the `source` property to `.remote` for NL based on the config.

### 🧠 Domain Layer

- **`FetchKycConfigUseCase`** retrieves the config for the selected country, encapsulating data access logic.
- **`FetchProfileUseCase`** fetches the NL user profile when the config’s `source` is `.remote`, ensuring platform-agnostic business logic.
- The **`KycConfigModel`** includes a `source` property (`.remote` or `.manual`) to indicate whether fields are populated via API or user input.

### 🎯 Presentation Layer

- **`CountrySelectionViewModel`** (using `@Observable`) coordinates the form loading process.
    - Calls `FetchKycConfigUseCase` to load config.
    - If `source == .remote`, invokes `FetchProfileUseCase` to fetch profile data.
- The `mergeRemoteProfile(into:)` method merges fetched profile values into the config and marks fields like `first_name` and `last_name` as `readOnly`.
- The **FormView** uses reusable views (e.g., `TextFieldView`) which respect the `readOnly` flag and render non-editable UI accordingly.
- Async states (`loading`, `success`, `error`) are managed reactively via a `state` property.

---

## Proposed Changes to the Config Format

To improve support for data source behavior (like the NL-specific API fetch) and future extensibility:

### 🧾 Dedicated `source/dataSource` Object

add the simple `source/dataSource` with a structured object at the root of the kyc_config_`country_code`):

**Example:**

```json
{
  "dataSource": {
    "type": "remote",
    "endpoint": "/api/nl-user-profile"
  }
}
```
---
## 📩 Contact

Author: **Zuhaib Imtiaz**  
GitHub: [@zuhaibimtiaz](https://github.com/zuhaibimtiaz)  
Email: *[zuhaib.imtiaz](zuhaib.imtiaz.ios@gmail.com)*

---
