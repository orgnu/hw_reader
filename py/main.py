import cv2
import os
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()

# x_train = tf.keras.utils.normalize(x_train, axis=1)
# x_test = tf.keras.utils.normalize(x_test, axis=1)


# model = tf.keras.models.Sequential()
# model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
# model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
# model.add(tf.keras.layers.Dropout(0.2))
# model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
# model.add(tf.keras.layers.Dropout(0.2))
# model.add(tf.keras.layers.Dense(10, activation=tf.nn.softmax))

# model.compile(optimizer='adam',
#               loss='sparse_categorical_crossentropy', metrics=['accuracy'])

# model.fit(x_train, y_train, epochs=3)

model = tf.keras.models.load_model('handwritten.model')

# # loss, acc = model.evaluate(x_test, y_test)

# # print(loss, acc)  # 0.0984 0.9698

# print(x_test.shape)


# for i in range(0, 10):
#     print(np.argmax(model.predict(x_test)[i]))
#     plt.imshow(x_test[i], cmap=plt.cm.binary)
#     plt.show()


# # img = x_test[6:28:28]
# # prediction = model.predict(img)
# # print(np.argmax(prediction))
# # img.shape = (28, 28)
# # plt.imshow(img, cmap=plt.cm.binary)
# # plt.show()


img_number = 1
while os.path.isfile('images/{}.png'.format(img_number)):
    try:
        img = cv2.imread('images/{}.png'.format(img_number))[:, :, 0]
        img = np.reshape(img, (1, 28, 28))
        prediction = model.predict(img)
        # prediction(prediction)
        print(np.argmax(prediction))

        # show image
        img.shape = (28, 28)
        plt.imshow(img, cmap=plt.cm.binary)
        plt.show()
    except:
        print('error')
    finally:
        img_number += 1
