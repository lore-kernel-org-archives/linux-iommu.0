From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 V2 05/17] iommu/vt-d: move private structures and
	variables into intel-iommu.c
Date: Wed, 19 Feb 2014 14:07:25 +0800
Message-ID: <1392790057-32434-6-git-send-email-jiang.liu@linux.intel.com>
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

Move private structures and variables into intel-iommu.c, which will
help to simplify locking policy for hotplug. Also delete redundant
declarations.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   31 +++++++++++++++++++++++++------
 include/linux/dmar.h        |   23 +----------------------
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5a411e8..fffe3d1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -380,6 +380,29 @@ struct device_domain_info {
 	struct dmar_domain *domain; /* pointer to domain */
 };
 
+struct dmar_rmrr_unit {
+	struct list_head list;		/* list of rmrr units	*/
+	struct acpi_dmar_header *hdr;	/* ACPI header		*/
+	u64	base_address;		/* reserved base address*/
+	u64	end_address;		/* reserved end address */
+	struct pci_dev **devices;	/* target devices */
+	int	devices_cnt;		/* target device count */
+};
+
+struct dmar_atsr_unit {
+	struct list_head list;		/* list of ATSR units */
+	struct acpi_dmar_header *hdr;	/* ACPI header */
+	struct pci_dev **devices;	/* target devices */
+	int devices_cnt;		/* target device count */
+	u8 include_all:1;		/* include all ports */
+};
+
+static LIST_HEAD(dmar_atsr_units);
+static LIST_HEAD(dmar_rmrr_units);
+
+#define for_each_rmrr_units(rmrr) \
+	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
+
 static void flush_unmaps_timeout(unsigned long data);
 
 static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
@@ -403,6 +426,8 @@ static int timer_on;
 static long list_size;
 
 static void domain_remove_dev_info(struct dmar_domain *domain);
+static void domain_remove_one_dev_info(struct dmar_domain *domain,
+				       struct pci_dev *pdev);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -2243,8 +2268,6 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static void domain_remove_one_dev_info(struct dmar_domain *domain,
-					  struct pci_dev *pdev);
 static int identity_mapping(struct pci_dev *pdev)
 {
 	struct device_domain_info *info;
@@ -3432,8 +3455,6 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
-LIST_HEAD(dmar_rmrr_units);
-
 static void __init dmar_register_rmrr_unit(struct dmar_rmrr_unit *rmrr)
 {
 	list_add(&rmrr->list, &dmar_rmrr_units);
@@ -3470,8 +3491,6 @@ rmrr_parse_dev(struct dmar_rmrr_unit *rmrru)
 				    rmrr->segment);
 }
 
-static LIST_HEAD(dmar_atsr_units);
-
 int __init dmar_parse_one_atsr(struct acpi_dmar_header *hdr)
 {
 	struct acpi_dmar_atsr *atsr;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 1b08ce8..ea599d4 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -139,28 +139,7 @@ extern int arch_setup_dmar_msi(unsigned int irq);
 
 #ifdef CONFIG_INTEL_IOMMU
 extern int iommu_detected, no_iommu;
-extern struct list_head dmar_rmrr_units;
-struct dmar_rmrr_unit {
-	struct list_head list;		/* list of rmrr units	*/
-	struct acpi_dmar_header *hdr;	/* ACPI header		*/
-	u64	base_address;		/* reserved base address*/
-	u64	end_address;		/* reserved end address */
-	struct pci_dev **devices;	/* target devices */
-	int	devices_cnt;		/* target device count */
-};
-
-#define for_each_rmrr_units(rmrr) \
-	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
-
-struct dmar_atsr_unit {
-	struct list_head list;		/* list of ATSR units */
-	struct acpi_dmar_header *hdr;	/* ACPI header */
-	struct pci_dev **devices;	/* target devices */
-	int devices_cnt;		/* target device count */
-	u8 include_all:1;		/* include all ports */
-};
-
-int dmar_parse_rmrr_atsr_dev(void);
+extern int dmar_parse_rmrr_atsr_dev(void);
 extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header);
 extern int dmar_parse_one_atsr(struct acpi_dmar_header *header);
 extern int intel_iommu_init(void);
-- 
1.7.10.4
