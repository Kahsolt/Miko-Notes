# Keras是一个简单上手的深度学习框架
# 2019/03/05

零.目录结构
import keras
keras = [
  # 数据集&预处理
  datasets
  preprocessing
  
  # 模型&训练&测试
  models
    initializers
  layers
    activations
    constraints
    regularizers
  losses
  metrics
  optimizers
  
  # 著名模型应用
  applications
  
  # 工具包
  utils
  
  # 后端&引擎&其他杂项
  engine
  backend
  callbacks # used during training
  legacy
  wrappers  # wrapper for scikit_learn, etc..
]

一.数据集&预处理
import keras.datasets
datasets = [
  boston_housing
  cifar
  cifar10
  cifar100
  fashion_mnist
  imdb
  mnist
  reuters
]
import keras.preprocessing
preprocessing = [
  image
    ImageDataGenerator(
    DirectoryIterator(
    NumpyArrayIterator(
    array_to_img/img_to_array(
    load/save_img(
    random_brightnes/channel_shift/rotation/shear/shift/zoom(
  sequence
    TimeseriesGenerator(
    make_sampling_table(
    pad_sequences(
    skipgrams(
  text
    Tokenizer(
    one_hot(
    hashing_trick(
    text_to_word_sequence(
]

二.模型&训练&测试
import keras.models
models = [
  Sequential(
  Model(
  Input/InputLayer(
  model_from_config/json/yaml(
  load/save/clone_model(
]
import keras.initializers
initializers = [
  Ones/Zeros/Constant(
  Identity/Orthogonal(
  RandomNormal/RandomUniform(
  TruncatedNormal(
  VarianceScaling(
]

import keras.layers
layers = [
  core
    Dense(
    Activation(
    Flatten/Reshape(
    Dropout/SpatialDropout(  
    Masking/Permute/RepeatVector/Lambda(
    ActivityRegularization(
  advanced_activations
    ReLU/PReLU/LeakyReLU/ThresholdedReLU/ELU(
    Softmax(
  pooling
    [Global]AveragePooling
    [Global]MaxPooling
  convolutional
    Convolution[Transpose](
    AtrousConvolution(
    SeparableConvolution(
    DepthwiseConv(
    Deconvolution(
    Cropping(
    UpSampling(
    ZeroPadding(
  recurrent
    GRU(
    LSTM(
    Recurrent(
    SimpleRNN(
  convolutional_recurrent
    ConvLSTM(
    ConvRecurrent(
  noise
    AlphaDropout(
    GaussianDropout(
    GaussianNoise(
  merge
    Add/Subtract/Multiply/Dot(
    Maximum/Minimum/Average(
    Concatenate(
  embeddings
    Embedding(
  local
    LocallyConnected(
  constraints
    Constraint(
    MaxNorm/MinMaxNorm/UnitNorm(
    NonNeg(
  regularizers
    L1L2(
]
import keras.activations
activations = [
  linear(
  relu/selu/elu(
  softmax/softplus/softsign(
  sigmoid/hard_sigmoid(
  tanh(
  exponential(
]

import keras.losses
losses = [
  mean_absolute_error(
  mean_absolute_percentage_error(
  mean_squared_error(
  mean_squared_logarithmic_error(
  kullback_leibler_divergence(
  binary_crossentropy(
  categorical_crossentropy(
  sparse_categorical_crossentropy(
  hinge(
  squared_hinge(
  categorical_hinge(
  cosine(
  logcosh(
  poisson(
]
import keras.metrics
metrics = [
  binary_accuracy(
  categorical_accuracy(
  top_k_categorical_accuracy(
  sparse_categorical_accuracy(
  sparse_top_k_categorical_accuracy(
]

import keras.optimizers
optimizers = [
  Adadelta(
  Adagrad(
  Adam(
  Adamax(
  Nadam(
  RMSprop(
  SGD(
  TFOptimizer(
]

三.著名模型应用
import keras.applications
applications = [
  DenseNet121/DenseNet169/DenseNet201(
  InceptionV3(
  ResNet50(
  InceptionResNetV2(
  MobileNet/MobileNetV2(
  NASNetLarge/NASNetMobile(
  VGG16/VGG19(
  Xception(
]

四.工具包
import keras.utils
utils = [
  np_utils
    normalize(
    to_categorical(
  vis_utils
    model_to_dot(
    plot_model(
  layer_utils
    count_params(
  conv_utils
    conv_input/output_length(
    deconv_length(
    normalize_padding/tuple(
  io_utils
  data_utils
  generic_utils
  multi_gpu_utils  
]