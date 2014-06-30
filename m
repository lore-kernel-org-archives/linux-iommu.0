From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/5] iommu/arm-smmu: caps: add IOMMU_CAP_INTR_REMAP capability
Date: Mon, 30 Jun 2014 11:52:08 +0100
Message-ID: <1404125530-17984-4-git-send-email-will.deacon@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404125530-17984-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

MSIs are just seen as bog standard memory writes by the ARM SMMU, so
they can be translated (and isolated) in the same way.

This patch adds the IOMMU_CAP_INTR_REMAP capability to the ARM SMMU
driver and reworks our capabaility code so that we don't assume the
caps are organised as bits in a bitmask (since this isn't the intention).

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e4eebc50612c..835d01f47302 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1606,13 +1606,17 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 				   unsigned long cap)
 {
-	unsigned long caps = 0;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+	u32 features = smmu_domain->root_cfg.smmu->features;
 
-	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
-		caps |= IOMMU_CAP_CACHE_COHERENCY;
-
-	return !!(cap & caps);
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return features & ARM_SMMU_FEAT_COHERENT_WALK;
+	case IOMMU_CAP_INTR_REMAP:
+		return 1; /* MSIs are just memory writes */
+	default:
+		return 0;
+	}
 }
 
 static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *data)
-- 
2.0.0
