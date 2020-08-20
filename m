Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B113C433EA
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:09:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1D6221E2
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1D6221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E39BA226A2;
	Thu, 20 Aug 2020 15:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YM5q4jPhx-SU; Thu, 20 Aug 2020 15:09:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C3E922735;
	Thu, 20 Aug 2020 15:09:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FFFDC07FF;
	Thu, 20 Aug 2020 15:09:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BEB3C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2AD5722767
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m1FCdax4Y3ch for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 15:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id C3574226A2
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:09:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4642D142F;
 Thu, 20 Aug 2020 08:09:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B557C3F6CF;
 Thu, 20 Aug 2020 08:09:20 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	joro@8bytes.org,
	linux@armlinux.org.uk
Subject: [PATCH 08/18] iommu/renesas: Remove arch/arm workaround
Date: Thu, 20 Aug 2020 16:08:27 +0100
Message-Id: <8489dd1d9224ad60e63b9903c40832481eab622f.1597931876.git.robin.murphy@arm.com>
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

Now that arch/arm is wired up for default domains and iommu-dma, remove
the shared mapping workaround and rely on groups there as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 69 --------------------------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 0f18abda0e20..8ad74a76f402 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -26,15 +26,6 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-#include <asm/dma-iommu.h>
-#else
-#define arm_iommu_create_mapping(...)	NULL
-#define arm_iommu_attach_device(...)	-ENODEV
-#define arm_iommu_release_mapping(...)	do {} while (0)
-#define arm_iommu_detach_device(...)	do {} while (0)
-#endif
-
 #define IPMMU_CTX_MAX		8U
 #define IPMMU_CTX_INVALID	-1
 
@@ -67,7 +58,6 @@ struct ipmmu_vmsa_device {
 	s8 utlb_ctx[IPMMU_UTLB_MAX];
 
 	struct iommu_group *group;
-	struct dma_iommu_mapping *mapping;
 };
 
 struct ipmmu_vmsa_domain {
@@ -805,50 +795,6 @@ static int ipmmu_of_xlate(struct device *dev,
 	return ipmmu_init_platform_device(dev, spec);
 }
 
-static int ipmmu_init_arm_mapping(struct device *dev)
-{
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	int ret;
-
-	/*
-	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
-	 * VAs. This will allocate a corresponding IOMMU domain.
-	 *
-	 * TODO:
-	 * - Create one mapping per context (TLB).
-	 * - Make the mapping size configurable ? We currently use a 2GB mapping
-	 *   at a 1GB offset to ensure that NULL VAs will fault.
-	 */
-	if (!mmu->mapping) {
-		struct dma_iommu_mapping *mapping;
-
-		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						   SZ_1G, SZ_2G);
-		if (IS_ERR(mapping)) {
-			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			ret = PTR_ERR(mapping);
-			goto error;
-		}
-
-		mmu->mapping = mapping;
-	}
-
-	/* Attach the ARM VA mapping to the device. */
-	ret = arm_iommu_attach_device(dev, mmu->mapping);
-	if (ret < 0) {
-		dev_err(dev, "Failed to attach device to VA mapping\n");
-		goto error;
-	}
-
-	return 0;
-
-error:
-	if (mmu->mapping)
-		arm_iommu_release_mapping(mmu->mapping);
-
-	return ret;
-}
-
 static struct iommu_device *ipmmu_probe_device(struct device *dev)
 {
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
@@ -862,20 +808,8 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
 	return &mmu->iommu;
 }
 
-static void ipmmu_probe_finalize(struct device *dev)
-{
-	int ret = 0;
-
-	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
-		ret = ipmmu_init_arm_mapping(dev);
-
-	if (ret)
-		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
-}
-
 static void ipmmu_release_device(struct device *dev)
 {
-	arm_iommu_detach_device(dev);
 }
 
 static struct iommu_group *ipmmu_find_group(struct device *dev)
@@ -905,7 +839,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
-	.probe_finalize = ipmmu_probe_finalize,
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : ipmmu_find_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
@@ -1118,8 +1051,6 @@ static int ipmmu_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&mmu->iommu);
 	iommu_device_unregister(&mmu->iommu);
 
-	arm_iommu_release_mapping(mmu->mapping);
-
 	ipmmu_device_reset(mmu);
 
 	return 0;
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
