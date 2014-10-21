From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 4/5] iommu/vt-d: Add domain-id functions
Date: Tue, 21 Oct 2014 16:04:18 +0800
Message-ID: <1413878659-1383-5-git-send-email-zhen-hual@hp.com>
References: <1413878659-1383-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1413878659-1383-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Interfaces for when a new domain in the crashdump kernel needs some
values from the panicked kernel's context entries.

Signed-off-by: Bill Sumner 
---
 drivers/iommu/intel-iommu.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 73afed4..bde8f22 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -348,6 +348,7 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 
 
 #ifdef CONFIG_CRASH_DUMP
+
 /*
  * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
  *
@@ -437,6 +438,16 @@ static int intel_iommu_copy_translation_tables(struct dmar_drhd_unit *drhd,
 		struct root_entry **root_new_virt_p,
 		int g_num_of_iommus);
 
+static struct domain_values_entry *intel_iommu_did_to_domain_values_entry(
+		int did, struct intel_iommu *iommu);
+
+static int intel_iommu_get_dids_from_old_kernel(struct intel_iommu *iommu);
+
+static struct domain_values_entry *intel_iommu_did_to_domain_values_entry(
+		int did, struct intel_iommu *iommu);
+
+static int intel_iommu_get_dids_from_old_kernel(struct intel_iommu *iommu);
+
 #endif /* CONFIG_CRASH_DUMP */
 
 /*
@@ -5230,4 +5241,39 @@ static int intel_iommu_copy_translation_tables(struct dmar_drhd_unit *drhd,
 	return 0;
 }
 
+/*
+ * Interfaces for when a new domain in the crashdump kernel needs some
+ * values from the panicked kernel's context entries
+ *
+ */
+static struct domain_values_entry *intel_iommu_did_to_domain_values_entry(
+		int did, struct intel_iommu *iommu)
+{
+	struct domain_values_entry *dve;	/* iterator */
+
+	list_for_each_entry(dve, &domain_values_list[iommu->seq_id], link)
+		if (dve->did == did)
+			return dve;
+	return NULL;
+}
+
+/* Mark domain-id's from old kernel as in-use on this iommu so that a new
+ * domain-id is allocated in the case where there is a device in the new kernel
+ * that was not in the old kernel -- and therefore a new domain-id is needed.
+ */
+static int intel_iommu_get_dids_from_old_kernel(struct intel_iommu *iommu)
+{
+	struct domain_values_entry *dve;	/* iterator */
+
+	pr_info("IOMMU:%d Domain ids from panicked kernel:\n", iommu->seq_id);
+
+	list_for_each_entry(dve, &domain_values_list[iommu->seq_id], link) {
+		set_bit(dve->did, iommu->domain_ids);
+		pr_info("DID did:%d(0x%4.4x)\n", dve->did, dve->did);
+	}
+
+	pr_info("----------------------------------------\n");
+	return 0;
+}
+
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.0.0-rc0
