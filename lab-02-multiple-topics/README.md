# Lab 02: Multiple Topics

In this lab, you will create and interact with multiple Kafka topics using Docker Compose.

## Steps

### 1. Start Kafka and Zookeeper

Run:

```sh
docker compose up -d
```

### 2. Create Multiple Topics

```sh
docker exec lab-02-multiple-topics-kafka-1 kafka-topics.sh --create --topic topic1 --bootstrap-server localhost:9092

docker exec lab-02-multiple-topics-kafka-1 kafka-topics.sh --create --topic topic2 --bootstrap-server localhost:9092
```

### 3. Verify Topics Creation

Before sending messages, let's confirm both topics were created successfully:

```sh
docker exec lab-02-multiple-topics-kafka-1 kafka-topics.sh --list --bootstrap-server localhost:9092
```

You should see both `topic1` and `topic2` in the output. You can also get detailed information about each topic:

```sh
docker exec lab-02-multiple-topics-kafka-1 kafka-topics.sh --describe --topic topic1 --bootstrap-server localhost:9092
docker exec lab-02-multiple-topics-kafka-1 kafka-topics.sh --describe --topic topic2 --bootstrap-server localhost:9092
```

### 4. Send Messages to Each Topic

Send messages to topic1:
```sh
docker exec -it lab-02-multiple-topics-kafka-1 kafka-console-producer.sh --topic topic1 --bootstrap-server localhost:9092
```

Type messages for topic1. Press Ctrl+C to exit.

**Alternative: Send a message from command line:**
```sh
echo "Message for topic1" | docker exec -i lab-02-multiple-topics-kafka-1 kafka-console-producer.sh --topic topic1 --bootstrap-server localhost:9092
```

Send messages to topic2:
```sh
docker exec -it lab-02-multiple-topics-kafka-1 kafka-console-producer.sh --topic topic2 --bootstrap-server localhost:9092
```

Type messages for topic2. Press Ctrl+C to exit.

**Alternative: Send a message from command line:**
```sh
echo "Message for topic2" | docker exec -i lab-02-multiple-topics-kafka-1 kafka-console-producer.sh --topic topic2 --bootstrap-server localhost:9092
```

### 5. Consume Messages from Each Topic

Open new terminals and consume messages from each topic:

From topic1:
```sh
docker exec -it lab-02-multiple-topics-kafka-1 kafka-console-consumer.sh --topic topic1 --bootstrap-server localhost:9092 --from-beginning
```

From topic2:
```sh
docker exec -it lab-02-multiple-topics-kafka-1 kafka-console-consumer.sh --topic topic2 --bootstrap-server localhost:9092 --from-beginning
```

**Alternative: Read a limited number of messages:**
```sh
docker exec lab-02-multiple-topics-kafka-1 kafka-console-consumer.sh --topic topic1 --bootstrap-server localhost:9092 --from-beginning --max-messages 5

docker exec lab-02-multiple-topics-kafka-1 kafka-console-consumer.sh --topic topic2 --bootstrap-server localhost:9092 --from-beginning --max-messages 5
```

You should see that messages sent to topic1 only appear when consuming from topic1, and messages sent to topic2 only appear when consuming from topic2. This demonstrates topic isolation.

---

## Clean Up

```sh
docker compose down
```
