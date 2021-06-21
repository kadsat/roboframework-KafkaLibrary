*** Settings ***
Documentation  Testing Kafka
Library    BuiltIn
Library    Screenshot
Library    KafkaLibrary
*** Test Cases ***
Testing Kafka topic
    [Documentation]  Trying to connect to the Kafka topic as a consumer client and deriving messages
    [Tags]  smoke
    #zookeeper-server-start -daemon /usr/local/etc/kafka/zookeeper.properties
    #kafka-server-start /usr/local/etc/kafka/server.properties
    #kafka-topics --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
    #kafka-console-producer --broker-list localhost:9092 --topic test
    #kafka-console-consumer --bootstrap-server localhost:9092 --topic test --from-beginning
    Log    Let's Go
    Connect To Kafka    bootstrap_servers=localhost:9092    client_id=robot
    ${topics} =    Get Kafka Topics
    Log    ${topics}
    #Need to get the topic name in string from the topics list
    #Need to obtain the parition# by using Get Topic Partition keyword
    ${partition} =  Create Topicpartition  test  ${0}
    Log    ${partition}
    ${num_of_msg} =    Get Number Of Messages In Topicpartition    ${partition}
    Log    ${num_of_msg}
    Assign To Topic Partition    ${partition}
    Seek To Beginning    ${partition}
    ${messages}=  Poll  max_records=${10}  timeout_ms=${500}
    Log    ${messages}