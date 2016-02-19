From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 6/6] iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass for now
Date: Fri, 19 Feb 2016 17:46:43 +0000
Message-ID: <1455904003-28069-7-git-send-email-will.deacon@arm.com>
References: <1455904003-28069-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455904003-28069-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Until all upstream devices have their DMA ops swizzled to point at the
SMMU, we need to treat the IOMMU_DOMAIN_DMA domain as bypass to avoid
putting devices into an empty address space when detaching from VFIO.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 drivers/iommu/arm-smmu.c    | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d96d45ddf500..4ff73ff64e49 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1687,7 +1687,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 
 	smmu_group->domain	= smmu_domain;
-	smmu_group->ste.bypass	= false;
+
+	/*
+	 * FIXME: This should always be "false" once we have IOMMU-backed
+	 * DMA ops for all devices behind the SMMU.
+	 */
+	smmu_group->ste.bypass	= domain->type == IOMMU_DOMAIN_DMA;
 
 	ret = arm_smmu_install_ste_for_group(smmu_group);
 	if (IS_ERR_VALUE(ret))
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f21332a15040..2409e3bd3df2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1094,6 +1094,13 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		return ret == -EEXIST ? 0 : ret;
 
+	/*
+	 * FIXME: This won't be needed once we have IOMMU-backed DMA ops
+	 * for all devices behind the SMMU.
+	 */
+	if (smmu_domain->domain.type == IOMMU_DOMAIN_DMA)
+		return 0;
+
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx, s2cr;
 
-- 
2.1.4
