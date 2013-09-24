From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 7/7] iommu/arm-smmu: Clear global and context bank fault
 status and syndrome registers
Date: Tue, 24 Sep 2013 17:07:01 +0200
Message-ID: <1380035221-11576-8-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 251564e..a499146 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -645,6 +645,10 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	stage1 = root_cfg->cbar != CBAR_TYPE_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
 
+	/* clear fsr */
+	writel_relaxed(0xffffffff, cb_base + ARM_SMMU_CB_FSR);
+	writel_relaxed(0, cb_base + ARM_SMMU_CB_FSYNR0);
+
 	/* CBAR */
 	reg = root_cfg->cbar;
 	if (smmu->version == 1)
@@ -1570,6 +1574,11 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	int i = 0;
 	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
 
+	/* clear global FSRs */
+	writel(0xffffffff, gr0_base + ARM_SMMU_GR0_sGFSR);
+	writel(0, gr0_base + ARM_SMMU_GR0_sGFSYNR0);
+	writel(0, gr0_base + ARM_SMMU_GR0_sGFSYNR1);
+
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
-- 
1.7.9.5
