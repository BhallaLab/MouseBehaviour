# How to run the pipeline

First install the dependencies. 

```
python3 -m pip install -r ./requirements.txt --user
```

Then, 

```
make DATADIR=/path/to/the/folder/containing/trial/tiff
```

where `DATADIR` is path to trial data. Usually this older contains tiff files
containing trial data.
