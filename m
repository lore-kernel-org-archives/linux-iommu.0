From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2] iommu/arm-smmu: clear cache lock bit of ACR
Date: Tue,  3 May 2016 21:50:30 +0800
Message-ID: <1462283430-9559-1-git-send-email-van.freenix@gmail.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

According MMU-500r2 TRM, section 3.7.1 Auxiliary Control registers,
You can modify ACTLR only when the ACR.CACHE_LOCK bit is 0.

So before clearing ARM_MMU500_ACTLR_CPRE of each context bank,
need clear CACHE_LOCK bit of ACR register first.

Since CACHE_LOCK bit is only present in MMU-500r2 onwards,
need to check the major number of IDR7.

Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

V2:
 Following Robin's comments, need to check IDR7 before clearing
 CACHE_LOCK bit of ACR.

V1:
 Patch based on iommu/devel

 drivers/iommu/arm-smmu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index acff332..c7ad23e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -98,6 +98,9 @@
 #define sCR0_BSU_SHIFT			14
 #define sCR0_BSU_MASK			0x3
 
+/* Auxiliary Configuration register */
+#define ARM_SMMU_GR0_sACR		0x10
+
 /* Identification registers */
 #define ARM_SMMU_GR0_ID0		0x20
 #define ARM_SMMU_GR0_ID1		0x24
@@ -144,6 +147,9 @@
 #define ID2_PTFS_64K			(1 << 14)
 #define ID2_VMID16			(1 << 15)
 
+#define ID7_MAJOR_SHIFT			4
+#define ID7_MAJOR_MASK			0xf
+
 /* Global TLB invalidation */
 #define ARM_SMMU_GR0_TLBIVMID		0x64
 #define ARM_SMMU_GR0_TLBIALLNSNH	0x68
@@ -235,6 +241,8 @@
 
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
+#define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
+
 #define CB_PAR_F			(1 << 0)
 
 #define ATSR_ACTIVE			(1 << 0)
@@ -1493,7 +1501,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	void __iomem *cb_base;
 	int i = 0;
-	u32 reg;
+	u32 reg, major;
 
 	/* clear global FSR */
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
@@ -1506,6 +1514,19 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
+	/*
+	 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
+	 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
+	 * bit is only present in MMU-500r2 onwards.
+	 */
+	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
+	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
+	if ((smmu->model == ARM_MMU500) && (major >= 2)) {
+		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
+		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
+		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
+	}
+
 	/* Make sure all context banks are disabled and clear CB_FSR  */
 	for (i = 0; i < smmu->num_context_banks; ++i) {
 		cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, i);
-- 
2.6.2
