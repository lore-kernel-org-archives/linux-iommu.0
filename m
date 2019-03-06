From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 3/3] iommu/tegra-smmu: Respect IOMMU API read-write protections
Date: Thu,  7 Mar 2019 01:50:09 +0300
Message-ID: <20190306225009.3391-4-digetx@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Set PTE read/write attributes accordingly to the the protections requested
by IOMMU API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 27b1249f0773..463ee08f7d3a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -145,8 +145,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 
 #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
 				 SMMU_PDE_NONSECURE)
-#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
-				 SMMU_PTE_NONSECURE)
 
 static unsigned int iova_pd_index(unsigned long iova)
 {
@@ -659,6 +657,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
+	u32 pte_attrs;
 	u32 *pte;
 
 	pte = as_get_pte(as, iova, &pte_dma);
@@ -669,8 +668,16 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (*pte == 0)
 		tegra_smmu_pte_get_use(as, iova);
 
+	pte_attrs = SMMU_PTE_NONSECURE;
+
+	if (prot & IOMMU_READ)
+		pte_attrs |= SMMU_PTE_READABLE;
+
+	if (prot & IOMMU_WRITE)
+		pte_attrs |= SMMU_PTE_WRITABLE;
+
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
-			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
+			   __phys_to_pfn(paddr) | pte_attrs);
 
 	return 0;
 }
-- 
2.20.1
