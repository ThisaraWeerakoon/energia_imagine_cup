# from flask import Flask, request

# app = Flask(__name__)

# @app.route('/api/data', methods=['POST'])
# def receive_data():
#     data = request.get_json()

#     # Process the received data as needed
#     time = data['time']
#     fridge = data['fridge']
#     washing_machine = data['washing_machine']
#     kettle = data['kettle']
#     rice_coocker = data['rice_coocker']

#     # Example: print the received data
#     print(f"Received Data - Time: {time}, fride: {fridge}, washing machine: {washing_machine}, kettle: {kettle}, rice coocker: {rice_coocker}")

#     # Add your own processing logic here

#     return {'status': 'success'}

# if __name__ == '__main__':
#     app.run(debug=True)

# from flask import Flask, request
# from azure.cosmos import CosmosClient

# app = Flask(__name__)

# # Cosmos DB configurations
# cosmosdb_endpoint = 'https://energia.documents.azure.com:443/'
# cosmosdb_key = 'bDy0LsJ9eSjmvcMn67mnIRMAvCWvwDxJWVVQzSZjSopbi5UBAKzNZ5qVUWIjpr3OywvUPGgBrogWACDbHiz3rg======'
# cosmosdb_database_name = 'power_telemetry'
# cosmosdb_container_name = 'device_1'

# # Initialize Cosmos DB client
# client = CosmosClient(cosmosdb_endpoint, cosmosdb_key)
# database = client.get_database_client(cosmosdb_database_name)
# container = database.get_container_client(cosmosdb_container_name)

# @app.route('/api/data', methods=['POST'])
# def receive_data():
#     data = request.get_json()

#     # Process the received data as needed
#     # timestamp = data['timestamp']
#     # received_data = data['data']

#     # Example: print the received data
#     time = data['time']
#     fridge = data['fridge']
#     washing_machine = data['washing_machine']
#     kettle = data['kettle']
#     rice_coocker = data['rice_coocker']

#     # Add your own processing logic here

#     # Save data to Cosmos DB
#     item = {
#         'id': str(timestamp),

#     }
#     container.create_item(item)

#     return {'status': 'success'}

# if __name__ == '__main__':
#     app.run(debug=True)


# from flask import Flask, request
# from azure.cosmos import CosmosClient

# app = Flask(__name__)

# # Cosmos DB configurations
# cosmosdb_endpoint = 'https://energia.documents.azure.com:443/'
# cosmosdb_key = 'bDy0LsJ9eSjmvcMn67mnIRMAvCWvwDxJWVVQzSZjSopbi5UBAKzNZ5qVUWIjpr3OywvUPGgBrogWACDbHiz3rg======'
# cosmosdb_database_name = 'power_telemetry'
# # Define container names for each endpoint
# container_names = {
#     '/api/data1': 'device_1',
#     '/api/data2': 'device_2',
#     '/api/data3': 'device_3',
#     '/api/data4': 'device_4'
# }

# # Initialize Cosmos DB client
# client = CosmosClient(cosmosdb_endpoint, cosmosdb_key)
# database = client.get_database_client(cosmosdb_database_name)

# # Create container clients for each container
# container_clients = {}
# for endpoint, container_name in container_names.items():
#     container_clients[endpoint] = database.get_container_client(container_name)

# @app.route('/api/data1', methods=['POST'])
# @app.route('/api/data2', methods=['POST'])
# @app.route('/api/data3', methods=['POST'])
# @app.route('/api/data4', methods=['POST'])
# def receive_data():
#     endpoint = request.path  # Get the endpoint from the request path
#     container_client = container_clients.get(endpoint)

#     if container_client is None:
#         return {'error': 'Invalid endpoint'}, 400

#     data = request.get_json()

#     # Process the received data as needed
#     time = data['time']
#     fridge = data['fridge']
#     washing_machine = data['washing_machine']
#     kettle = data['kettle']
#     rice_coocker = data['rice_coocker']

#     # Example: print the received data
#     print(f"Received Data - Time: {time}, fride: {fridge}, washing_machine: {washing_machine}, kettle: {kettle}, rice coocker: {rice_coocker}")

#     # Save data to Cosmos DB
#     item = {
#         'id': time,
#         'fride': fridge,
#         'washing_machine': washing_machine,
#         'kettle': kettle,
#         'rice_coocker': rice_coocker
#     }
#     container_client.create_item(item)

#     return {'status': 'success'}

