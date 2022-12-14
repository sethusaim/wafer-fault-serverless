from json import dumps

from data_type_valid_train import DB_Operation_Train
from utils.logger import App_Logger
from utils.main_utils import Main_Utils
from utils.read_params import get_log_dic


class Run:
    """
    Description :   This class is used for running the database operation train service
    Version     :   1.2
    
    Revisions   :   Moved to setup to cloud 
    """

    def __init__(self):
        self.log_writer = App_Logger()

        self.db_operation = DB_Operation_Train()

    def train_data_type_valid(self):
        """
        Method Name :   train_data_type_valid
        Description :   This method performs the database operations on the training data

        Output      :   The database operations are performed on training data and artifacts are stored in 
                        s3 buckets
        On Failure  :   Write an exception log and then raise an exception

        Version     :   1.2
        Revisions   :   moved setup to cloud
        """
        log_dic = get_log_dic(
            self.__class__.__name__,
            self.train_data_type_valid.__name__,
            __file__,
            "db_main",
        )

        self.log_writer.start_log("start", **log_dic)

        try:
            self.log_writer.log("Data type validation operation started !!", **log_dic)

            self.db_operation.insert_good_data_as_record("db_name", "collection_name")

            self.db_operation.export_collection_to_csv("db_name", "collection_name")

            self.log_writer.log(
                "Data type validation Operation completed !!", **log_dic
            )

            self.log_writer.start_log("exit", **log_dic)

        except Exception as e:
            self.log_writer.exception_log(e, **log_dic)


def lambda_handler(event, context):
    try:
        run = Run()

        run.train_data_type_valid()

        return {
            "statusCode": 200,
            "body": dumps("Train Database Operation Function executed"),
        }

    except Exception as e:
        raise e

    finally:
        utils = Main_Utils()

        utils.upload_logs()
