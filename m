From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] Fix ACS path checking
Date: Sat, 04 Aug 2012 12:08:46 -0600
Message-ID: <20120804180155.6144.83332.stgit@bling.home>
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
To: joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dsahern-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

David Ahern reported an oops caused by passing a NULL start device
to pci_acs_path_enabled().  This can happen when a bus is created
for sr-iov devices without an associated bridge.  To handle this,
skip over to the parent bus and look for a bridge there.  Continue
until we find something or reach the root bus.

This works on my system, but still needs to be tested by David.  I'd
like to get this in for 3.6-rc2.

Joerg, I notice that ACS isn't getting enabled on my AMD system on
3.6-rc1.  I'll investigate more, but mention it in case you get to
it first.  Thanks,

Alex

---

Alex Williamson (2):
      amd-iommu: Fix ACS path checking
      intel-iommu: Fix ACS path checking


 drivers/iommu/amd_iommu.c   |   25 ++++++++++++++++++++++---
 drivers/iommu/intel-iommu.c |   25 ++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 6 deletions(-)
