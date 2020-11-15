#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jul 12 12:28:34 2020

@author: ankitjha
"""
import cv2
import os
import matplotlib.pyplot as plt
import numpy as np


spiral_datapath={
                "training":os.path.join('drawings/spiral/training'),
                "testing" : os.path.join('drawings/spiral/testing')
    }
wave_datapath={}

categories=os.listdir(spiral_datapath["training"])

labels=[i for i in range(len(categories))]
label_dict=dict(zip(categories,labels)) #empty dictionary

print(label_dict)
training_data=[]
training_target=[]
testing_data=[]
testing_target=[]

img_size=100

#training data
for category in categories:
    folder_path=os.path.join(spiral_datapath["training"],category)
    img_names=os.listdir(folder_path)
    
    for img_name in img_names:
        img_path=os.path.join(folder_path,img_name)
        img=cv2.imread(img_path)

        try:
            gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)           
            #Coverting the image into gray scale
            resized=cv2.resize(gray,(img_size,img_size))
            #resizing the gray scale into 50x50, since we need a fixed common size for all the images in the dataset
            training_data.append(resized)
            training_target.append(label_dict[category])
            #appending the image and the label(categorized) into the list (dataset)

        except Exception as e:
            print('Exception:',e)
            #if any exception rasied, the exception will be printed here. And pass to the next image

#Test Data
for category in categories:
    folder_path=os.path.join(spiral_datapath["testing"],category)
    img_names=os.listdir(folder_path)
    
    for img_name in img_names:
        img_path=os.path.join(folder_path,img_name)
        img=cv2.imread(img_path)

        try:
            gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)           
            #Coverting the image into gray scale
            resized=cv2.resize(gray,(img_size,img_size))
            #resizing the gray scale into 50x50, since we need a fixed common size for all the images in the dataset
            testing_data.append(resized)
            testing_target.append(label_dict[category])
            #appending the image and the label(categorized) into the list (dataset)

        except Exception as e:
            print('Exception:',e)
            #if any exception rasied, the exception will be printed here. And pass to the next image        

X_train=np.array(training_data)/255.0
y_train= np.array(training_target)
X_test= np.array(testing_data)/255.0
y_test=np.array(testing_target)

X_train.shape
X_train = X_train.reshape(X_train.shape[0], 100, 100, 1)
X_train.shape


#building the model
import tensorflow as tf

model=tf.keras.models.Sequential([
    tf.keras.layers.Conv2D(16,(3,3),activation='relu',input_shape=(100,100,1)),
    tf.keras.layers.MaxPooling2D(2,2),
    
    tf.keras.layers.Conv2D(32,(3,3),activation='relu'),
    tf.keras.layers.MaxPooling2D(2,2),
    
    tf.keras.layers.Conv2D(64,(3,3),activation='relu'),
    tf.keras.layers.MaxPooling2D(2,2),
    
    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(512,activation='relu'),
    tf.keras.layers.Dense(1,activation='sigmoid')
    ])

model.summary()


from tensorflow.keras.optimizers import RMSprop

model.compile(loss='binary_crossentropy',
              optimizer=RMSprop(lr=0.0001),
              metrics=['acc'])


history=model.fit(X_train,y_train,epochs=20,validation_split=0.2)



