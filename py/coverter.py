import tensorflow as tf


def h5ToTflite(file_name):
    new_model = tf.keras.models.load_model(filepath="{}.h5".format(file_name))
    tflite_converter = tf.lite.TFLiteConverter.from_keras_model(new_model)
    tflite_model = tflite_converter.convert()
    open("{}.tflite".format(file_name), "wb").write(tflite_model)
