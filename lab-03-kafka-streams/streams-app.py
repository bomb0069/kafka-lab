from kafka import KafkaConsumer, KafkaProducer

consumer = KafkaConsumer('input-topic', bootstrap_servers='kafka:9092', auto_offset_reset='earliest')
producer = KafkaProducer(bootstrap_servers='kafka:9092')

for message in consumer:
    uppercased = message.value.decode('utf-8').upper()
    producer.send('output-topic', uppercased.encode('utf-8'))
    print(f"Processed: {uppercased}")
