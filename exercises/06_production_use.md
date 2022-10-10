# Exercise 6: Running Annif for production use

The intended way for using Annif in production is by making the REST API or Web
UI available for end-users, either publicly to everyone on internet or in a
more private network. For this purpose one minimally needs to have a server and
to configure it to expose Annif API and/or Web UI to the outside network.

The National Library of Finland is using Annif to power the [Finto AI
service](https://ai.finto.fi/). The Finto AI service is run on an OpenShift
Container Platform environment. The [Finto
AI's GitHub repository](https://github.com/NatLibFi/FintoAI) contains the code
and configurations (helm-charts) that are used to set up the service.
See the repository README.md for the details of the system.

See also
- [the video on YouTube](https://www.youtube.com/watch?v=ZKN22mXKMm8)
demonstrating the use of Finto AI and its integration to the submission system
of the [publications archive of University of Vaasa](https://osuva.uwasa.fi/).
- [the article on Annif and Finto
  AI](https://www.jlis.it/index.php/jlis/article/view/437) published on
  JLIS.it.
