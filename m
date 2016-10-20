From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 7/9] iommu/amd: Update domain into to dte entry during
 device driver init
Date: Thu, 20 Oct 2016 19:37:18 +0800
Message-ID: <1476963440-23039-8-git-send-email-bhe@redhat.com>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1476963440-23039-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

All devices are supposed to reset themselves at device driver initialization
stage. At this time if in kdump kernel those on-flight DMA will be stopped
because of device reset. It's best time to update the protection domain info,
especially pte_root, to dte entry which the device relates to.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index aa78506..3b95904 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2396,6 +2396,10 @@ static dma_addr_t __map_single(struct device *dev,
 			       enum dma_data_direction direction,
 			       u64 dma_mask)
 {
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
+	struct protection_domain *domain = get_domain(dev);
+	u16 alias = amd_iommu_alias_table[dev_data->devid];
 	dma_addr_t offset = paddr & ~PAGE_MASK;
 	dma_addr_t address, start, ret;
 	unsigned int pages;
@@ -2410,6 +2414,13 @@ static dma_addr_t __map_single(struct device *dev,
 		goto out;
 
 	prot = dir2prot(direction);
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
+		dev_data->domain_updated = true;
+		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
+		if (alias != dev_data->devid)
+			set_dte_entry(alias, domain, dev_data->ats.enabled);
+		device_flush_dte(dev_data);
+	}
 
 	start = address;
 	for (i = 0; i < pages; ++i) {
@@ -2555,6 +2566,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  int nelems, enum dma_data_direction direction,
 		  unsigned long attrs)
 {
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
+	u16 alias = amd_iommu_alias_table[dev_data->devid];
 	int mapped_pages = 0, npages = 0, prot = 0, i;
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
@@ -2576,6 +2590,13 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		goto out_err;
 
 	prot = dir2prot(direction);
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
+		dev_data->domain_updated = true;
+		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
+		if (alias != dev_data->devid)
+			set_dte_entry(alias, domain, dev_data->ats.enabled);
+		device_flush_dte(dev_data);
+	}
 
 	/* Map all sg entries */
 	for_each_sg(sglist, s, nelems, i) {
-- 
2.5.5
