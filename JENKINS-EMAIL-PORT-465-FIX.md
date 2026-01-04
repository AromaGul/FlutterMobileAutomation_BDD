# Fix: Bad Greeting Error on Port 465

## Error: `Got bad greeting from SMTP host: smtp.gmail.com, port: 465, response: [EOF]`

This error means the connection to Gmail is being closed immediately. Port 465 often has issues with firewalls or network restrictions.

---

## Solution: Use Port 587 with TLS (Recommended)

**Port 587 is more reliable and works better with most networks.**

### Correct Settings for Port 587:

```
SMTP server: smtp.gmail.com
Port: 587
❌ Use SSL: UNCHECKED
✅ Use TLS: CHECKED
✅ Use SMTP Authentication: CHECKED
User Name: aroma.gul@venturedive.com (or your Gmail)
Password: [Gmail App Password]
Default suffix: @venturedive.com
```

**Steps:**
1. Go to: **Manage Jenkins → Configure System**
2. Find: **Extended E-mail Notification**
3. Change port from **465** to **587**
4. **Uncheck** "Use SSL"
5. **Check** "Use TLS"
6. **Save**
7. **Test again**

---

## Why Port 465 Fails

**Common reasons:**
1. **Firewall blocking port 465** (many corporate networks block it)
2. **Gmail restrictions** on port 465
3. **Network security policies**
4. **ISP blocking** port 465

**Port 587 is usually:**
- ✅ Not blocked by firewalls
- ✅ More reliable
- ✅ Standard for most email providers
- ✅ Works with STARTTLS

---

## Alternative Solutions

### Option 1: Try Outlook/Office 365 (If Gmail continues to fail)

If Gmail keeps having issues, try Outlook:

```
SMTP server: smtp.office365.com
Port: 587
❌ Use SSL: UNCHECKED
✅ Use TLS: CHECKED
User Name: aroma.gul@venturedive.com
Password: [Your Outlook password]
Default suffix: @venturedive.com
```

**Outlook is often more reliable** for corporate environments.

---

### Option 2: Check Firewall Settings

If you must use port 465:

1. **Check Windows Firewall:**
   - Allow outbound connections on port 465
   - Allow Jenkins through firewall

2. **Check Corporate Firewall:**
   - Contact IT to allow port 465
   - Or use port 587 (usually allowed)

3. **Check Antivirus:**
   - Some antivirus blocks SMTP ports
   - Temporarily disable to test

---

### Option 3: Use Different SMTP Server

If your company has its own email server:

1. **Contact IT team** for SMTP settings
2. **Ask for:**
   - SMTP server address
   - Port number
   - SSL/TLS requirements
   - Authentication method

---

## Step-by-Step Fix (Port 587)

### Step 1: Open Email Configuration
1. **Manage Jenkins → Configure System**
2. **Scroll to:** "Extended E-mail Notification"

### Step 2: Update Settings

**Change from:**
```
Port: 465
✅ Use SSL
❌ Use TLS
```

**Change to:**
```
Port: 587
❌ Use SSL  ← UNCHECK
✅ Use TLS  ← CHECK
```

### Step 3: Verify Other Settings

```
✅ SMTP server: smtp.gmail.com
✅ Port: 587
✅ Use SMTP Authentication: CHECKED
✅ User Name: aroma.gul@venturedive.com
✅ Password: [Gmail App Password]
❌ Use SSL: UNCHECKED
✅ Use TLS: CHECKED
✅ Default suffix: @venturedive.com
```

### Step 4: Save and Test
1. **Click "Save"**
2. **Test email configuration**
3. **Should work now!**

---

## Complete Working Configuration

### For Gmail (Port 587 - Recommended):

```
SMTP server: smtp.gmail.com
Port: 587
Use SMTP Authentication: ✅ CHECKED
User Name: aroma.gul@venturedive.com
Password: [Gmail App Password - 16 characters]
Use SSL: ❌ UNCHECKED
Use TLS: ✅ CHECKED
Default user e-mail suffix: @venturedive.com
Charset: UTF-8
Reply To List: (leave empty)
Add Timestamp: ✅ CHECKED
Add Jenkins URL: ✅ CHECKED
```

---

## Troubleshooting Port 465

If you must use port 465, try:

1. **Enable SSL properly:**
   ```
   Port: 465
   ✅ Use SSL: CHECKED
   ❌ Use TLS: UNCHECKED
   ```

2. **Check Java SSL settings:**
   - Some Java versions have SSL issues
   - Update Java if needed

3. **Test connection:**
   ```bash
   telnet smtp.gmail.com 465
   ```
   (If connection fails, port is blocked)

---

## Quick Decision Tree

```
Port 465 giving errors?
    ↓
Try Port 587 with TLS
    ↓
Still failing?
    ↓
Try Outlook (smtp.office365.com:587)
    ↓
Still failing?
    ↓
Contact IT for company SMTP server
```

---

## Summary

**Best Solution:**
- **Use Port 587** with TLS (not SSL)
- More reliable than port 465
- Works with most networks

**Your Settings:**
```
Port: 587
SSL: ❌ OFF
TLS: ✅ ON
```

**This should fix the "bad greeting" error!**

