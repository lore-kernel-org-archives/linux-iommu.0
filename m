From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 1/4] iommu/tegra: gart: Don't unnecessarily allocate registers context
Date: Wed,  5 Jul 2017 19:29:45 +0300
Message-ID: <df570fb6649da6bc3b5f2a68afcb5471e6148269.1499270277.git.digetx@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

GART looses it's state only in case of a deepest suspend level. Let's not
waste memory if machine doesn't support that suspend level.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 37e708fdbb5a..1557a6a9a438 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -31,6 +31,8 @@
 #include <linux/iommu.h>
 #include <linux/of.h>
 
+#include <soc/tegra/pmc.h>
+
 #include <asm/cacheflush.h>
 
 /* bitmap of the page sizes currently supported */
@@ -354,10 +356,13 @@ static int tegra_gart_suspend(struct device *dev)
 	u32 *data = gart->savedata;
 	unsigned long flags;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
-	for_each_gart_pte(gart, iova)
-		*(data++) = gart_read_pte(gart, iova);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
+	if (gart->savedata != NULL) {
+		spin_lock_irqsave(&gart->pte_lock, flags);
+		for_each_gart_pte(gart, iova)
+			*(data++) = gart_read_pte(gart, iova);
+		spin_unlock_irqrestore(&gart->pte_lock, flags);
+	}
+
 	return 0;
 }
 
@@ -366,9 +371,12 @@ static int tegra_gart_resume(struct device *dev)
 	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
-	do_gart_setup(gart, gart->savedata);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
+	if (gart->savedata != NULL) {
+		spin_lock_irqsave(&gart->pte_lock, flags);
+		do_gart_setup(gart, gart->savedata);
+		spin_unlock_irqrestore(&gart->pte_lock, flags);
+	}
+
 	return 0;
 }
 
@@ -412,10 +420,16 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
 
-	gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
-	if (!gart->savedata) {
-		dev_err(dev, "failed to allocate context save area\n");
-		return -ENOMEM;
+	/*
+	 * The registers store/restore is required only in case of a
+	 * deepest sleep state, do not waste memory if it's unnecessary.
+	 */
+	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_LP0) {
+		gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
+		if (!gart->savedata) {
+			dev_err(dev, "failed to allocate context save area\n");
+			return -ENOMEM;
+		}
 	}
 
 	platform_set_drvdata(pdev, gart);
-- 
2.13.2