# if __name__ == '__main__':
#     app.run(debug=True)

from flask import Flask, jsonify
from azure.cosmos import CosmosClient
import csv
import threading
import time
import uuid  # Import the uuid module

app = Flask(__name__)

# Your existing Cosmos DB configurations and container initialization here...
# # Cosmos DB configurations
cosmosdb_endpoint = 'https://energia.documents.azure.com:443/'
cosmosdb_key = 'bDy0LsJ9eSjmvcMn67mnIRMAvCWvwDxJWVVQzSZjSopbi5UBAKzNZ5qVUWIjpr3OywvUPGgBrogWACDbHiz3rg======'
cosmosdb_database_name = 'power_telemetry'

# container_clients=['device_1', 'device_2', 'device_3', 'device_4']

container_clients = {'fridge': 'device_1', 'washing_machine': 'device_2', 'kettle': 'device_3', 'rice_cooker': 'device_4'}
# Path to the CSV file
csv_file_path = 'energy_data.csv'

# # Initialize Cosmos DB client
client = CosmosClient(cosmosdb_endpoint, cosmosdb_key)
database = client.get_database_client(cosmosdb_database_name)
# container = database.get_container_client(cosmosdb_container_name)

def read_csv_and_send_to_cosmos():
    while True:
        with open(csv_file_path, 'r') as csv_file:
            csv_reader = csv.DictReader(csv_file)
            for row in csv_reader:
                timestamp = row['time']

                # Iterate over each column and send data to the corresponding container
                for column_name, container_client in container_clients.items():
                    if column_name in row:
                        item = {
                            'id': str(uuid.uuid4()),  # Generate a random UUID for 'id'
                            'time': timestamp,
                            'data': row[column_name]
                        }
                        database.get_container_client(container_client).create_item(item)
                        # print(f"Sent data to {container_client} - Id: {item['id']}, Time: {item['time']}, Data: {item['data']}")

        # Sleep for a specified interval (e.g., 1 hour)
        time.sleep(6000)

# Start the thread for periodic CSV reading and Cosmos DB updates
csv_thread = threading.Thread(target=read_csv_and_send_to_cosmos)
csv_thread.daemon = True
csv_thread.start()

# @app.route('/api/data1', methods=['POST'])
# @app.route('/api/data2', methods=['POST'])
# @app.route('/api/data3', methods=['POST'])
# @app.route('/api/data4', methods=['POST'])
# def receive_data():
#     # Your existing endpoint handling logic here...

@app.route('/')
def welcome():
    return 'Welcome to the Power Telemetry API'


@app.route('/appliances/<device_name>', methods=['GET'])
def index(device_name):
    try:
        print("getData")
        # Get the container client
        container_client = database.get_container_client(device_name)

        # Query all items in the container
        items = list(container_client.query_items(
            query="SELECT * FROM c",
            enable_cross_partition_query=True
        ))

        print('items found')
        
        # Check if any items were retrieved
        if not items:
            return jsonify({"error": "No items found in the container"}), 404

        json_data = []
        for i in range(500, 511):
            item = items[i]
            
            # print(f'item: {item}')
            if 'timestamp' not in item:
                # return jsonify({"error": "Missing 'timestamp' or 'data' field in the document"}), 500
                print('Missing timestamp in the document')
                continue

            if 'data' not in item:
                # return jsonify({"error": "Missing 'data' field in the document"}), 500
                print('Missing data field in the document')
                continue

            if 'time' not in item:
                # return jsonify({"error": "Missing 'timestamp' or 'data' field in the document"}), 500
                print('Missing time in the document')
                continue

            print(item['time'])

            json_file = {
                'date': item['time'],
                'data': item['data']
            }
            print(f'json_file: {json_file}')
            json_data.append(json_file)

        # Return the items as JSON
        return jsonify(json_data)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/delete_items/<container_name>', methods=['DELETE'])
def delete_items(container_name):
    try:
        print("delete_items")
        # Get the container client
        container_client = database.get_container_client(container_clients.get(container_name))

        # Query all items in the container
        items = list(container_client.query_items(
            query="SELECT * FROM c",
            enable_cross_partition_query=True
        ))

        # Delete each item in the container
        for item in items:
            container_client.delete_item(item, partition_key=item['id'])

        return jsonify({"message": f"All items in container {container_name} deleted successfully"})
        
    except Exception as e:
        return jsonify({"error": str(e)}), 500



if __name__ == '__main__':
    app.run(debug=True)


