From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 V2 03/17] iommu/vt-d: avoid caching stale
	domain_device_info when hot-removing PCI device
Date: Wed, 19 Feb 2014 14:07:23 +0800
Message-ID: <1392790057-32434-4-git-send-email-jiang.liu@linux.intel.com>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392790057-32434-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Function device_notifier() in intel-iommu.c only remove domain_device_info
data structure associated with a PCI device when handling PCI device
driver unbinding events. If a PCI device has never been bound to a PCI
device driver, there won't be BUS_NOTIFY_UNBOUND_DRIVER event when
hot-removing the PCI device. So associated domain_device_info data
structure may get lost.

On the other hand, if iommu_pass_through is enabled, function
iommu_prepare_static_indentify_mapping() will create domain_device_info
data structure for each PCIe to PCIe bridge and PCIe endpoint,
no matter whether there are drivers associated with those PCIe devices
or not. So those domain_device_info data structures will get lost when
hot-removing the assocated PCIe devices if they have never bound to
any PCI device driver.

To be even worse, it's not only an memory leak issue, but also an
caching of stale information bug because the memory are kept in
device_domain_list and domain->devices lists.

Fix the bug by trying to remove domain_device_info data structure when
handling BUS_NOTIFY_DEL_DEVICE event.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f75d3ae..5a411e8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3603,18 +3603,19 @@ static int device_notifier(struct notifier_block *nb,
 	if (iommu_dummy(pdev))
 		return 0;
 
+	if (action != BUS_NOTIFY_UNBOUND_DRIVER &&
+	    action != BUS_NOTIFY_DEL_DEVICE)
+		return 0;
+
 	domain = find_domain(pdev);
 	if (!domain)
 		return 0;
 
-	if (action == BUS_NOTIFY_UNBOUND_DRIVER) {
-		domain_remove_one_dev_info(domain, pdev);
-
-		if (!(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) &&
-		    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
-		    list_empty(&domain->devices))
-			domain_exit(domain);
-	}
+	domain_remove_one_dev_info(domain, pdev);
+	if (!(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) &&
+	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
+	    list_empty(&domain->devices))
+		domain_exit(domain);
 
 	return 0;
 }
-- 
1.7.10.4
