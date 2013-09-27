From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Refine check for proper size of mapped region
Date: Fri, 27 Sep 2013 16:33:56 +0200
Message-ID: <20130927143356.GS3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-3-git-send-email-andreas.herrmann@calxeda.com>
	<20130927095157.GA9057@mudshark.cambridge.arm.com>
	<20130927102359.GL3315@alberich>
	<20130927105153.GG9057@mudshark.cambridge.arm.com>
	<20130927110521.GO3315@alberich>
	<20130927110832.GC9520@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130927110832.GC9520-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


There is already a check to print a warning if the size of SMMU
address space (calculated from SMMU register values) is greater than
the size of the mapped memory region (e.g. passed via DT to the
driver).

Adapt this check to print also a warning in case the mapped region is
larger than the SMMU address space.

Such a mismatch could be intentional (to fix wrong register values).
If its not intentional (e.g. due to wrong DT information) this will
very likely cause a malfunction of the driver as SMMU_CB_BASE is
derived from the size of the mapped region. The warning helps to
identify the root cause in this case.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

FYI, posted the patch to the mail thread for reference.
I'll send updated patches as a series asap.


Andreas

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 548f5d1..d19676c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1700,13 +1700,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID1);
 	smmu->pagesize = (id & ID1_PAGESIZE) ? SZ_64K : SZ_4K;
 
-	/* Check that we ioremapped enough */
+	/* Check for size mismatch of SMMU address space from mapped region */
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
 	size *= (smmu->pagesize << 1);
-	if (smmu->size < size)
-		dev_warn(smmu->dev,
-			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
-			 size, smmu->size);
+	if (smmu->size != size)
+		dev_warn(smmu->dev, "SMMU address space size (0x%lx) differs "
+			"from mapped region size (0x%lx)!\n", size, smmu->size);
 
 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) &
 				      ID1_NUMS2CB_MASK;
-- 
1.7.9.5
