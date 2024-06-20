from flask import Flask, request, jsonify
import os
from openai import OpenAI
app = Flask(__name__)

# Remplace 'your-openai-api-key' par ta clé API d'OpenAI.

os.environ["OPENAI_API_KEY"] = ""

# Initialize the Language Model
client = OpenAI()


# Function to interact with the agent
def ask_agent(context, question):
    # Ajouter la question de l'utilisateur au contexte
    print(context)
    context.append({"role": "user", "content": question})
    
    response = client.chat.completions.create(
        model="gpt-3.5-turbo-0125",
        messages=context
    )
    
    # Récupérer la réponse de l'agent
    answer = response.choices[0].message.content
    
    # Ajouter la réponse de l'agent au contexte
    context.append({"role": "assistant", "content": answer})
    
    print(answer)
    return answer

# Example usage
context = [
    {"role": "system", "content": "You are a NPC in a fantasy game, you are a blacksmith, you lost your hammer on a volcano, you speak French. Your name is Erik"}
]
#question = "How can I build an agent using LangChain?"

@app.route('/generate', methods=['POST'])
def generate():
    try:
        data = request.json
        prompt = data.get('prompt')
        
        if not prompt:
            return jsonify({'error': 'Le champ "prompt" est requis.'}), 400

        response = ask_agent(context, prompt)

        return jsonify(response)

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/')
def home():
    return "Bienvenue sur le serveur GPT de test. Utilise le point de terminaison /generate pour générer du texte."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
