From: wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [iommu:irq-remapping 7/28] WARNING:
	drivers/iommu/built-in.o(.text+0x617a): Section mismatch in reference
	from the function amd_iommu_init_pci() to the function
	.init.text:amd_iommu_init_devices()
Date: Fri, 6 Jul 2012 01:38:00 +0800
Message-ID: <20120705173800.GA16714@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

There are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git irq-remapping
head:   afd6b14061a786c34b41722d35035d0eeecae55c
commit: ac2ff05e6451271c6744e9c9d9742de40575dbce [7/28] iommu/amd: Introduce early_amd_iommu_init routine

All warnings:


WARNING: drivers/iommu/built-in.o(.text+0x617a): Section mismatch in reference from the function amd_iommu_init_pci() to the function .init.text:amd_iommu_init_devices()
The function amd_iommu_init_pci() references
the function __init amd_iommu_init_devices().
This is often because amd_iommu_init_pci lacks a __init 
annotation or the annotation of amd_iommu_init_devices is wrong.


WARNING: drivers/iommu/built-in.o(.text+0x6a18): Section mismatch in reference from the function amd_iommu_init_hardware() to the function .init.text:early_amd_iommu_init()
The function amd_iommu_init_hardware() references
the function __init early_amd_iommu_init().
This is often because amd_iommu_init_hardware lacks a __init 
annotation or the annotation of early_amd_iommu_init is wrong.


WARNING: drivers/built-in.o(.text+0x13ec1a): Section mismatch in reference from the function amd_iommu_init_pci() to the function .init.text:amd_iommu_init_devices()
The function amd_iommu_init_pci() references
the function __init amd_iommu_init_devices().
This is often because amd_iommu_init_pci lacks a __init 
annotation or the annotation of amd_iommu_init_devices is wrong.


WARNING: drivers/built-in.o(.text+0x13f4b8): Section mismatch in reference from the function amd_iommu_init_hardware() to the function .init.text:early_amd_iommu_init()
The function amd_iommu_init_hardware() references
the function __init early_amd_iommu_init().
This is often because amd_iommu_init_hardware lacks a __init 
annotation or the annotation of early_amd_iommu_init is wrong.


WARNING: vmlinux.o(.text+0x4de732): Section mismatch in reference from the function amd_iommu_init_pci() to the function .init.text:amd_iommu_init_devices()
The function amd_iommu_init_pci() references
the function __init amd_iommu_init_devices().
This is often because amd_iommu_init_pci lacks a __init 
annotation or the annotation of amd_iommu_init_devices is wrong.


WARNING: vmlinux.o(.text+0x4defd0): Section mismatch in reference from the function amd_iommu_init_hardware() to the function .init.text:early_amd_iommu_init()
The function amd_iommu_init_hardware() references
the function __init early_amd_iommu_init().
This is often because amd_iommu_init_hardware lacks a __init 
annotation or the annotation of early_amd_iommu_init is wrong.

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu <wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>                     Intel Corporation

--XsQoSWH+UP9D9v3l
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-iommu-amd-Introduce-early_amd_iommu_init-routine.patch"

>From ac2ff05e6451271c6744e9c9d9742de40575dbce Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 12 Jun 2012 12:09:35 +0200
Subject: [PATCH] iommu/amd: Introduce early_amd_iommu_init routine

Split out the code to parse the ACPI table and setup
relevant data structures into a new function.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      |    1 -
 drivers/iommu/amd_iommu_init.c |   38 +++++++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a2e418c..cfa01c4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -376,19 +376,18 @@ DECLARE_STATS_COUNTER(cross_page);
 DECLARE_STATS_COUNTER(domain_flush_single);
 DECLARE_STATS_COUNTER(domain_flush_all);
 DECLARE_STATS_COUNTER(alloced_io_mem);
 DECLARE_STATS_COUNTER(total_map_requests);
 DECLARE_STATS_COUNTER(complete_ppr);
 DECLARE_STATS_COUNTER(invalidate_iotlb);
 DECLARE_STATS_COUNTER(invalidate_iotlb_all);
 DECLARE_STATS_COUNTER(pri_requests);
 
-
 static struct dentry *stats_dir;
 static struct dentry *de_fflush;
 
 static void amd_iommu_stats_add(struct __iommu_counter *cnt)
 {
 	if (stats_dir == NULL)
 		return;
 
 	cnt->dent = debugfs_create_u64(cnt->name, 0444, stats_dir,
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e6782fa..1b23235 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1488,29 +1488,26 @@ static void __init free_on_init_error(void)
  *
  *	3 pass) After the basic data structures are allocated and
  *		initialized we update them with information about memory
  *		remapping requirements parsed out of the ACPI table in
  *		this last pass.
  *
  * After everything is set up the IOMMUs are enabled and the necessary
  * hotplug and suspend notifiers are registered.
  */
-int __init amd_iommu_init_hardware(void)
+static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
 	acpi_size ivrs_size;
 	acpi_status status;
 	int i, ret = 0;
 
-	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
-		return -ENODEV;
-
-	if (amd_iommu_disabled || !amd_iommu_detected)
+	if (!amd_iommu_detected)
 		return -ENODEV;
 
 	if (amd_iommu_dev_table != NULL) {
 		/* Hardware already initialized */
 		return 0;
 	}
 
 	status = acpi_get_table_with_size("IVRS", 0, &ivrs_base, &ivrs_size);
 	if (status == AE_NOT_FOUND)
@@ -1585,41 +1582,52 @@ int __init amd_iommu_init_hardware(void)
 	 */
 	ret = init_iommu_all(ivrs_base);
 	if (ret)
 		goto free;
 
 	ret = init_memory_definitions(ivrs_base);
 	if (ret)
 		goto free;
 
-	ret = amd_iommu_init_pci();
-	if (ret)
-		goto free;
-
-	enable_iommus();
-
-	amd_iommu_init_notifier();
-
-	register_syscore_ops(&amd_iommu_syscore_ops);
-
 out:
 	/* Don't leak any ACPI memory */
 	early_acpi_os_unmap_memory((char *)ivrs_base, ivrs_size);
 	ivrs_base = NULL;
 
 	return ret;
 
 free:
 	free_on_init_error();
 
 	goto out;
 }
 
+int amd_iommu_init_hardware(void)
+{
+	int ret = 0;
+
+	ret = early_amd_iommu_init();
+	if (ret)
+		return ret;
+
+	ret = amd_iommu_init_pci();
+	if (ret)
+		return ret;
+
+	enable_iommus();
+
+	amd_iommu_init_notifier();
+
+	register_syscore_ops(&amd_iommu_syscore_ops);
+
+	return ret;
+}
+
 static int amd_iommu_enable_interrupts(void)
 {
 	struct amd_iommu *iommu;
 	int ret = 0;
 
 	for_each_iommu(iommu) {
 		ret = iommu_init_msi(iommu);
 		if (ret)
 			goto out;
-- 
1.7.10


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--XsQoSWH+UP9D9v3l--
