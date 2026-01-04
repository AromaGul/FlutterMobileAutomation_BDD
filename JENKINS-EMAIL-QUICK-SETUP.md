# Quick Email Setup for Jenkins

## Your Email: aroma.gul@venturedive.com

---

## Fast Setup (5 Minutes)

### 1. Install Plugin
- Manage Jenkins → Plugins → Available
- Search: `Email Extension Plugin`
- Install

### 2. Configure Email
- Manage Jenkins → Configure System
- Scroll to: **Extended E-mail Notification**

### 3. Enter Settings

**If using Gmail:**
```
SMTP server: smtp.gmail.com
Port: 587
✅ Use SSL
✅ Use TLS
User Name: aroma.gul@venturedive.com
Password: [Gmail App Password - see below]
Default suffix: @venturedive.com
```

**If using Outlook:**
```
SMTP server: smtp.office365.com
Port: 587
✅ Use SSL
✅ Use TLS
User Name: aroma.gul@venturedive.com
Password: [Your password]
Default suffix: @venturedive.com
```

### 4. Test
- Enter: `aroma.gul@venturedive.com`
- Click: **Test configuration**
- Check your email inbox

### 5. Save
- Click **Save** at bottom

---

## Gmail App Password (If using Gmail)

1. Go to: https://myaccount.google.com/security
2. Enable: **2-Step Verification** (if not enabled)
3. Go to: **App passwords**
4. Select: **Mail** → **Other (Custom name)**
5. Enter: "Jenkins"
6. Click: **Generate**
7. Copy the 16-character password
8. Use this password in Jenkins (not your regular password)

---

## Done! ✅

Your Jenkinsfile is already configured to send emails to:
`aroma.gul@venturedive.com`

You'll receive emails for:
- ✅ Build Success
- ❌ Build Failure  
- ⚠️ Build Unstable

---

## Need Help?

See `JENKINS-EMAIL-SETUP.md` for detailed troubleshooting.

