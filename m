From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/7] iommu/arm-smmu: fix programming of SMMU_CBn_TCR for stage
	1
Date: Fri, 29 Aug 2014 15:47:42 +0100
Message-ID: <1409323665-9605-5-git-send-email-will.deacon@arm.com>
References: <1409323665-9605-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409323665-9605-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: vladimir.murzin-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Stage-1 context banks do not have the SMMU_CBn_TCR[SL0] field since it
is only applicable to stage-2 context banks.

This patch ensures that we don't set the reserved TCR bits for stage-1
translations.

Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 34dc7b1cec3c..b03959ddb32c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -854,8 +854,11 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	reg |= TTBCR_EAE |
 	      (TTBCR_SH_IS << TTBCR_SH0_SHIFT) |
 	      (TTBCR_RGN_WBWA << TTBCR_ORGN0_SHIFT) |
-	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT) |
-	      (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
+	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT);
+
+	if (!stage1)
+		reg |= (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
+
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
 
 	/* MAIR0 (stage-1 only) */
-- 
2.1.0
