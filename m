From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/10] iommu/exynos: Make use of iommu_device_register
	interface
Date: Mon,  6 Feb 2017 17:10:28 +0100
Message-ID: <1486397429-29327-10-git-send-email-joro@8bytes.org>
References: <1486397429-29327-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486397429-29327-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Register Exynos IOMMUs to the IOMMU core and make them
visible in sysfs. This patch does not add the links between
IOMMUs and translated devices yet.

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 57ba0d3..90f0f52 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -276,6 +276,8 @@ struct sysmmu_drvdata {
 	struct list_head owner_node;	/* node for owner controllers list */
 	phys_addr_t pgtable;		/* assigned page table structure */
 	unsigned int version;		/* our version */
+
+	struct iommu_device iommu;	/* IOMMU core handle */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -556,6 +558,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sysmmu_drvdata *data;
 	struct resource *res;
+	resource_size_t ioaddr;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -565,6 +568,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sfrbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->sfrbase))
 		return PTR_ERR(data->sfrbase);
+	ioaddr = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
@@ -611,6 +615,18 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
 
+	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
+				     "sysmmu.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	data->iommu.ops    = &exynos_iommu_ops;
+	data->iommu.fwnode = &dev->of_node->fwnode;
+
+	ret = iommu_device_register(&data->iommu);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, data);
 
 	__sysmmu_get_version(data);
-- 
1.9.1
