From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/rockchip: Make use of 'struct iommu_device'
Date: Fri, 31 Mar 2017 16:30:24 +0200
Message-ID: <1490970624-19981-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Register hardware IOMMUs seperatly with the iommu-core code
and add a sysfs representation of the iommu topology.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9afcbf7..36d0890 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -90,6 +90,7 @@ struct rk_iommu {
 	void __iomem **bases;
 	int num_mmu;
 	int irq;
+	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 };
@@ -1032,6 +1033,7 @@ static int rk_iommu_group_set_iommudata(struct iommu_group *group,
 static int rk_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
+	struct rk_iommu *iommu;
 	int ret;
 
 	if (!rk_iommu_is_dev_iommu_master(dev))
@@ -1054,6 +1056,10 @@ static int rk_iommu_add_device(struct device *dev)
 	if (ret)
 		goto err_remove_device;
 
+	iommu = rk_iommu_from_dev(dev);
+	if (iommu)
+		iommu_device_link(&iommu->iommu, dev);
+
 	iommu_group_put(group);
 
 	return 0;
@@ -1067,9 +1073,15 @@ static int rk_iommu_add_device(struct device *dev)
 
 static void rk_iommu_remove_device(struct device *dev)
 {
+	struct rk_iommu *iommu;
+
 	if (!rk_iommu_is_dev_iommu_master(dev))
 		return;
 
+	iommu = rk_iommu_from_dev(dev);
+	if (iommu)
+		iommu_device_unlink(&iommu->iommu, dev);
+
 	iommu_group_remove_device(dev);
 }
 
@@ -1117,7 +1129,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct rk_iommu *iommu;
 	struct resource *res;
 	int num_res = pdev->num_resources;
-	int i;
+	int err, i;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -1150,11 +1162,25 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	return 0;
+	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
+	if (err)
+		return err;
+
+	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
+	err = iommu_device_register(&iommu->iommu);
+
+	return err;
 }
 
 static int rk_iommu_remove(struct platform_device *pdev)
 {
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+
+	if (iommu) {
+		iommu_device_sysfs_remove(&iommu->iommu);
+		iommu_device_unregister(&iommu->iommu);
+	}
+
 	return 0;
 }
 
-- 
1.9.1
