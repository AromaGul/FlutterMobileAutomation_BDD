# Jenkins Email Configuration Guide

## Email Address: aroma.gul@venturedive.com

---

## Step-by-Step Email Configuration

### Step 1: Install Email Extension Plugin

1. **Open Jenkins Dashboard**
2. **Click "Manage Jenkins"** (left sidebar)
3. **Click "Plugins"** (or "Manage Plugins")
4. **Click "Available" tab**
5. **Search for:** `Email Extension Plugin`
6. **Check the box** next to "Email Extension Plugin"
7. **Click "Install without restart"** (or "Download now and install after restart")
8. **Wait for installation** to complete
9. **Restart Jenkins** if prompted

---

### Step 2: Configure SMTP Settings

1. **Go to:** Manage Jenkins → Configure System
2. **Scroll down** to find **"Extended E-mail Notification"** section

#### Option A: Gmail SMTP (If using Gmail)

**Settings:**
```
SMTP server: smtp.gmail.com
SMTP Port: 587
✅ Use SSL: Checked
✅ Use TLS: Checked
User Name: aroma.gul@venturedive.com (or your Gmail if using Gmail)
Password: [Your Gmail App Password - see below]
Default user e-mail suffix: @venturedive.com
```

**Important for Gmail:**
- You need to use an **App Password**, not your regular password
- Go to: Google Account → Security → 2-Step Verification → App Passwords
- Generate an app password for "Mail"
- Use that 16-character password in Jenkins

#### Option B: Outlook/Office 365 SMTP (If using Outlook)

**Settings:**
```
SMTP server: smtp.office365.com
SMTP Port: 587
✅ Use SSL: Checked
✅ Use TLS: Checked
User Name: aroma.gul@venturedive.com
Password: [Your Outlook password]
Default user e-mail suffix: @venturedive.com
```

#### Option C: Custom SMTP Server (If VentureDive has custom SMTP)

**Settings:**
```
SMTP server: [Ask your IT team for SMTP server]
SMTP Port: [Usually 587 or 465]
✅ Use SSL: Checked (if port 465)
✅ Use TLS: Checked (if port 587)
User Name: aroma.gul@venturedive.com
Password: [Your email password]
Default user e-mail suffix: @venturedive.com
```

---

### Step 3: Configure Email Settings

In the **"Extended E-mail Notification"** section:

1. **SMTP server:** Enter your SMTP server (see options above)
2. **Default user e-mail suffix:** `@venturedive.com`
3. **Use SMTP Authentication:** ✅ Checked
4. **User Name:** `aroma.gul@venturedive.com`
5. **Password:** Enter your email password (or App Password for Gmail)
6. **Use SSL:** ✅ Checked (for port 587/465)
7. **SMTP Port:** `587` (or `465` for SSL)
8. **Charset:** `UTF-8`

**Advanced Settings (Optional):**
- **Reply To List:** Leave empty or add: `aroma.gul@venturedive.com`
- **Add Timestamp:** ✅ Checked (recommended)
- **Add Jenkins URL:** ✅ Checked (recommended)

---

### Step 4: Test Email Configuration

1. **Scroll down** in the "Extended E-mail Notification" section
2. **Find "Test configuration by sending test e-mail"**
3. **Enter test email address:** `aroma.gul@venturedive.com`
4. **Click "Test configuration"** button
5. **Wait for result:**
   - ✅ **Success:** "Email was successfully sent"
   - ❌ **Failure:** Check error message and fix settings

**If test fails:**
- Check SMTP server address
- Verify port number
- Check username/password
- Verify SSL/TLS settings
- Check firewall/network settings

---

### Step 5: Configure Default Email Recipients

1. **Still in "Extended E-mail Notification" section**
2. **Find "Default Recipients"** field
3. **Enter:** `aroma.gul@venturedive.com`
4. **Click "Save"** at the bottom of the page

---

### Step 6: Update Jenkinsfile (Already Done)

The Jenkinsfile already includes email notifications. The email will be sent to:
```groovy
to: "${env.EMAIL_RECIPIENT}"
```

