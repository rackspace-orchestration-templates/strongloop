from fabric.api import env, task
from envassert import detect, file, group, port, process, service, \
    user
from hot.utils.test import get_artifacts


@task
def check():
    env.platform_family = detect.detect()

    assert file.exists('/home/strongloop/loopback-example-app/package.json'), \
        '/home/strongloop/loopback-example-app/package.json does not exist'
    assert file.exists('/etc/supervisor.d/strongloop.conf'), \
        '/etc/supervisor.d/strongloop.conf does not exist'

    assert port.is_listening(3000), 'port 3000/node is not listening'

    assert user.exists('strongloop'), 'user strongbad does not exist'
    assert group.is_exists('strongloop'), 'group strongloop does not exist'

    assert process.is_up('supervisord'), 'process supervisord is not running'
    assert process.is_up('node'), 'process node is not running'

    assert service.is_enabled('supervisor'), \
        'service supervisor is not enabled'


@task
def artifacts():
    env.platform_family = detect.detect()
    get_artifacts()
