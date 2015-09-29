From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC PATCH 3/3] iommu/tegra-smmu: Make the driver use out of band flushing
Date: Tue, 29 Sep 2015 14:25:26 +0900
Message-ID: <1443504379-31841-4-git-send-email-tfiga@chromium.org>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443504379-31841-1-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch modifies the tegra-smmu driver to perform PTC and TLB flushes
inside iommu_ops .flush() callback instead of map and unmap operations,
so that performance of large maps and unmaps is heavily optimized due to
elimination of page-by-page flushing.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 91 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 9305964..92b46d2 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -614,18 +614,54 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	}
 }
 
+static void tegra_smmu_pte_put_use_range(struct tegra_smmu_as *as,
+		unsigned long iova, unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++)
+		tegra_smmu_pte_put_use(as, iova + i * PAGE_SIZE);
+}
+
 static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 			       u32 *pte, dma_addr_t pte_dma, u32 val)
 {
-	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset = offset_in_page(pte);
-
 	*pte = val;
+}
+
+static void tegra_smmu_flush_pte_range(struct tegra_smmu_as *as,
+				unsigned long iova, unsigned int num_ptes, u32 *pte,
+				dma_addr_t pt_dma)
+{
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned int tlb_lines_per_atom;
+	unsigned int ptes_per_tlb_line;
+	unsigned int ptes_per_atom;
+	unsigned long offset;
+	unsigned long iova_end;
+	int i;
+
+	ptes_per_atom = smmu->mc->soc->atom_size / sizeof(*pte);
+	ptes_per_tlb_line = smmu->soc->tlb_line_size / sizeof(*pte);
+	tlb_lines_per_atom = smmu->mc->soc->atom_size
+				/ smmu->soc->tlb_line_size;
+
+	offset = round_down(offset_in_page(pte), smmu->mc->soc->atom_size);
+
+	iova_end = iova + num_ptes * PAGE_SIZE;
+	iova = round_down(iova, ptes_per_atom * PAGE_SIZE);
+	iova_end = round_up(iova_end, ptes_per_atom * PAGE_SIZE);
+	num_ptes = (iova_end - iova) / PAGE_SIZE;
+	while (num_ptes) {
+		smmu_flush_ptc(smmu, pt_dma, offset);
+		for (i = 0; i < tlb_lines_per_atom; i++) {
+			smmu_flush_tlb_group(smmu, as->id, iova);
+			iova += ptes_per_tlb_line * PAGE_SIZE;
+		}
+		offset += smmu->mc->soc->atom_size;
+		num_ptes -= ptes_per_atom;
+	}
 
-	dma_sync_single_range_for_device(smmu->dev, pte_dma, offset,
-					 4, DMA_TO_DEVICE);
-	smmu_flush_ptc(smmu, pte_dma, offset);
-	smmu_flush_tlb_group(smmu, as->id, iova);
 	smmu_flush(smmu);
 }
 
@@ -662,11 +698,49 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 		return 0;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma, 0);
-	tegra_smmu_pte_put_use(as, iova);
 
 	return size;
 }
 
+static void tegra_smmu_flush(struct iommu_domain *domain, unsigned long iova,
+			     size_t size)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	struct tegra_smmu *smmu = as->smmu;
+	u32 num = size >> PAGE_SHIFT;
+
+	might_sleep();
+
+	while (num) {
+		unsigned int pt_index = iova_pt_index(iova);
+		unsigned int len, end;
+		unsigned long offset;
+		dma_addr_t pte_dma;
+		u32 *pte;
+
+		end = pt_index + num;
+		if (end > SMMU_NUM_PTE)
+			end = SMMU_NUM_PTE;
+		len = end - pt_index;
+
+		pte = tegra_smmu_pte_lookup(as, iova, &pte_dma);
+		if (!pte)
+			goto next_pde;
+
+		offset = offset_in_page(pte);
+		dma_sync_single_range_for_device(smmu->dev, pte_dma, offset,
+						 sizeof(*pte) * len, DMA_TO_DEVICE);
+
+		tegra_smmu_flush_pte_range(as, iova, len, pte, pte_dma);
+		if (*pte == 0)
+			tegra_smmu_pte_put_use_range(as, iova, len);
+
+next_pde:
+		num -= len;
+		iova += len << PAGE_SHIFT;
+	}
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -743,6 +817,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.map_sg = default_iommu_map_sg,
+	.flush = tegra_smmu_flush,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
 
 	.pgsize_bitmap = SZ_4K,
-- 
2.6.0.rc2.230.g3dd15c0
