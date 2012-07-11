From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/27] iommu/amd: Introduce early_amd_iommu_init routine
Date: Wed, 11 Jul 2012 15:38:52 +0200
Message-ID: <1342013952-10174-8-git-send-email-joerg.roedel@amd.com>
References: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342013952-10174-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Split out the code to parse the ACPI table and setup
relevant data structures into a new function.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      |    1 -
 drivers/iommu/amd_iommu_init.c |   38 +++++++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a0ccdcb..45ee0a3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -382,7 +382,6 @@ DECLARE_STATS_COUNTER(invalidate_iotlb);
 DECLARE_STATS_COUNTER(invalidate_iotlb_all);
 DECLARE_STATS_COUNTER(pri_requests);
 
-
 static struct dentry *stats_dir;
 static struct dentry *de_fflush;
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index bcdcaac..49e16bb 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1491,17 +1491,14 @@ static void __init free_on_init_error(void)
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
@@ -1588,16 +1585,6 @@ int __init amd_iommu_init_hardware(void)
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
 	early_acpi_os_unmap_memory((char __iomem *)ivrs_base, ivrs_size);
@@ -1611,6 +1598,27 @@ free:
 	goto out;
 }
 
+int __init amd_iommu_init_hardware(void)
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
-- 
1.7.9.5