Where `EMAIL_RECIPIENT = 'aroma.gul@venturedive.com'` (already configured in Jenkinsfile)

---

## Email Notification Types

Your Jenkinsfile is configured to send emails for:

### 1. Build Success ✅
- **Subject:** `✅ Build #X - SUCCESS: native_demo_app_automation`
- **Recipient:** `aroma.gul@venturedive.com`
- **Content:** Build details, test results, APK artifacts

### 2. Build Failure ❌
- **Subject:** `❌ Build #X - FAILED: native_demo_app_automation`
- **Recipient:** `aroma.gul@venturedive.com`
- **Content:** Error details, console output link

### 3. Build Unstable ⚠️
- **Subject:** `⚠️ Build #X - UNSTABLE: native_demo_app_automation`
- **Recipient:** `aroma.gul@venturedive.com`
- **Content:** Test failures, warnings

---

## Troubleshooting

### Problem: "Authentication failed"

**Solutions:**
1. **For Gmail:** Use App Password, not regular password
2. **Check username:** Must be full email: `aroma.gul@venturedive.com`
3. **Verify password:** No typos, correct password
4. **Check 2FA:** If enabled, use App Password

### Problem: "Connection timeout"

**Solutions:**
1. **Check SMTP server:** Verify server address
2. **Check port:** Usually 587 (TLS) or 465 (SSL)
3. **Check firewall:** Allow outbound connections on port 587/465
4. **Check network:** Ensure Jenkins can reach SMTP server

### Problem: "Email not received"

**Solutions:**
1. **Check spam folder:** Emails might be filtered
2. **Verify recipient:** Check email address is correct
3. **Check SMTP settings:** Re-test configuration
4. **Check Jenkins logs:** View Jenkins console for errors

### Problem: "SSL/TLS error"

**Solutions:**
1. **Try different port:** 587 (TLS) or 465 (SSL)
2. **Toggle SSL/TLS:** Try both checked/unchecked
3. **Check certificate:** Some servers need certificate validation disabled

---

## Quick Reference

### Gmail Configuration:
```
SMTP: smtp.gmail.com
Port: 587
SSL: ✅
TLS: ✅
User: aroma.gul@venturedive.com (or your Gmail)
Password: [Gmail App Password]
```

### Outlook Configuration:
```
SMTP: smtp.office365.com
Port: 587
SSL: ✅
TLS: ✅
User: aroma.gul@venturedive.com
Password: [Your Outlook password]
```

### Default Settings:
```
Default Recipients: aroma.gul@venturedive.com
Default Suffix: @venturedive.com
Charset: UTF-8
```

---

## Verification Checklist

After configuration, verify:

- [ ] Email Extension Plugin installed
- [ ] SMTP server configured correctly
- [ ] Port number correct (587 or 465)
- [ ] SSL/TLS settings correct
- [ ] Username and password correct
- [ ] Test email sent successfully
- [ ] Default recipients set to `aroma.gul@venturedive.com`
- [ ] Jenkinsfile has `EMAIL_RECIPIENT` variable set

---

## Next Steps

After email is configured:

1. **Create Jenkins Job** (if not done)
2. **Run first build**
3. **Check email** for notifications
4. **Verify** success/failure emails are received
5. **Test** scheduled builds send emails

---

## Need Help?

If email configuration fails:

1. **Contact IT team** for SMTP server details (if using company email)
2. **Check email provider documentation** (Gmail/Outlook)
3. **Review Jenkins logs** for detailed error messages
4. **Try different SMTP settings** (port, SSL/TLS combinations)

---

## Summary

**Your Email:** `aroma.gul@venturedive.com`

**Configuration Location:**
- Manage Jenkins → Configure System → Extended E-mail Notification

**Key Settings:**
- SMTP server: (Gmail/Outlook/Custom)
- Port: 587 (TLS) or 465 (SSL)
- User: `aroma.gul@venturedive.com`
- Default Recipients: `aroma.gul@venturedive.com`

**Test Before Saving:**
- Always test email configuration before saving
- Verify you receive test email

