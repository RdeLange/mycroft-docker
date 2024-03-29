# Mycroft Docker Server

## Install
### Build image
Git pull this repository.

```bash
git clone https://github.com/Rdelange/mycroft-docker.git
```

Build the docker image in the directory that you have checked out.

```bash
docker build -t mycroft .
```

## Run
To get persistent data and don't have, for example, to pair our instance every time the container is started. You can map a local directory into the container. Just replace the directory_on_local_machine with where you want the container mapped on your local machine (eg: /home/user/mycroft).

Run the following to start up mycroft:

```bash
docker run -d \
-v directory_on_local_machine:/root/.mycroft \
-v directory_on_local_machine_for_skills:/opt/mycroft/skills \
-p 8181:8181 \
-p 6789:6789 \
--name mycroft-server mycroft
```

Confirm via docker ps that your container is up and serving port 8181:

```bash
docker ps
CONTAINER ID        IMAGE                                                COMMAND                  CREATED             STATUS              PORTS                                            NAMES
692219e23bf2        mycroft                                    "/mycroft/ai/mycro..."         3 seconds ago         Up 1 second           0.0.0.0:8181->8181/tcp                          mycroft
```

You should now have a running instance of mycroft that you can interact with via the cli, etc.

## Logs
At any time you can watch the logs simply by running the bellow command:

```bash
docker logs -f mycroft-server
```

You can exit out of this docker log command by hitting ctrl + c, the `--follow` basically turns it into a real tail instead of a cat of the log.

## CLI Access
You can interact with the CLI of the container by running the following command, this will connect you to the running container via bash:

```bash
docker exec -it mycroft-server /bin/bash
```

Once in the container you can do `./start-mycroft.sh cli` to get a interactive CLI to interact with mycroft if needed.

You can hit ctrl + c to exit the cli.

## Pairing Instance
After the container has been started you can watch the logs and look for the line that says Pairing Code and use this to pair at https://home.mycroft.ai.

## Skills
You can watch the logs and confirm it installs/deletes skills.

### Install
You can install skills into the container from outside by running the following:

```bash
docker exec -it mycroft-server /usr/local/bin/msm install github_url
```

So to install say my basic-skill helper:

```bash
docker exec -it mycroft-server /opt/mycroft/msm/msm install https://github.com/btotharye/mycroft-skill-basichelp
```

### Remove
You can uninstall a skill by removing the folder location for it

```bash
docker exec -it mycroft-server rm -rf /opt/mycroft/skills/mycroft-skill-basichelp
```

This would remove the above test basic help skill.
