# This software is distributed under the 3-clause BSD License.
""" An extension to send to the W and nonant spokes less often.
"""

import pyomo.environ as pyo
import mpisppy.extensions.extension

class Send_Less(mpisppy.extensions.extension.Extension):

    def __init__(self, ph):
        self.ph = ph
        self.rank = self.ph.rank
        self.rank0 = self.ph.rank0
        self.verbose = self.ph.PHoptions["verbose"]
        # we reset to where they started (they might be false)
        self.startnon = self.ph.spcomm.should_send_nonants
        self.startw = self.ph.spcomm.should_send_ws
        
                       
    def _vb(self, str):
        if self.verbose and self.rank == 0:
            print ("(rank0) mipgapper:" + str)

    def pre_iter0(self):
        return

    def post_iter0(self):
        return

    def miditer(self):
        return

    def enditer(self):
        # We might disable or enable sending for the next iteration
        # We will send for the last couple of iterations is terminating on iters
        # and we will send for the first couple iterations.
        ph = self.ph
        skip = 5 if "spoke_skip_interval" not in ph.PHoptions\
               else ph.PHoptions["spoke_skip_interval"]
        if ph._PHIter >= int(ph.PHoptions["PHIterLimit"])-2\
           or ph._PHIter % skip == 0:
            self.should_send_nonants = self.startnon
            self.should_send_ws = self.startw
        else:
            self.should_send_nonants = False
            self.should_send_ws = False
        return

    def post_everything(self):
        return
