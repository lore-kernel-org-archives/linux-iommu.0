From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 09/20] iommu/vt-d: mark internal functions as static
Date: Mon,  6 Jan 2014 14:18:16 +0800
Message-ID: <1388989107-4795-10-git-send-email-jiang.liu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Function detect_intel_iommu()/alloc_iommu()/parse_ioapics_under_ir()
are only used internally, so mark them as static.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c                |    9 ++++++---
 drivers/iommu/intel_irq_remapping.c |    4 +++-
 include/linux/dmar.h                |   12 +-----------
 include/linux/intel-iommu.h         |    1 -
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index f5f7b7d..f02a4fd 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -52,6 +52,8 @@ LIST_HEAD(dmar_drhd_units);
 struct acpi_table_header * __initdata dmar_tbl;
 static acpi_size dmar_tbl_size;
 
+static int alloc_iommu(struct dmar_drhd_unit *drhd);
+
 static void __init dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
@@ -498,7 +500,7 @@ static void warn_invalid_dmar(u64 addr, const char *message)
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
 }
 
-int __init check_zero_address(void)
+static int __init check_zero_address(void)
 {
 	struct acpi_table_dmar *dmar;
 	struct acpi_dmar_header *entry_header;
@@ -548,7 +550,7 @@ failed:
 	return 0;
 }
 
-int __init detect_intel_iommu(void)
+static int __init detect_intel_iommu(void)
 {
 	int ret;
 
@@ -649,7 +651,7 @@ out:
 	return err;
 }
 
-int alloc_iommu(struct dmar_drhd_unit *drhd)
+static int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
 	u32 ver, sts;
@@ -1366,4 +1368,5 @@ int __init dmar_ir_support(void)
 		return 0;
 	return dmar->flags & 0x1;
 }
+
 IOMMU_INIT_POST(detect_intel_iommu);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 2616e8a..6712f1e 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -40,6 +40,8 @@ static int ir_ioapic_num, ir_hpet_num;
 
 static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
 
+static int __init parse_ioapics_under_ir(void);
+
 static struct irq_2_iommu *irq_2_iommu(unsigned int irq)
 {
 	struct irq_cfg *cfg = irq_get_chip_data(irq);
@@ -773,7 +775,7 @@ static int ir_parse_ioapic_hpet_scope(struct acpi_dmar_header *header,
  * Finds the assocaition between IOAPIC's and its Interrupt-remapping
  * hardware unit.
  */
-int __init parse_ioapics_under_ir(void)
+static int __init parse_ioapics_under_ir(void)
 {
 	struct dmar_drhd_unit *drhd;
 	int ir_supported = 0;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 8adfce0..f614357 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -33,6 +33,7 @@ struct acpi_dmar_header;
 #define DMAR_X2APIC_OPT_OUT	0x2
 
 struct intel_iommu;
+
 #ifdef CONFIG_DMAR_TABLE
 extern struct acpi_table_header *dmar_tbl;
 struct dmar_drhd_unit {
@@ -62,19 +63,8 @@ extern struct list_head dmar_drhd_units;
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
-
-/* Intel IOMMU detection */
-extern int detect_intel_iommu(void);
 extern int enable_drhd_fault_handling(void);
-
-extern int parse_ioapics_under_ir(void);
-extern int alloc_iommu(struct dmar_drhd_unit *);
 #else
-static inline int detect_intel_iommu(void)
-{
-	return -ENODEV;
-}
-
 static inline int dmar_table_init(void)
 {
 	return -ENODEV;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index de1e5e9..f2c4114 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -348,7 +348,6 @@ static inline void __iommu_flush_cache(
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-extern int alloc_iommu(struct dmar_drhd_unit *drhd);
 extern void free_iommu(struct intel_iommu *iommu);
 extern int dmar_enable_qi(struct intel_iommu *iommu);
 extern void dmar_disable_qi(struct intel_iommu *iommu);
-- 
1.7.10.4
