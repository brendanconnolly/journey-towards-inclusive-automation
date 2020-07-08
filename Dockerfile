ARG BASE_IMAGE_TAG=latest
FROM rubydata/minimal-notebook

USER $NB_UID

RUN conda install -c conda-forge jupyter_contrib_nbextensions
RUN conda install -c conda-forge hide_code

RUN jupyter nbextension install --py hide_code --sys-prefix

RUN jupyter nbextension enable --py hide_code --sys-prefix
RUN jupyter serverextension enable --py hide_code --sys-prefix

RUN jupyter nbextension enable init_cell/main --sys-prefix

RUN jupyter contrib nbextension install --user



USER root
COPY Gemfile .
COPY .env .
COPY .env ./work

COPY ./notebooks ./notebooks
COPY ./lib ./lib

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
RUN bundle config set system 'true'
RUN bundle install

USER $NB_UID
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]