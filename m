From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 20/20] iommu/vt-d: free all resources if failed to
	initialize DMARs
Date: Mon,  6 Jan 2014 14:18:27 +0800
Message-ID: <1388989107-4795-21-git-send-email-jiang.liu@linux.intel.com>
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

Enhance intel_iommu_init() to free all resources if failed to
initialize DMAR hardware.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   81 ++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c28e9fe..0863e25 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2615,6 +2615,7 @@ static int __init init_dmars(void)
 error:
 	for_each_active_iommu(iommu, drhd)
 		free_dmar_iommu(iommu);
+	kfree(deferred_flush);
 	kfree(g_iommus);
 	g_iommus = NULL;
 	return ret;
@@ -3459,18 +3460,12 @@ static int __init
 rmrr_parse_dev(struct dmar_rmrr_unit *rmrru)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
-	int ret;
 
 	rmrr = (struct acpi_dmar_reserved_memory *) rmrru->hdr;
-	ret = dmar_parse_dev_scope((void *)(rmrr + 1),
-		((void *)rmrr) + rmrr->header.length,
-		&rmrru->devices_cnt, &rmrru->devices, rmrr->segment);
-
-	if (ret || (rmrru->devices_cnt == 0)) {
-		list_del(&rmrru->list);
-		kfree(rmrru);
-	}
-	return ret;
+	return dmar_parse_dev_scope((void *)(rmrr + 1),
+				    ((void *)rmrr) + rmrr->header.length,
+				    &rmrru->devices_cnt, &rmrru->devices,
+				    rmrr->segment);
 }
 
 static LIST_HEAD(dmar_atsr_units);
@@ -3495,23 +3490,39 @@ int __init dmar_parse_one_atsr(struct acpi_dmar_header *hdr)
 
 static int __init atsr_parse_dev(struct dmar_atsr_unit *atsru)
 {
-	int rc;
 	struct acpi_dmar_atsr *atsr;
 
 	if (atsru->include_all)
 		return 0;
 
 	atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
-	rc = dmar_parse_dev_scope((void *)(atsr + 1),
-				(void *)atsr + atsr->header.length,
-				&atsru->devices_cnt, &atsru->devices,
-				atsr->segment);
-	if (rc || !atsru->devices_cnt) {
-		list_del(&atsru->list);
-		kfree(atsru);
+	return dmar_parse_dev_scope((void *)(atsr + 1),
+				    (void *)atsr + atsr->header.length,
+				    &atsru->devices_cnt, &atsru->devices,
+				    atsr->segment);
+}
+
+static void intel_iommu_free_atsr(struct dmar_atsr_unit *atsru)
+{
+	dmar_free_dev_scope(&atsru->devices, &atsru->devices_cnt);
+	kfree(atsru);
+}
+
+static void intel_iommu_free_dmars(void)
+{
+	struct dmar_rmrr_unit *rmrru, *rmrr_n;
+	struct dmar_atsr_unit *atsru, *atsr_n;
+
+	list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
+		list_del(&rmrru->list);
+		dmar_free_dev_scope(&rmrru->devices, &rmrru->devices_cnt);
+		kfree(rmrru);
 	}
 
-	return rc;
+	list_for_each_entry_safe(atsru, atsr_n, &dmar_atsr_units, list) {
+		list_del(&atsru->list);
+		intel_iommu_free_atsr(atsru);
+	}
 }
 
 int dmar_find_matched_atsr_unit(struct pci_dev *dev)
@@ -3555,17 +3566,17 @@ found:
 
 int __init dmar_parse_rmrr_atsr_dev(void)
 {
-	struct dmar_rmrr_unit *rmrr, *rmrr_n;
-	struct dmar_atsr_unit *atsr, *atsr_n;
+	struct dmar_rmrr_unit *rmrr;
+	struct dmar_atsr_unit *atsr;
 	int ret = 0;
 
-	list_for_each_entry_safe(rmrr, rmrr_n, &dmar_rmrr_units, list) {
+	list_for_each_entry(rmrr, &dmar_rmrr_units, list) {
 		ret = rmrr_parse_dev(rmrr);
 		if (ret)
 			return ret;
 	}
 
-	list_for_each_entry_safe(atsr, atsr_n, &dmar_atsr_units, list) {
+	list_for_each_entry(atsr, &dmar_atsr_units, list) {
 		ret = atsr_parse_dev(atsr);
 		if (ret)
 			return ret;
@@ -3612,7 +3623,7 @@ static struct notifier_block device_nb = {
 
 int __init intel_iommu_init(void)
 {
-	int ret = 0;
+	int ret = -ENODEV;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
@@ -3622,7 +3633,7 @@ int __init intel_iommu_init(void)
 	if (dmar_table_init()) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
-		return 	-ENODEV;
+		goto out_free_dmar;
 	}
 
 	/*
@@ -3635,16 +3646,16 @@ int __init intel_iommu_init(void)
 	if (dmar_dev_scope_init() < 0) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR device scope\n");
-		return 	-ENODEV;
+		goto out_free_dmar;
 	}
 
 	if (no_iommu || dmar_disabled)
-		return -ENODEV;
+		goto out_free_dmar;
 
 	if (iommu_init_mempool()) {
 		if (force_on)
 			panic("tboot: Failed to initialize iommu memory\n");
-		return 	-ENODEV;
+		goto out_free_dmar;
 	}
 
 	if (list_empty(&dmar_rmrr_units))
@@ -3656,7 +3667,7 @@ int __init intel_iommu_init(void)
 	if (dmar_init_reserved_ranges()) {
 		if (force_on)
 			panic("tboot: Failed to reserve iommu ranges\n");
-		return 	-ENODEV;
+		goto out_free_mempool;
 	}
 
 	init_no_remapping_devices();
@@ -3666,9 +3677,7 @@ int __init intel_iommu_init(void)
 		if (force_on)
 			panic("tboot: Failed to initialize DMARs\n");
 		printk(KERN_ERR "IOMMU: dmar init failed\n");
-		put_iova_domain(&reserved_iova_list);
-		iommu_exit_mempool();
-		return ret;
+		goto out_free_reserved_range;
 	}
 	printk(KERN_INFO
 	"PCI-DMA: Intel(R) Virtualization Technology for Directed I/O\n");
@@ -3688,6 +3697,14 @@ int __init intel_iommu_init(void)
 	intel_iommu_enabled = 1;
 
 	return 0;
+
+out_free_reserved_range:
+	put_iova_domain(&reserved_iova_list);
+out_free_mempool:
+	iommu_exit_mempool();
+out_free_dmar:
+	intel_iommu_free_dmars();
+	return ret;
 }
 
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
-- 
1.7.10.4
