# SegmentFault_Gembo

An application to bring all the tourists of sri lanka into one community.

## Flutter Application Setup

The user application is built using Flutter and intergrates with Firebase.

### Prerequisites:
- **Flutter SDK**: [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Android Studio/Xcode**: For running the application.
- **Stripe API Keys**: Obtain from [Stripe Dashboard](https://dashboard.stripe.com/).

### Steps to Run:
1. Clone the project:
    ```bash
    git clone <repository-url>
    cd <project-folder>
    ```
2. Navigate to the `user_application` directory
    ```bash
    cd user_application
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Set up environment variables: Create a .env file in the root directory with the following:
    ```bash
    STRIPE_SECRET_KEY="your-stripe-secret-key"
    STRIPE_PUBLISHABLE_KEY="your-stripe-publishable-key"
    ```
5. Run the app:
    ```bash
    flutter run
    ```

## Admin Panel (Next.js)

The admin panel is built using Next.js and integrates with Firebase, Tailwind CSS and Shadcn.

### Steps to Run:
1. Navigate to the `admin-panel` directory:
    ```bash
    cd admin-panel
    ```
2. Install dependencies:
    ```bash
    npm install
    ```
3. SRun the development server:
    ```bash
    npm run dev
    ```
4. Open the admin panel: Navigate to http://localhost:3000 in your browser.