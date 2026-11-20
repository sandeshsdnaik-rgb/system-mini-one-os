# System-1 MiniOS — Autonomous Spatial Desktop Workspace

> Transform an interactive infinite whiteboard into an intelligent desktop environment powered by local AI agents, visual workflows, C code diagnostics, and hardware-aware concurrency management.

---

## Key Features

1. **Infinite Spatial Canvas (Excalidraw)**
   - Official `@excalidraw/excalidraw` embedding with dark/light themes.
   - Scene change tracking with debounced SQLite auto-persistence.
   - Whiteboard drawing, text notes, shapes, arrows, and JSON export.

2. **Canvas Intelligence Engine**
   - Extracts shapes, text, and arrow bindings from the visual scene.
   - Automatically builds topologically ordered workflow execution graphs.
   - Disconnected and ambiguous node validation.

3. **Dual-System AI Architecture**
   - **System-1**: Fast deterministic intent classification achieving sub-50ms latency.
   - **System-2**: Deep reasoning powered by local Ollama (`qwen2.5-coder`) for code fixes and outlines.
   - Works 100% offline with zero external API dependencies.

4. **Specialized AI Agents**
   - **Calendar Agent**: Natural language meeting staging with confirmation requirements.
   - **Diagram Agent**: Converts text to Mermaid flowcharts and inserts editable shapes onto the canvas.
   - **C Code Diagnostics Agent**: C compiler syntax verification (`-fsyntax-only`) with one-click diff repair.
   - **Presentation Agent**: Structured outlines and `.pptx` slide generation.
   - **Canvas Search Agent**: Spotlight-style visual element lookup (Ctrl + K).
   - **Workflow Agent**: Dispatches visual process steps through concurrency throttles.

5. **Hardware-Aware Concurrency & Safety**
   - **TabBudgetSemaphore**: Limits concurrent heavy tasks to 3, safely queuing overflow.
   - **InferenceMutex**: Prevents simultaneous heavy inference collisions on local hardware.
   - **Anti-Ostrich Deadlock Sentinel**: Implements real Wait-For Graph (WFG) cycle detection.
   - **Data Loss Prevention (DLP)**: Real-time secret and API key redaction before journal logging.

---

## Technology Stack

- **Frontend**: React 18, TypeScript, Vite, Tailwind CSS, Lucide React, `@excalidraw/excalidraw`, `@excalidraw/mermaid-to-excalidraw`, Mermaid.js.
- **Backend**: Python 3.12, FastAPI, Uvicorn, SQLAlchemy (Async SQLite), WebSockets, Pydantic, psutil, python-pptx.
- **Testing**: Pytest, Pytest-Asyncio.

---

## Quick Start (Windows 10/11)

### 1. Launch All Services (One Command)
```powershell
.\scripts\run-all.ps1
```
This starts both the FastAPI backend (`http://127.0.0.1:8000`) and the Vite frontend (`http://localhost:5173`).

---

### Standalone HTML Diagram Studio
Use the **Diagram Studio** link in the MiniOS toolbar to open `frontend/mermaid-generator.html`. Keep MiniOS open in another tab to insert converted, editable Excalidraw elements into the active whiteboard. On Windows, install Ollama and its diagram model with `winget install Ollama.Ollama` followed by `ollama pull qwen2.5-coder:1.5b`. Diagram Studio reports backend and Ollama status separately; Mermaid can also be edited and previewed directly when local AI is unavailable.

---

### 2. Manual Startup Commands

#### Backend
```powershell
cd "d:\mini project syst mini os"
.\backend\venv\Scripts\python.exe -m uvicorn backend.app.main:app --reload --port 8000
```

#### Frontend
```powershell
cd "d:\mini project syst mini os\frontend"
npm run dev
```

---

## Verification & Testing

Run the automated backend test suite:
```powershell
.\backend\venv\Scripts\python.exe -m pytest backend\tests
```

**Results:**
- `17 passed in ~2.9s`
- Verified: System-1 sub-50ms intent classification, TabBudgetSemaphore limits, InferenceMutex timeouts, Deadlock Sentinel cycle detection & recovery, DLP redaction, and Canvas graph parsing.

---

## Project Structure

```
SYSTEM-1-MINIOS/
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── layout/        (Sidebar, TopNav, StatusBar)
│   │   │   ├── canvas/        (ExcalidrawWorkspace, SpotlightModal)
│   │   │   ├── assistant/     (IntelligencePanel, Chat)
│   │   │   ├── calendar/      (CalendarTimelineModal)
│   │   │   ├── diagrams/      (MermaidGeneratorModal)
│   │   │   ├── code-lab/      (CodeLabModal)
│   │   │   ├── tasks/         (TasksPage)
│   │   │   └── monitoring/    (SystemMonitoringPage)
│   │   ├── pages/             (AgentsPage, ActivityHistoryPage, SettingsPage)
│   │   ├── services/          (api.ts, canvasIntelligence.ts)
│   │   ├── hooks/             (useWebSocket.ts)
│   │   ├── types/
│   │   └── App.tsx
│   ├── package.json
│   └── vite.config.ts
├── backend/
│   ├── app/
│   │   ├── api/               (REST endpoints: health, canvas, ai, agents, workflows, etc.)
│   │   ├── agents/            (Calendar, Diagram, Code, Presentation, Search, Workflow)
│   │   ├── ai/                (System-1 Classifier, System-2 Engine)
│   │   ├── concurrency/       (TabBudgetSemaphore, InferenceMutex, DeadlockSentinel)
│   │   ├── core/              (Config, DLP Security)
│   │   ├── database/          (Async SQLAlchemy session)
│   │   ├── models/            (Entities: Workspaces, Canvas, Tasks, Journal, Events)
│   │   ├── services/          (OllamaService, CanvasIntelligence)
│   │   └── main.py            (FastAPI application & WebSockets)
│   ├── tests/                 (13 automated Pytest test suites)
│   └── requirements.txt
├── docs/                      (architecture.md, api.md, setup.md)
├── scripts/                   (start-backend.ps1, start-frontend.ps1, run-all.ps1)
└── README.md
```

---

## License
MIT License. Built for the System-1 MiniOS Autonomous Spatial Desktop Workspace.
