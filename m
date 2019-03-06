From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 1/3] iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
Date: Thu,  7 Mar 2019 01:50:07 +0300
Message-ID: <20190306225009.3391-2-digetx@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190306225009.3391-1-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
the TLB_FLUSH register differs from later Tegra generations that have 128
ASID's.

In a result the PTE's are now flushed correctly from TLB and this fixes
problems with graphics (randomly failing tests) on Tegra30.

Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5182c7d6171e..8d30653cd13a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
 #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
 #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
-#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
 #define  SMMU_TLB_FLUSH_VA_SECTION(addr) ((((addr) & 0xffc00000) >> 12) | \
 					  SMMU_TLB_FLUSH_VA_MATCH_SECTION)
 #define  SMMU_TLB_FLUSH_VA_GROUP(addr)   ((((addr) & 0xffffc000) >> 12) | \
@@ -205,8 +204,12 @@ static inline void smmu_flush_tlb_asid(struct tegra_smmu *smmu,
 {
 	u32 value;
 
-	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
-		SMMU_TLB_FLUSH_VA_MATCH_ALL;
+	if (smmu->soc->num_asids == 4)
+		value = (asid & 0x3) << 29;
+	else
+		value = (asid & 0x7f) << 24;
+
+	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_MATCH_ALL;
 	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
 }
 
@@ -216,8 +219,12 @@ static inline void smmu_flush_tlb_section(struct tegra_smmu *smmu,
 {
 	u32 value;
 
-	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
-		SMMU_TLB_FLUSH_VA_SECTION(iova);
+	if (smmu->soc->num_asids == 4)
+		value = (asid & 0x3) << 29;
+	else
+		value = (asid & 0x7f) << 24;
+
+	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_SECTION(iova);
 	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
 }
 
@@ -227,8 +234,12 @@ static inline void smmu_flush_tlb_group(struct tegra_smmu *smmu,
 {
 	u32 value;
 
-	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
-		SMMU_TLB_FLUSH_VA_GROUP(iova);
+	if (smmu->soc->num_asids == 4)
+		value = (asid & 0x3) << 29;
+	else
+		value = (asid & 0x7f) << 24;
+
+	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_GROUP(iova);
 	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
 }
 
-- 
2.20.1
