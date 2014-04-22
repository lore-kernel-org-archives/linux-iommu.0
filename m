From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V1 18/22] iommu/vt-d: update proximity information when
	a new node with memory available
Date: Tue, 22 Apr 2014 15:07:29 +0800
Message-ID: <1398150453-28141-19-git-send-email-jiang.liu@linux.intel.com>
References: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398150453-28141-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

If node associated with a DMAR unit has no memory available, it uses -1
as default NUMA node id. So when memory hot-addition adds new memory to
an empty NUMA node, we should update the NUMA node id associated with
the DMAR unit. This will help to optomize memory allocation.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c        |   50 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |    1 +
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 7a7383858c34..d607691a6a80 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -38,6 +38,7 @@
 #include <linux/tboot.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/memory.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
@@ -444,6 +445,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 			if (!node_online(node))
 				node = -1;
 			drhd->iommu->node = node;
+			drhd->iommu->proximity_domain = rhsa->proximity_domain;
 			return 0;
 		}
 	}
@@ -458,8 +460,48 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 
 	return 0;
 }
+
+static int dmar_memory_notifier(struct notifier_block *nb,
+				unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int nid;
+
+	if (val != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	if (mhp->status_change_nid < 0)
+		return NOTIFY_OK;
+
+	down_read(&dmar_global_lock);
+	for_each_iommu(iommu, drhd) {
+		if (iommu->node != -1)
+			continue;
+		nid = acpi_map_pxm_to_node(iommu->proximity_domain);
+		if (nid == mhp->status_change_nid)
+			iommu->node = nid;
+	}
+	up_read(&dmar_global_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dmar_memory_nb = {
+	.notifier_call = dmar_memory_notifier,
+};
+
+static void dmar_register_memory_notifier(void)
+{
+	register_memory_notifier(&dmar_memory_nb);
+}
 #else
 #define	dmar_parse_one_rhsa		dmar_res_noop
+
+static void dmar_register_memory_notifier(void)
+{
+}
 #endif
 
 static void __init
@@ -1715,12 +1757,14 @@ static inline bool dmar_in_use(void)
 	return irq_remapping_enabled || intel_iommu_enabled;
 }
 
-static int __init dmar_free_unused_resources(void)
+static int __init dmar_late_init(void)
 {
 	struct dmar_drhd_unit *dmaru, *dmaru_n;
 
-	if (dmar_in_use())
+	if (dmar_in_use()) {
+		dmar_register_memory_notifier();
 		return 0;
+	}
 
 	if (dmar_dev_scope_status != 1 && !list_empty(&dmar_drhd_units))
 		bus_unregister_notifier(&pci_bus_type, &dmar_pci_bus_nb);
@@ -1735,7 +1779,7 @@ static int __init dmar_free_unused_resources(void)
 	return 0;
 }
 
-late_initcall(dmar_free_unused_resources);
+late_initcall(dmar_late_init);
 IOMMU_INIT_POST(detect_intel_iommu);
 
 /*
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0a2da5188217..eea52ccdbd8e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -337,6 +337,7 @@ struct intel_iommu {
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 #endif
 	int		node;
+	int		proximity_domain;
 };
 
 static inline void __iommu_flush_cache(
-- 
1.7.10.4
