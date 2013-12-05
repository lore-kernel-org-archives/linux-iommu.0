From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/6] iommu/tegra124: smmu: adjust TLB_FLUSH_ASID bit range
Date: Thu, 5 Dec 2013 14:25:19 +0200
Message-ID: <1386246319-17851-7-git-send-email-hdoyu@nvidia.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje Bergstrom <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

TLB_FLUSH_ASID bit range depends on the number of asids to support
other number than the current 4, especially for a new Tegra124. Based
on Terje's internal patch.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Terje Bergstrom <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 9b81e3a..535b14a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -92,11 +92,14 @@ enum {
 #define SMMU_TLB_FLUSH_VA_MATCH_ALL		0
 #define SMMU_TLB_FLUSH_VA_MATCH_SECTION		2
 #define SMMU_TLB_FLUSH_VA_MATCH_GROUP		3
-#define SMMU_TLB_FLUSH_ASID_SHIFT		29
+#define SMMU_TLB_FLUSH_ASID_SHIFT_BASE		31
 #define SMMU_TLB_FLUSH_ASID_MATCH_DISABLE	0
 #define SMMU_TLB_FLUSH_ASID_MATCH_ENABLE	1
 #define SMMU_TLB_FLUSH_ASID_MATCH_SHIFT		31
 
+#define SMMU_TLB_FLUSH_ASID_SHIFT(as)					\
+	(SMMU_TLB_FLUSH_ASID_SHIFT_BASE - __ffs((as)->smmu->num_as))
+
 #define SMMU_PTC_FLUSH				0x34
 #define SMMU_PTC_FLUSH_TYPE_ALL			0
 #define SMMU_PTC_FLUSH_TYPE_ADR			1
@@ -563,7 +566,7 @@ static void flush_ptc_and_tlb(struct smmu_device *smmu,
 
 	val = tlb_flush_va |
 		SMMU_TLB_FLUSH_ASID_MATCH__ENABLE |
-		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT);
+		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT(as));
 	smmu_write(smmu, val, SMMU_TLB_FLUSH);
 	FLUSH_SMMU_REGS(smmu);
 }
@@ -730,7 +733,7 @@ static int alloc_pdir(struct smmu_as *as)
 
 	val = SMMU_TLB_FLUSH_VA_MATCH_ALL |
 		SMMU_TLB_FLUSH_ASID_MATCH__ENABLE |
-		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT);
+		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT(as));
 	smmu_write(smmu, val, SMMU_TLB_FLUSH);
 	FLUSH_SMMU_REGS(as->smmu);
 
-- 
1.8.1.5
