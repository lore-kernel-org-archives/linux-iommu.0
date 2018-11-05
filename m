From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 1/8] iommu: Add APIs for multiple domains per device
Date: Mon,  5 Nov 2018 15:34:01 +0800
Message-ID: <20181105073408.21815-2-baolu.lu@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181105073408.21815-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
DMA isolation, all DMA requests out of or to a subset of
a physical PCI device can be protected by the IOMMU. As a
result, there is a request in software to attach multiple
domains to a physical PCI device. One example of such use
model is the Intel Scalable IOV [1] [2]. The Intel vt-d
3.0 spec [3] introduces the scalable mode which enables
PASID granularity DMA isolation.

This adds the APIs to support multiple domains per device.
In order to ease the discussions, we call it 'a domain in
auxiliary mode' or simply 'auxiliary domain' when multiple
domains are attached to a physical device.

The APIs includes:

* iommu_get_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_CAPABILITY)
  - Represents the ability of supporting multiple domains
    per device.

* iommu_get_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLED)
  - Checks whether the device identified by @dev is working
    in auxiliary mode.

* iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLE)
  - Enables the multiple domains capability for the device
    referenced by @dev.

* iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_DISABLE)
  - Disables the multiple domains capability for the device
    referenced by @dev.

* iommu_attach_device_aux(domain, dev)
  - Attaches @domain to @dev in the auxiliary mode. Multiple
    domains could be attached to a single device in the
    auxiliary mode with each domain representing an isolated
    address space for an assignable subset of the device.

* iommu_detach_device_aux(domain, dev)
  - Detach @domain which has been attached to @dev in the
    auxiliary mode.

* iommu_domain_get_attr(domain, DOMAIN_ATTR_AUXD_ID)
  - Return ID used for finer-granularity DMA translation.
    For the Intel Scalable IOV usage model, this will be
    a PASID. The device which supports Scalalbe IOV needs
    to writes this ID to the device register so that DMA
    requests could be tagged with a right PASID prefix.

Many people involved in discussions of this design.

Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

and some discussions can be found here [4].

[1] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[2] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
[3] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[4] https://lkml.org/lkml/2018/7/26/4

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Suggested-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Suggested-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/iommu.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index edbdf5d6962c..0b7c96d1425e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2030,3 +2030,55 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+/*
+ * Generic interfaces to get or set per device IOMMU attributions.
+ */
+int iommu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->get_dev_attr)
+		return ops->get_dev_attr(dev, attr, data);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iommu_get_dev_attr);
+
+int iommu_set_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->set_dev_attr)
+		return ops->set_dev_attr(dev, attr, data);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iommu_set_dev_attr);
+
+/*
+ * APIs to attach/detach a domain to/from a device in the
+ * auxiliary mode.
+ */
+int iommu_attach_device_aux(struct iommu_domain *domain, struct device *dev)
+{
+	int ret = -ENODEV;
+
+	if (domain->ops->attach_dev_aux)
+		ret = domain->ops->attach_dev_aux(domain, dev);
+
+	if (!ret)
+		trace_attach_device_to_domain(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_attach_device_aux);
+
+void iommu_detach_device_aux(struct iommu_domain *domain, struct device *dev)
+{
+	if (domain->ops->detach_dev_aux) {
+		domain->ops->detach_dev_aux(domain, dev);
+		trace_detach_device_from_domain(dev);
+	}
+}
+EXPORT_SYMBOL_GPL(iommu_detach_device_aux);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..9bf1b3f2457a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -126,6 +126,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_MAX,
+	DOMAIN_ATTR_AUXD_ID,
 };
 
 /* These are the possible reserved region types */
@@ -156,6 +157,14 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
+/* Per device IOMMU attributions */
+enum iommu_dev_attr {
+	IOMMU_DEV_ATTR_AUXD_CAPABILITY,
+	IOMMU_DEV_ATTR_AUXD_ENABLED,
+	IOMMU_DEV_ATTR_AUXD_ENABLE,
+	IOMMU_DEV_ATTR_AUXD_DISABLE,
+};
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -183,6 +192,8 @@ struct iommu_resv_region {
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
  * @of_xlate: add OF master IDs to iommu grouping
+ * @get_dev_attr: get per device IOMMU attributions
+ * @set_dev_attr: set per device IOMMU attributions
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -226,6 +237,15 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	/* Get/set per device IOMMU attributions */
+	int (*get_dev_attr)(struct device *dev,
+			    enum iommu_dev_attr attr, void *data);
+	int (*set_dev_attr)(struct device *dev,
+			    enum iommu_dev_attr attr, void *data);
+	/* Attach/detach aux domain */
+	int (*attach_dev_aux)(struct iommu_domain *domain, struct device *dev);
+	void (*detach_dev_aux)(struct iommu_domain *domain, struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -398,6 +418,16 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+int iommu_get_dev_attr(struct device *dev,
+		       enum iommu_dev_attr attr, void *data);
+int iommu_set_dev_attr(struct device *dev,
+		       enum iommu_dev_attr attr, void *data);
+
+extern int iommu_attach_device_aux(struct iommu_domain *domain,
+				   struct device *dev);
+extern void iommu_detach_device_aux(struct iommu_domain *domain,
+				    struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -682,6 +712,28 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int
+iommu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	return -EINVAL;
+}
+
+static inline int
+iommu_set_dev_attr(struct device *dev, enum iommu_dev_attr attr, void *data)
+{
+	return -EINVAL;
+}
+
+static inline int
+iommu_attach_device_aux(struct iommu_domain *domain, struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline void
+iommu_detach_device_aux(struct iommu_domain *domain, struct device *dev)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.17.1
