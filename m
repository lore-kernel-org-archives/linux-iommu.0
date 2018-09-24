From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Date: Mon, 24 Sep 2018 03:41:49 +0300
Message-ID: <20180924004153.8232-17-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-1-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

GART is a part of the Memory Controller driver that is always built-in,
hence there is no benefit from the use of managed resources.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 9f7d3afb686f..d019ae8ecfc9 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -171,7 +171,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
+	client = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 	client->dev = dev;
@@ -197,7 +197,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 fail:
-	devm_kfree(gart->dev, client);
+	kfree(client);
 	spin_unlock(&gart->client_lock);
 	return err;
 }
@@ -212,7 +212,7 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
-			devm_kfree(gart->dev, c);
+			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
@@ -459,7 +459,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -468,7 +468,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -506,6 +506,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.19.0
