# LoomAI App - Project Overview & Design Plan

This document outlines the project plan, UI/UX design concepts, and technical architecture for the LoomAI Flutter application, based on the provided requirements.

---

## 1. Core Concept & Vision

LoomAI is a mobile application for iOS and Android that allows users to create, customize, and engage in deep, meaningful conversations with personalized AI characters. The core experience revolves around a unique memory system that ensures conversational continuity and character development over time.

- **App Name:** LoomAI
- **Platforms:** iOS & Android
- **UI/UX Vision:** A blend of gentle, dream-like aesthetics with subtle cyberpunk elements, creating a unique, immersive, and comforting user experience.

---

## 2. UI/UX Design Guideline

The visual identity of LoomAI should be soft and inviting, yet modern and technologically advanced.

### Color Palette

- **Primary Background:** A very dark, soft desaturated purple or blue (`#1A182D`).
- **Primary Accent / "Glow" Color:** A vibrant, soft neon lavender (`#C8A2C8`).
- **Secondary Accent:** A gentle teal or cyan for highlights and interactive elements (`#7ADFDD`).
- **Text & Icons:** Off-white (`#F0F0F0`) for readability.
- **Character/System Messages:** Use slightly different background bubble colors to distinguish between the user and the AI (e.g., user messages on a dark grey, AI messages on a dark purple).

### Typography

- **Headers & Titles:** **"Orbitron"** or a similar futuristic, slightly wide sans-serif font to bring in the cyberpunk feel.
- **Body & UI Text:** **"Poppins"** or **"Lato"** for its clean, modern, and friendly appearance.

### Component Style & Mockup Ideas

- **Glassmorphism/Frosted Glass:** Use this effect for bottom navigation bars, modal dialogs, and character cards. It creates a sense of depth and fits the "dreamy" aesthetic.
- **Neon Glow:** Buttons, active icons, and input fields should have a soft outer glow (`box-shadow` in web terms) using the primary accent color. This effect should intensify on hover or tap.
- **Buttons:** Rounded corners, filled with a dark color, with glowing text/icons.
- **Character Cards (`Character Hub`):** Each card will feature the character's avatar. The avatar itself could have a subtle, animated circular border that glows with the accent color. The "啟動碎片" (Activate Shard) button would be prominent on the card.
- **Chat Interface (`Chat`):**
    - Speech bubbles with rounded corners.
    - Support for Markdown rendering (bold, italics, lists) is crucial.
    - A top app bar showing the current AI character's name and avatar, with a settings icon to adjust model parameters (`temperature`, etc.) for the current session.
- **Memory Box (`Memory Box`):** Saved conversations could be displayed as small, glowing "crystals" or "shards" that, when tapped, expand to show the full text.

---

## 3. Application Architecture & Navigation

The app will use a `BottomNavigationBar` with four main tabs.

1.  **Chat (`/chat`):** The active conversation screen. This is the heart of the app.
2.  **Character Hub (`/characters`):** A grid or list of created AI characters. This is the default landing page.
3.  **Memory Box (`/memories`):** A collection of user-saved conversation snippets.
4.  **Profile (`/profile`):** User settings, subscription status (future), and app info.

---

## 4. Technical Stack & Project Structure

### Recommended Stack

- **Framework:** Flutter
- **State Management:** **Riverpod**. It provides compile-safe dependency injection, simplifies state management across the app, and is highly scalable, making it ideal for managing API services, repositories, and complex UI state.
- **Local Database:** **Hive**. It's a lightweight, fast, and native Dart key-value database. It's perfect for storing structured data like character profiles, chat histories, and memory summaries without the overhead of a full SQL database.
- **API Client:** `dio` for its powerful features like interceptors, which will be useful for injecting API keys and handling errors.

### Proposed Project Structure

A feature-first project structure is recommended for scalability.

```
lib/
├── main.dart
│
└── src/
    ├── core/                 # Core services, models, and utilities
    │   ├── api/              # OpenAI API client (Dio setup)
    │   ├── database/         # Hive setup and data models (DAOs)
    │   └── models/           # Core data models (User, Subscription, etc.)
    │
    ├── features/             # Each feature as a module
    │   ├── auth/             # User authentication (if needed later)
    │   ├── character_hub/    # Character creation, editing, selection
    │   │   ├── models/       # CharacterProfile model
    │   │   ├── providers/    # Riverpod providers for characters
    │   │   └── views/        # Character Hub screen, edit screen
    │   │
    │   ├── chat/             # Chat interface and logic
    │   │   ├── models/       # ChatMessage model
    │   │   ├── providers/    # Riverpod providers for chat state
    │   │   ├── services/     # Memory management service
    │   │   └── views/        # Chat screen
    │   │
    │   ├── memory_box/       # Saved memories feature
    │   │   └── ...
    │   │
    │   └── profile/          # User profile and settings
    │       └── ...
    │
    ├── shared/               # Shared widgets, constants, and themes
    │   ├── widgets/          # Reusable UI components (e.g., glowing buttons)
    │   ├── theme/            # App theme, colors, text styles
    │   └── constants/        # API keys (from env), routes, etc.
    │
    └── app.dart              # Root widget with navigation setup
```

