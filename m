From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/26] iommu/vt-d: Rename iommu_detach_dependent_devices()
Date: Wed,  5 Aug 2015 17:18:48 +0200
Message-ID: <1438787937-7340-18-git-send-email-joro@8bytes.org>
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

Rename this function and the ones further down its
call-chain to domain_context_clear_*. In particular this
means:

	iommu_detach_dependent_devices -> domain_context_clear
		   iommu_detach_dev_cb -> domain_context_clear_one_cb
		      iommu_detach_dev -> domain_context_clear_one

These names match a lot better with its
domain_context_mapping counterparts.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e033bb0..08391a6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -472,8 +472,8 @@ static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 				     struct device *dev);
-static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
-					   struct device *dev);
+static void domain_context_clear(struct intel_iommu *iommu,
+				 struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
 
@@ -2228,7 +2228,7 @@ static inline int domain_pfn_mapping(struct dmar_domain *domain, unsigned long i
 	return __domain_mapping(domain, iov_pfn, NULL, phys_pfn, nr_pages, prot);
 }
 
-static void iommu_detach_dev(struct intel_iommu *iommu, u8 bus, u8 devfn)
+static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	if (!iommu)
 		return;
@@ -4528,11 +4528,11 @@ out_free_dmar:
 	return ret;
 }
 
-static int iommu_detach_dev_cb(struct pci_dev *pdev, u16 alias, void *opaque)
+static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *opaque)
 {
 	struct intel_iommu *iommu = opaque;
 
-	iommu_detach_dev(iommu, PCI_BUS_NUM(alias), alias & 0xff);
+	domain_context_clear_one(iommu, PCI_BUS_NUM(alias), alias & 0xff);
 	return 0;
 }
 
@@ -4542,13 +4542,12 @@ static int iommu_detach_dev_cb(struct pci_dev *pdev, u16 alias, void *opaque)
  * devices, unbinding the driver from any one of them will possibly leave
  * the others unable to operate.
  */
-static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
-					   struct device *dev)
+static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
 {
 	if (!iommu || !dev || !dev_is_pci(dev))
 		return;
 
-	pci_for_each_dma_alias(to_pci_dev(dev), &iommu_detach_dev_cb, iommu);
+	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb, iommu);
 }
 
 static void dmar_remove_one_dev_info(struct dmar_domain *domain,
@@ -4573,8 +4572,7 @@ static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	iommu_disable_dev_iotlb(info);
-	iommu_detach_dev(iommu, info->bus, info->devfn);
-	iommu_detach_dependent_devices(iommu, dev);
+	domain_context_clear(iommu, dev);
 	free_devinfo_mem(info);
 	domain_detach_iommu(domain, iommu);
 
-- 
1.9.1
