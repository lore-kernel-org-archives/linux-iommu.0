From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/7] iommu: add api to get iommu_domain of a device
Date: Thu, 19 Sep 2013 12:59:18 +0530
Message-ID: <1379575763-2091-3-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1379575763-2091-1-git-send-email-Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This api return the iommu domain to which the device is attached.
The iommu_domain is required for making API calls related to iommu.
Follow up patches which use this API to know iommu maping.

Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/iommu.c |   10 ++++++++++
 include/linux/iommu.h |    7 +++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbe9ca7..6ac5f50 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -696,6 +696,16 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
+struct iommu_domain *iommu_get_dev_domain(struct device *dev)
+{
+	struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (unlikely(ops == NULL || ops->get_dev_iommu_domain == NULL))
+		return NULL;
+
+	return ops->get_dev_iommu_domain(dev);
+}
+EXPORT_SYMBOL_GPL(iommu_get_dev_domain);
 /*
  * IOMMU groups are really the natrual working unit of the IOMMU, but
  * the IOMMU API works on domains and devices.  Bridge that gap by
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ea319e..fa046bd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,6 +127,7 @@ struct iommu_ops {
 	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
 	/* Get the numer of window per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
+	struct iommu_domain *(*get_dev_iommu_domain)(struct device *dev);
 
 	unsigned long pgsize_bitmap;
 };
@@ -190,6 +191,7 @@ extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				      phys_addr_t offset, u64 size,
 				      int prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
+extern struct iommu_domain *iommu_get_dev_domain(struct device *dev);
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
  * @domain: the iommu domain where the fault has happened
@@ -284,6 +286,11 @@ static inline void iommu_domain_window_disable(struct iommu_domain *domain,
 {
 }
 
+static inline struct iommu_domain *iommu_get_dev_domain(struct device *dev)
+{
+	return NULL;
+}
+
 static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	return 0;
-- 
1.7.0.4
