From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 3/4] iommu/tegra: gart: Move PFN validation out of spinlock
Date: Wed,  5 Jul 2017 19:29:47 +0300
Message-ID: <301b5e91fae43beae4542e8c4a7d5ca6a6918ba0.1499270277.git.digetx@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Validation of page frame number doesn't require protection with a spinlock,
let's move it out of spinlock for consistency.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 54699e341110..55fdb56d85ea 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -276,13 +276,13 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return -EINVAL;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
 	pfn = __phys_to_pfn(pa);
 	if (!pfn_valid(pfn)) {
 		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
-		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
+
+	spin_lock_irqsave(&gart->pte_lock, flags);
 	pte = gart_read_pte(gart, iova);
 	if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
-- 
2.13.2
