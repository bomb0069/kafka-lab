# Lab 01: Kafka Basics

In this lab, you will start Kafka and Zookeeper using Docker Compose, create a topic, and send/receive messages using command-line tools.

## Prerequisites

- Docker and Docker Compose installed (no Kafka installation needed)

## Understanding the Docker Compose File

Before we start, let's understand what's in our `docker-compose.yml` file and why each part is necessary:

```yaml
services:
  zookeeper:
    image: bitnami/zookeeper:3.8
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes
    ports:
      - "2181:2181"
  kafka:
    image: bitnami/kafka:3.4
    environment:
      - KAFKA_BROKER_ID=1
      - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
      - KAFKA_CFG_LISTENERS=PLAINTEXT://:9092
      - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
      - ALLOW_PLAINTEXT_LISTENER=yes
    ports:
      - "9092:9092"
    depends_on:
      - zookeeper
```

### Explanation:

**Zookeeper Service:**

- `image: bitnami/zookeeper:3.8` - Uses a stable Zookeeper version for cluster coordination
- `ALLOW_ANONYMOUS_LOGIN=yes` - Allows connection without authentication (for learning purposes)
- `ports: "2181:2181"` - Exposes Zookeeper's default port for client connections

**Kafka Service:**

- `image: bitnami/kafka:3.4` - Uses a stable Kafka version compatible with Zookeeper
- `KAFKA_BROKER_ID=1` - Unique identifier for this Kafka broker in the cluster
- `KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181` - Tells Kafka how to connect to Zookeeper
- `KAFKA_CFG_LISTENERS=PLAINTEXT://:9092` - Configures Kafka to listen on port 9092
- `KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092` - How clients should connect to Kafka
- `ALLOW_PLAINTEXT_LISTENER=yes` - Enables unencrypted connections (for learning)
- `ports: "9092:9092"` - Exposes Kafka's port to the host machine
- `depends_on: zookeeper` - Ensures Zookeeper starts before Kafka

### Why do we need both Zookeeper and Kafka?

**Zookeeper's Role:**

- **Cluster Management**: Keeps track of which Kafka brokers are alive and available
- **Configuration Storage**: Stores metadata about topics, partitions, and broker configurations
- **Leader Election**: Helps elect partition leaders when brokers fail or restart
- **Synchronization**: Ensures consistency across the Kafka cluster

**Kafka's Role:**

- **Message Storage**: Stores and manages the actual message data
- **Producer/Consumer API**: Handles incoming messages from producers and serves them to consumers
- **Partition Management**: Manages data distribution across partitions for scalability

**Startup Process:**

1. Zookeeper starts first and creates its coordination services
2. Kafka starts and registers itself with Zookeeper
3. Kafka creates internal topics for coordination
4. The cluster is ready to accept topics, producers, and consumers

## Steps

### 1. Start Kafka and Zookeeper

Run the following command in this directory:

```sh
docker compose up -d
```

### 2. Create a Kafka Topic

```sh
docker exec lab-01-kafka-basics-kafka-1 kafka-topics.sh --create --topic test-topic --bootstrap-server localhost:9092
```

### 3. Send Messages (Producer)

```sh
docker exec -it lab-01-kafka-basics-kafka-1 kafka-console-producer.sh --topic test-topic --bootstrap-server localhost:9092
```

Type a few messages and press Enter after each. Press Ctrl+C to exit.

**Alternative: Send a message from a file:**

```sh
echo "Hello Kafka!" | docker exec -i lab-01-kafka-basics-kafka-1 kafka-console-producer.sh --topic test-topic --bootstrap-server localhost:9092
```

### 4. Receive Messages (Consumer)

Open a new terminal and run:

```sh
docker exec -it lab-01-kafka-basics-kafka-1 kafka-console-consumer.sh --topic test-topic --bootstrap-server localhost:9092 --from-beginning
```

**Alternative: Read a limited number of messages:**

```sh
docker exec lab-01-kafka-basics-kafka-1 kafka-console-consumer.sh --topic test-topic --bootstrap-server localhost:9092 --from-beginning --max-messages 5
```

You should see the messages you sent in step 3.

---

## Clean Up

To stop and remove containers:

```sh
docker compose down
```
