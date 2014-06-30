From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/5] iommu/arm-smmu: fix calculation of TCR.T0SZ
Date: Mon, 30 Jun 2014 11:52:06 +0100
Message-ID: <1404125530-17984-2-git-send-email-will.deacon@arm.com>
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

T0SZ controls the input address range for TTBR0, so use the input
address range rather than the output address range for the calculation.
For stage-2, this means using the output size of stage-1.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1599354e974d..81e8ec290756 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -800,6 +800,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			reg = TTBCR_TG0_64K;
 
 		if (!stage1) {
+			reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+
 			switch (smmu->s2_output_size) {
 			case 32:
 				reg |= (TTBCR2_ADDR_32 << TTBCR_PASIZE_SHIFT);
@@ -821,7 +823,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 				break;
 			}
 		} else {
-			reg |= (64 - smmu->s1_output_size) << TTBCR_T0SZ_SHIFT;
+			reg |= (64 - smmu->input_size) << TTBCR_T0SZ_SHIFT;
 		}
 	} else {
 		reg = 0;
-- 
2.0.0
