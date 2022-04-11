Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0014C4332F
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 13:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DC4240A79;
	Mon, 11 Apr 2022 13:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyfxUEmqfmFk; Mon, 11 Apr 2022 13:46:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3FF09403C4;
	Mon, 11 Apr 2022 13:46:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22657C0033;
	Mon, 11 Apr 2022 13:46:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8635C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 13:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A748C410C1
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 13:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FtSMtJ1j71nW for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 13:46:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8ACBB40A05
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 13:46:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A365E1570;
 Mon, 11 Apr 2022 06:46:47 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC3083F73B;
 Mon, 11 Apr 2022 06:46:46 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: thierry.reding@gmail.com
Subject: [PATCH v2] drm/tegra: Stop using iommu_present()
Date: Mon, 11 Apr 2022 14:46:43 +0100
Message-Id: <1f7c304a79b8b8dd5d4716786cae7502a0cc31f5.1649684782.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
 jonathanh@nvidia.com
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

Refactor the confusing logic to make it both clearer and more robust. If
the host1x parent device does have an IOMMU domain then iommu_present()
is redundantly true, while otherwise for the 32-bit DMA mask case it
still doesn't say whether the IOMMU driver actually knows about the DRM
device or not.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Fix logic for older SoCs and clarify.

 drivers/gpu/drm/tegra/drm.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 9464f522e257..4f2bdab31064 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1092,6 +1092,19 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
 	struct host1x *host1x = dev_get_drvdata(dev->dev.parent);
 	struct iommu_domain *domain;
 
+	/* For starters, this is moot if no IOMMU is available */
+	if (!device_iommu_mapped(&dev->dev))
+		return false;
+
+	/*
+	 * Tegra20 and Tegra30 don't support addressing memory beyond the
+	 * 32-bit boundary, so the regular GATHER opcodes will always be
+	 * sufficient and whether or not the host1x is attached to an IOMMU
+	 * doesn't matter.
+	 */
+	if (host1x_get_dma_mask(host1x) <= DMA_BIT_MASK(32))
+		return true;
+
 	/*
 	 * If the Tegra DRM clients are backed by an IOMMU, push buffers are
 	 * likely to be allocated beyond the 32-bit boundary if sufficient
@@ -1122,14 +1135,13 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
 	domain = iommu_get_domain_for_dev(dev->dev.parent);
 
 	/*
-	 * Tegra20 and Tegra30 don't support addressing memory beyond the
-	 * 32-bit boundary, so the regular GATHER opcodes will always be
-	 * sufficient and whether or not the host1x is attached to an IOMMU
-	 * doesn't matter.
+	 * At the moment, the exact type of domain doesn't actually matter.
+	 * Only for 64-bit kernels might this be a managed DMA API domain, and
+	 * then only on newer SoCs using arm-smmu, since tegra-smmu doesn't
+	 * support default domains at all, and since those SoCs are the same
+	 * ones with extended GATHER support, even if it's a passthrough domain
+	 * it can still work out OK.
 	 */
-	if (!domain && host1x_get_dma_mask(host1x) <= DMA_BIT_MASK(32))
-		return true;
-
 	return domain != NULL;
 }
 
@@ -1149,7 +1161,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
 		goto put;
 	}
 
-	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
+	if (host1x_drm_wants_iommu(dev)) {
 		tegra->domain = iommu_domain_alloc(&platform_bus_type);
 		if (!tegra->domain) {
 			err = -ENOMEM;
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
