# AI chat 應用程式
使用 gemini cli 產出

### 生成概述檔
```
cat prompt.txt | gemini -m gemini-2.5-pro -p "" > loomai_app_overview.md
```

### 安裝依賴
```bash
flutter pub get
```

### 啟動 iOS 模擬器
```bash
open -a Simulator
```
#### 若有問題需重啟
```bash
killall Simulator
```

### 執行
```bash
flutter run
```
