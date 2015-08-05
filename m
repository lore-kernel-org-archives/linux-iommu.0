From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/26] iommu/vt-d: Calculate translation in
	domain_context_mapping_one
Date: Wed,  5 Aug 2015 17:18:36 +0200
Message-ID: <1438787937-7340-6-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

There is no reason to pass the translation type through
multiple layers. It can also be determined in the
domain_context_mapping_one function directly.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 58fc4bb..1a934f8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -364,7 +364,8 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 static struct dmar_domain *si_domain;
 static int hw_pass_through = 1;
 
-/* domain represents a virtual machine, more than one devices
+/*
+ * Domain represents a virtual machine, more than one devices
  * across iommus may be owned in one domain, e.g. kvm guest.
  */
 #define DOMAIN_FLAG_VIRTUAL_MACHINE	(1 << 0)
@@ -638,6 +639,11 @@ static inline int domain_type_is_vm(struct dmar_domain *domain)
 	return domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE;
 }
 
+static inline int domain_type_is_si(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
+}
+
 static inline int domain_type_is_vm_or_si(struct dmar_domain *domain)
 {
 	return domain->flags & (DOMAIN_FLAG_VIRTUAL_MACHINE |
@@ -1904,21 +1910,24 @@ static void domain_exit(struct dmar_domain *domain)
 
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
-				      u8 bus, u8 devfn, int translation)
+				      u8 bus, u8 devfn)
 {
+	int translation = CONTEXT_TT_MULTI_LEVEL;
+	struct device_domain_info *info = NULL;
 	struct context_entry *context;
 	unsigned long flags;
 	struct dma_pte *pgd;
 	int id;
 	int agaw;
-	struct device_domain_info *info = NULL;
+
+	translation = CONTEXT_TT_MULTI_LEVEL;
+	if (hw_pass_through && domain_type_is_si(domain))
+		translation = CONTEXT_TT_PASS_THROUGH;
 
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
 	BUG_ON(!domain->pgd);
-	BUG_ON(translation != CONTEXT_TT_PASS_THROUGH &&
-	       translation != CONTEXT_TT_MULTI_LEVEL);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	context = iommu_context_addr(iommu, bus, devfn, 1);
@@ -2010,7 +2019,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 struct domain_context_mapping_data {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
-	int translation;
 };
 
 static int domain_context_mapping_cb(struct pci_dev *pdev,
@@ -2019,13 +2027,11 @@ static int domain_context_mapping_cb(struct pci_dev *pdev,
 	struct domain_context_mapping_data *data = opaque;
 
 	return domain_context_mapping_one(data->domain, data->iommu,
-					  PCI_BUS_NUM(alias), alias & 0xff,
-					  data->translation);
+					  PCI_BUS_NUM(alias), alias & 0xff);
 }
 
 static int
-domain_context_mapping(struct dmar_domain *domain, struct device *dev,
-		       int translation)
+domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
@@ -2036,12 +2042,10 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev,
 		return -ENODEV;
 
 	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, bus, devfn,
-						  translation);
+		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
 	data.domain = domain;
 	data.iommu = iommu;
-	data.translation = translation;
 
 	return pci_for_each_dma_alias(to_pci_dev(dev),
 				      &domain_context_mapping_cb, &data);
@@ -2508,7 +2512,7 @@ static int iommu_prepare_identity_map(struct device *dev,
 		goto error;
 
 	/* context entry init */
-	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
+	ret = domain_context_mapping(domain, dev);
 	if (ret)
 		goto error;
 
@@ -2621,8 +2625,7 @@ static int identity_mapping(struct device *dev)
 	return 0;
 }
 
-static int domain_add_dev_info(struct dmar_domain *domain,
-			       struct device *dev, int translation)
+static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
@@ -2637,7 +2640,7 @@ static int domain_add_dev_info(struct dmar_domain *domain,
 	if (ndomain != domain)
 		return -EBUSY;
 
-	ret = domain_context_mapping(domain, dev, translation);
+	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		domain_remove_one_dev_info(domain, dev);
 		return ret;
@@ -2782,9 +2785,7 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 	if (!iommu_should_identity_map(dev, 1))
 		return 0;
 
-	ret = domain_add_dev_info(si_domain, dev,
-				  hw ? CONTEXT_TT_PASS_THROUGH :
-				       CONTEXT_TT_MULTI_LEVEL);
+	ret = domain_add_dev_info(si_domain, dev);
 	if (!ret)
 		pr_info("%s identity mapping for device %s\n",
 			hw ? "Hardware" : "Software", dev_name(dev));
@@ -3311,7 +3312,7 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 
 	/* make sure context mapping is ok */
 	if (unlikely(!domain_context_mapped(dev))) {
-		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
+		ret = domain_context_mapping(domain, dev);
 		if (ret) {
 			pr_err("Domain context map for %s failed\n",
 			       dev_name(dev));
@@ -3366,10 +3367,7 @@ static int iommu_no_mapping(struct device *dev)
 		 */
 		if (iommu_should_identity_map(dev, 0)) {
 			int ret;
-			ret = domain_add_dev_info(si_domain, dev,
-						  hw_pass_through ?
-						  CONTEXT_TT_PASS_THROUGH :
-						  CONTEXT_TT_MULTI_LEVEL);
+			ret = domain_add_dev_info(si_domain, dev);
 			if (!ret) {
 				pr_info("64bit %s uses identity mapping\n",
 					dev_name(dev));
@@ -4786,7 +4784,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
 
-	return domain_add_dev_info(dmar_domain, dev, CONTEXT_TT_MULTI_LEVEL);
+	return domain_add_dev_info(dmar_domain, dev);
 }
 
 static void intel_iommu_detach_device(struct iommu_domain *domain,
-- 
1.9.1
