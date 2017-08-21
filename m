From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 4/8] iommu/mediatek: Merge 2 M4U HWs into one iommu domain
Date: Mon, 21 Aug 2017 19:00:17 +0800
Message-ID: <1503313221-26453-5-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cloud.zhou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In theory, If there are 2 M4U HWs, there should be 2 IOMMU domains.
But one IOMMU domain(4GB iova range) is enough for us currently,
It's unnecessary to maintain 2 pagetables.

Besides, This patch can simplify our consumer code largely. They don't
need map a iova range from one domain into another, They can share the
iova address easily.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/mtk_iommu.c | 92 ++++++++++++++++++++++++++++++++++-------------
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index df23e02..1503dfa 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -114,6 +114,27 @@ struct mtk_iommu_domain {
 
 static struct iommu_ops mtk_iommu_ops;
 
+static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
+
+#define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
+
+/*
+ * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
+ * for the performance.
+ *
+ * Here always return the mtk_iommu_data of the first probed M4U where the
+ * iommu domain information is recorded.
+ */
+static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
+{
+	struct mtk_iommu_data *data;
+
+	for_each_m4u(data)
+		return data;
+
+	return NULL;
+}
+
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct mtk_iommu_domain, domain);
@@ -123,9 +144,12 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
 {
 	struct mtk_iommu_data *data = cookie;
 
-	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, data->base + REG_MMU_INV_SEL);
-	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
-	wmb(); /* Make sure the tlb flush all done */
+	for_each_m4u(data) {
+		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
+			       data->base + REG_MMU_INV_SEL);
+		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
+		wmb(); /* Make sure the tlb flush all done */
+	}
 }
 
 static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
@@ -134,12 +158,17 @@ static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
 {
 	struct mtk_iommu_data *data = cookie;
 
-	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, data->base + REG_MMU_INV_SEL);
+	for_each_m4u(data) {
+		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
+			       data->base + REG_MMU_INV_SEL);
 
-	writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
-	writel_relaxed(iova + size - 1, data->base + REG_MMU_INVLD_END_A);
-	writel_relaxed(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
-	data->tlb_flush_active = true;
+		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
+		writel_relaxed(iova + size - 1,
+			       data->base + REG_MMU_INVLD_END_A);
+		writel_relaxed(F_MMU_INV_RANGE,
+			       data->base + REG_MMU_INVALIDATE);
+		data->tlb_flush_active = true;
+	}
 }
 
 static void mtk_iommu_tlb_sync(void *cookie)
@@ -148,20 +177,22 @@ static void mtk_iommu_tlb_sync(void *cookie)
 	int ret;
 	u32 tmp;
 
-	/* Avoid timing out if there's nothing to wait for */
-	if (!data->tlb_flush_active)
-		return;
+	for_each_m4u(data) {
+		/* Avoid timing out if there's nothing to wait for */
+		if (!data->tlb_flush_active)
+			return;
 
-	ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE, tmp,
-					tmp != 0, 10, 100000);
-	if (ret) {
-		dev_warn(data->dev,
-			 "Partial TLB flush timed out, falling back to full flush\n");
-		mtk_iommu_tlb_flush_all(cookie);
+		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
+						tmp, tmp != 0, 10, 100000);
+		if (ret) {
+			dev_warn(data->dev,
+				 "Partial TLB flush timed out, falling back to full flush\n");
+			mtk_iommu_tlb_flush_all(cookie);
+		}
+		/* Clear the CPE status */
+		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
+		data->tlb_flush_active = false;
 	}
-	/* Clear the CPE status */
-	writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
-	data->tlb_flush_active = false;
 }
 
 static const struct iommu_gather_ops mtk_iommu_gather_ops = {
@@ -298,10 +329,11 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *curdata = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	int ret;
 
-	if (!data)
+	if (!data || !curdata)
 		return -ENODEV;
 
 	if (!data->m4u_dom) {
@@ -313,7 +345,17 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		}
 	}
 
-	mtk_iommu_config(data, dev, true);
+	/*
+	 * Update the pgtable base address register of another M4U HW with the
+	 * existed pgtable if there are more than one M4U HW.
+	 */
+	if (!curdata->m4u_dom) {
+		curdata->m4u_dom = data->m4u_dom;
+		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
+		       curdata->base + REG_MMU_PT_BASE_ADDR);
+	}
+
+	mtk_iommu_config(curdata, dev, true);
 	return 0;
 }
 
@@ -405,7 +447,7 @@ static void mtk_iommu_remove_device(struct device *dev)
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
 	if (!data)
 		return ERR_PTR(-ENODEV);
@@ -604,6 +646,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	list_add_tail(&data->list, &m4ulist);
+
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 462e593..b4451a1 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -57,6 +57,8 @@ struct mtk_iommu_data {
 
 	struct iommu_device		iommu;
 	enum mtk_iommu_plat		m4u_plat;
+
+	struct list_head		list;
 };
 
 static inline int compare_of(struct device *dev, void *data)
-- 
1.9.1
