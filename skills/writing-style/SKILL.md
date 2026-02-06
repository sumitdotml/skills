---
name: writing-style
description: Writing style guidelines for blog posts and technical documents. Covers tone, formatting, and patterns to avoid.
user-invocable: true
---

# Writing Style Guidelines

Personal writing preferences for blog posts and technical documents.

## 1. Bold Usage

**Use sparingly.** Bold is for emphasis, not decoration.

- Don't bold every bullet point
- Don't bold "important" words throughout paragraphs
- Reserve bold for truly critical terms or section titles

## 2. Em-Dash Rules

**Only for removable parenthetical phrases.** Not for dramatic effect.

Format: `--` (double hyphen), not `—` (unicode em-dash)

Valid:

```
I slept for very long last night -- although with no good quality -- and still woke up tired
```

Invalid:

```
This is important -- and it changes everything
The results were clear -- success
```

Test: If you can't remove the content between dashes without losing core meaning, don't use em-dashes.

## 3. Banned Sentence Patterns

Avoid these dramatic/superlative constructions:

- "That's not just X, that's Y -- that's Z"
- "This is the testament to X: that this is Y"
- "I strive to get better not just for X, but for Y that I want to Z"
- "This isn't merely X; it's fundamentally Y"
- Starting sentences with "The key insight here is that..."
- "What makes this particularly interesting is..."

## 4. Tone Guidelines

- Conversational but technical
- First-person narrative where appropriate
- Honest about uncertainties and WIP status
- Questions-driven structure can be used (pose questions, then answer them - but try to use first-person narrative or a monologue tone)
- No excessive validation or superlatives
- No hedging qualifiers ("quite", "rather", "fairly")

## 5. Technical Writing

- Include code examples with tensor shapes when relevant
- Use `> Note:` blockquotes for asides
- Footnotes for paper references
- Concrete numbers over vague statements
- Every claim should be traceable to a commit or doc or a reference link

## 6. Structure

- Numbered sections with H2 headers
- Lists for enumerable items
- Horizontal rules between major sections

---

**These guidelines are working if:** text reads naturally, emphasis is meaningful, and technical content is precise without being dry.
