From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] iommu: arm-smmu: avoid build warning
Date: Fri, 30 Jan 2015 22:55:55 +0100
Message-ID: <1754709.y30A9Ie4hF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ARM allmodconfig gained a new warning when dma_addr_t is 32-bit wide:

drivers/iommu/arm-smmu.c: In function 'arm_smmu_iova_to_phys_hard':
drivers/iommu/arm-smmu.c:1255:3: warning: right shift count >= width of type

This changes the calculation so that the effective type is always
64-bit.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: 859a732e4f713 ("iommu/arm-smmu: add support for iova_to_phys through ATS1PR")

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d6d43bb3395..fc13dd56953e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1252,7 +1252,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	} else {
 		u32 reg = iova & ~0xfff;
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
-		reg = (iova & ~0xfff) >> 32;
+		reg = ((u64)iova & ~0xfff) >> 32;
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
 	}
 
