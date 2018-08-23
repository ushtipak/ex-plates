FROM elixir
MAINTAINER ushtipak@gmail.com
RUN apt-get -y update

# prepare and execute platecodes (golang)
WORKDIR /opt/plates/
RUN apt-get install -y git golang
RUN git clone https://github.com/ushtipak/platecodes.git

WORKDIR /opt/plates/platecodes
RUN GOPATH=$HOME/go go get github.com/antchfx/htmlquery
RUN GOPATH=$HOME/go go run platecodes.go

# prepare and execute ex-plates (elixir)
RUN mkdir -p /opt/plates/ex-plates
WORKDIR /opt/plates/ex-plates
COPY . /opt/plates/ex-plates
RUN apt-get install -y wamerican

RUN mix local.hex --force && mix deps.get
RUN mix local.rebar --force
CMD mix run -e "Execute.start"

