From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v6 04/20] iommu/of: Introduce iommu_fwspec
Date: Tue,  6 Sep 2016 16:33:37 +0100
Message-ID: <4f6bdd985dec84855daa832b421233a363501b09.1473173789.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473173789.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Introduce a common structure to hold the per-device firmware data that
non-architectural IOMMU drivers generally need to keep track of.
Initially this is DT-specific to complement the existing of_iommu
support code, but will generalise further once other firmware methods
(e.g. ACPI IORT) come along.

Ultimately the aim is to promote the fwspec to a first-class member of
struct device, and handle the init/free automatically in the firmware
code. That way we can have API calls look for dev->fwspec->iommu_ops
before falling back to dev->bus->iommu_ops, and thus gracefully handle
those troublesome multi-IOMMU systems which we currently cannot. To
start with, though, make use of the existing archdata field and delegate
the init/free to drivers to allow an incremental conversion rather than
the impractical pain of trying to attempt everything in one go.

Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

- Replace crazy while loop with sane code
---
 drivers/iommu/of_iommu.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h | 15 ++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 19e1e8f2f871..04d616daffa3 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -226,3 +226,57 @@ static int __init of_iommu_init(void)
 	return 0;
 }
 postcore_initcall_sync(of_iommu_init);
+
+int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
+{
+	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+
+	if (fwspec)
+		return 0;
+
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	fwspec->iommu_np = of_node_get(iommu_np);
+	fwspec->iommu_ops = of_iommu_get_ops(iommu_np);
+	dev->archdata.iommu = fwspec;
+	return 0;
+}
+
+void iommu_fwspec_free(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+
+	if (fwspec) {
+		of_node_put(fwspec->iommu_np);
+		kfree(fwspec);
+	}
+}
+
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+{
+	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	size_t size;
+	int i;
+
+	if (!fwspec)
+		return -EINVAL;
+
+	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
+	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	for (i = 0; i < num_ids; i++)
+		fwspec->ids[fwspec->num_ids + i] = ids[i];
+
+	fwspec->num_ids += num_ids;
+	dev->archdata.iommu = fwspec;
+	return 0;
+}
+
+inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index e80b9c762a03..accdc0525f28 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -14,6 +14,14 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
+struct iommu_fwspec {
+	const struct iommu_ops	*iommu_ops;
+	struct device_node	*iommu_np;
+	void			*iommu_priv;
+	unsigned int		num_ids;
+	u32			ids[];
+};
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -29,8 +37,15 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+struct iommu_fwspec;
+
 #endif	/* CONFIG_OF_IOMMU */
 
+int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
+void iommu_fwspec_free(struct device *dev);
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
+struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
+
 void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
 const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
 
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
