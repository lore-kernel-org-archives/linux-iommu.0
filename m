From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 10/18] iommu: tegra-smmu: move flush_dcache to tegra-smmu.c
Date: Mon, 27 Jul 2015 13:29:36 +0100
Message-ID: <E1ZJhXE-00047x-IV@rmk-PC.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150727122824.GH7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Drivers should not be using __cpuc_* functions nor outer_cache_flush()
directly.  This change partly cleans up tegra-smmu.c.

The only difference between cache handling of the tegra variants is
Denver, which omits the call to outer_cache_flush().  This is due to
Denver being an ARM64 CPU, and the ARM64 architecture does not provide
this function.  (This, in itself, is a good reason why these should not
be used.)

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c      | 24 +++++++++++++++++++-----
 drivers/memory/tegra/tegra114.c | 17 -----------------
 drivers/memory/tegra/tegra124.c | 30 ------------------------------
 drivers/memory/tegra/tegra30.c  | 17 -----------------
 include/soc/tegra/mc.h          |  7 -------
 5 files changed, 19 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index d649b06cc4ca..fa26b76017cf 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include <asm/cacheflush.h>
+
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
@@ -145,6 +147,18 @@ static unsigned int iova_pt_index(unsigned long iova)
 	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
 }
 
+static void smmu_flush_dcache(struct page *page, unsigned long offset,
+			      size_t size)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	void *virt = page_address(page) + offset;
+
+	__cpuc_flush_dcache_area(virt, size);
+#ifdef CONFIG_ARM
+	outer_flush_range(phys, phys + size);
+#endif
+}
+
 static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
 				  unsigned long offset)
 {
@@ -392,7 +406,7 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 	if (err < 0)
 		return err;
 
-	smmu->soc->ops->flush_dcache(as->pd, 0, SMMU_SIZE_PD);
+	smmu_flush_dcache(as->pd, 0, SMMU_SIZE_PD);
 	smmu_flush_ptc(smmu, as->pd, 0);
 	smmu_flush_tlb_asid(smmu, as->id);
 
@@ -521,11 +535,11 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 
 		as->pts[pde] = page;
 
-		smmu->soc->ops->flush_dcache(page, 0, SMMU_SIZE_PT);
+		smmu_flush_dcache(page, 0, SMMU_SIZE_PT);
 
 		pd[pde] = SMMU_MK_PDE(page, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
 
-		smmu->soc->ops->flush_dcache(as->pd, pde << 2, 4);
+		smmu_flush_dcache(as->pd, pde << 2, 4);
 		smmu_flush_ptc(smmu, as->pd, pde << 2);
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
@@ -562,7 +576,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 		pd[pde] = 0;
 
 		/* Flush the page directory entry */
-		smmu->soc->ops->flush_dcache(as->pd, offset, sizeof(*pd));
+		smmu_flush_dcache(as->pd, offset, sizeof(*pd));
 		smmu_flush_ptc(smmu, as->pd, offset);
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
@@ -582,7 +596,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 
 	*pte = val;
 
-	smmu->soc->ops->flush_dcache(pte_page, offset, 4);
+	smmu_flush_dcache(pte_page, offset, 4);
 	smmu_flush_ptc(smmu, pte_page, offset);
 	smmu_flush_tlb_group(smmu, as->id, iova);
 	smmu_flush(smmu);
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 9f579589e800..7122f39be9cc 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -9,8 +9,6 @@
 #include <linux/of.h>
 #include <linux/mm.h>
 
-#include <asm/cacheflush.h>
-
 #include <dt-bindings/memory/tegra114-mc.h>
 
 #include "mc.h"
@@ -914,20 +912,6 @@ static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
 	{ .name = "tsec",      .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
 };
 
-static void tegra114_flush_dcache(struct page *page, unsigned long offset,
-				  size_t size)
-{
-	phys_addr_t phys = page_to_phys(page) + offset;
-	void *virt = page_address(page) + offset;
-
-	__cpuc_flush_dcache_area(virt, size);
-	outer_flush_range(phys, phys + size);
-}
-
-static const struct tegra_smmu_ops tegra114_smmu_ops = {
-	.flush_dcache = tegra114_flush_dcache,
-};
-
 static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.clients = tegra114_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
@@ -936,7 +920,6 @@ static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
 	.num_asids = 4,
-	.ops = &tegra114_smmu_ops,
 };
 
 const struct tegra_mc_soc tegra114_mc_soc = {
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 966e1557e6f4..ebda63283853 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -9,8 +9,6 @@
 #include <linux/of.h>
 #include <linux/mm.h>
 
-#include <asm/cacheflush.h>
-
 #include <dt-bindings/memory/tegra124-mc.h>
 
 #include "mc.h"
@@ -1002,20 +1000,6 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 };
 
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
-static void tegra124_flush_dcache(struct page *page, unsigned long offset,
-				  size_t size)
-{
-	phys_addr_t phys = page_to_phys(page) + offset;
-	void *virt = page_address(page) + offset;
-
-	__cpuc_flush_dcache_area(virt, size);
-	outer_flush_range(phys, phys + size);
-}
-
-static const struct tegra_smmu_ops tegra124_smmu_ops = {
-	.flush_dcache = tegra124_flush_dcache,
-};
-
 static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.clients = tegra124_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
@@ -1024,7 +1008,6 @@ static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_asids = 128,
-	.ops = &tegra124_smmu_ops,
 };
 
 const struct tegra_mc_soc tegra124_mc_soc = {
@@ -1039,18 +1022,6 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
 #ifdef CONFIG_ARCH_TEGRA_132_SOC
-static void tegra132_flush_dcache(struct page *page, unsigned long offset,
-				  size_t size)
-{
-	void *virt = page_address(page) + offset;
-
-	__flush_dcache_area(virt, size);
-}
-
-static const struct tegra_smmu_ops tegra132_smmu_ops = {
-	.flush_dcache = tegra132_flush_dcache,
-};
-
 static const struct tegra_smmu_soc tegra132_smmu_soc = {
 	.clients = tegra124_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
@@ -1059,7 +1030,6 @@ static const struct tegra_smmu_soc tegra132_smmu_soc = {
 	.supports_round_robin_arbitration = true,
 	.supports_request_limit = true,
 	.num_asids = 128,
-	.ops = &tegra132_smmu_ops,
 };
 
 const struct tegra_mc_soc tegra132_mc_soc = {
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 1abcd8f6f3ba..3cb30b69d95b 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -9,8 +9,6 @@
 #include <linux/of.h>
 #include <linux/mm.h>
 
-#include <asm/cacheflush.h>
-
 #include <dt-bindings/memory/tegra30-mc.h>
 
 #include "mc.h"
@@ -936,20 +934,6 @@ static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
 	{ .name = "isp",  .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
 };
 
-static void tegra30_flush_dcache(struct page *page, unsigned long offset,
-				 size_t size)
-{
-	phys_addr_t phys = page_to_phys(page) + offset;
-	void *virt = page_address(page) + offset;
-
-	__cpuc_flush_dcache_area(virt, size);
-	outer_flush_range(phys, phys + size);
-}
-
-static const struct tegra_smmu_ops tegra30_smmu_ops = {
-	.flush_dcache = tegra30_flush_dcache,
-};
-
 static const struct tegra_smmu_soc tegra30_smmu_soc = {
 	.clients = tegra30_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra30_mc_clients),
@@ -958,7 +942,6 @@ static const struct tegra_smmu_soc tegra30_smmu_soc = {
 	.supports_round_robin_arbitration = false,
 	.supports_request_limit = false,
 	.num_asids = 4,
-	.ops = &tegra30_smmu_ops,
 };
 
 const struct tegra_mc_soc tegra30_mc_soc = {
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1ab2813273cd..d6c3190ec852 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -51,11 +51,6 @@ struct tegra_smmu_swgroup {
 	unsigned int reg;
 };
 
-struct tegra_smmu_ops {
-	void (*flush_dcache)(struct page *page, unsigned long offset,
-			     size_t size);
-};
-
 struct tegra_smmu_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
@@ -67,8 +62,6 @@ struct tegra_smmu_soc {
 	bool supports_request_limit;
 
 	unsigned int num_asids;
-
-	const struct tegra_smmu_ops *ops;
 };
 
 struct tegra_mc;
-- 
2.1.0
