From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu/arm-smmu: Fix broken ATOS check
Date: Mon, 29 Jun 2015 17:47:42 +0100
Message-ID: <1435596463-19247-2-git-send-email-will.deacon@arm.com>
References: <1435596463-19247-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1435596463-19247-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Commit 83a60ed8f0b5 ("iommu/arm-smmu: fix ARM_SMMU_FEAT_TRANS_OPS
condition") accidentally negated the ID0_ATOSNS predicate in the ATOS
feature check, causing the driver to attempt ATOS requests on SMMUv2
hardware without the ATOS feature implemented.

This patch restores the predicate to the correct value.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.0+
Reported-by: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index dce041b1c139..4cd0c29cb585 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1566,7 +1566,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
-	if ((id & ID0_S1TS) && ((smmu->version == 1) || (id & ID0_ATOSNS))) {
+	if ((id & ID0_S1TS) && ((smmu->version == 1) || !(id & ID0_ATOSNS))) {
 		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
 		dev_notice(smmu->dev, "\taddress translation ops\n");
 	}
-- 
2.1.4
