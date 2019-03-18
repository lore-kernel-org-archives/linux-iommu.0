From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
Date: Mon, 18 Mar 2019 21:12:42 +0800
Message-ID: <20190318131243.20716-2-thunder.leizhen@huawei.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318131243.20716-1-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

After the content of L1STD(Level 1 Stream Table Descriptor) in DDR has been
modified, should make sure the cached copies be invalidated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cfc8c..9b6afa8e69f70f6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1071,13 +1071,14 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	*dst = cpu_to_le64(val);
 }
 
-static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
+static void __arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu,
+					 u32 sid, bool leaf)
 {
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_STE,
 		.cfgi	= {
 			.sid	= sid,
-			.leaf	= true,
+			.leaf	= leaf,
 		},
 	};
 
@@ -1085,6 +1086,16 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
+static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__arm_smmu_sync_ste_for_sid(smmu, sid, true);
+}
+
+static void arm_smmu_sync_std_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__arm_smmu_sync_ste_for_sid(smmu, sid, false);
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 				      __le64 *dst, struct arm_smmu_strtab_ent *ste)
 {
@@ -1232,6 +1243,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
+	arm_smmu_sync_std_for_sid(smmu, sid);
 	return 0;
 }
 
-- 
1.8.3
