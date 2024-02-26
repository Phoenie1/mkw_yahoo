import json
import datetime
import boto3 # Python SDK for AWS

s3 = boto3.client('s3')
topic = boto3.client('sns')
bucket = 'mkw-bucket-b4432'
key = 'index.html'


def write_into_s3_file(data):
    try:
        s3.put_object(
            Body=data,
            Bucket=bucket,
#            ACL='public-read-write',
            ContentType='text/html',
            Key=key)
    except Exception as err:
        print("Couldn't put object into S3 bucket: {}".format(err))


def publish_msg(message):
    """
    Publish message to the topic created using Amazon SNS
    :param message: Message to publish
    """
    try:
        resp = topic.publish(
            TargetArn="your-topic-arn",
            Message=json.dumps({'default': message}),
            MessageStructure='json')
        print("Published message successfully")
        return resp
    except Exception as error:
        print("Couldn't publish message: {}".format(error))
        return error


def lambda_handler(event, context):
    # TODO implement


    now = datetime.datetime.now()
    write_into_s3_file(now.strftime('%m-%d-%y %H:%M:%S'))


    print("Success")
    return {
        'statusCode': 200,
#        'body': json.dumps(resp)
    }
