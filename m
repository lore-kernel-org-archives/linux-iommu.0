From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
Date: Tue, 19 Feb 2019 15:54:40 +0800
Message-ID: <20190219075443.17732-3-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

To reduce the risk of further crash, the device_shutdown() was not called
by the first kernel. That means some devices may still working in the
secondary kernel. For example, a netcard may still using ring buffer to
receive the broadcast messages in the kdump kernel. No events are reported
utill the related smmu reinitialized by the kdump kernel.

commit b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is
enabled in kdump kernel") set SMMU_GBPA.ABORT to prevent the unexpected
devices accessing, but it also prevent the devices accessing which we
needed, like hard disk, netcard.

In fact, we can use STE.config=0b000 to abort the unexpected devices
accessing only. As below:
1. In the first kernel, all buffers used by the "unexpected" devices are
   correctly mapped, and it will not be used by the secondary kernel
   because the latter has its dedicated reserved memory.
2. In the secondary kernel, set SMMU_GBPA.ABORT=1 before "disable smmu".
3. In the secondary kernel, after the smmu was disabled, preset all
   STE.config=0b000. For 2-level Stream Table, make all L1STD.l2ptr
   pointer to a dummy L2ST. The dummy L2ST is shared by all L1STDs.
4. In the secondary kernel, enable smmu. For the needed devices, allocate
   new L2STs accordingly.

For phase 1 and 2, the unexpected devices base the old mapping access
memory, it will not corrupt others. For phase 3, SMMU_GBPA abort it. For
phase 4 STE abort it.

Fixes: commit b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions ...")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 72 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2072897..c3c4ff2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1219,35 +1219,57 @@ static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
 	}
 }

-static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+static int __arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+				     struct arm_smmu_strtab_l1_desc *desc)
 {
-	size_t size;
 	void *strtab;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[sid >> STRTAB_SPLIT];

-	if (desc->l2ptr)
-		return 0;
-
-	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
 	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];

-	desc->span = STRTAB_SPLIT + 1;
-	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
-					  GFP_KERNEL | __GFP_ZERO);
 	if (!desc->l2ptr) {
-		dev_err(smmu->dev,
-			"failed to allocate l2 stream table for SID %u\n",
-			sid);
-		return -ENOMEM;
+		size_t size;
+
+		size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
+		desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+						  &desc->l2ptr_dma,
+						  GFP_KERNEL | __GFP_ZERO);
+		if (!desc->l2ptr) {
+			dev_err(smmu->dev,
+				"failed to allocate l2 stream table for SID %u\n",
+				sid);
+			return -ENOMEM;
+		}
+
+		desc->span = STRTAB_SPLIT + 1;
+		arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	}

-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
+	return 0;
+}
+
+static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	int ret;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[sid >> STRTAB_SPLIT];
+
+	ret = __arm_smmu_init_l2_strtab(smmu, sid, desc);
+	if (ret)
+		return ret;
+
 	arm_smmu_sync_std_for_sid(smmu, sid);
 	return 0;
 }

+static int arm_smmu_init_dummy_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	static struct arm_smmu_strtab_l1_desc dummy_desc;
+
+	return __arm_smmu_init_l2_strtab(smmu, sid, &dummy_desc);
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -2150,8 +2172,12 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 	}

 	for (i = 0; i < cfg->num_l1_ents; ++i) {
-		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-		strtab += STRTAB_L1_DESC_DWORDS << 3;
+		if (is_kdump_kernel()) {
+			arm_smmu_init_dummy_l2_strtab(smmu, i << STRTAB_SPLIT);
+		} else {
+			arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
+			strtab += STRTAB_L1_DESC_DWORDS << 3;
+		}
 	}

 	return 0;
@@ -2467,11 +2493,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
-		if (is_kdump_kernel()) {
+		if (is_kdump_kernel())
 			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
-			arm_smmu_device_disable(smmu);
-			return -EBUSY;
-		}

 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 	}
@@ -2859,6 +2882,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	bool bypass;

+	/*
+	 * Force to disable bypass for the kdump kernel, abort all incoming
+	 * transactions from the unknown devices.
+	 */
+	if (is_kdump_kernel())
+		disable_bypass = 1;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
--
1.8.3
