import subprocess
import argparse
import json

def execute_command(command):
    try:
        result = subprocess.run(
            command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")
        return None


def parse_output(output):
    nodes = []
    current_node = {}

    for line in output.split('\n'):
        line = line.strip()
        if line.startswith("id"):
            if current_node:
                nodes.append(current_node)
            current_node = {"id": line.split()[1]}
        elif line:
            key, value = line.split(" = ")
            key = key.replace(".", "_")
            key = key.replace('"', "")
            value = value.replace('"', '')
            current_node[key.strip()] = value.strip()

    if current_node:
        nodes.append(current_node)
    # remove non audio notes
    outputs = []
    for o in nodes:
        if 'media_class' not in o:
            continue
        if o['media_class'] != "Audio/Sink":
            continue
        outputs.append(o)
    return outputs


def list_devices():
    command = ["pw-cli", "list-objects", "Node"]
    output = execute_command(command)
    if output:
        objects = parse_output(output)
        out = {'count': len(objects)}
        for o in range(len(objects)):
            out[f'dev{o}'] = objects[o]
        print(json.dumps(objects))


def switch_device(name):
    command = ["pactl", "set-default-sink", name]
    execute_command(command)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Argument Parser Example")
    parser.add_argument("-l", "--execute", action="store_true",
                        help="Execute some_function")
    parser.add_argument("-s", "--id", type=str,
                        help="Execute function_with_id with given id")
    args = parser.parse_args()

    if args.execute:
        list_devices()

    if args.id is not None:
        switch_device(args.id)
