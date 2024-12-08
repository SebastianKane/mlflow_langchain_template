# LangChain + MLflow Template Project

This template sets up a Python environment to develop and track experiments using [LangChain](https://docs.langchain.com/) and [MLflow](https://mlflow.org/docs/latest/index.html).

## Overview

- **LangChain:** A framework for building applications with language models.  
- **MLflow:** A platform for managing the end-to-end machine learning lifecycle, including experiment tracking, model packaging, and deployment.

This template uses the latest recommended practices from both LangChain and MLflow documentation.

### Features

1. **Environment Management:**  
   - `.env_template` provided; copy it to `.env` and add your API keys and environment variables.
   
2. **LangChain Integration:**  
   - Easily integrate any LLM (e.g., OpenAI) using your API keys and environment variables.
   - Add custom Chains, Tools, and Agents in the `src` directory.
   
3. **MLflow Experiment Tracking:**  
   - Log parameters, metrics, and artifacts.
   - Manage different experiments by changing `MLFLOW_EXPERIMENT_NAME` in `.env`.

### Getting Started

1. **Clone the repository:**
```bash
 git clone https://github.com/SebastianKane/mlflow_langchain_template.git
 ```

### Run init.sh
```bash
cd mlflow_lanchain_template
sh init.sh
```