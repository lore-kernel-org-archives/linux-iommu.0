From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/12] iommu/arm-smmu: Convert to iommu_capable() API function
Date: Fri,  5 Sep 2014 12:52:56 +0200
Message-ID: <1409914384-21191-5-git-send-email-joro@8bytes.org>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409914384-21191-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d..47c2cb6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1515,20 +1515,37 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
-static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
-				   unsigned long cap)
+static bool arm_smmu_capable(enum iommu_cap cap)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	u32 features = smmu ? smmu->features : 0;
+	struct arm_smmu_device *smmu;
+	bool ret = false;
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-		return features & ARM_SMMU_FEAT_COHERENT_WALK;
+		/*
+		 * Use ARM_SMMU_FEAT_COHERENT_WALK as an indicator on whether
+		 * the SMMU can force coherency on the DMA transaction. If it
+		 * supports COHERENT_WALK it must be behind a coherent
+		 * interconnect.
+		 * A domain can be attached to any SMMU, so to reliably support
+		 * IOMMU_CAP_CACHE_COHERENCY all SMMUs in the system need to be
+		 * behind a coherent interconnect.
+		 */
+		spin_lock(&arm_smmu_devices_lock);
+		list_for_each_entry(smmu, &arm_smmu_devices, list) {
+			if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+				ret = true;
+			} else {
+				ret = false;
+				break;
+			}
+		}
+		spin_unlock(&arm_smmu_devices_lock);
+		return ret;
 	case IOMMU_CAP_INTR_REMAP:
-		return 1; /* MSIs are just memory writes */
+		return true; /* MSIs are just memory writes */
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -1598,6 +1615,7 @@ static void arm_smmu_remove_device(struct device *dev)
 }
 
 static const struct iommu_ops arm_smmu_ops = {
+	.capable	= arm_smmu_capable,
 	.domain_init	= arm_smmu_domain_init,
 	.domain_destroy	= arm_smmu_domain_destroy,
 	.attach_dev	= arm_smmu_attach_dev,
@@ -1605,7 +1623,6 @@ static const struct iommu_ops arm_smmu_ops = {
 	.map		= arm_smmu_map,
 	.unmap		= arm_smmu_unmap,
 	.iova_to_phys	= arm_smmu_iova_to_phys,
-	.domain_has_cap	= arm_smmu_domain_has_cap,
 	.add_device	= arm_smmu_add_device,
 	.remove_device	= arm_smmu_remove_device,
 	.pgsize_bitmap	= (SECTION_SIZE |
-- 
1.9.1
