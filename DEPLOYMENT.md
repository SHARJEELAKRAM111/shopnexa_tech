# Deployment Guide: ShopNexa Technologies on Vercel

This guide provides instructions to build and deploy the **ShopNexa Technologies** website to Vercel.

## Prerequisites

Make sure you have installed:
1. [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.41.6 or newer recommended)
2. [Vercel CLI](https://vercel.com/cli) (optional, if you want to deploy from the command line)

---

## Step 1: Build the Flutter Web App Locally

Before deploying, you must compile the Flutter project to web production-ready static assets:

```bash
# Fetch dependencies
flutter pub get

# Build in release mode using CanvasKit renderer for web efficiency
flutter build web --release
```

This generates compiled files inside the `build/web/` directory.

---

## Step 2: Deploy to Vercel

You can choose one of the following deployment paths:

### Option A: Using Vercel CLI (Recommended & Fastest)

1. Open your terminal in the project root directory.
2. Run the deployment command pointing directly to the compiled web assets:
   ```bash
   vercel deploy build/web --prod
   ```
3. Follow the Vercel prompt setup instructions:
   - **Set up and deploy?** Yes
   - **Which scope?** (Select your workspace)
   - **Link to existing project?** No
   - **What is your project's name?** `shopnexa-technologies`
   - **In which directory is your code located?** `./`

---

### Option B: Deploying via GitHub Git Integration

If you want automated CI/CD deployments (re-building whenever you push to a git branch):

1. Push your project code to a GitHub, GitLab, or Bitbucket repository.
2. Go to the [Vercel Dashboard](https://vercel.com/) and click **Add New** > **Project**.
3. Import your repository.
4. Configure the **Build & Development Settings**:
   - **Build Command**: `flutter/bin/flutter build web --release` or override and leave empty if building locally and committing `build/web`.
   - **Output Directory**: `build/web`
5. Click **Deploy**.

---

## Step 3: Verify Router Redirects

The project includes a `vercel.json` file in the root. This is automatically applied when importing the project folder or using the Vercel CLI. It ensures that sub-navigation and page reloads are handled correctly by redirecting routes back to `index.html`.
