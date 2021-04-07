# from https://github.com/bryant1410/dotbot-apt
from subprocess import CalledProcessError, check_call, DEVNULL
from typing import Any, List, Sequence

import dotbot


class Dnf(dotbot.Plugin):
    def can_handle(self, directive: str) -> bool:
        return directive == "dnf"

    def handle(self, directive: str, packages: List[str]) -> bool:
        success = self._run(["dnf", "update"], "Updating DNF") \
                  and self._run(["dnf", "install", "-y"] + packages,
                                "Installing the DNF packages: {}".format(", ".join(packages)))

        if success:
            self._log.info("DNF packages installed successfully")

        return success

    def _run(self, command: Sequence[Any], low_info: str) -> bool:
        self._log.lowinfo(low_info)
        try:
            check_call(command, stdout=DEVNULL, stderr=DEVNULL)
            return True
        except CalledProcessError as e:
            self._log.error(e)
            return False
