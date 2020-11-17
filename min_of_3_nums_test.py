import itertools
from subprocess import Popen, PIPE

def start(cmd):
    return Popen(cmd, stdin=PIPE, stdout=PIPE, stderr=PIPE)

def read(process):
    return process.stdout.read().decode("utf-8")

def write(process, s):
    process.stdin.write(f"{s}\n".encode("utf-8"))
    process.stdin.flush()

def terminate(process):
    process.stdin.close()
    process.terminate()
    process.wait(timeout=0.2)

def run_test(mips_prog, inputs, should_endwith):
    process = start(["spim", "-f", mips_prog])

    for num in nums:
        write(process, num)

    assert read(process).endswith(should_endwith)
    terminate(process)

if __name__ == "__main__":
    for nums in itertools.permutations("345"):
        run_test("min_of_3_nums.s", nums, "The smallest integer is: 3")
    
    for nums in itertools.permutations(["-3", "-2", "-1"]):
        run_test("min_of_3_nums.s", nums, "The smallest integer is: -3")
    
    for nums in itertools.permutations(["-4", "-4", "-1"]):
        run_test("min_of_3_nums.s", nums, "The smallest integer is: -4")
    
    for nums in itertools.permutations("667"):
        run_test("min_of_3_nums.s", nums, "The smallest integer is: 6")
