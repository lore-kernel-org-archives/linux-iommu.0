From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 6/9] iommu/of: Introduce iommu_fwspec
Date: Tue, 28 Jun 2016 16:48:25 +0100
Message-ID: <227abd6fb43e4163d94673066b4b736d7efaa635.1467123945.git.robin.murphy@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1467123945.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
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

v3: New.

 drivers/iommu/of_iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h | 18 ++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 25406a8b9d4e..2b90c1f56ff2 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -220,3 +220,50 @@ void __init of_iommu_init(void)
 				of_node_full_name(np));
 	}
 }
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
+
+	if (!fwspec)
+		return -EINVAL;
+
+	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + 1]);
+	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	while (num_ids--)
+		fwspec->ids[fwspec->num_ids++] = *ids++;
+
+	dev->archdata.iommu = fwspec;
+	return 0;
+}
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index bd02b44902d0..5a4f516cfcfe 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -15,6 +15,14 @@ extern void of_iommu_init(void);
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
@@ -31,8 +39,18 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+struct iommu_fwspec;
+
 #endif	/* CONFIG_OF_IOMMU */
 
+int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
+void iommu_fwspec_free(struct device *dev);
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
+static inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
+
 void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
 const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
 
-- 
2.8.1.dirty
