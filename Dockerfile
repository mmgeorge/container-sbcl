FROM debian:latest

ENV HOME /root

RUN apt-get update && apt-get install -y make bzip2 wget git

# Install sbcl
RUN wget 'http://prdownloads.sourceforge.net/sbcl/sbcl-1.5.0-x86-64-linux-binary.tar.bz2' \
         -O /tmp/sbcl.tar.bz2 && \
    mkdir /tmp/sbcl && \
    tar jxvf /tmp/sbcl.tar.bz2 --strip-components=1 -C /tmp/sbcl && \
    cd /tmp/sbcl && \
    ls -la && \    
    sh install.sh && \
    cd /tmp \
    rm -rf /tmp/sbcl 


# Install quicklisp
COPY ./install.lisp $HOME
WORKDIR $HOME
RUN wget https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --load install.lisp --non-interactive


# Install depdencies
RUN mkdir common-lisp
WORKDIR $HOME/common-lisp

RUN git clone https://github.com/mmgeorge/asdf.git && \
    git clone https://github.com/mmgeorge/cl-expect.git   
