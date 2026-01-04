# Final Email Configuration Fix

## Current Error: Bad Greeting on Port 465

**Solution: Switch to Port 587**

---

## ✅ Working Configuration

### Gmail Settings (Port 587):

```
SMTP server: smtp.gmail.com
Port: 587                    ← Change from 465 to 587
Use SMTP Authentication: ✅ CHECKED
User Name: aroma.gul@venturedive.com
Password: [Gmail App Password]
Use SSL: ❌ UNCHECKED        ← Important!
Use TLS: ✅ CHECKED          ← Important!
Default suffix: @venturedive.com
```

---

## Quick Fix Steps

1. **Manage Jenkins → Configure System**
2. **Extended E-mail Notification**
3. **Change:**
   - Port: **465** → **587**
   - SSL: **Uncheck**
   - TLS: **Check**
4. **Save**
5. **Test**

---

## Why This Works

- **Port 587** = Standard, not blocked
- **TLS (STARTTLS)** = Works with Gmail
- **Port 465** = Often blocked by firewalls

---

## If Still Failing

Try **Outlook** instead:

```
SMTP: smtp.office365.com
Port: 587
SSL: ❌ OFF
TLS: ✅ ON
User: aroma.gul@venturedive.com
```

---

**Port 587 with TLS is the most reliable solution!** ✅

