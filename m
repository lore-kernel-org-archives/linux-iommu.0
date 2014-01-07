From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch Part2 V1 14/14] iommu/vt-d: update IOMMU state when memory
	hotplug happens
Date: Tue,  7 Jan 2014 17:00:34 +0800
Message-ID: <1389085234-22296-15-git-send-email-jiang.liu@linux.intel.com>
References: <1389085234-22296-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389085234-22296-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

If static identity domain is created, IOMMU driver needs to update
si_domain page table when memory hotplug event happens. Otherwise
PCI device DMA operations can't access the hot-added memory regions.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 83e3ed4..35a987d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -33,6 +33,7 @@
 #include <linux/dmar.h>
 #include <linux/dma-mapping.h>
 #include <linux/mempool.h>
+#include <linux/memory.h>
 #include <linux/timer.h>
 #include <linux/iova.h>
 #include <linux/iommu.h>
@@ -3689,6 +3690,54 @@ static struct notifier_block device_nb = {
 	.notifier_call = device_notifier,
 };
 
+static int intel_iommu_memory_notifier(struct notifier_block *nb,
+				       unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+	unsigned long long start, end;
+	struct iova *iova;
+
+	switch (val) {
+	case MEM_GOING_ONLINE:
+		start = mhp->start_pfn << PAGE_SHIFT;
+		end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
+		if (iommu_domain_identity_map(si_domain, start, end)) {
+			pr_warn("dmar: failed to build identity map for [%llx-%llx]\n",
+				start, end);
+			return NOTIFY_BAD;
+		}
+		break;
+	case MEM_OFFLINE:
+	case MEM_CANCEL_ONLINE:
+		/* TODO: enhance RB-tree and IOVA code to support of splitting iova */
+		iova = find_iova(&si_domain->iovad, mhp->start_pfn);
+		if (iova) {
+			unsigned long start_pfn, last_pfn;
+			struct dmar_drhd_unit *drhd;
+			struct intel_iommu *iommu;
+
+			start_pfn = mm_to_dma_pfn(iova->pfn_lo);
+			last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
+			dma_pte_clear_range(si_domain, start_pfn, last_pfn);
+			dma_pte_free_pagetable(si_domain, start_pfn, last_pfn);
+			rcu_read_lock();
+			for_each_active_iommu(iommu, drhd)
+				iommu_flush_iotlb_psi(iommu, si_domain->id,
+					start_pfn, last_pfn - start_pfn + 1, 0);
+			rcu_read_unlock();
+			__free_iova(&si_domain->iovad, iova);
+		}
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block intel_iommu_memory_nb = {
+	.notifier_call = intel_iommu_memory_notifier,
+	.priority = 0
+};
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
@@ -3761,8 +3810,9 @@ int __init intel_iommu_init(void)
 	init_iommu_pm_ops();
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
-
 	bus_register_notifier(&pci_bus_type, &device_nb);
+	if (si_domain)
+		register_memory_notifier(&intel_iommu_memory_nb);
 
 	intel_iommu_enabled = 1;
 
-- 
1.7.10.4
