Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE517C433E1
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:10:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53F4208E4
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53F4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99D1F8816F;
	Thu, 20 Aug 2020 15:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzJu79GShLCj; Thu, 20 Aug 2020 15:10:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B793388185;
	Thu, 20 Aug 2020 15:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4256C07FF;
	Thu, 20 Aug 2020 15:10:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D08C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D7ED8226A2
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dWPnpfqH0qUw for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 15:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 00BCE203F6
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:10:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84CA2152B;
 Thu, 20 Aug 2020 08:09:58 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA9CB3F6CF;
 Thu, 20 Aug 2020 08:09:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	joro@8bytes.org,
	linux@armlinux.org.uk
Subject: [PATCH 17/18] media/omap3isp: Clean up IOMMU workaround
Date: Thu, 20 Aug 2020 16:08:36 +0100
Message-Id: <11d8419744e4e744a9448180801b0c4683328afd.1597931876.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1597931875.git.robin.murphy@arm.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, digetx@gmail.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Now that arch/arm is wired up for default domains and iommu-dma, devices
behind IOMMUs will get mappings set up automatically as appropriate, so
there is no need for drivers to do so manually.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/media/platform/omap3isp/isp.c | 68 ++-------------------------
 drivers/media/platform/omap3isp/isp.h |  3 --
 2 files changed, 3 insertions(+), 68 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index b91e472ee764..196522883231 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -56,10 +56,6 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-#include <asm/dma-iommu.h>
-#endif
-
 #include <media/v4l2-common.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-device.h>
@@ -1942,51 +1938,6 @@ static int isp_initialize_modules(struct isp_device *isp)
 	return ret;
 }
 
-static void isp_detach_iommu(struct isp_device *isp)
-{
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-	arm_iommu_detach_device(isp->dev);
-	arm_iommu_release_mapping(isp->mapping);
-	isp->mapping = NULL;
-#endif
-}
-
-static int isp_attach_iommu(struct isp_device *isp)
-{
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-	struct dma_iommu_mapping *mapping;
-	int ret;
-
-	/*
-	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
-	 * VAs. This will allocate a corresponding IOMMU domain.
-	 */
-	mapping = arm_iommu_create_mapping(&platform_bus_type, SZ_1G, SZ_2G);
-	if (IS_ERR(mapping)) {
-		dev_err(isp->dev, "failed to create ARM IOMMU mapping\n");
-		return PTR_ERR(mapping);
-	}
-
-	isp->mapping = mapping;
-
-	/* Attach the ARM VA mapping to the device. */
-	ret = arm_iommu_attach_device(isp->dev, mapping);
-	if (ret < 0) {
-		dev_err(isp->dev, "failed to attach device to VA mapping\n");
-		goto error;
-	}
-
-	return 0;
-
-error:
-	arm_iommu_release_mapping(isp->mapping);
-	isp->mapping = NULL;
-	return ret;
-#else
-	return -ENODEV;
-#endif
-}
-
 /*
  * isp_remove - Remove ISP platform device
  * @pdev: Pointer to ISP platform device
@@ -2002,10 +1953,6 @@ static int isp_remove(struct platform_device *pdev)
 	isp_cleanup_modules(isp);
 	isp_xclk_cleanup(isp);
 
-	__omap3isp_get(isp, false);
-	isp_detach_iommu(isp);
-	__omap3isp_put(isp, false);
-
 	media_entity_enum_cleanup(&isp->crashed);
 	v4l2_async_notifier_cleanup(&isp->notifier);
 
@@ -2383,18 +2330,11 @@ static int isp_probe(struct platform_device *pdev)
 	isp->mmio_hist_base_phys =
 		mem->start + isp_res_maps[m].offset[OMAP3_ISP_IOMEM_HIST];
 
-	/* IOMMU */
-	ret = isp_attach_iommu(isp);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to attach to IOMMU\n");
-		goto error_isp;
-	}
-
 	/* Interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
 		ret = -ENODEV;
-		goto error_iommu;
+		goto error_isp;
 	}
 	isp->irq_num = ret;
 
@@ -2402,13 +2342,13 @@ static int isp_probe(struct platform_device *pdev)
 			     "OMAP3 ISP", isp)) {
 		dev_err(isp->dev, "Unable to request IRQ\n");
 		ret = -EINVAL;
-		goto error_iommu;
+		goto error_isp;
 	}
 
 	/* Entities */
 	ret = isp_initialize_modules(isp);
 	if (ret < 0)
-		goto error_iommu;
+		goto error_isp;
 
 	ret = isp_register_entities(isp);
 	if (ret < 0)
@@ -2433,8 +2373,6 @@ static int isp_probe(struct platform_device *pdev)
 	isp_unregister_entities(isp);
 error_modules:
 	isp_cleanup_modules(isp);
-error_iommu:
-	isp_detach_iommu(isp);
 error_isp:
 	isp_xclk_cleanup(isp);
 	__omap3isp_put(isp, false);
diff --git a/drivers/media/platform/omap3isp/isp.h b/drivers/media/platform/omap3isp/isp.h
index a9d760fbf349..b50459106d89 100644
--- a/drivers/media/platform/omap3isp/isp.h
+++ b/drivers/media/platform/omap3isp/isp.h
@@ -145,7 +145,6 @@ struct isp_xclk {
  * @syscon: Regmap for the syscon register space
  * @syscon_offset: Offset of the CSIPHY control register in syscon
  * @phy_type: ISP_PHY_TYPE_{3430,3630}
- * @mapping: IOMMU mapping
  * @stat_lock: Spinlock for handling statistics
  * @isp_mutex: Mutex for serializing requests to ISP.
  * @stop_failure: Indicates that an entity failed to stop.
@@ -185,8 +184,6 @@ struct isp_device {
 	u32 syscon_offset;
 	u32 phy_type;
 
-	struct dma_iommu_mapping *mapping;
-
 	/* ISP Obj */
 	spinlock_t stat_lock;	/* common lock for statistic drivers */
 	struct mutex isp_mutex;	/* For handling ref_count field */
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
