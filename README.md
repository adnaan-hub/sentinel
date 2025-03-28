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
├── main.py
├── ai_engine.py
├── pubmed_search.py
├── database.py
├── csv_export.py
├── requirements.txt
├── .env
└── README.md
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
python main.py --query "I want the most relevant retrospective articles for knee osteoarthritis patients treated with placebo between 2000 and 2025" --export
```

- If `--query` is not provided, you will be prompted to enter it interactively.
- Optionally specify `--min_year` and `--max_year` for the publication date range (defaults to the last 5 years).
- The `--export` flag will export the results to an Excel file (`output.xlsx`).

## License

This project is released under the MIT License.
