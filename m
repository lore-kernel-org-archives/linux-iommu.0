From: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: [PATCH] iommu: arm-smmu-v2: Enable 16 bit ASID
Date: Sat, 22 Oct 2016 10:32:04 +0530
Message-ID: <1477112524-13023-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc: Prasun.Kapoor@cavium.com, Geetha sowjanya <gakula@caviumnetworks.com>, Tirumalesh.Chalamarla@cavium.com, iommu@lists.linux-foundation.org, Geetha sowjanya <gakula@cavium.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

 Support up to 16 bit ASID. This patch enables
 16 bit ASID when supported.

Signed-off-by: Geetha sowjanya <gakula@cavium.com>
Acked-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
---
 drivers/iommu/arm-smmu.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c841eb7..9740846 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -258,6 +258,9 @@ enum arm_smmu_s2cr_privcfg {
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
 
+#define TTBCR2_AS_SHIFT			4
+#define TTBCR2_AS_ENABLE		(1 << TTBCR2_AS_SHIFT)
+
 #define TTBRn_ASID_SHIFT		48
 
 #define FSR_MULTI			(1 << 31)
@@ -773,6 +776,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
 			reg2 |= TTBCR2_SEP_UPSTREAM;
+		/* Enable 16 bit ASID if 16 bit VMID is supported */
+			if (smmu->features & ARM_SMMU_FEAT_VMID16)
+				reg |= TTBCR2_AS_ENABLE;
 		}
 		if (smmu->version > ARM_SMMU_V1)
 			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
-- 
1.7.1
