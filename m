From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 5/5] iommu/arm-smmu: prefer stage-1 mappings where we have a
	choice
Date: Mon, 30 Jun 2014 11:52:10 +0100
Message-ID: <1404125530-17984-6-git-send-email-will.deacon@arm.com>
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

For an SMMU that supports both Stage-1 and Stage-2 mappings (but not
nested translation), then we should prefer stage-1 mappings as we
otherwise rely on the memory attributes of the incoming transactions
for IOMMU_CACHE mappings.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60986de3ada8..a6e38982d09c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -876,12 +876,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		 */
 		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
-	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S2) {
-		cfg->cbar = CBAR_TYPE_S2_TRANS;
-		start = 0;
-	} else {
+	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S1) {
 		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
+	} else {
+		cfg->cbar = CBAR_TYPE_S2_TRANS;
+		start = 0;
 	}
 
 	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-- 
2.0.0
