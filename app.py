from fastapi import FastAPI
from transformers import pipeline

## new FASTAPI app instance
app = FastAPI()

#init the text generation pipiline
pipe = pipeline("text2text-generation", model="google/flan-t5-small")

@app.get("/")
def read_root():
    return {"Welcome to": "My Universe"}

#define a function that takes in a prompt and returns a generated response
@app.get("/generate")
def generate(text: str):
    ## use the pipeline to generate text from the given input text
    output=pipe(text)
    
    ## return the generated text as a JSON response
    return {"output": output[0]["generated_text"]}
    