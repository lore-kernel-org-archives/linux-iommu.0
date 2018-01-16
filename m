From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 13/13] iommu/rockchip: Support sharing IOMMU between masters
Date: Tue, 16 Jan 2018 21:25:40 +0800
Message-ID: <20180116132540.18939-14-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180116132540.18939-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There would be some masters sharing the same IOMMU device. Put them in
the same iommu group and share the same iommu domain.

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c8de1456a016..6c316dd0dd2d 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -100,11 +100,13 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	struct iommu_group *group;
 	struct mutex pm_mutex; /* serializes power transitions */
 };
 
 struct rk_iommudata {
 	struct device_link *link; /* runtime PM link from IOMMU to master */
+	struct iommu_domain *domain; /* domain to which device is attached */
 	struct rk_iommu *iommu;
 };
 
@@ -964,6 +966,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct rk_iommudata *data = dev->archdata.iommu;
 	unsigned long flags;
 
 	/* Allow 'virtual devices' (eg drm) to detach from domain */
@@ -971,6 +974,12 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return;
 
+	/* device already detached */
+	if (data->domain != domain)
+		return;
+
+	data->domain = NULL;
+
 	dev_dbg(dev, "Detaching from iommu domain\n");
 
 	/* iommu already detached */
@@ -994,6 +1003,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct rk_iommudata *data = dev->archdata.iommu;
 	unsigned long flags;
 	int ret;
 
@@ -1005,15 +1015,21 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return 0;
 
+	/* device already attached */
+	if (data->domain == domain)
+		return 0;
+
+	if (data->domain)
+		rk_iommu_detach_device(data->domain, dev);
+
+	data->domain = domain;
+
 	dev_dbg(dev, "Attaching to iommu domain\n");
 
 	/* iommu already attached */
 	if (iommu->domain == domain)
 		return 0;
 
-	if (iommu->domain)
-		rk_iommu_detach_device(iommu->domain, dev);
-
 	iommu->domain = domain;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
@@ -1150,13 +1166,11 @@ static void rk_iommu_remove_device(struct device *dev)
 
 static struct iommu_group *rk_iommu_device_group(struct device *dev)
 {
-	struct iommu_group *group;
+	struct rk_iommu *iommu;
 
-	group = iommu_group_get(dev);
-	if (!group)
-		group = iommu_group_alloc();
+	iommu = rk_iommu_from_dev(dev);
 
-	return group;
+	return iommu ? iommu->group : NULL;
 }
 
 static int rk_iommu_of_xlate(struct device *dev,
@@ -1263,6 +1277,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		goto err_remove_sysfs;
 
+	iommu->group = iommu_group_alloc();
+	if (IS_ERR(iommu->group)) {
+		err = PTR_ERR(iommu->group);
+		goto err_unreg_iommu;
+	}
+
 	/*
 	 * Use the first registered IOMMU device for domain to use with DMA
 	 * API, since a domain might not physically correspond to a single
@@ -1276,6 +1296,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	return 0;
+err_unreg_iommu:
+	iommu_device_unregister(&iommu->iommu);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_put_clocks:
@@ -1289,6 +1311,7 @@ static int rk_iommu_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
+	iommu_group_put(iommu->group);
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 	rk_iommu_put_clocks(iommu);
-- 
2.11.0
