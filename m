From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/tegra-smmu: Parameterize number of TLB lines
Date: Fri,  7 Aug 2015 14:58:26 +0200
Message-ID: <1438952306-27483-1-git-send-email-thierry.reding@gmail.com>
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
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The number of TLB lines was increased from 16 on Tegra30 to 32 on
Tegra114 and later. Parameterize the value so that the initial default
can be set accordingly.

On Tegra30, initializing the value to 32 would effectively disable the
TLB and hence cause massive latencies for memory accesses translated
through the SMMU. This is especially noticeable for isochronuous clients
such as display, whose FIFOs would continuously underrun.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Joerg, it's probably easiest if I include this in my pull request that
will include Russell's massive rework of the driver, hence why I didn't
send this To: you. But I still wanted to get it out in case anybody had
comments on it.

 drivers/iommu/tegra-smmu.c      | 9 +++++++--
 drivers/memory/tegra/tegra114.c | 1 +
 drivers/memory/tegra/tegra124.c | 1 +
 drivers/memory/tegra/tegra30.c  | 1 +
 include/soc/tegra/mc.h          | 1 +
 5 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2f1481ad4aa5..9305964250ac 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -27,6 +27,7 @@ struct tegra_smmu {
 	const struct tegra_smmu_soc *soc;
 
 	unsigned long pfn_mask;
+	unsigned long tlb_mask;
 
 	unsigned long *asids;
 	struct mutex lock;
@@ -70,7 +71,8 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_TLB_CONFIG 0x14
 #define  SMMU_TLB_CONFIG_HIT_UNDER_MISS (1 << 29)
 #define  SMMU_TLB_CONFIG_ROUND_ROBIN_ARBITRATION (1 << 28)
-#define  SMMU_TLB_CONFIG_ACTIVE_LINES(x) ((x) & 0x3f)
+#define  SMMU_TLB_CONFIG_ACTIVE_LINES(smmu) \
+	((smmu)->soc->num_tlb_lines & (smmu)->tlb_mask)
 
 #define SMMU_PTC_CONFIG 0x18
 #define  SMMU_PTC_CONFIG_ENABLE (1 << 29)
@@ -901,6 +903,9 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->pfn_mask = BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
+	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
+	dev_dbg(dev, "TLB lines: %u, mask: %#lx\n", smmu->soc->num_tlb_lines,
+		smmu->tlb_mask);
 
 	value = SMMU_PTC_CONFIG_ENABLE | SMMU_PTC_CONFIG_INDEX_MAP(0x3f);
 
@@ -910,7 +915,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu_writel(smmu, value, SMMU_PTC_CONFIG);
 
 	value = SMMU_TLB_CONFIG_HIT_UNDER_MISS |
-		SMMU_TLB_CONFIG_ACTIVE_LINES(0x20);
+		SMMU_TLB_CONFIG_ACTIVE_LINES(smmu);
 
 	if (soc->supports_round_robin_arbitration)
 		value |= SMMU_TLB_CONFIG_ROUND_ROBIN_ARBITRATION;
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 7122f39be9cc..8053f70dbfd1 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -919,6 +919,7 @@ static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.num_swgroups = ARRAY_SIZE(tegra114_swgroups),
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
+	.num_tlb_lines = 32,
 	.num_asids = 4,
 };
 
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index ebda63283853..7d734befe0ed 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1029,6 +1029,7 @@ static const struct tegra_smmu_soc tegra132_smmu_soc = {
 	.num_swgroups = ARRAY_SIZE(tegra124_swgroups),
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
+	.num_tlb_lines = 32,
 	.num_asids = 128,
 };
 
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 3cb30b69d95b..7e0694d80edb 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -941,6 +941,7 @@ static const struct tegra_smmu_soc tegra30_smmu_soc = {
 	.num_swgroups = ARRAY_SIZE(tegra30_swgroups),
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
+	.num_tlb_lines = 16,
 	.num_asids = 4,
 };
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index d6c3190ec852..8cb3a7ecd6f8 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -61,6 +61,7 @@ struct tegra_smmu_soc {
 	bool supports_round_robin_arbitration;
 	bool supports_request_limit;
 
+	unsigned int num_tlb_lines;
 	unsigned int num_asids;
 };
 
-- 
2.4.5
