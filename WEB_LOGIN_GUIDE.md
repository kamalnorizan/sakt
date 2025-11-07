# Web Login Implementation

## Overview
The web login feature allows users to authenticate through a web interface and automatically captures the authentication token.

## How It Works

1. User clicks "Log Masuk 1 ID" button
2. Opens a WebView with the login URL
3. User logs in through the web interface
4. After successful login, the server redirects to a callback URL
5. The app intercepts the URL and extracts the token
6. Token is saved to SharedPreferences as 'auth_token'
7. User is redirected to the home screen

## Configuration

### In login.dart
```dart
WebLogin(
  loginUrl: 'https://sak.treasury.gov.my/login',
  redirectUrlPattern: '/callback',
)
```

### Token Extraction Methods

The WebLogin widget supports three methods to extract the token:

#### Method 1: Query Parameters (Recommended)
Server redirects to: `myapp://callback?token=abc123`
```dart
// Automatically extracted from URI query parameters
```

#### Method 2: Hash Fragment
Server redirects to: `myapp://callback#token=abc123`
```dart
// Automatically extracted from URI fragment
```

#### Method 3: Path Segments
Server redirects to: `myapp://callback/abc123`
```dart
// Automatically extracted from the last path segment
```

## Server-Side Requirements

Your web login server should:

1. Accept the login credentials
2. Authenticate the user
3. Generate an authentication token
4. Redirect to the callback URL with the token

### Example Redirect URLs:
```
https://yourapp.com/callback?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
https://yourapp.com/callback?access_token=abc123def456
myapp://callback#token=abc123
```

## Customization

### Change Login URL
```dart
WebLogin(
  loginUrl: 'https://your-domain.com/auth/login',
  redirectUrlPattern: '/auth/callback',
)
```

### Change Token Parameter Name
Edit `web_login.dart` line 51-53 to match your server's parameter name:
```dart
String? token = uri.queryParameters['your_token_param_name'];
```

## Testing

1. Make sure your server redirects to a URL containing `/callback`
2. Ensure the token is included in the URL
3. Token will be automatically saved to SharedPreferences with key `auth_token`

## Stored Data

After successful login:
- Key: `auth_token`
- Value: The token extracted from the redirect URL

## Example Server Response

### Backend (Laravel/PHP)
```php
return redirect("myapp://callback?token=" . $token);
```

### Backend (Node.js)
```javascript
res.redirect(`myapp://callback?token=${token}`);
```

### Backend (Python/Flask)
```python
return redirect(f"myapp://callback?token={token}")
```
