<!--
  GitHub PROFILE README for github.com/im-abhyuday
  Special repository: im-abhyuday/im-abhyuday
-->

<div align="center">

<img width="100%" alt="header" src="https://capsule-render.vercel.app/api?type=waving&color=0:0d1117,100:2f81f7&height=180&section=header&text=Abhyuday&fontSize=44&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Backend%20%7C%20GenAI%20%7C%20Data%20Systems&descSize=18&descAlignY=60" />

<a href="https://github.com/im-abhyuday">
  <img alt="typing intro" src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=22&duration=3000&pause=1000&color=2F81F7&center=true&vCenter=true&width=720&lines=Final-year+B.Tech+CSE+student;Building+Vaultly%3A+a+multi-tenant+RAG+platform;Postgres+RLS+%C2%B7+Kafka+%C2%B7+FastAPI+%C2%B7+pgvector;Open+to+off-campus+SDE+and+GenAI+roles" />
</a>

<br/>

<img alt="Profile views" src="https://komarev.com/ghpvc/?username=im-abhyuday&label=Profile+views&color=2f81f7&style=flat" />
<img alt="Open to work" src="https://img.shields.io/badge/Open_to-Off--campus_roles-2ea44f?style=flat" />
<img alt="Followers" src="https://img.shields.io/github/followers/im-abhyuday?style=flat&label=Followers&color=2f81f7" />

<br/><br/>

<b>
<a href="#about-me">About</a> &nbsp;•&nbsp;
<a href="#featured-project">Project</a> &nbsp;•&nbsp;
<a href="#tech-stack">Tech</a> &nbsp;•&nbsp;
<a href="#github-stats">Stats</a> &nbsp;•&nbsp;
<a href="#lets-connect">Contact</a>
</b>

</div>

---

## <a id="about-me"></a>👋 About me

I'm a final-year B.Tech CSE student who likes building systems that keep working after the demo ends: access control that is enforced in the database, pipelines that survive crashes, and ML features you can actually explain.

