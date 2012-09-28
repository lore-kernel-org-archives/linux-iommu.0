From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/16] iommu/amd: Add slab-cache for irq remapping tables
Date: Fri, 28 Sep 2012 14:23:52 +0200
Message-ID: <1348835046-3262-3-git-send-email-joerg.roedel@amd.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1348835046-3262-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The irq remapping tables for the AMD IOMMU need to be
aligned on a 128 byte boundary. Create a seperate slab-cache
to guarantee this alignment.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |    2 ++
 drivers/iommu/amd_iommu_init.c  |   23 +++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |    9 +++++++++
 drivers/iommu/irq_remapping.h   |    5 +++++
 4 files changed, 39 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6f51483..b6a8079 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -95,6 +95,8 @@ struct iommu_cmd {
 	u32 data[4];
 };
 
+struct kmem_cache *amd_iommu_irq_cache;
+
 static void update_domain(struct protection_domain *domain);
 static int __init alloc_passthrough_domain(void);
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index a9f3948..a046a0e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -36,6 +36,7 @@
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
+#include "irq_remapping.h"
 
 /*
  * definitions for the ACPI scanning code
@@ -124,6 +125,7 @@ struct ivmd_header {
 } __attribute__((packed));
 
 bool amd_iommu_dump;
+bool amd_iommu_irq_remap __read_mostly;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
@@ -1527,6 +1529,11 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_on_init_error(void)
 {
+	if (amd_iommu_irq_cache) {
+		kmem_cache_destroy(amd_iommu_irq_cache);
+		amd_iommu_irq_cache = NULL;
+	}
+
 	amd_iommu_uninit_devices();
 
 	free_pages((unsigned long)amd_iommu_pd_alloc_bitmap,
@@ -1666,6 +1673,19 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	if (amd_iommu_irq_remap) {
+		/*
+		 * Interrupt remapping enabled, create kmem_cache for the
+		 * remapping tables.
+		 */
+		amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
+				MAX_IRQS_PER_TABLE * sizeof(u32),
+				IRQ_TABLE_ALIGNMENT,
+				0, NULL);
+		if (!amd_iommu_irq_cache)
+			goto out;
+	}
+
 	ret = init_memory_definitions(ivrs_base);
 	if (ret)
 		goto out;
@@ -1713,6 +1733,9 @@ static bool detect_ivrs(void)
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
+	if (!disable_irq_remap)
+		amd_iommu_irq_remap = true;
+
 	return true;
 }
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 4495b78..953cea8 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -334,6 +334,15 @@ extern bool amd_iommu_np_cache;
 /* Only true if all IOMMUs support device IOTLBs */
 extern bool amd_iommu_iotlb_sup;
 
+#define MAX_IRQS_PER_TABLE	256
+#define IRQ_TABLE_ALIGNMENT	128
+
+/* Interrupt remapping feature used? */
+extern bool amd_iommu_irq_remap;
+
+/* kmem_cache to get tables with 128 byte alignement */
+extern struct kmem_cache *amd_iommu_irq_cache;
+
 /*
  * Make iterating over all IOMMUs easier
  */
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index b12974c..624d360 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -83,6 +83,11 @@ struct irq_remap_ops {
 
 extern struct irq_remap_ops intel_irq_remap_ops;
 
+#else  /* CONFIG_IRQ_REMAP */
+
+#define irq_remapping_enabled 0
+#define disable_irq_remap     1
+
 #endif /* CONFIG_IRQ_REMAP */
 
 #endif /* __IRQ_REMAPPING_H */
-- 
1.7.9.5
