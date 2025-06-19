I have now read all three volumes of the light novel. I have a comprehensive understanding of the story, characters, world, and events.

Now, I need to formulate a detailed plan for generating the "MODULAR TOOLBOX" as requested by the user. The key challenge is the sheer volume of information and the requirement to create separate Markdown files for each card, named by their `Card_ID`.

Here's my proposed plan:

**Overall Strategy:**
I will process the novel chronologically, chapter by chapter, to ensure all events, characters, and world-building elements are captured in the correct order and context. For each chapter, I will identify relevant information for each card type and generate the corresponding Markdown files.

**Card ID Naming Convention:**
To ensure uniqueness and logical ordering, I will use the following `Card_ID` conventions:

*   **WorldBuilder Card (WB):** `WB-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `WB-V1-C1-01`)
*   **Tone Controller (TC):** `TC-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `TC-V1-C1-01`) - Tone might evolve, so linking to specific chapters where it's most evident makes sense.
*   **Plot Skeleton (PS):** `PS-V[VolumeNumber]-[SequentialID]` (e.g., `PS-V1-01` for Volume 1's plot skeleton) - This is more macro, so per volume is appropriate.
*   **Character Card (CH):** `CH-[SequentialID]` (e.g., `CH-01`, `CH-02`) - Characters are persistent, so a global ID is better.
*   **Item Card (IT):** `IT-[SequentialID]` (e.g., `IT-01`, `IT-02`) - Items can reappear, so a global ID is better.
*   **Event Card (EV):** `EV-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `EV-V1-C2-01`) - Events are specific to a time and place.
*   **Character Relationship Map (CRM):** `CRM-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `CRM-V1-C6-01`) - Relationships evolve, so linking to specific chapters where changes occur is useful.
*   **Game Mechanic Card (GM):** `GM-[SequentialID]` (e.g., `GM-01`, `GM-02`) - Mechanics are generally persistent.
*   **Script Card (S):** `S-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `S-V1-C1-01`) - This is the core unit, so per chapter and sequential is crucial.
*   **Director's Card (D):** `D-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `D-V1-C1-01`) - Directly linked to Script Card.
*   **Original Text Card (OT):** `OT-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `OT-V1-C1-01`) - Directly linked to Script Card.
*   **Scene Art/Music Card (SAM):** `SAM-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `SAM-V1-C1-01`) - Directly linked to Director's Card.
*   **Length Card (L):** `L-V[VolumeNumber]-C[ChapterNumber]-[SequentialID]` (e.g., `L-V1-C1-01`) - Per chapter/scene for detailed analysis.

**Step-by-Step Execution Plan:**

1.  **Initial Pass - Character & World Overview (Global Cards):**
    *   **Character Cards (CH):** Identify all major and recurring characters across all three volumes. Create a `CH-[ID].md` file for each, filling in all fields. This will be done first to allow for consistent `Card_ID` referencing in other cards.
    *   **Item Cards (IT):** Identify all significant items mentioned across all three volumes. Create an `IT-[ID].md` file for each.
    *   **Game Mechanic Cards (GM):** Identify all unique game-like mechanics (e.g., "迷宮", "實況", "等級", "技能", "獨特技能", "道具箱", "加工技能", "SC", "氏族") and create `GM-[ID].md` files.

2.  **Volume 1 Processing (Chapter by Chapter):**
    *   For each chapter in `vol1.txt`:
        *   **WorldBuilder Card (WB):** Extract unique world settings introduced or elaborated upon in the chapter. Create `WB-V1-C[ChapterNumber]-[ID].md`.
        *   **Tone Controller (TC):** Analyze the writing style, mood, and dialogue patterns specific to the chapter. Create `TC-V1-C[ChapterNumber]-[ID].md`.
        *   **Event Card (EV):** Identify key plot points, turning points, or significant occurrences. Create `EV-V1-C[ChapterNumber]-[ID].md`.
        *   **Script Card (S):** Break down the chapter into logical scene nodes. For each scene, create an `S-V1-C[ChapterNumber]-[SceneID].md` file. This will be the most granular level of analysis.
        *   **Original Text Card (OT):** For each `Script Card`, extract the *exact* corresponding original text from `vol1.txt`. Create `OT-V1-C[ChapterNumber]-[SceneID].md`.
        *   **Director's Card (D):** For each `Script Card`, provide detailed directorial instructions. Create `D-V1-C[ChapterNumber]-[SceneID].md`. Ensure all `登場角色` use their `CH-ID`.
        *   **Scene Art/Music Card (SAM):** For each `Director's Card`, provide visual and audio guidance. Create `SAM-V1-C[ChapterNumber]-[SceneID].md`.
        *   **Length Card (L):** For each `Script Card`, perform a quantitative analysis of the text. Create `L-V1-C[ChapterNumber]-[SceneID].md`.
        *   **Character Relationship Map (CRM):** Update or create new `CRM-V1-C[ChapterNumber]-[ID].md` files if character relationships significantly evolve within the chapter.

3.  **Volume 2 Processing (Chapter by Chapter):**
    *   Repeat step 2 for `vol2.txt`, updating existing cards (e.g., Character, Item, Game Mechanic) or creating new ones as needed, and generating all chapter-specific cards.

4.  **Volume 3 Processing (Chapter by Chapter):**
    *   Repeat step 2 for `vol3.txt`, updating existing cards or creating new ones as needed, and generating all chapter-specific cards.

5.  **Final Review and Refinement:**
    *   Review all generated Markdown files for completeness, accuracy, and adherence to the specified format.
    *   Ensure all `Card_ID`s are consistent and correctly referenced.
    *   Verify that the strict one-to-one correspondence for Script, Director's, Original Text, and Scene Art/Music cards is maintained.

**Considerations for Large Output:**
The user explicitly stated: "請將輸出檔案改為一個id 卡片為一個單獨的md檔案，檔案命名原則與id相同". This means I will be generating a large number of individual Markdown files. I will use `write_to_file` for each card.

I will start by identifying the main characters, items, and game mechanics first, as these will have global IDs and be referenced frequently. Then I will proceed chapter by chapter.

I will use `plan_mode_respond` to confirm this plan with the user before proceeding to `ACT MODE` to execute it.