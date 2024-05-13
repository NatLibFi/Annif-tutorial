# Optional exercise: Running Annif for production use

The intended way for using Annif in production is by making the REST API or Web
UI available for end-users, either publicly to everyone on internet or in a
more private network. For this purpose one minimally needs to have a server and
to configure it to expose Annif API and/or Web UI to the outside network.

Also, when training large Annif models, and especially optimizing them by searching for optimal hyperparameters, 
it is best to have a separate computer for that with adequote resources.
From that training computer the ready-made models (the `data/` directory and the projects configuration file)
can be transferred to the server where an Annif instance is run for the API and/or Web UI.

For a reference value, the memory consumption of the current (in 2022) Annif models run for [Finto AI](https://ai.finto.fi/)
is ~25 GB (there are [12 projects](https://annif.org/download/models/finto-ai-2022-06/projects.cfg)).
Note that the memory consumption of a model of a given backend/algorithm
depends on the hyperparameters and the data the model is trained on.
Usually there is a trade-off between the quality of the model's suggestions and its memory consumption.

## Web component stack
Annif is based on [Flask](https://flask.palletsprojects.com/en/2.2.x/),
which is a WSGI (Web Server Gateway Interface) *application framework*
well suitable for development and debugging, but in production systems
[it is recommended](https://flask.palletsprojects.com/en/2.2.x/deploying/)
to use a WSGI *server* in front.

[Gunicorn](https://gunicorn.org/) is a good choice for the WSGI server. 
To start Annif behind Gunicorn run e.g.
`gunicorn "annif:create_app()" --bind 0.0.0.0:8000 --timeout 600 --worker-class uvicorn.workers.UvicornWorker`.
This exposes port 8000, sets the timeout to 600 s to allow the Annif models to load in case they are large, and uses Uvicorn workers (necessitated by [Annif v1.1](https://github.com/NatLibFi/Annif/releases/tag/v1.1.0)). 

In addition to a WSGI server, in front of all it is recommended
to put a dedicated *HTTP server* to act as a reverse proxy.
[Gunicorn documentation](https://docs.gunicorn.org/en/stable/deploy.html)
advices to use [NGINX](https://nginx.org/).
In addition to increasing performance the proxying HTTP server can serve static files for a web page
(in the case you don't want to use the default Annif Web UI), perform TLS/SLL handling, redirections etc.

## Server platform 
The platform to run the above components can be a traditional server, but nowdays
a more common approach is to employ containers.
Docker image of Annif is available on [quay.io/natlibfi/annif](https://quay.io/repository/natlibfi/annif) repository.
The image includes Gunicorn as well as all optional dependencies of Annif
(see how to [customize the Annif image](https://github.com/NatLibFi/Annif/wiki/Usage-with-Docker#customizing-docker-image) for example to reduce the size of the image).
NGINX is better to be run on a separete container.

There are many platforms where the containers can be run.
The National Library of Finland is using Annif to power the [Finto AI
service](https://ai.finto.fi/), which is run on an OpenShift
Container Platform environment. The [Finto
AI's GitHub repository](https://github.com/NatLibFi/FintoAI) contains code for the service.

## Other material
See also:
- [The video on YouTube](https://www.youtube.com/watch?v=ZKN22mXKMm8)
demonstrating the use of Finto AI and its integration to the submission system
of the [publications archive of University of Vaasa](https://osuva.uwasa.fi/).
- [The article on Annif and Finto
  AI](https://www.jlis.it/index.php/jlis/article/view/437) published on
  JLIS.it in 2022.
- [The presentation at LIBER 2022](https://zenodo.org/record/6811550) and [the paper and presentation at IFLA 2022](https://repository.ifla.org/handle/123456789/2047) by Anna Kasprzik about automating subject indexing process at ZBW.
