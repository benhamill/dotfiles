---
name: commit
description: ALWAYS invoke this skill whenever the user's message contains the word "commit" in a git/version control context, including "commit this", "commit these changes", "commit them", "look at changes and commit", "commit the files", "create a commit", "make a commit", "write a commit message", "let's commit", or any instruction to commit staged/unstaged changes. This skill MUST be used before drafting ANY git commit message.
---
# Writing Commit Messages

## Commit Message Checklist

Follow these steps in order before writing any commit message:

### 1. Ask "Why?" if unclear from the diff
If the motivation for the change is not obvious from the code diff, ask the user "Why are you making this change?" before proceeding. Never make up reasons.

### 2. Write Summary in Title Case
Capitalize Every Major Word (except small joining words like "from", "to", "and").
- ✓ "Remove Hardcoded Environment Variables From ECS Task Definitions"
- ✗ "Remove hardcoded environment variables from ECS task definitions"

### 3. Write Body in Present Tense
Use present tense verbs, not past tense.
- ✓ "Removes...", "Cleans...", "Updates..."
- ✗ "Removed...", "Cleaned...", "Updated..."

### 4. Do Not Enumerate Specific Files/Variables
Describe changes conceptually. The diff shows implementation details.
- ✓ "Removes hardcoded environment variables from task definitions"
- ✗ "Removes ECS_ENABLE_CONTAINER_METADATA, ASPNETCORE_ENVIRONMENT, ENV_TYPE..."
- ✗ Bullet lists of specific files/variables removed

---

## Instructions

1. Use `git diff`, `git diff --staged`, and other git commands to assess changes.
2. Examine directory structure and README files to understand project scope.
3. Suggest a commit message with:
   - Summary under 50 characters in Title Case
   - Body text explaining what and why (not how)
   - Sentence fragments in present tense (as if "This commit..." is prepended)


## Best Practices

### Summary Line
- Use imperative mood: "Add", "Fix", "Remove", "Update" (not "Adds", "Fixes", "Removes")
- Include scope/project name for org-wide or multi-project repos
- Target 50 characters (can exceed slightly for clarity)

### Body Text
- Write sentence fragments in present tense as if "This commit..." is prepended
  - Good: "Removes environment variables from ECS task definitions"
  - Bad: "Remove environment variables..." (imperative), "This removes..." (redundant)
- Explain why with specific, concrete reasons - ask the user if unclear
  - Good: "because Octopus over-writes all environment variables on deploy anyway"
  - Bad: "because they are no longer needed" (vague)
- Describe changes conceptually, not implementation details
  - Good: "Also removes the unused variables, locals and tfvars referenced only in the deleted sections"
  - Bad: Enumerating specific variable names or listing affected files
- Reinforce scope when relevant: "for the Envoy Logging Proxy" clarifies which component
- Include the Claude attribution lines.

### Scope and Grouping
- Determine scope by examining directory structure and README files
- Include scope in both summary and body for large repos
- Group changes by logical purpose, not individual actions
- Use sentences for 1-3 conceptual changes, bulleted lists for 4+ changes


## Examples

### Example 1

#### Good
```
Remove Environment Variables from Logging Proxy ECS Tasks

Removes all environment sections from ECS task configurations for the Envoy
Logging Proxy because Octopus over-writes all environment variables  on deploy
anyway, so these had no impact and were confusing. Also removes the unused
variables, locals and tfvars referenced only in the deleted sections.
```

#### Bad
```
Remove environment variables from ECS task definitions

Remove all environment sections from ECS task definitions and clean up
unused variables. Environment variables were previously used to pass
configuration to containers but are no longer needed.

Changes:
- Remove environment sections from all ECS task definitions
- Delete unused variables: grafana_prometheus_url, grafana_loki_url
- Delete unused local: aspnetcore_environment
- Clean up tfvars files to remove deleted variable values
```
Problems:
- Summary not in Title Case (should be "Remove Environment Variables from ECS Task Definitions")
- Summary missing scope/project name (which project in the org-wide repo?)
- Body uses imperative mood ("Remove") instead of present tense ("Removes")
- Lists granular implementation details (specific variable names, file types) instead of describing the conceptual change
- Vague "why" ("no longer needed") without explaining the actual reason

```
Remove unused environment variables from ECS tasks

Removes environment variable blocks from all logging_proxy ECS task
definitions as these configurations are no longer needed by the
containers. This cleanup simplifies the task definitions and removes
the associated unused Terraform variables.

Changes include removing environment variables from kafka_follower,
loki_log_follower, observability_grafana, logging_proxy, and all Loki
tasks (write, read, backend). Also deletes the grafana_prometheus_url
and grafana_loki_url variables along with the aspnetcore_environment
local, and removes their values from all environment tfvars files.
```
Problems:
- Summary not in Title Case (should be "Remove Unused Environment Variables from ECS Tasks")
- Made up a vague reason ("no longer needed by the containers") instead of asking the user
- Enumerates specific tasks (kafka_follower, loki_log_follower, etc.) and variable names - this is what the diff is for
- Adds unnecessary fluff like "This cleanup simplifies the task definitions"

```
Remove hardcoded environment variables from ECS task definitions

Removed ECS_ENABLE_CONTAINER_METADATA, ASPNETCORE_ENVIRONMENT, ENV_TYPE,
PROMETHEUS_URL, LOKI_URL, AWS_REGION, and LOKI_CONFIG environment variables
from task definitions. Also cleaned up associated variable definitions and
tfvars across all environments.
```
Problems:
- Summary not in Title Case (should be "Remove Hardcoded Environment Variables from ECS Task Definitions")
- Body uses PAST TENSE ("Removed", "cleaned") instead of PRESENT TENSE ("Removes", "cleans")
- Lists specific variable names (ECS_ENABLE_CONTAINER_METADATA, ASPNETCORE_ENVIRONMENT, etc.) - this belongs in the diff, not the commit message

```
Remove hardcoded environment variables from ECS task definitions

Cleans up environment variable configuration by removing:
- ECS_ENABLE_CONTAINER_METADATA from all task definitions
- ASPNETCORE_ENVIRONMENT, ENV_TYPE, PROMETHEUS_URL, LOKI_URL from Grafana task
- AWS_REGION and LOKI_CONFIG from Loki tasks
- Grafana datasource URL variables from tfvars and variable.tf
```
Problems:
- Summary not in Title Case (should be "Remove Hardcoded Environment Variables from ECS Task Definitions")
- NO "WHY" - should have asked the user why these are being removed
- Uses bullet list to enumerate specific variable names - violates Step 4 of checklist
