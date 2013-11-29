From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/4] iommu/arm-smmu: use VA_BITS to determine arm64 virtual
	address space
Date: Fri, 29 Nov 2013 12:15:48 +0000
Message-ID: <1385727350-20032-3-git-send-email-will.deacon@arm.com>
References: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1385727350-20032-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

With the introduction of the VA_BITS definition for arm64, make use of
it in the driver, allowing up to 42-bits of VA space when configured
with 64k pages.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 879da20617fb..fa3371adea4f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -24,7 +24,7 @@
  *	- v7/v8 long-descriptor format
  *	- Non-secure access to the SMMU
  *	- 4k and 64k pages, with contiguous pte hints.
- *	- Up to 39-bit addressing
+ *	- Up to 42-bit addressing (dependent on VA_BITS)
  *	- Context fault reporting
  */
 
@@ -1747,7 +1747,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	 * allocation (PTRS_PER_PGD).
 	 */
 #ifdef CONFIG_64BIT
-	/* Current maximum output size of 39 bits */
 	smmu->s1_output_size = min(39UL, size);
 #else
 	smmu->s1_output_size = min(32UL, size);
@@ -1762,7 +1761,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	} else {
 #ifdef CONFIG_64BIT
 		size = (id >> ID2_UBS_SHIFT) & ID2_UBS_MASK;
-		size = min(39, arm_smmu_id_size_to_bits(size));
+		size = min(VA_BITS, arm_smmu_id_size_to_bits(size));
 #else
 		size = 32;
 #endif
-- 
1.8.2.2
