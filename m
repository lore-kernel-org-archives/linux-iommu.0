From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 4/8] iommu/mediatek: Move pgtable allocation into domain_alloc
Date: Fri, 11 Aug 2017 17:56:13 +0800
Message-ID: <1502445377-26936-5-git-send-email-yong.wu@mediatek.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502445377-26936-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

After adding the global list for M4U HW, We get a chance to
move the pagetable allocation into the mtk_iommu_domain_alloc.
Let the domain_alloc do the right thing.

This patch is for fixing this problem[1].
[1]: https://patchwork.codeaurora.org/patch/53987/

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/mtk_iommu.c | 50 +++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e3848e1..e81ed9a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -254,9 +254,9 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	}
 }
 
-static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
+static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 {
-	struct mtk_iommu_domain *dom = data->m4u_dom;
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
 	spin_lock_init(&dom->pgtlock);
 
@@ -282,9 +282,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
 
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
-
-	writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
-	       data->base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
 
@@ -299,20 +296,28 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (!dom)
 		return NULL;
 
-	if (iommu_get_dma_cookie(&dom->domain)) {
-		kfree(dom);
-		return NULL;
-	}
+	if (iommu_get_dma_cookie(&dom->domain))
+		goto  free_dom;
+
+	if (mtk_iommu_domain_finalise(dom))
+		goto  free_dom;
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
+
+free_dom:
+	kfree(dom);
+	return NULL;
 }
 
 static void mtk_iommu_domain_free(struct iommu_domain *domain)
 {
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+
+	free_io_pgtable_ops(dom->iop);
 	iommu_put_dma_cookie(domain);
 	kfree(to_mtk_domain(domain));
 }
@@ -321,33 +326,19 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *curdata = dev->iommu_fwspec->iommu_priv;
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
-	int ret;
+	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
 
-	if (!data || !curdata)
+	if (!data)
 		return -ENODEV;
 
+	/* Update the pgtable base address register of the M4U HW */
 	if (!data->m4u_dom) {
 		data->m4u_dom = dom;
-		ret = mtk_iommu_domain_finalise(data);
-		if (ret) {
-			data->m4u_dom = NULL;
-			return ret;
-		}
-	}
-
-	/*
-	 * Update the pgtable base address register of another M4U HW with the
-	 * existed pgtable if there are more than one M4U HW.
-	 */
-	if (!curdata->m4u_dom) {
-		curdata->m4u_dom = data->m4u_dom;
-		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
-		       curdata->base + REG_MMU_PT_BASE_ADDR);
+		writel(dom->cfg.arm_v7s_cfg.ttbr[0],
+		       data->base + REG_MMU_PT_BASE_ADDR);
 	}
 
-	mtk_iommu_config(curdata, dev, true);
+	mtk_iommu_config(data, dev, true);
 	return 0;
 }
 
@@ -666,7 +657,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, NULL);
 
-	free_io_pgtable_ops(data->m4u_dom->iop);
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-- 
1.9.1
