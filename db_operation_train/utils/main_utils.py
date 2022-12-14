from datetime import datetime
from shutil import rmtree

from s3_operations import S3_Operation
from utils.logger import App_Logger
from utils.read_params import get_log_dic, read_params


class Main_Utils:
    """
    Description :   This class is used for main utility functions required in core functions of the service
    Version     :   1.2
    
    Revisions   :   Moved to setup to cloud 
    """

    def __init__(self):
        self.s3 = S3_Operation()

        self.log_writer = App_Logger()

        self.config = read_params()

        self.current_date = f"{datetime.now().strftime('%Y-%m-%d')}"

        self.log_dir = self.config["dir"]["log"]

        self.files = self.config["files"]

        self.mongodb_config = self.config["mongodb"]

    def upload_logs(self):
        """
        Method Name :   upload_logs
        Description :   This method uploads the logs folder to s3 bucket
        
        Output      :   The logs are uploaded to s3 bucket
        On Failure  :   Write an exception log and then raise an exception
        
        Version     :   1.2
        Revisions   :   moved setup to cloud
        """
        log_dic = get_log_dic(
            self.__class__.__name__, self.upload_logs.__name__, __file__, "upload"
        )

        self.log_writer.start_log("start", **log_dic)

        try:
            log_folder = "/tmp" + "/" + self.log_dir

            self.s3.upload_folder(self.log_dir, "logs", log_dic["log_file"])

            self.log_writer.log(f"Uploaded logs to logs bucket", **log_dic)

            self.log_writer.start_log("exit", **log_dic)

            self.log_writer.stop_log()

            rmtree(log_folder)

        except Exception as e:
            self.log_writer.exception_log(e, **log_dic)

    def get_file_with_timestamp(self, file, log_file):
        """
        Method Name :   get_file_with_timestamp
        Description :   This method gets the file name with current time stamp
        
        Output      :   The filename is returned based on the current time stamp
        On Failure  :   Write an exception log and then raise an exception
        
        Version     :   1.2
        Revisions   :   moved setup to cloud
        """
        log_dic = get_log_dic(
            self.__class__.__name__,
            self.get_file_with_timestamp.__name__,
            __file__,
            log_file,
        )

        self.log_writer.start_log("start", **log_dic)

        try:
            file = "/tmp" + "/" + self.current_date + "-" + self.files[file]

            self.log_writer.log("Got file name with date time stamp", **log_dic)

            self.log_writer.start_log("exit", **log_dic)

            return file

        except Exception as e:
            self.log_writer.exception_log(e, **log_dic)

    def get_collection_with_timestamp(self, collection_name, log_file):
        """
        Method Name :   get_collection_with_timestamp
        Description :   This method gets the collection name with current time stamp
        
        Output      :   The collection name is returned based on the current time stmap
        On Failure  :   Write an exception log and then raise an exception
        
        Version     :   1.2
        Revisions   :   moved setup to cloud
        """
        log_dic = get_log_dic(
            self.__class__.__name__,
            self.get_collection_with_timestamp.__name__,
            __file__,
            log_file,
        )

        self.log_writer.start_log("start", **log_dic)

        try:
            current_collection_name = (
                self.current_date + "-" + self.mongodb_config[collection_name]
            )

            self.log_writer.log(
                "Got collection name with current time stamp", **log_dic
            )

            self.log_writer.start_log("exit", **log_dic)

            return current_collection_name

        except Exception as e:
            self.log_writer.exception_log(e, **log_dic)
