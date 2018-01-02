From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu-v3: Cope with duplicated Stream IDs
Date: Tue,  2 Jan 2018 12:33:14 +0000
Message-ID: <13744c7ba2af61bc39b68e9ab05ab8482f928334.1514896042.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Tomasz.Nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

For PCI devices behind an aliasing PCIe-to-PCI/X bridge, the bridge
alias to DevFn 0.0 on the subordinate bus may match the original RID of
the device, resulting in the same SID being present in the device's
fwspec twice. This causes trouble later in arm_smmu_write_strtab_ent()
when we wind up visiting the STE a second time and find it already live.

Avoid the issue by giving arm_smmu_install_ste_for_dev() the cleverness
to skip over duplicates. It seems mildly counterintuitive compared to
preventing the duplicates from existing in the first place, but since
the DT and ACPI probe paths build their fwspecs differently, this is
actually the cleanest and most self-contained way to deal with it.

Fixes: 8f78515425da ("iommu/arm-smmu: Implement of_xlate() for SMMUv3")
Reported-by: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Tested-by: Jayachandran C. <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 9ce3cde575a8..57c92aa3122e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1752,7 +1752,7 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 
 static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 {
-	int i;
+	int i, j;
 	struct arm_smmu_master_data *master = fwspec->iommu_priv;
 	struct arm_smmu_device *smmu = master->smmu;
 
@@ -1760,6 +1760,13 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 		u32 sid = fwspec->ids[i];
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
+		/* Bridged PCI devices may end up with duplicated IDs */
+		for (j = 0; j < i; j++)
+			if (fwspec->ids[j] == sid)
+				break;
+		if (j < i)
+			continue;
+
 		arm_smmu_write_strtab_ent(smmu, sid, step, &master->ste);
 	}
 }
-- 
2.13.4.dirty
