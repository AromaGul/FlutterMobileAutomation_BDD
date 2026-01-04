# Fix: Gmail Authentication Required Error

## Error: `530-5.7.0 Authentication Required`

This means Gmail is rejecting your password. **You MUST use a Gmail App Password**, not your regular password.

---

## Solution: Generate and Use Gmail App Password

### Step 1: Enable 2-Step Verification (If Not Already Enabled)

1. **Go to:** https://myaccount.google.com/security
2. **Find:** "2-Step Verification"
3. **Click:** "Get started" or "Turn on"
4. **Follow the steps** to enable 2-Step Verification
5. **Complete the setup**

**Note:** You MUST have 2-Step Verification enabled to use App Passwords.

---

### Step 2: Generate Gmail App Password

1. **Go to:** https://myaccount.google.com/apppasswords
   - Or: Google Account → Security → 2-Step Verification → App passwords

2. **Select app:**
   - Choose: **"Mail"**

3. **Select device:**
   - Choose: **"Other (Custom name)"**
   - Enter: **"Jenkins"**

4. **Click:** **"Generate"**

5. **Copy the 16-character password:**
   - It will look like: `abcd efgh ijkl mnop`
   - **Remove spaces** when using: `abcdefghijklmnop`
   - **Save this password** - you won't see it again!

---

### Step 3: Use App Password in Jenkins

1. **Go to:** Manage Jenkins → Configure System
2. **Find:** Extended E-mail Notification
3. **Enter settings:**

```
SMTP server: smtp.gmail.com
Port: 587
Use SMTP Authentication: ✅ CHECKED  ← Important!
User Name: aroma.gul@venturedive.com (or your Gmail address)
Password: [Paste the 16-character App Password here]  ← Use App Password!
Use SSL: ❌ UNCHECKED
Use TLS: ✅ CHECKED
Default suffix: @venturedive.com
```

**Important:**
- ✅ **Use SMTP Authentication** must be CHECKED
- ✅ **Password** must be the **16-character App Password** (no spaces)
- ❌ **NOT your regular Gmail password**

---

### Step 4: Test Email

1. **Scroll down** in the email configuration
2. **Find:** "Test configuration by sending test e-mail"
3. **Enter:** `aroma.gul@venturedive.com`
4. **Click:** "Test configuration"
5. **Check your email** - should receive test email!

---

## Why Regular Password Doesn't Work

**Gmail Security:**
- Gmail requires **App Passwords** for third-party apps
- Regular passwords are blocked for security
- App Passwords are 16-character codes
- Each app gets its own password

**Error Message Meaning:**
- `530-5.7.0 Authentication Required` = Gmail rejected your password
- This happens when using regular password instead of App Password

---

## Complete Working Configuration

### Gmail Settings (Final):

```
✅ SMTP server: smtp.gmail.com
✅ Port: 587
✅ Use SMTP Authentication: CHECKED
✅ User Name: aroma.gul@venturedive.com (or your Gmail)
✅ Password: [16-character App Password - no spaces]
❌ Use SSL: UNCHECKED
✅ Use TLS: CHECKED
✅ Default user e-mail suffix: @venturedive.com
✅ Charset: UTF-8
```

---

## Troubleshooting

### Problem: "Can't find App Passwords option"

**Solution:**
1. **Enable 2-Step Verification first**
2. **Wait a few minutes** after enabling
3. **Then** go to App Passwords
4. If still not visible, your account might not support it (work/school accounts sometimes don't)

### Problem: "App Password doesn't work"

**Solutions:**
1. **Remove spaces** from App Password (16 characters, no spaces)
2. **Copy-paste** the password (don't type manually)
3. **Generate new App Password** if old one doesn't work
4. **Check** "Use SMTP Authentication" is checked

### Problem: "2-Step Verification not available"

**Solutions:**
1. **Check account type:** Personal Gmail accounts support it
2. **Work/School accounts:** May need IT admin to enable
3. **Use Outlook instead:** If Gmail doesn't work

---

## Alternative: Use Outlook/Office 365

If Gmail App Passwords are not available, use Outlook:

### Outlook Settings:

```
SMTP server: smtp.office365.com
Port: 587
Use SMTP Authentication: ✅ CHECKED
User Name: aroma.gul@venturedive.com
Password: [Your Outlook password]  ← Regular password works
Use SSL: ❌ UNCHECKED
Use TLS: ✅ CHECKED
Default suffix: @venturedive.com
```

**Outlook doesn't require App Passwords** - regular password works.

---

## Quick Checklist

- [ ] 2-Step Verification enabled on Gmail
- [ ] App Password generated (16 characters)
- [ ] App Password copied (no spaces)
- [ ] "Use SMTP Authentication" checked in Jenkins
- [ ] App Password pasted in Jenkins (not regular password)
- [ ] Port 587, TLS checked, SSL unchecked
- [ ] Test email sent successfully

---

## Step-by-Step Summary

1. **Enable 2-Step Verification** on Gmail
2. **Generate App Password** for "Jenkins"
3. **Copy 16-character password** (remove spaces)
4. **Paste in Jenkins** email configuration
5. **Check "Use SMTP Authentication"**
6. **Test email**

---

## Important Notes

**App Password:**
- 16 characters, no spaces
- Generated once, save it securely
- Can generate multiple (one per app)
- Can revoke if needed

**Security:**
- App Passwords are safer than regular passwords
- Each app has its own password
- Can revoke without changing main password

---

## Summary

**The Fix:**
1. Enable 2-Step Verification on Gmail
2. Generate App Password
3. Use App Password in Jenkins (not regular password)
4. Check "Use SMTP Authentication"

**Your Email:** `aroma.gul@venturedive.com`

**This will fix the authentication error!** ✅