- 🔭 Currently building **[Vaultly](https://github.com/im-abhyuday/Vaultly)**, a multi-tenant RAG platform with built-in evaluation
- 🎯 Looking for **off-campus SDE / backend / GenAI engineering** roles
- 📚 Digging into: PostgreSQL row-level security, Kafka delivery guarantees, RAG evaluation
- 💬 Ask me about: RAG pipelines, tenant isolation, event-driven design, FastAPI

<details>
<summary><b>⚡ Quick facts (click to expand)</b></summary>
<br/>

| | |
|---|---|
| 🎓 Education | B.Tech, Computer Science & Engineering (final year), VIT Bhopal University |
| 💼 Looking for | Off-campus SDE, backend, GenAI / ML engineering roles |
| 🧠 Strongest at | Python, API design, SQL, system design basics |
| 🌱 Learning | Distributed systems, MLOps, production RAG evaluation |
| 📫 Best way to reach me | [LinkedIn](https://www.linkedin.com/in/abhyudayyy/) or [Email](mailto:abhyudaymishra2004@gmail.com) |

</details>

---

## <a id="featured-project"></a>🚀 Featured project: Vaultly

<div align="center">
  <a href="https://github.com/im-abhyuday/Vaultly">
    <img alt="Vaultly repo card" src="https://github-readme-stats.vercel.app/api/pin/?username=im-abhyuday&repo=Vaultly&theme=tokyonight&hide_border=true" />
  </a>
</div>

**Vaultly** is a production-style, multi-tenant Retrieval-Augmented Generation platform. Most RAG demos have no tenant isolation, no evaluation and no cost tracking, so they can't be trusted in production. Vaultly is built to fix exactly that.

| Area | What it does |
|---|---|
| 🔐 **Isolation** | Forced PostgreSQL Row-Level Security, a least-privilege runtime DB role, composite foreign keys |
| 🪪 **Auth** | JWT access tokens, rotating refresh tokens with reuse detection, role-based access control |
| 📨 **Ingestion** | Kafka pipeline with transactional outbox, idempotent consumers and dead-letter queues |
| 🔎 **Retrieval** | Hybrid search (pgvector + full-text, RRF) with reranking, permission-aware at query time |
| 📏 **Evaluation** | recall@k, MRR, faithfulness scoring and config-by-config comparison |

<details>
<summary><b>🏗️ Target architecture (click to expand)</b></summary>
<br/>

```mermaid
flowchart LR
    C[Client] -->|JWT| API[FastAPI]
    API -->|tenant context + RLS| PG[(PostgreSQL + pgvector)]
    API -->|outbox event, same transaction| PG
    PG -->|outbox relay| K{{Kafka / Redpanda}}
    K --> W[Workers: parse, chunk, embed]
    W -->|chunks + vectors| PG
    API -.->|semantic cache, planned| R[(Redis)]
    API -.->|answers with citations| L[LLM]
```

</details>

<details>
<summary><b>🔐 How tenant isolation works (click to expand)</b></summary>
<br/>


1. **Every tenant-scoped table has `tenant_id`** and `FORCE ROW LEVEL SECURITY`, so even the table owner is filtered.
2. **The API connects as a separate low-privilege role** (not a superuser, no `BYPASSRLS`), because superusers silently skip RLS.
3. **The tenant is set per transaction** with `set_config(..., true)`, so it can never leak between pooled connections.
4. **No tenant context means zero rows**: the policy fails closed.
5. **Composite foreign keys** make cross-tenant links impossible at the schema level.
6. **Cross-tenant IDs return 404, not 403**, so existence is not revealed.
7. **A CI meta-test fails** if any new table with a `tenant_id` forgets RLS.

</details>

<details>
<summary><b>🗺️ Roadmap and progress (click to expand)</b></summary>
<br/>

- [x] **Phase 0**: scaffold, Docker Compose, FastAPI, Alembic, CI
- [x] **Phase 1**: auth, multi-tenancy, RBAC, forced RLS, isolation tests
- [ ] **Phase 2** 🚧: document upload and Kafka ingestion pipeline
- [ ] **Phase 3**: hybrid retrieval, reranking, answers with citations
- [ ] **Phase 4**: Redis semantic cache and rate limiting
- [ ] **Phase 5**: per-tenant usage and cost tracking
- [ ] **Phase 6**: evaluation module and ablation runs
- [ ] **Phase 7**: React frontend
- [ ] **Phase 8**: load testing, observability, final docs

<!-- TODO: tick boxes as you finish phases, and add real numbers once measured -->

</details>

---

## <a id="tech-stack"></a>🛠️ Tech stack

<div align="center">
  <a href="https://github.com/im-abhyuday?tab=repositories">
    <img alt="Tech icons" src="https://skillicons.dev/icons?i=py,fastapi,django,react,ts,docker,postgres,redis,kafka,git,github,vscode&perline=6" />
  </a>
  <br/><br/>
  <a href="https://xgboost.readthedocs.io"><img alt="XGBoost" src="https://img.shields.io/badge/XGBoost-EC6C00?style=for-the-badge" /></a>
  <a href="https://shap.readthedocs.io"><img alt="SHAP" src="https://img.shields.io/badge/SHAP-6A5ACD?style=for-the-badge" /></a>
  <a href="https://www.sqlalchemy.org"><img alt="SQLAlchemy" src="https://img.shields.io/badge/SQLAlchemy-D71F00?style=for-the-badge" /></a>
  <a href="https://github.com/pgvector/pgvector"><img alt="pgvector" src="https://img.shields.io/badge/pgvector-336791?style=for-the-badge" /></a>
  <a href="https://streamlit.io"><img alt="Streamlit" src="https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge" /></a>
  <a href="https://redpanda.com"><img alt="Redpanda" src="https://img.shields.io/badge/Redpanda-E2401B?style=for-the-badge" /></a>
</div>

<details>
<summary><b>🧩 Skills by area (click to expand)</b></summary>
<br/>

| Area | Tools |
|---|---|
| **Languages** | Python, SQL, TypeScript |
| **Backend** | FastAPI, Django, SQLAlchemy (async), Pydantic, Alembic |
| **Data & messaging** | PostgreSQL, pgvector, Redis, Kafka / Redpanda |
| **AI / ML** | RAG, embeddings, rerankers, LLM APIs, XGBoost, SHAP |
| **Security** | OAuth2, JWT, RBAC, Row-Level Security |
| **DevOps** | Docker, Docker Compose, GitHub Actions, pytest, Ruff, mypy |
| **Frontend** | React, Vite, Streamlit |

</details>

---

## <a id="github-stats"></a>📊 GitHub stats

<div align="center">
  <img height="170" alt="GitHub stats" src="https://github-readme-stats.vercel.app/api?username=im-abhyuday&show_icons=true&theme=tokyonight&hide_border=true" />
  <img height="170" alt="Top languages" src="https://github-readme-stats.vercel.app/api/top-langs/?username=im-abhyuday&layout=compact&theme=tokyonight&hide_border=true" />
  <br/>
  <img alt="Streak stats" src="https://streak-stats.demolab.com?user=im-abhyuday&theme=tokyonight&hide_border=true" />
</div>

<details>
<summary><b>📈 Contribution activity graph (click to expand)</b></summary>
<br/>

<div align="center">
  <img alt="Contribution graph" src="https://github-readme-activity-graph.vercel.app/graph?username=im-abhyuday&theme=tokyo-night&hide_border=true" />
</div>

</details>

<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/im-abhyuday/im-abhyuday/output/github-snake-dark.svg" />
    <img alt="Contribution snake" src="https://raw.githubusercontent.com/im-abhyuday/im-abhyuday/output/github-snake.svg" />
  </picture>
</div>

---

## <a id="lets-connect"></a>🤝 Let's connect

<div align="center">

<a href="https://www.linkedin.com/in/abhyudayyy/"><img alt="LinkedIn" src="https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" /></a>
<a href="mailto:abhyudaymishra2004@gmail.com"><img alt="Email" src="https://img.shields.io/badge/Email-Say_hello-EA4335?style=for-the-badge&logo=gmail&logoColor=white" /></a>
<a href="https://github.com/im-abhyuday/Resume"><img alt="Resume" src="https://img.shields.io/badge/Resume-View-2ea44f?style=for-the-badge" /></a>
<a href="https://github.com/im-abhyuday/Vaultly"><img alt="Vaultly" src="https://img.shields.io/badge/Vaultly-See_the_project-2F81F7?style=for-the-badge&logo=github&logoColor=white" /></a>

<br/><br/>

<i>If you're hiring for backend or GenAI roles, I'd love to talk. ⭐ a repo if you like what you see.</i>

<br/><br/>

<img width="100%" alt="footer" src="https://capsule-render.vercel.app/api?type=waving&color=0:2f81f7,100:0d1117&height=100&section=footer" />

</div>
