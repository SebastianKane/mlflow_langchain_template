import os
import mlflow
import mlflow.pyfunc
from dotenv import load_dotenv
from langchain.chat_models import ChatOpenAI
from langchain.chains import LLMChain
from langchain.prompts import ChatPromptTemplate

# Load environment variables
load_dotenv()
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
MLFLOW_TRACKING_URI = os.getenv("MLFLOW_TRACKING_URI", "http://127.0.0.1:5000")
MLFLOW_EXPERIMENT_NAME = os.getenv("MLFLOW_EXPERIMENT_NAME", "LangChain_Experiment")

# Set MLflow tracking URI and experiment
mlflow.set_tracking_uri(MLFLOW_TRACKING_URI)
mlflow.set_experiment(MLFLOW_EXPERIMENT_NAME)

def run_chain(prompt: str):
    # Create a ChatOpenAI model instance
    llm = ChatOpenAI(
        model_name="gpt-3.5-turbo",
        openai_api_key=OPENAI_API_KEY,
        temperature=0.7
    )

    # Define a prompt template
    template = ChatPromptTemplate.from_template(
        "You are a helpful assistant. Answer the following question: {question}"
    )

    chain = LLMChain(llm=llm, prompt=template)

    # Run the chain
    return chain.run({"question": prompt})

if __name__ == "__main__":
    prompt = "What is the capital of France?"

    with mlflow.start_run() as run:
        mlflow.log_param("prompt", prompt)
        
        result = run_chain(prompt)
        
        mlflow.log_metric("response_length", len(result))
        mlflow.log_artifact(".env_template")  # Example artifact logging
        
        print(f"Model Response: {result}")
        mlflow.set_tag("Model", "OpenAI-gpt-3.5-turbo")
        mlflow.set_tag("LangChain-Version", "0.0.320")

        # Optionally save the result to a file and log it as artifact
        with open("output.txt", "w") as f:
            f.write(result)
        mlflow.log_artifact("output.txt")
