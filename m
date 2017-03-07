From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/4] iommu/arm-smmu: Handle size mismatches better
Date: Tue,  7 Mar 2017 18:09:04 +0000
Message-ID: <6e61306e6823943b3eeb0c405d4505dd565e723e.1488907474.git.robin.murphy@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1488907474.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We currently warn if the firmware-described region size differs from the
SMMU address space size reported by the hardware, but continue to use
the former to calculate where our context bank base should be,
effectively guaranteeing that things will not work correctly.

Since over-mapping is effectively harmless, and under-mapping can be OK
provided all the usable context banks are still covered, let's let the
hardware information take precedence in the case of a mismatch, such
that we get the correct context bank base and in most cases things will
actually work instead of silently misbehaving. And at worst, if the
firmware is wrong enough to have not mapped something we actually try to
use, the resulting out-of-bounds access will hopefully provide a much
more obvious clue.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index abf6496843a6..bc7ef6a0c54d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1864,10 +1864,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	/* Check for size mismatch of SMMU address space from mapped region */
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
 	size *= 2 << smmu->pgshift;
-	if (smmu->size != size)
+	if (smmu->size != size) {
 		dev_warn(smmu->dev,
 			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
 			size, smmu->size);
+		smmu->size = size;
+	}
 
 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) & ID1_NUMS2CB_MASK;
 	smmu->num_context_banks = (id >> ID1_NUMCB_SHIFT) & ID1_NUMCB_MASK;
-- 
2.11.0.dirty
