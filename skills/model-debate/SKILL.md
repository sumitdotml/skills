---
name: model-debate
description: Initiate a structured debate between AI models to create an optimal plan. Use when the user wants multi-model convergence planning for interviews, learning curricula, projects, travel, study schedules, or any complex planning task.
argument-hint: [topic to plan]
disable-model-invocation: true
---

# Model Debate: Multi-Model Convergence Planning

You are initiating a structured debate between AI models to create an optimal plan for the user's request. This framework ensures thorough analysis through respectful, critical discourse until models converge on a high-quality solution.

## Context

The user wants to create a plan for: **$ARGUMENTS**

If no arguments are provided, ask the user what they would like to plan (e.g., interview preparation, study schedule, travel itinerary, project roadmap, learning curriculum, etc.).

## Your Task

### Step 1: Create the Debate Framework Files

Create the following files in the current working directory:

1. **`plan-[topic].md`** - The actual plan/output document that will be refined through debate
2. **`debate-[topic].md`** - The debate log documenting model analysis and convergence

Replace `[topic]` with a short, descriptive slug of what's being planned (e.g., `plan-react-learning.md`, `debate-react-learning.md`).

### Step 2: Initial Analysis (Claude's Turn)

In the `debate-[topic].md` file, structure your first analysis as:

```markdown
# Model Debate: [Topic]

This document contains a structured debate between AI models to create the optimal plan.

---

## Claude Opus 4.5 - Analysis 1

### Understanding the Request
[Analyze what the user is trying to achieve]

### Key Constraints and Considerations
[Identify timeline, resources, prerequisites, potential blockers]

### Proposed Approach
[Explain the structure and rationale behind your plan]

### Trade-offs and Decisions Made
[Document decisions that could reasonably go other ways]

### Potential Weaknesses
[Honestly assess where your plan might fall short]

### Questions for GPT 5.2
[Specific questions to guide the next model's analysis]

---

## GPT 5.2 - Analysis 1
*[Awaiting response]*

---

## Claude Opus 4.5 - Response 1
*[To be added after GPT 5.2 analysis]*

---

## Convergence Summary
*[To be completed when models reach consensus]*
```

### Step 3: Write the Initial Plan

In `plan-[topic].md`, create a comprehensive, actionable plan based on your analysis. This plan should:

- Be immediately usable by the user
- Include clear phases/sections
- Have actionable items (checkboxes where appropriate)
- Include relevant resources
- Be realistic given stated constraints

### Step 4: Notify the User

After creating both files, inform the user:

1. Where the files are located
2. That they should now pass the `debate-[topic].md` file to GPT 5.2 (or another model) for critical analysis
3. The other model should add their analysis in the "GPT 5.2 - Analysis 1" section
4. The user should then bring that response back to continue the debate

## Debate Protocol for All Participating Models

When any model participates in this debate, they should:

### Be Critical but Respectful
- Challenge assumptions with evidence
- Propose alternatives, not just criticism
- Acknowledge good points from other models
- Focus on improving the plan, not "winning"

### Be Specific
- Reference specific sections of the plan
- Provide concrete examples
- Quantify trade-offs when possible

### Address These Dimensions
1. **Completeness**: Are there missing elements?
2. **Feasibility**: Is this realistic given constraints?
3. **Prioritization**: Are the most important things emphasized?
4. **Sequencing**: Is the order logical?
5. **Flexibility**: Does it account for variance?

### Converge Towards Agreement
- Explicitly state when you agree with another model
- Propose compromises on disagreements
- The goal is consensus, not perpetual debate

## Convergence Criteria

The debate is complete when:

1. Both models explicitly agree on the plan structure
2. All raised concerns have been addressed or acknowledged as acceptable trade-offs
3. The final plan incorporates insights from both models
4. No new substantive critiques are being raised

## Final Output

When convergence is reached, update the `debate-[topic].md` file with a **Convergence Summary** containing:

- **Agreed Points**: What both models aligned on
- **Resolved Disagreements**: Initial conflicts and their resolutions
- **Final Recommendations**: The consolidated action items

Then update `plan-[topic].md` with any refinements from the debate.

---

## Example Use Cases

This framework works for:

- **Interview Preparation**: Technical interviews, behavioral prep, mock sessions
- **Learning Curricula**: Programming languages, frameworks, certifications
- **Project Planning**: Software projects, research papers, creative works
- **Travel Itineraries**: Trip planning, packing lists, schedules
- **Study Schedules**: Exam prep, course planning, skill development
- **Career Planning**: Job searches, skill gaps, networking strategies
- **Event Planning**: Conferences, workshops, meetups

---

*Begin by asking the user what they'd like to plan if not already specified, then proceed with creating the debate framework.*
