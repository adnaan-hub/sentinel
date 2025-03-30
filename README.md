# Sentinel | Terminal-Based AI Agent for PubMed Search

This application is a terminal-based AI agent that:

- Accepts a natural language search query from the user.
- Uses a local phi3.5 model (via Ollama and phidata) to generate a research purpose and a detailed MeSH search strategy.
- Executes the search on PubMed using a free API (via Entrez from Biopython).
- Retrieves the top 250 relevant articles, sorted by relevance and publication year.
- Stores the search results and metadata in a relational SQL database.
- Allows the user to export the search results and metadata to an Excel file with two tabs.

## File Structure

```plaintext
sentinel/
├── src/
│   ├── __init__.py
│   ├── agent.py
│   ├── config.py
│   └── utils/
│       ├── __init__.py
│       ├── xlsx_export.py
│       ├── database.py
│       ├── extract_values.py
│       └── pubmed_search.py
├── tests/
│   ├── __init__.py
│   └── test_pubmed_search.py
├── main.py
├── requirements.txt
└── setup.sh
```

## Requirements

The application uses the following Python packages:

- phidata
- ollama
- sqlalchemy
- requests
- biopython
- openpyxl
- pandas
- python-dotenv

Setup virtual Python environment and install all dependencies with:

```bash
./setup.sh
```

## Configuration

Create a `.env` file (make a copy of `.env.example`) in the project root with your configuration. For example:

```dotenv
# .env file
ENTREZ_EMAIL=your.email@example.com
PUBMED_API_KEY=your_pubmed_api_key
MODEL_ID=phi3.5
```

## Usage

Run the application from the terminal:

```bash
python main.py --query "efficacy of placebo injections in knee osteoarthritis patients between 2000 and 2025" --export
```

- If `--query` is not provided, you will be prompted to enter it interactively.
- Optionally specify `--min_year` and `--max_year` for the publication date range (defaults to the last 5 years).
- The `--export` flag will export the results to an Excel file (`output.xlsx`).

## Example Output

See the below example for running a custom query:

```bash
python main.py
Using PubMed API key for enhanced rate limits.
Enter your search query: efficacy of placebo injections in knee osteoarthritis patients
2025-03-28 20:58:24,835 [WARNING] No date range found in the query. Using default values: 2020 to 2025
2025-03-28 20:58:33,472 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-28 20:58:33,834 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-28 20:58:41,921 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-28 20:58:42,270 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-28 20:58:42,272 [INFO] To assess whether placebo injections offer measurable improvements beyond psychological effects on physical health outcomes such as pain management and functional mobility among adults suffering from knee osteoarthritis, this study will evaluate their efficacy.
2025-03-28 20:59:02,339 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-28 20:59:02,680 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-28 20:59:07,426 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-28 20:59:07,777 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-28 20:59:07,778 [INFO] (osteoarthritis knee) AND ((placebo injection treatment) AND (pain relief OR analgesia OR symptom improvement)) AND (functionality OR mobility)
2025-03-28 20:59:07,778 [INFO] Executing PubMed search...
Final query for PubMed: (osteoarthritis knee) AND ((placebo injection treatment) AND (pain relief OR analgesia OR symptom improvement)) AND (functionality OR mobility) AND "2020/01/01"[dp] : "2025/12/31"[dp]
Found 74 PubMed IDs
2025-03-28 20:59:19,417 [INFO] Retrieved 74 search results
2025-03-28 20:59:19,460 [INFO] Data stored successfully in the database.
```

With custom non-default date in query:

```bash
python main.py
Using PubMed API key for enhanced rate limits.
Enter your search query: efficacy of placebo injections in knee osteoarthritis patients between 2000 and 2025
2025-03-29 22:04:53,730 [INFO] Extracted date range from query: 2000 to 2025
2025-03-29 22:05:18,730 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:05:19,094 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:05:23,616 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:05:23,929 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:05:23,931 [INFO] To assess how placebo injections impact pain perception and functional ability among knee osteoarthritis patients, distinguishing between actual pharmacological treatment effects versus perceived benefits from belief alone.
2025-03-29 22:05:40,470 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:05:40,790 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:05:45,990 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:05:46,311 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:05:53,900 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:05:54,226 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:05:54,228 [INFO] (knee AND osteoarthritis) AND (placebo injection OR sham treatment) AND (pain relief OR symptom improvement OR functional ability)
2025-03-29 22:05:54,228 [INFO] Executing PubMed search...
Final query for PubMed: (knee AND osteoarthritis) AND (placebo injection OR sham treatment) AND (pain relief OR symptom improvement OR functional ability) AND "2000/01/01"[dp] : "2025/12/31"[dp]
Found 250 PubMed IDs
2025-03-29 22:06:02,573 [INFO] Retrieved 248 search results
2025-03-29 22:06:02,650 [INFO] Data stored successfully in the database.
```

With more general outcome criteria (efficacy instead of specific outcomes e.g., pain relief):

```bash
python main.py --export
Using PubMed API key for enhanced rate limits.
Enter your search query: efficacy of placebo injections in knee osteoarthritis patients
2025-03-29 22:20:14,741 [WARNING] No date range found in the query. Using default values: 2020 to 2025
2025-03-29 22:20:25,772 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:20:26,133 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:20:30,568 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:20:30,899 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:20:30,900 [INFO] To evaluate the effectiveness of placebo injections compared to standard medical treatments for alleviating pain and enhancing mobility among patients with knee osteoarthritis.
2025-03-29 22:21:12,265 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:21:12,601 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:21:18,577 [INFO] HTTP Request: POST http://127.0.0.1:11434/api/chat "HTTP/1.1 200 OK"
2025-03-29 22:21:18,903 [INFO] HTTP Request: POST https://api.phidata.com/v1/telemetry/agent/run/create "HTTP/1.1 200 OK"
2025-03-29 22:21:18,904 [INFO] (ostearthritis OR osteoarthritis) AND knee AND (placebo treatment OR sham injection) AND (effectiveness OR efficacy OR outcome)
2025-03-29 22:21:18,904 [INFO] Executing PubMed search...
Final query for PubMed: (ostearthritis OR osteoarthritis) AND knee AND (placebo treatment OR sham injection) AND (effectiveness OR efficacy OR outcome) AND "2020/01/01"[dp] : "2025/12/31"[dp]
Found 250 PubMed IDs
2025-03-29 22:21:27,628 [INFO] Retrieved 250 search results
2025-03-29 22:21:27,667 [INFO] Data stored successfully in the database.
2025-03-29 22:21:27,769 [INFO] Data exported successfully to output.xlsx
```

## License

This project is released under the MIT License.
