From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V3 08/21] iommu/VT-d: simplify include/linux/dmar.h
Date: Wed, 25 Jun 2014 17:02:34 +0800
Message-ID: <1403686967-10887-9-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Simplify include/linux/dmar.h a bit based on the fact that
both CONFIG_INTEL_IOMMU and CONFIG_IRQ_REMAP select CONFIG_DMAR_TABLE.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/dmar.h |   50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 23c8db129560..1deece46a0ca 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -114,22 +114,30 @@ extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
 /* Intel IOMMU detection */
 extern int detect_intel_iommu(void);
 extern int enable_drhd_fault_handling(void);
-#else
-struct dmar_pci_notify_info;
-static inline int detect_intel_iommu(void)
+
+#ifdef CONFIG_INTEL_IOMMU
+extern int iommu_detected, no_iommu;
+extern int intel_iommu_init(void);
+extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header);
+extern int dmar_parse_one_atsr(struct acpi_dmar_header *header);
+extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
+#else /* !CONFIG_INTEL_IOMMU: */
+static inline int intel_iommu_init(void) { return -ENODEV; }
+static inline int dmar_parse_one_rmrr(struct acpi_dmar_header *header)
 {
-	return -ENODEV;
+	return 0;
 }
-
-static inline int dmar_table_init(void)
+static inline int dmar_parse_one_atsr(struct acpi_dmar_header *header)
 {
-	return -ENODEV;
+	return 0;
 }
-static inline int enable_drhd_fault_handling(void)
+static inline int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
-	return -1;
+	return 0;
 }
-#endif /* !CONFIG_DMAR_TABLE */
+#endif /* CONFIG_INTEL_IOMMU */
+
+#endif /* CONFIG_DMAR_TABLE */
 
 struct irte {
 	union {
@@ -177,26 +185,4 @@ extern int dmar_set_interrupt(struct intel_iommu *iommu);
 extern irqreturn_t dmar_fault(int irq, void *dev_id);
 extern int arch_setup_dmar_msi(unsigned int irq);
 
-#ifdef CONFIG_INTEL_IOMMU
-extern int iommu_detected, no_iommu;
-extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header);
-extern int dmar_parse_one_atsr(struct acpi_dmar_header *header);
-extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
-extern int intel_iommu_init(void);
-#else /* !CONFIG_INTEL_IOMMU: */
-static inline int intel_iommu_init(void) { return -ENODEV; }
-static inline int dmar_parse_one_rmrr(struct acpi_dmar_header *header)
-{
-	return 0;
-}
-static inline int dmar_parse_one_atsr(struct acpi_dmar_header *header)
-{
-	return 0;
-}
-static inline int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
-{
-	return 0;
-}
-#endif /* CONFIG_INTEL_IOMMU */
-
 #endif /* __DMAR_H__ */
-- 
1.7.10.4
