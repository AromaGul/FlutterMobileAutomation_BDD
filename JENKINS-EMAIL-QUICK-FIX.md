# Quick Fix: SSL Error

## Problem
`Unsupported or unrecognized SSL message` when testing email

## Solution (30 seconds)

### For Port 587 (Gmail):
1. **Manage Jenkins → Configure System**
2. **Extended E-mail Notification section**
3. **Change:**
   - ❌ **Uncheck** "Use SSL"
   - ✅ **Keep checked** "Use TLS"
4. **Save**
5. **Test again**

### That's It! ✅

Port 587 uses TLS (STARTTLS), not SSL. Having both checked causes the error.

---

## Alternative: Port 465

If 587 still fails:
- **Port:** 465
- ✅ **Check** "Use SSL"
- ❌ **Uncheck** "Use TLS"

---

## Your Settings Should Be:

```
SMTP: smtp.gmail.com
Port: 587
SSL: ❌ UNCHECKED
TLS: ✅ CHECKED
User: aroma.gul@venturedive.com
Password: [Gmail App Password]
```

**Save and test!**

