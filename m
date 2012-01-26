From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] iommu: Add domain-attribute handlers
Date: Thu, 26 Jan 2012 19:40:52 +0100
Message-ID: <1327603257-17028-2-git-send-email-joerg.roedel@amd.com>
References: <1327603257-17028-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1327603257-17028-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch introduces an extension to the iommu-api to get
and set attributes for an iommu_domain. Two functions are
introduced for this:

	* iommu_domain_get_attr()
	* iommu_domain_set_attr()

These functions will be used to make the iommu-api suitable
for GART-like IOMMUs and to implement hardware-specifc
api-extensions.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/iommu.c |   20 ++++++++++++++++++++
 include/linux/iommu.h |   28 +++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2198b2d..ef54718 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -341,3 +341,23 @@ int iommu_device_group(struct device *dev, unsigned int *groupid)
 	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(iommu_device_group);
+
+int iommu_domain_get_attr(struct iommu_domain *domain,
+			  enum iommu_attr attr, void *data)
+{
+	if (!domain->ops->domain_get_attr)
+		return -EINVAL;
+
+	return domain->ops->domain_get_attr(domain, attr, data);
+}
+EXPORT_SYMBOL_GPL(iommu_domain_get_attr);
+
+int iommu_domain_set_attr(struct iommu_domain *domain,
+			  enum iommu_attr attr, void *data)
+{
+	if (!domain->ops->domain_set_attr)
+		return -EINVAL;
+
+	return domain->ops->domain_set_attr(domain, attr, data);
+}
+EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d937580..8b66e84 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -46,6 +46,10 @@ struct iommu_domain {
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
 #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
 
+enum iommu_attr {
+	DOMAIN_ATTR_MAX,
+};
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -58,7 +62,8 @@ struct iommu_domain {
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @domain_has_cap: domain capabilities query
- * @commit: commit iommu domain
+ * @domain_get_attr: Query domain attributes
+ * @domain_set_attr: Change domain attributes
  * @pgsize_bitmap: bitmap of supported page sizes
  */
 struct iommu_ops {
@@ -75,6 +80,10 @@ struct iommu_ops {
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
 	int (*device_group)(struct device *dev, unsigned int *groupid);
+	int (*domain_get_attr)(struct iommu_domain *domain,
+			       enum iommu_attr attr, void *data);
+	int (*domain_set_attr)(struct iommu_domain *domain,
+			       enum iommu_attr attr, void *data);
 	unsigned long pgsize_bitmap;
 };
 
@@ -98,6 +107,11 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 					iommu_fault_handler_t handler);
 extern int iommu_device_group(struct device *dev, unsigned int *groupid);
 
+extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
+				 void *data);
+extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
+				 void *data);
+
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
  * @domain: the iommu domain where the fault has happened
@@ -200,6 +214,18 @@ static inline int iommu_device_group(struct device *dev, unsigned int *groupid)
 	return -ENODEV;
 }
 
+static inline int iommu_domain_get_attr(struct iommu_domain *domain,
+					enum iommu_attr attr, void *data)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_domain_set_attr(struct iommu_domain *domain,
+					enum iommu_attr attr, void *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
-- 
1.7.5.4
