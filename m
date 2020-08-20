Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB8C433E1
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:09:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EFF208C7
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EFF208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3463A203F6;
	Thu, 20 Aug 2020 15:09:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ot5QANrj+TgW; Thu, 20 Aug 2020 15:08:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A2B51FC7D;
	Thu, 20 Aug 2020 15:08:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C401C07FF;
	Thu, 20 Aug 2020 15:08:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86416C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E2EA8816A
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00RgHvNpyocp for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 15:08:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0033B87E88
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:08:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA18331B;
 Thu, 20 Aug 2020 08:08:53 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FDC83F6CF;
 Thu, 20 Aug 2020 08:08:50 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	joro@8bytes.org,
	linux@armlinux.org.uk
Subject: [PATCH 00/18] Convert arch/arm to use iommu-dma
Date: Thu, 20 Aug 2020 16:08:19 +0100
Message-Id: <cover.1597931875.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
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

Hi all,

After 5 years or so of intending to get round to this, finally the
time comes! The changes themselves actualy turn out to be relatively
mechanical; the bigger concern appears to be how to get everything
merged across about 5 diffferent trees given the dependencies.

I've lightly boot-tested things on Rockchip RK3288 and Exynos 4412
(Odroid-U3), to the degree that their display drivers should be using
IOMMU-backed buffers and don't explode (the Odroid doesn't manage to
send a working HDMI signal to the one monitor I have that it actually
detects, but that's a pre-existing condition...) Confirmation that the
Mediatek, OMAP and Tegra changes work will be most welcome.

Patches are based on 5.9-rc1, branch available here:

  git://linux-arm.org/linux-rm arm/dma


Robin.


Robin Murphy (18):
  ARM/dma-mapping: Drop .dma_supported for IOMMU ops
  ARM/dma-mapping: Consolidate IOMMU ops callbacks
  ARM/dma-mapping: Merge IOMMU ops
  iommu/dma: Add temporary hacks for arch/arm
  ARM/dma-mapping: Switch to iommu_dma_ops
  ARM/dma-mapping: Support IOMMU default domains
  iommu/arm-smmu: Remove arch/arm workaround
  iommu/renesas: Remove arch/arm workaround
  iommu/mediatek-v1: Add IOMMU_DOMAIN_DMA support
  iommu/msm: Add IOMMU_DOMAIN_DMA support
  iommu/omap: Add IOMMU_DOMAIN_DMA support
  iommu/tegra-gart: Add IOMMU_DOMAIN_DMA support
  iommu/tegra: Add IOMMU_DOMAIN_DMA support
  drm/exynos: Consolidate IOMMU mapping code
  drm/nouveau/tegra: Clean up IOMMU workaround
  staging/media/tegra-vde: Clean up IOMMU workaround
  media/omap3isp: Clean up IOMMU workaround
  ARM/dma-mapping: Remove legacy dma-iommu API

 arch/arm/Kconfig                              |   28 +-
 arch/arm/common/dmabounce.c                   |    1 -
 arch/arm/include/asm/device.h                 |    9 -
 arch/arm/include/asm/dma-iommu.h              |   37 -
 arch/arm/mm/dma-mapping.c                     | 1198 +----------------
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c |    5 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c    |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c       |   61 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h       |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c      |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c      |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c       |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   |    5 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c    |    6 +-
 drivers/gpu/drm/exynos/exynos_mixer.c         |    7 +-
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   13 -
 drivers/iommu/Kconfig                         |    8 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |   10 -
 drivers/iommu/ipmmu-vmsa.c                    |   69 -
 drivers/iommu/msm_iommu.c                     |    7 +-
 drivers/iommu/mtk_iommu.h                     |    2 -
 drivers/iommu/mtk_iommu_v1.c                  |  153 +--
 drivers/iommu/omap-iommu.c                    |   22 +-
 drivers/iommu/tegra-gart.c                    |   17 +-
 drivers/iommu/tegra-smmu.c                    |   37 +-
 drivers/media/platform/Kconfig                |    1 -
 drivers/media/platform/omap3isp/isp.c         |   68 +-
 drivers/media/platform/omap3isp/isp.h         |    3 -
 drivers/staging/media/tegra-vde/iommu.c       |   12 -
 30 files changed, 150 insertions(+), 1660 deletions(-)
 delete mode 100644 arch/arm/include/asm/dma-iommu.h

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
