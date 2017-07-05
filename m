From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 4/4] iommu/tegra: gart: Correct number of unmapped bytes
Date: Wed,  5 Jul 2017 19:29:48 +0300
Message-ID: <f30500403195b029ee236fff3b3c6f0b4dc60cbb.1499270277.git.digetx@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The iommu_unmap() treats zero bytes number returned by an IOMMU driver as
an indicator that unmapping should be stopped. As a result, GART driver
unmaps only the first page entry of the whole range, which is incorrect.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 55fdb56d85ea..c622f4a4bedd 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -309,7 +309,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	gart_set_pte(gart, iova, 0);
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
-	return 0;
+	return bytes;
 }
 
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.13.2
