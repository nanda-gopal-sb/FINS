# FINS
A flutter app used for disease protection and detection

## Database schema:

### Firestore:
```
/user {
  $uid {
    email   : <string>
    name    : <string>
    photoURL: <string>
    uid     : <string>
  }
}
```

### Realtime
```
/$uid {
  Moisture: <number>
  Rain: <number>
}
```

### Storage
```
/$uid {
	profile: <file>
}
```