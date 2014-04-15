From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: fix bug in matching PCI devices with DRHD/RMRR
	descriptors
Date: Tue, 15 Apr 2014 10:35:35 +0800
Message-ID: <1397529335-4834-1-git-send-email-jiang.liu@linux.intel.com>
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
To: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Davidlohr Bueso <davidlohr-VXdhtT5mjnY@public.gmane.org>
Cc: "bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aswin-VXdhtT5mjnY@public.gmane.org, James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, scameron-3C9H9nn4BS4HL6m8NFMY+dBPR1lH4CV8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Commit "59ce0515cdaf iommu/vt-d: Update DRHD/RMRR/ATSR device scope
caches when PCI hotplug happens" introduces a bug, which fails to
match PCI devices with DMAR device scope entries if PCI path array
in the entry has more than one level.

For example, it fails to handle
[1D2h 0466   1]      Device Scope Entry Type : 01
[1D3h 0467   1]                 Entry Length : 0A
[1D4h 0468   2]                     Reserved : 0000
[1D6h 0470   1]               Enumeration ID : 00
[1D7h 0471   1]               PCI Bus Number : 00
[1D8h 0472   2]                     PCI Path : 1C,04
[1DAh 0474   2]                     PCI Path : 00,02

And cause DMA failure on HP DL980 as:
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 602
dmar: DMAR:[DMA Read] Request device [02:00.2] fault addr 7f61e000

Reported-and-tested-by: Davidlohr Bueso <davidlohr-VXdhtT5mjnY@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Hi David and Davidlohr,
	I have made minor syntax change to the patch, but there should be no
functional change.
Thanks!
Gerry
---
 drivers/iommu/dmar.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index f445c10df8df..39f8b717fe84 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -152,7 +152,8 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 	info->seg = pci_domain_nr(dev->bus);
 	info->level = level;
 	if (event == BUS_NOTIFY_ADD_DEVICE) {
-		for (tmp = dev, level--; tmp; tmp = tmp->bus->self) {
+		for (tmp = dev; tmp; tmp = tmp->bus->self) {
+			level--;
 			info->path[level].device = PCI_SLOT(tmp->devfn);
 			info->path[level].function = PCI_FUNC(tmp->devfn);
 			if (pci_is_root_bus(tmp->bus))
-- 
1.7.10.4
