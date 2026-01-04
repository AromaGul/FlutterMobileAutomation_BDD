# Quick Guide: Gmail App Password for Jenkins

## Error: Authentication Required

**Solution:** Use Gmail App Password (not regular password)

---

## Generate App Password (5 Minutes)

### Step 1: Enable 2-Step Verification
1. Go to: https://myaccount.google.com/security
2. Enable: **2-Step Verification**
3. Complete setup

### Step 2: Generate App Password
1. Go to: https://myaccount.google.com/apppasswords
2. Select: **Mail** → **Other (Custom name)**
3. Enter: **"Jenkins"**
4. Click: **Generate**
5. Copy: **16-character password** (remove spaces)

### Step 3: Use in Jenkins
1. **Manage Jenkins → Configure System**
2. **Extended E-mail Notification**
3. **Password field:** Paste App Password (16 chars, no spaces)
4. **Check:** "Use SMTP Authentication"
5. **Test**

---

## Example App Password

```
Generated: abcd efgh ijkl mnop
Use in Jenkins: abcdefghijklmnop  ← No spaces!
```

---

## Settings Summary

```
SMTP: smtp.gmail.com
Port: 587
Auth: ✅ CHECKED
User: aroma.gul@venturedive.com
Password: [16-char App Password]
SSL: ❌ OFF
TLS: ✅ ON
```

---

**That's it!** ✅

