From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] iommu: Fix regression in IOMMU grouping
Date: Fri, 19 Sep 2014 10:03:00 -0600
Message-ID: <20140919154944.14485.743.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We've had surprisingly little fallout from the DMA alias changes, but
unfortunately one regression has popped up.  We have an AMD system
that seems to use the SATA controller to master transactions for the
legacy IDE controller and they are different slots on the root complex.
The IVRS reports 00:11.0 (SATA) as an alias from 00:14.1 (IDE), which
doesn't work with the new, converged PCI IOMMU grouping code, where
we've made a simplifying assumption that aliases will be to the same
slot.

To fix this, we need to rip out that assumption and write the alias
search code that I was unable to come up with previously.  I think
this can now do the chaining of aliases, which I referenced in the
removed comments.  Any sort of multi-level aliases are exceptionally
unlikely, but I think this code can now handle whatever firmware and
alias quirks can throw at it.

I know this is late for 3.17, but this is a regression from the prior
code.  If reviews and testing can give us the confidence to put it in
for 3.17, that would be my preference.  I've also marked it for stable
in case we want to loop back through that way.  Thanks,

Alex

---

Alex Williamson (2):
      iommu/amd: Split init_iommu_group() from iommu_init_device()
      iommu: Rework iommu_group_get_for_pci_dev()


 drivers/iommu/amd_iommu.c |   27 ++++---
 drivers/iommu/iommu.c     |  163 +++++++++++++++++++++++++++------------------
 2 files changed, 109 insertions(+), 81 deletions(-)
