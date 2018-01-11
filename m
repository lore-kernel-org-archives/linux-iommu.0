From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 7/9] iommu/rockchip: Use iommu_group_get_for_dev() for
	add_device
Date: Thu, 11 Jan 2018 16:22:27 +0800
Message-ID: <20180111082229.24011-8-jeffy.chen@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180111082229.24011-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

IOMMU drivers are supposed to call this function instead of manually
creating a group in their .add_device callback. This behavior is not
strictly required by ARM DMA mapping implementation, but ARM64 already
relies on it. This patch fixes the rockchip-iommu driver to comply with
this requirement.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/iommu/rockchip-iommu.c | 122 +++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index cfeafbf54096..86f8190d7bed 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -802,6 +802,40 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 	return rk_iommu;
 }
 
+static void rk_iommu_detach_device(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct rk_iommu *iommu;
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+	int i;
+
+	/* Allow 'virtual devices' (eg drm) to detach from domain */
+	iommu = rk_iommu_from_dev(dev);
+	if (!iommu)
+		return;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_del_init(&iommu->node);
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+
+	/* Ignore error while disabling, just keep going */
+	rk_iommu_enable_stall(iommu);
+	rk_iommu_disable_paging(iommu);
+	for (i = 0; i < iommu->num_mmu; i++) {
+		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
+		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
+	}
+	rk_iommu_disable_stall(iommu);
+
+	for (i = 0; i < iommu->num_irq; i++)
+		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
+
+	iommu->domain = NULL;
+
+	dev_dbg(dev, "Detached from iommu domain\n");
+}
+
 static int rk_iommu_attach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
@@ -818,6 +852,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return 0;
 
+	if (iommu->domain)
+		rk_iommu_detach_device(domain, dev);
+
 	ret = rk_iommu_enable_stall(iommu);
 	if (ret)
 		return ret;
@@ -865,40 +902,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
-static void rk_iommu_detach_device(struct iommu_domain *domain,
-				   struct device *dev)
-{
-	struct rk_iommu *iommu;
-	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
-	unsigned long flags;
-	int i;
-
-	/* Allow 'virtual devices' (eg drm) to detach from domain */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return;
-
-	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
-	list_del_init(&iommu->node);
-	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
-
-	/* Ignore error while disabling, just keep going */
-	rk_iommu_enable_stall(iommu);
-	rk_iommu_disable_paging(iommu);
-	for (i = 0; i < iommu->num_mmu; i++) {
-		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
-		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
-	}
-	rk_iommu_disable_stall(iommu);
-
-	for (i = 0; i < iommu->num_irq; i++)
-		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
-
-	iommu->domain = NULL;
-
-	dev_dbg(dev, "Detached from iommu domain\n");
-}
-
 static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 {
 	struct rk_iommu_domain *rk_domain;
@@ -1049,41 +1052,20 @@ static int rk_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 	struct rk_iommu *iommu;
-	int ret;
 
 	if (!rk_iommu_is_dev_iommu_master(dev))
 		return -ENODEV;
 
-	group = iommu_group_get(dev);
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group)) {
-			dev_err(dev, "Failed to allocate IOMMU group\n");
-			return PTR_ERR(group);
-		}
-	}
-
-	ret = iommu_group_add_device(group, dev);
-	if (ret)
-		goto err_put_group;
-
-	ret = rk_iommu_group_set_iommudata(group, dev);
-	if (ret)
-		goto err_remove_device;
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
 
 	iommu = rk_iommu_from_dev(dev);
 	if (iommu)
 		iommu_device_link(&iommu->iommu, dev);
 
 	iommu_group_put(group);
-
 	return 0;
-
-err_remove_device:
-	iommu_group_remove_device(dev);
-err_put_group:
-	iommu_group_put(group);
-	return ret;
 }
 
 static void rk_iommu_remove_device(struct device *dev)
@@ -1100,6 +1082,29 @@ static void rk_iommu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static struct iommu_group *rk_iommu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return group;
+	}
+
+	ret = rk_iommu_group_set_iommudata(group, dev);
+	if (ret)
+		goto err_put_group;
+
+	return group;
+
+err_put_group:
+	iommu_group_put(group);
+	return ERR_PTR(ret);
+}
+
 static const struct iommu_ops rk_iommu_ops = {
 	.domain_alloc = rk_iommu_domain_alloc,
 	.domain_free = rk_iommu_domain_free,
@@ -1111,6 +1116,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
+	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 };
 
-- 
2.11.0
