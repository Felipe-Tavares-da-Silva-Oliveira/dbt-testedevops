from flask import Flask, jsonify
from subprocess import check_output
import os

app = Flask(__name__)

@app.route('/')
def health_check():
    print("dbt: health check ok")
    return jsonify({"status":"ok"})

@app.route('/dbt-run')
def dbt_run():
    print("dbt: received a request")
    #subprocess.run(["/bin/sh", "/dbt/script.sh"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
    #return jsonify({"execucaoDbt":"ok"})
    stdout = check_output(['/bin/sh', '/dbt/script.sh']).decode('utf-8')
    return stdout

if __name__ == 'main':
    port = int(os.environ.get('PORT', 8080))
    print(f"dbt: listening on port {port}")
    app.run(host='0.0.0.0', port=port)