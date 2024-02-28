# Features implemented
### Dash mechanic
Saya mengimplementasikan dash mechanic yang akan mengganti kecepatan pemain dengan dash speed ketika key yang sama ditekan dua kali dalam waktu yang singkat. Referensi saya dapatkan dari forum Godot
### Double Jump
Double Jump, saya implementasikan dengan cara menambahkan variable yang bekerja sebagai counter dan limiter player agar hanya dapat melakukan aksi melompat sebanyak dua kali saja di dalam `get_input()`. Selain itu, saya menambahkan sebuah deteksi `is_on_floor()` sebagai tempat reset counter double jump dan juga sprite.
### Crouching
Crouching yang saya implementasikan membuat player menunduk serta melambatkan pergerakan dari kiri atau kanan dan membuat player tidak dapat melompat.