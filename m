From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] iommu/arm-smmu: Fix sign-extension of upstream bus addresses at stage 1
Date: Fri,  8 May 2015 17:44:22 +0100
Message-ID: <1431103462-8153-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, Varun.Sethi@freescale.com, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Stage 1 translation is controlled by two sets of page tables (TTBR0 and
TTBR1) which grow up and down from zero respectively in the ARMv8
translation regime. For the SMMU, we only care about TTBR0 and, in the
case of a 48-bit virtual space, we expect to map virtual addresses 0x0
through to 0xffff_ffff_ffff.

Given that some masters may be incapable of emitting virtual addresses
targetting TTBR1 (e.g. because they sit on a 48-bit bus), the SMMU
architecture allows bit 47 to be sign-extended, halving the virtual
range of TTBR0 but allowing TTBR1 to be used. This is controlled by the
SEP field in TTBCR2.

The SMMU driver incorrectly enables this sign-extension feature, which
causes problems when userspace addresses are programmed into a master
device with the SMMU expecting to map the incoming transactions via
TTBR0; if the top bit of address is set, we will instead get a
translation fault since TTBR1 walks are disabled in the TTBCR.

This patch fixes the issue by disabling sign-extension of a fixed
virtual address bit and instead basing the behaviour on the upstream bus
size: the incoming address is zero extended unless the upstream bus is
only 49 bits wide, in which case bit 48 is used as the sign bit and is
replicated to the upper bits.

Cc: <stable@vger.kernel.org> # v4.0+
Reported-by: Varun Sethi <varun.sethi@freescale.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hi Joerg,

I only have this one fix pending for arm-smmu, so please could you pick
it up for 4.1? I can send a pull if you'd prefer, but it feels a bit
OTT.

Will

 drivers/iommu/arm-smmu.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9f7e1d34a32b..66a803b9dd3a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -224,14 +224,7 @@
 #define RESUME_TERMINATE		(1 << 0)
 
 #define TTBCR2_SEP_SHIFT		15
-#define TTBCR2_SEP_MASK			0x7
-
-#define TTBCR2_ADDR_32			0
-#define TTBCR2_ADDR_36			1
-#define TTBCR2_ADDR_40			2
-#define TTBCR2_ADDR_42			3
-#define TTBCR2_ADDR_44			4
-#define TTBCR2_ADDR_48			5
+#define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
 
 #define TTBRn_HI_ASID_SHIFT            16
 
@@ -793,26 +786,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
 		if (smmu->version > ARM_SMMU_V1) {
 			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
-			switch (smmu->va_size) {
-			case 32:
-				reg |= (TTBCR2_ADDR_32 << TTBCR2_SEP_SHIFT);
-				break;
-			case 36:
-				reg |= (TTBCR2_ADDR_36 << TTBCR2_SEP_SHIFT);
-				break;
-			case 40:
-				reg |= (TTBCR2_ADDR_40 << TTBCR2_SEP_SHIFT);
-				break;
-			case 42:
-				reg |= (TTBCR2_ADDR_42 << TTBCR2_SEP_SHIFT);
-				break;
-			case 44:
-				reg |= (TTBCR2_ADDR_44 << TTBCR2_SEP_SHIFT);
-				break;
-			case 48:
-				reg |= (TTBCR2_ADDR_48 << TTBCR2_SEP_SHIFT);
-				break;
-			}
+			reg |= TTBCR2_SEP_UPSTREAM;
 			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR2);
 		}
 	} else {
-- 
2.1.4
