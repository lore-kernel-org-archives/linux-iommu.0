From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v8 1/9] iommu: Add APIs for multiple domains per device
Date: Mon, 25 Mar 2019 09:30:28 +0800
Message-ID: <20190325013036.18400-2-baolu.lu@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190325013036.18400-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Sharing a physical PCI device in a finer-granularity way
is becoming a consensus in the industry. IOMMU vendors
are also engaging efforts to support such sharing as well
as possible. Among the efforts, the capability of support
finer-granularity DMA isolation is a common requirement
due to the security consideration. With finer-granularity
DMA isolation, subsets of a PCI function can be isolated
from each others by the IOMMU. As a result, there is a
request in software to attach multiple domains to a physical
PCI device. One example of such use model is the Intel
Scalable IOV [1] [2]. The Intel vt-d 3.0 spec [3] introduces
the scalable mode which enables PASID granularity DMA
isolation.

This adds the APIs to support multiple domains per device.
In order to ease the discussions, we call it 'a domain in
auxiliary mode' or simply 'auxiliary domain' when multiple
domains are attached to a physical device.

The APIs include:

* iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
  - Detect both IOMMU and PCI endpoint devices supporting
    the feature (aux-domain here) without the host driver
    dependency.

* iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)
  - Check the enabling status of the feature (aux-domain
    here). The aux-domain interfaces are available only
    if this returns true.

* iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)
  - Enable/disable device specific aux-domain feature.

* iommu_aux_attach_device(domain, dev)
  - Attaches @domain to @dev in the auxiliary mode. Multiple
    domains could be attached to a single device in the
    auxiliary mode with each domain representing an isolated
    address space for an assignable subset of the device.

* iommu_aux_detach_device(domain, dev)
  - Detach @domain which has been attached to @dev in the
    auxiliary mode.

* iommu_aux_get_pasid(domain, dev)
  - Return ID used for finer-granularity DMA translation.
    For the Intel Scalable IOV usage model, this will be
    a PASID. The device which supports Scalable IOV needs
    to write this ID to the device register so that DMA
    requests could be tagged with a right PASID prefix.

This has been updated with the latest proposal from Joerg
posted here [5].

Many people involved in discussions of this design.

Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

and some discussions can be found here [4] [5].

[1] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[2] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
[3] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[4] https://lkml.org/lkml/2018/7/26/4
[5] https://www.spinics.net/lists/iommu/msg31874.html

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Suggested-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Suggested-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Suggested-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 70 +++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1164b9926a2b..1b697feb3e30 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2030,3 +2030,99 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+/*
+ * Per device IOMMU features.
+ */
+bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->dev_has_feat)
+		return ops->dev_has_feat(dev, feat);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_has_feature);
+
+int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->dev_enable_feat)
+		return ops->dev_enable_feat(dev, feat);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
+
+/*
+ * The device drivers should do the necessary cleanups before calling this.
+ * For example, before disabling the aux-domain feature, the device driver
+ * should detach all aux-domains. Otherwise, this will return -EBUSY.
+ */
+int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->dev_disable_feat)
+		return ops->dev_disable_feat(dev, feat);
+
+	return -EBUSY;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
+
+bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->dev_feat_enabled)
+		return ops->dev_feat_enabled(dev, feat);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
+
+/*
+ * Aux-domain specific attach/detach.
+ *
+ * Only works if iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) returns
+ * true. Also, as long as domains are attached to a device through this
+ * interface, any tries to call iommu_attach_device() should fail
+ * (iommu_detach_device() can't fail, so we fail when trying to re-attach).
+ * This should make us safe against a device being attached to a guest as a
+ * whole while there are still pasid users on it (aux and sva).
+ */
+int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
+{
+	int ret = -ENODEV;
+
+	if (domain->ops->aux_attach_dev)
+		ret = domain->ops->aux_attach_dev(domain, dev);
+
+	if (!ret)
+		trace_attach_device_to_domain(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
+
+void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
+{
+	if (domain->ops->aux_detach_dev) {
+		domain->ops->aux_detach_dev(domain, dev);
+		trace_detach_device_from_domain(dev);
+	}
+}
+EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
+
+int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	int ret = -ENODEV;
+
+	if (domain->ops->aux_get_pasid)
+		ret = domain->ops->aux_get_pasid(domain, dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ffbbc7e39cee..8239ece9fdfc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -156,6 +156,11 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
+/* Per device IOMMU features */
+enum iommu_dev_features {
+	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
+};
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -186,6 +191,11 @@ struct iommu_resv_region {
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
+ * @dev_has/enable/disable_feat: per device entries to check/enable/disable
+ *                               iommu specific features.
+ * @dev_feat_enabled: check enabled feature
+ * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
+ * @aux_get_pasid: get the pasid given an aux-domain
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -230,6 +240,17 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	/* Per device IOMMU features */
+	bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features f);
+	bool (*dev_feat_enabled)(struct device *dev, enum iommu_dev_features f);
+	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
+	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
+
+	/* Aux-domain specific attach/detach entries */
+	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
+	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -416,6 +437,14 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
+bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features f);
+int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
+int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
+bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
+int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
+void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
+int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -700,6 +729,47 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline bool
+iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
+{
+	return false;
+}
+
+static inline bool
+iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
+{
+	return false;
+}
+
+static inline int
+iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
+{
+	return -ENODEV;
+}
+
+static inline int
+iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
+{
+	return -ENODEV;
+}
+
+static inline int
+iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline void
+iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
+{
+}
+
+static inline int
+iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.17.1
