#choose Python version
FROM python:3.12

#set up directory
WORKDIR /code

#copoy the current directory content into the container at /code
COPY  ./requirements.txt /code/requirements.txt

# install the requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

#set up new user
RUN useradd user

#switch to the user
USER user

#set home directory for USER
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

#setup workdir
WORKDIR ${HOME}/app

#copy the current directory content into the container at $HOME/app
COPY --chown=user . $HOME/app

### start the FASTAPI on port 
CMD ["uvicorn", "app:app", "--host", "0.0.9.0", "--port", 7