From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 2/4] iommu/tegra: gart: Check whether page is already mapped
Date: Wed,  5 Jul 2017 19:29:46 +0300
Message-ID: <a19ba1ca835aa2526d2c0492e6b0d0b35889596a.1499270277.git.digetx@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Due to a bug, multiple devices may try to map the same IOVA region. We can
catch that case by checking that 'VALID' bit of the GART's page entry is
unset prior to mapping of the page.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1557a6a9a438..54699e341110 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -271,6 +271,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	struct gart_device *gart = gart_domain->gart;
 	unsigned long flags;
 	unsigned long pfn;
+	unsigned long pte;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return -EINVAL;
@@ -282,6 +283,12 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
+	pte = gart_read_pte(gart, iova);
+	if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
+		spin_unlock_irqrestore(&gart->pte_lock, flags);
+		dev_err(gart->dev, "Page entry is used already\n");
+		return -EBUSY;
+	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
-- 
2.13.2
