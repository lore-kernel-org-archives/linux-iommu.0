From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 8/8] iommu/amd: Update domain into to dte entry during
	device driver init
Date: Tue, 27 Sep 2016 09:51:43 +0800
Message-ID: <20160927015143.GG14155@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
	<1473951806-25511-9-git-send-email-bhe@redhat.com>
	<20160920125330.GG3541@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160920125330.GG3541-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/20/16 at 02:53pm, Joerg Roedel wrote:
> Hmm, have you tried hooking this into the set_dma_mask call-back? Every
> driver should call it for its device, so that should be a better
> indicator to now map a new domain.

Hi Joerg,

I tried hooking this into set_dma_mask call-back, but on my local
machine with amd iommu v2, an ohci pci device doesn't call set_dma_mask.
Then IO_PAGE_FAULT printing flooded.

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller (rev 11)

Below is the patch I made using set_dma_mask call-back. So should we do
as the original method, or use set_dma_mask method and add set_dma_mask
calling in those driver which missed calling it?


>From 1ca66f886a46839cb937fd1e6a1d84b6719f23c4 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Mon, 12 Sep 2016 08:05:15 +0800
Subject: [PATCH] iommu/amd: Update domain into to dte entry during device
 driver init

All devices are supposed to reset themselves at device driver initialization
stage. At this time if in kdump kernel those on-flight DMA will be stopped
because of device reset. It's best time to update the protection domain info,
especially pte_root, to dte entry which the device relates to. Usually
device driver initialization will call set_dma_mask to set the
limitation of dma address. Do it in set_dma_mask call-back is a good
chance.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6c37300..2a0b1ce 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2653,6 +2653,27 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 	return check_device(dev);
 }
 
+static int set_dma_mask(struct device *dev, u64 mask)
+{
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
+	struct protection_domain *domain = get_domain(dev);
+	u16 alias = amd_iommu_alias_table[dev_data->devid];
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
+
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
+               dev_data->domain_updated = true;
+               set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
+               if (alias != dev_data->devid)
+                       set_dte_entry(alias, domain, dev_data->ats.enabled);
+               device_flush_dte(dev_data);
+       }
+
+	if (!dev->dma_mask || !amd_iommu_dma_supported(dev, mask))
+		return -EIO;
+	*dev->dma_mask = mask;
+	return 0;
+}
+
 static struct dma_map_ops amd_iommu_dma_ops = {
 	.alloc		= alloc_coherent,
 	.free		= free_coherent,
@@ -2661,6 +2682,7 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 	.map_sg		= map_sg,
 	.unmap_sg	= unmap_sg,
 	.dma_supported	= amd_iommu_dma_supported,
+	.set_dma_mask	= set_dma_mask,
 };
 
 static int init_reserved_iova_ranges(void)
-- 
2.5.5
