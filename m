From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/5] iommu/dmar: Rectify return code handling in
	detect_intel_iommu()
Date: Thu, 16 Mar 2017 16:23:51 +0200
Message-ID: <20170316142355.16307-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is inconsistency in return codes across the functions called from
detect_intel_iommu().

Make it consistent and propagate return code to the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 36e3f430d265..edcf7410f736 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -551,7 +551,7 @@ static int __init dmar_table_detect(void)
 		status = AE_NOT_FOUND;
 	}
 
-	return (ACPI_SUCCESS(status) ? 1 : 0);
+	return ACPI_SUCCESS(status) ? 0 : -ENOENT;
 }
 
 static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
@@ -891,17 +891,17 @@ int __init detect_intel_iommu(void)
 
 	down_write(&dmar_global_lock);
 	ret = dmar_table_detect();
-	if (ret)
-		ret = !dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
-					    &validate_drhd_cb);
-	if (ret && !no_iommu && !iommu_detected && !dmar_disabled) {
+	if (!ret)
+		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
+					   &validate_drhd_cb);
+	if (!ret && !no_iommu && !iommu_detected && !dmar_disabled) {
 		iommu_detected = 1;
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
 	}
 
 #ifdef CONFIG_X86
-	if (ret)
+	if (!ret)
 		x86_init.iommu.iommu_init = intel_iommu_init;
 #endif
 
@@ -911,10 +911,9 @@ int __init detect_intel_iommu(void)
 	}
 	up_write(&dmar_global_lock);
 
-	return ret ? 1 : -ENODEV;
+	return ret ? ret : 1;
 }
 
-
 static void unmap_iommu(struct intel_iommu *iommu)
 {
 	iounmap(iommu->reg);
-- 
2.11.0
