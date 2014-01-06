From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 19/20] iommu/vt-d, trivial: clean sparse warnings
Date: Mon,  6 Jan 2014 14:18:26 +0800
Message-ID: <1388989107-4795-20-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Clean up most sparse warnings in Intel DMA and interrupt remapping
drivers.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c                |    8 ++++----
 drivers/iommu/intel-iommu.c         |    4 ++--
 drivers/iommu/intel_irq_remapping.c |    4 ++--
 drivers/iommu/irq_remapping.c       |    6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index c4b271d..248332e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -572,7 +572,7 @@ static int __init detect_intel_iommu(void)
 			x86_init.iommu.iommu_init = intel_iommu_init;
 #endif
 	}
-	early_acpi_os_unmap_memory(dmar_tbl, dmar_tbl_size);
+	early_acpi_os_unmap_memory((void __iomem *)dmar_tbl, dmar_tbl_size);
 	dmar_tbl = NULL;
 
 	return ret ? 1 : -ENODEV;
@@ -1064,7 +1064,7 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO, 0);
 	if (!desc_page) {
 		kfree(qi);
-		iommu->qi = 0;
+		iommu->qi = NULL;
 		return -ENOMEM;
 	}
 
@@ -1074,7 +1074,7 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 	if (!qi->desc_status) {
 		free_page((unsigned long) qi->desc);
 		kfree(qi);
-		iommu->qi = 0;
+		iommu->qi = NULL;
 		return -ENOMEM;
 	}
 
@@ -1125,7 +1125,7 @@ static const char *irq_remap_fault_reasons[] =
 	"Blocked an interrupt request due to source-id verification failure",
 };
 
-const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
+static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
 {
 	if (fault_reason >= 0x20 && (fault_reason - 0x20 <
 					ARRAY_SIZE(irq_remap_fault_reasons))) {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fce741..c28e9fe 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -382,7 +382,7 @@ struct device_domain_info {
 
 static void flush_unmaps_timeout(unsigned long data);
 
-DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
+static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
 
 #define HIGH_WATER_MARK 250
 struct deferred_flush_tables {
@@ -3127,7 +3127,7 @@ static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return !dma_addr;
 }
 
-struct dma_map_ops intel_dma_ops = {
+static struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
 	.map_sg = intel_map_sg,
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index ea425de..f307a3f 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -48,7 +48,7 @@ static struct irq_2_iommu *irq_2_iommu(unsigned int irq)
 	return cfg ? &cfg->irq_2_iommu : NULL;
 }
 
-int get_irte(int irq, struct irte *entry)
+static int get_irte(int irq, struct irte *entry)
 {
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
 	unsigned long flags;
@@ -797,7 +797,7 @@ static int __init parse_ioapics_under_ir(void)
 	return 1;
 }
 
-int __init ir_dev_scope_init(void)
+static int __init ir_dev_scope_init(void)
 {
 	if (!irq_remapping_enabled)
 		return 0;
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 39f81ae..228632c9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -150,7 +150,7 @@ static int irq_remapping_setup_msi_irqs(struct pci_dev *dev,
 		return do_setup_msix_irqs(dev, nvec);
 }
 
-void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
+static void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
 {
 	/*
 	 * Intr-remapping uses pin number as the virtual vector
@@ -295,8 +295,8 @@ int setup_ioapic_remapped_entry(int irq,
 					     vector, attr);
 }
 
-int set_remapped_irq_affinity(struct irq_data *data, const struct cpumask *mask,
-			      bool force)
+static int set_remapped_irq_affinity(struct irq_data *data,
+				     const struct cpumask *mask, bool force)
 {
 	if (!config_enabled(CONFIG_SMP) || !remap_ops ||
 	    !remap_ops->set_affinity)
-- 
1.7.10.4
