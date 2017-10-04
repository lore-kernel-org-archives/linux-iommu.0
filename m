From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] iommu/tegra: gart: Add optional debug checking for overwriting of page mappings
Date: Wed,  4 Oct 2017 04:02:30 +0300
Message-ID: <2eadfde76987532354e419ffc98aae44e4af489a.1507078586.git.digetx@gmail.com>
References: <cover.1507078770.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1507078770.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1507078586.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1507078586.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Due to a bug in IOVA allocator, page mapping could accidentally overwritten.
We can catch this case by checking 'VALID' bit of GART's page entry prior to
mapping of a page. Since that check introduces a noticeable performance
impact, it should be enabled explicitly by a new CONFIG_TEGRA_IOMMU_GART_DEBUG
option.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/Kconfig      |  9 +++++++++
 drivers/iommu/tegra-gart.c | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..851156a4896d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -242,6 +242,15 @@ config TEGRA_IOMMU_GART
 	  space through the GART (Graphics Address Relocation Table)
 	  hardware included on Tegra SoCs.
 
+config TEGRA_IOMMU_GART_DEBUG
+	bool "Debug Tegra GART IOMMU"
+	depends on TEGRA_IOMMU_GART
+	help
+	  Properly unmap pages and check whether page is already mapped
+	  during of mapping in expense of performance. This allows to
+	  catch double page remappings, caused by a bug in the IOVA
+	  allocator for example.
+
 config TEGRA_IOMMU_SMMU
 	bool "NVIDIA Tegra SMMU Support"
 	depends on ARCH_TEGRA
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index b62f790ad1ba..7e5df0ebcdfc 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -271,6 +271,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	struct gart_device *gart = gart_domain->gart;
 	unsigned long flags;
 	unsigned long pfn;
+	unsigned long pte;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return -EINVAL;
@@ -282,6 +283,14 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
+	if (IS_ENABLED(TEGRA_IOMMU_GART_DEBUG)) {
+		pte = gart_read_pte(gart, iova);
+		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
+			spin_unlock_irqrestore(&gart->pte_lock, flags);
+			dev_err(gart->dev, "Page entry is used already\n");
+			return -EBUSY;
+		}
+	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
@@ -298,11 +307,16 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return 0;
 
+	/* don't unmap page entries to achieve better performance */
+	if (!IS_ENABLED(TEGRA_IOMMU_GART_DEBUG))
+		return 0;
+
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	gart_set_pte(gart, iova, 0);
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
-	return 0;
+
+	return bytes;
 }
 
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.14.1
