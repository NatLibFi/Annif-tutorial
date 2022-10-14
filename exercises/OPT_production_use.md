# Optional exercise: Running Annif for production use

The intended way for using Annif in production is by making the REST API or Web
UI available for end-users, either publicly to everyone on internet or in a
more private network. For this purpose one minimally needs to have a server and
to configure it to expose Annif API and/or Web UI to the outside network.

## Web component stack
Annif is based on [Flask](https://flask.palletsprojects.com/en/2.2.x/),
which is a WSGI (Web Server Gateway Interface) *application framework*
well suitable for development an debugging, but in production systems
the best practise is to use a WSGI *server* in front.
[Flask documentation](https://flask.palletsprojects.com/en/2.2.x/deploying/) states:

> “Production” means “not development”, which applies whether you’re serving your application publicly to millions of users or privately / locally to a single user. Do not use the development server when deploying to production. It is intended for use only during local development. It is not designed to be particularly secure, stable, or efficient.

[Gunicorn](https://gunicorn.org/) is a good choice for the WSGI server. 
To start Annif behind Gunicorn run 
`gunicorn "annif:create_app()" --bind 0.0.0.0:8000 --timeout 600`.
This exposes port 8000, and the timeout allows 600 s for the Annif models to load. 

In addition to a WSGI server, in front of all it is recommended
to put a dedicated HTTP server to act as a reverse proxy.
[Gunicorn documentation](https://docs.gunicorn.org/en/stable/deploy.html)
advices:

> Although there are many HTTP proxies available, we strongly advise that you use [Nginx](https://nginx.org/)

In addition to increasing performance the proxying HTTP server can serve static files for a web page
(in the case you don't want to use the default Annif Web UI), perform TLS/SLL handling, redirections etc.

## Run platform 
The platform to run the above components can be a traditional server, but nowdays
a more common approach is to employ containers.
Docker image of Annif is available on [quay.io/natlibfi/annif](https://quay.io/repository/natlibfi/annif) repository.
The image includes Gunicorn as well as all optional dependencies of Annif
(see how to [customize the Annif image](https://github.com/NatLibFi/Annif/wiki/Usage-with-Docker#customizing-docker-image)).
NGINX is better to be run on a separete container.

There are many platforms where the containers can be run.
The National Library of Finland is using Annif to power the [Finto AI
service](https://ai.finto.fi/), which is run on an OpenShift
Container Platform environment. The [Finto
AI's GitHub repository](https://github.com/NatLibFi/FintoAI) contains the code
and configurations (helm-charts) that are used to set up the service.
See the repository README.md for the details of the system.

## Other material
See also
- [the video on YouTube](https://www.youtube.com/watch?v=ZKN22mXKMm8)
demonstrating the use of Finto AI and its integration to the submission system
of the [publications archive of University of Vaasa](https://osuva.uwasa.fi/).
- [the article on Annif and Finto
  AI](https://www.jlis.it/index.php/jlis/article/view/437) published on
  JLIS.it.
