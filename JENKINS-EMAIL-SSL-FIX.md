# Fix: SSL Error in Jenkins Email Configuration

## Error: `Unsupported or unrecognized SSL message`

This error occurs when SSL/TLS settings are incorrect for Gmail SMTP.

---

## Solution: Fix SSL/TLS Settings

### For Gmail Port 587 (Recommended)

**Correct Settings:**
```
SMTP server: smtp.gmail.com
Port: 587
❌ Use SSL: UNCHECKED (Important!)
✅ Use TLS: CHECKED
User Name: aroma.gul@venturedive.com (or your Gmail)
Password: [Gmail App Password]
Default suffix: @venturedive.com
```

**Key Point:** Port 587 uses **TLS (STARTTLS)**, NOT SSL. You must:
- ❌ **Uncheck** "Use SSL"
- ✅ **Check** "Use TLS"

---

## Step-by-Step Fix

### Step 1: Go to Email Configuration
1. **Manage Jenkins → Configure System**
2. **Scroll to:** "Extended E-mail Notification"

### Step 2: Update Settings

**Current (Wrong):**
```
Port: 587
✅ Use SSL  ← This is the problem!
✅ Use TLS
```

**Change to (Correct):**
```
Port: 587
❌ Use SSL  ← UNCHECK THIS
✅ Use TLS  ← KEEP THIS CHECKED
```

### Step 3: Save and Test
1. **Click "Save"**
2. **Test again** with your email address
3. **Should work now!**

---

## Alternative: Use Port 465 (SSL)

If port 587 still doesn't work, try port 465 with SSL:

**Settings:**
```
SMTP server: smtp.gmail.com
Port: 465
✅ Use SSL: CHECKED
❌ Use TLS: UNCHECKED
User Name: aroma.gul@venturedive.com
Password: [Gmail App Password]
Default suffix: @venturedive.com
```

**Key Point:** Port 465 uses **SSL**, NOT TLS. You must:
- ✅ **Check** "Use SSL"
- ❌ **Uncheck** "Use TLS"

---

## Why This Happens

**Port 587:**
- Uses **STARTTLS** (TLS over plain connection)
- Requires: TLS checked, SSL unchecked
- Standard for most email providers

**Port 465:**
- Uses **SSL/TLS** (encrypted from start)
- Requires: SSL checked, TLS unchecked
- Legacy but still works

**The Error:**
- When both SSL and TLS are checked on port 587, Jenkins tries to use SSL immediately
- Gmail expects STARTTLS (TLS), causing the "Unsupported SSL message" error

---

## Complete Gmail Configuration (Port 587)

```
✅ SMTP server: smtp.gmail.com
✅ Port: 587
✅ Use SMTP Authentication: CHECKED
✅ User Name: aroma.gul@venturedive.com
✅ Password: [Your Gmail App Password]
❌ Use SSL: UNCHECKED
✅ Use TLS: CHECKED
✅ Default user e-mail suffix: @venturedive.com
✅ Charset: UTF-8
```

---

## Complete Gmail Configuration (Port 465 - Alternative)

```
✅ SMTP server: smtp.gmail.com
✅ Port: 465
✅ Use SMTP Authentication: CHECKED
✅ User Name: aroma.gul@venturedive.com
✅ Password: [Your Gmail App Password]
✅ Use SSL: CHECKED
❌ Use TLS: UNCHECKED
✅ Default user e-mail suffix: @venturedive.com
✅ Charset: UTF-8
```

---

## Quick Fix Checklist

- [ ] Go to: Manage Jenkins → Configure System
- [ ] Find: Extended E-mail Notification
- [ ] Port 587: Uncheck SSL, Check TLS
- [ ] OR Port 465: Check SSL, Uncheck TLS
- [ ] Save settings
- [ ] Test email configuration
- [ ] Verify email received

---

## Still Not Working?

### Try These:

1. **Check Firewall:**
   - Ensure port 587 or 465 is not blocked
   - Allow outbound connections

2. **Verify App Password:**
   - For Gmail, must use App Password (not regular password)
   - Generate new App Password if needed

3. **Try Different Port:**
   - Try port 465 with SSL
   - Or try port 25 (if not blocked)

4. **Check Network:**
   - Ensure Jenkins can reach smtp.gmail.com
   - Test: `telnet smtp.gmail.com 587` (if available)

5. **Use Outlook Instead:**
   - If Gmail continues to fail, try Outlook:
   ```
   SMTP: smtp.office365.com
   Port: 587
   SSL: Unchecked
   TLS: Checked
   ```

---

## Summary

**The Fix:**
- Port 587: **Uncheck SSL, Check TLS** ✅
- Port 465: **Check SSL, Uncheck TLS** ✅

**Your Email:** `aroma.gul@venturedive.com`

**Most Common Solution:**
Uncheck "Use SSL" when using port 587 with Gmail!

