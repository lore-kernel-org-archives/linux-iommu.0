From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] iommu/amd: Handle errors returned from iommu_init_device
Date: Thu, 11 Jun 2015 09:35:52 +0200
Message-ID: <20150611073552.GC16345@suse.de>
References: <20150610153618.GA10549@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150610153618.GA10549@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Dan,

On Wed, Jun 10, 2015 at 06:36:18PM +0300, Dan Carpenter wrote:
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 0a3da4517107: "iommu/amd: Put IOMMUv2 devices in a direct 
> mapped domain" from May 28, 2015, leads to the following Smatch 
> complaint:
> 
> drivers/iommu/amd_iommu.c:2285 amd_iommu_add_device()
> 	 error: we previously assumed 'dev_data' could be null (see line 2279)
> 
> drivers/iommu/amd_iommu.c
>   2278		dev_data = get_dev_data(dev);
>   2279		if (dev_data && dev_data->iommu_v2)
>                     ^^^^^^^^
> Check.
> 
>   2280			iommu_request_dm_for_dev(dev);
>   2281	
>   2282		/* Domains are initialized for this device - have a look what we ended up with */
>   2283		domain = iommu_get_domain_for_dev(dev);
>   2284		if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>   2285			dev_data->passthrough = true;
>                         ^^^^^^^^^^
> Unchecked dereference.
> 
>   2286			dev->archdata.dma_ops = &nommu_dma_ops;
>   2287		} else {

This was a bit more complicated. I fixed it with this add-on patch:

>From 8a683d98936d7aa4e3ae554efca3a52c042593b9 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Thu, 11 Jun 2015 09:21:39 +0200
Subject: [PATCH] iommu/amd: Handle errors returned from iommu_init_device

Without this patch only -ENOTSUPP is handled, but there are
other possible errors. Handle them too.

Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6659b51..73fc4b7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2265,7 +2265,11 @@ static int amd_iommu_add_device(struct device *dev)
 	iommu = amd_iommu_rlookup_table[devid];
 
 	ret = iommu_init_device(dev);
-	if (ret == -ENOTSUPP) {
+	if (ret) {
+		if (ret != -ENOTSUPP)
+			pr_err("Failed to initialize device %s - trying to proceed anyway\n",
+				dev_name(dev));
+
 		iommu_ignore_device(dev);
 		dev->archdata.dma_ops = &nommu_dma_ops;
 		goto out;
@@ -2273,7 +2277,10 @@ static int amd_iommu_add_device(struct device *dev)
 	init_iommu_group(dev);
 
 	dev_data = get_dev_data(dev);
-	if (dev_data && dev_data->iommu_v2)
+
+	BUG_ON(!dev_data);
+
+	if (dev_data->iommu_v2)
 		iommu_request_dm_for_dev(dev);
 
 	/* Domains are initialized for this device - have a look what we ended up with */
-- 
1.8.4.5