---

## 5. Memory Management System (Key Design)

This is the most critical technical component. The goal is to create a robust long-term memory for each AI character. A hybrid approach is recommended.

### Step 1: Local Storage with Hive

- Create a `CharacterProfile` Hive object that stores the character's base info (name, personality, system prompt, etc.).
- Create a `ChatMessage` Hive object to store individual messages.
- Each `CharacterProfile` will have a `HiveList<ChatMessage>` to link it to its conversation history.
- Each `CharacterProfile` will also have a `String` field for `memory_summary`.

### Step 2: The Hybrid Memory Mechanism

1.  **Short-Term Context:** For every new message a user sends, the app will fetch the **last 10-15 messages** from the Hive database for that character. This list of recent messages is sent with the API call to provide immediate context.

2.  **Long-Term Memory Summarization (Asynchronous):**
    *   **Trigger:** This process can be triggered periodically (e.g., every 20 messages) or when the user navigates away from the chat screen.
    *   **Process:**
        1.  Take the latest batch of messages that haven't been summarized yet.
        2.  Make a **separate, background API call** to OpenAI (e.g., GPT-3.5-Turbo for cost-efficiency) with a specific prompt:
            ```
            "You are a memory summarization assistant. Read the following conversation and summarize the key events, facts, and emotional developments in 2-3 concise sentences. Focus on information that defines the user's relationship with the AI. Conversation: [Insert conversation text here]"
            ```
        3.  **Append to Memory:** The resulting summary is appended to the `memory_summary` string in the character's `CharacterProfile` in Hive.

3.  **Memory Injection:**
    *   When a new chat session begins, the character's full `system_message` is constructed dynamically:
    ```
    // Base Prompt
    "You are {character.name}. {character.backstory}. Your personality is {character.personality}."

    // Memory Injection
    "--- MEMORY LOG ---
    Here is a summary of your past interactions with the user. Use this to inform your responses and remember your shared history.
    {character.memory_summary}
    --- END MEMORY LOG ---"
    ```
    *   This combined prompt is sent as the `system` message in the `chat/completions` API call, ensuring the AI is always aware of its entire history in a compressed, efficient format.

### Advanced Option (Future Expansion)

- **Vector Embeddings:** For a more sophisticated solution, each user/AI message pair can be converted into a vector embedding and stored. When a user sends a new message, its embedding can be used to perform a similarity search against the stored vectors, retrieving the most relevant past interactions to inject as context, rather than a linear summary.

---

## 6. OpenAI API Integration

- **Service Class:** Create a `OpenAIService` class in `src/core/api/`.
- **Model Switching:** The service will have a method like `getChatCompletion(String prompt, List<ChatMessage> history, AIModel model, double temperature)` where `AIModel` is an enum (`GPT4`, `GPT3_5`).
- **Parameter Control:** The UI will allow users to update a `ChatSettings` provider, which the `OpenAIService` will read from when making API calls.
- **Cost Management:** The free tier of 10,000 words can be tracked locally in `shared_preferences` or a `User` object in Hive. The app will count the words in user prompts and AI responses and decrement the counter.

---

## 7. Initial Implementation Steps

1.  **Setup Project:** Create a new Flutter project and implement the folder structure outlined above.
2.  **Setup Hive:** Initialize Hive and create the `CharacterProfile` and `ChatMessage` `HiveObject`s.
3.  **Build UI Shell:** Create the four main pages and set up the `BottomNavigationBar`.
4.  **Character Hub:** Implement the UI for creating, viewing, and editing characters. Save character data to Hive.
5.  **Basic Chat:** Build the chat interface. When a user sends a message, save it to Hive and display it.
6.  **API Service:** Implement the `OpenAIService` to call the OpenAI API. For now, just use the last 5 messages as context.
7.  **Memory System v1:** Implement the asynchronous summarization logic.
8.  **Refine UI:** Apply the full "Gentle Cyberpunk" theme.