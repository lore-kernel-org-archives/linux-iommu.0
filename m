From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: new SBus related DMA warnings in 4.18+git
Date: Mon, 27 Aug 2018 17:47:16 +0200
Message-ID: <20180827154716.GA30492@lst.de>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1808260902280.22219-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Aug 26, 2018 at 10:48:44AM +0300, Meelis Roos wrote:
> Tried yesterdays git 4.18.0-12789-gaa5b105 on a Sun Ultra 1 with SBus 
> and several SBus connected devicess give DMA mapping related warnings:

This should have been around since the warning was added.

The patch below should fix it:

---
>From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Date: Mon, 27 Aug 2018 17:23:24 +0200
Subject: driver core: initialize a default DMA mask for platform device

We still treat devices without a DMA mask as defaulting to 32-bits for
both mask, but a few releases ago we've started warning about such
cases, as they require special cases to work around this sloppyness.
Add a dma_mask field to struct platform_object so that we can initialize
the dma_mask pointer in struct device and initialize both masks to
32-bits by default.  Architectures can still override this in
arch_setup_pdev_archdata if needed.

Note that the code looks a little odd with the various conditionals
because we have to support platform_device structures that are
statically allocated.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/base/platform.c         | 15 +++++++++++++--
 include/linux/platform_device.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..baf4b06cf2d9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -225,6 +225,17 @@ struct platform_object {
 	char name[];
 };
 
+static void setup_pdev_archdata(struct platform_device *pdev)
+{
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dma_mask)
+		pdev->dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pdev->dma_mask;
+	arch_setup_pdev_archdata(pdev);
+};
+
 /**
  * platform_device_put - destroy a platform device
  * @pdev: platform device to free
@@ -271,7 +282,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
 		pa->pdev.dev.release = platform_device_release;
-		arch_setup_pdev_archdata(&pa->pdev);
+		setup_pdev_archdata(&pa->pdev);
 	}
 
 	return pa ? &pa->pdev : NULL;
@@ -472,7 +483,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 int platform_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
-	arch_setup_pdev_archdata(pdev);
+	setup_pdev_archdata(pdev);
 	return platform_device_add(pdev);
 }
 EXPORT_SYMBOL_GPL(platform_device_register);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1a9f38f27f65..d84ec1de6022 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	int		id;
 	bool		id_auto;
 	struct device	dev;
+	dma_addr_t	dma_mask;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.18.0
