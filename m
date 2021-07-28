Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB6C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7C460F93
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 15:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE7C460F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B24B839E6;
	Wed, 28 Jul 2021 15:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ViDvkuAmsR8; Wed, 28 Jul 2021 15:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 73B7883653;
	Wed, 28 Jul 2021 15:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30A25C001A;
	Wed, 28 Jul 2021 15:59:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 884B2C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73B2460644
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iAPK3zlb22sR for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 15:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53D04605FD
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 15:59:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EEFA1FB;
 Wed, 28 Jul 2021 08:59:03 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8AF33F70D;
 Wed, 28 Jul 2021 08:59:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
Date: Wed, 28 Jul 2021 16:58:21 +0100
Message-Id: <cover.1627468308.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 dianders@chromium.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

Here's v2 where things start to look more realistic, hence the expanded
CC list. The patches are now based on the current iommu/core branch to
take John's iommu_set_dma_strict() cleanup into account.

The series remiains in two (or possibly 3) logical parts - for people
CC'd on cookie cleanup patches, the later parts should not affect you
since your drivers don't implement non-strict mode anyway; the cleanup
is all pretty straightforward, but please do yell at me if I've managed
to let a silly mistake slip through and broken your driver.

This time I have also build-tested x86 as well as arm64 :)

Changes in v2:

- Add iommu_is_dma_domain() helper to abstract flag check (and help
  avoid silly typos like the one in v1).
- Tweak a few commit messages for spelling and (hopefully) clarity.
- Move the iommu_create_device_direct_mappings() update to patch #14
  where it should have been.
- Rewrite patch #20 as a conversion of the now-existing option.
- Clean up the ops->flush_iotlb_all check which is also made redundant
  by the new domain type
- Add patch #24, which is arguably tangential, but it was something I
  spotted during the rebase, so...

Once again, the whole lot is available on a branch here:

https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq

Thanks,
Robin.


CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Yong Wu <yong.wu@mediatek.com>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>

Robin Murphy (24):
  iommu: Pull IOVA cookie management into the core
  iommu/amd: Drop IOVA cookie management
  iommu/arm-smmu: Drop IOVA cookie management
  iommu/vt-d: Drop IOVA cookie management
  iommu/exynos: Drop IOVA cookie management
  iommu/ipmmu-vmsa: Drop IOVA cookie management
  iommu/mtk: Drop IOVA cookie management
  iommu/rockchip: Drop IOVA cookie management
  iommu/sprd: Drop IOVA cookie management
  iommu/sun50i: Drop IOVA cookie management
  iommu/virtio: Drop IOVA cookie management
  iommu/dma: Unexport IOVA cookie management
  iommu/dma: Remove redundant "!dev" checks
  iommu: Introduce explicit type for non-strict DMA domains
  iommu/amd: Prepare for multiple DMA domain types
  iommu/arm-smmu: Prepare for multiple DMA domain types
  iommu/vt-d: Prepare for multiple DMA domain types
  iommu: Express DMA strictness via the domain type
  iommu: Expose DMA domain strictness via sysfs
  iommu: Merge strictness and domain type configs
  iommu/dma: Factor out flush queue init
  iommu: Allow enabling non-strict mode dynamically
  iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
  iommu: Only log strictness for DMA domains

 .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
 drivers/iommu/Kconfig                         | 80 +++++++++----------
 drivers/iommu/amd/iommu.c                     | 21 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 29 ++++---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 --
 drivers/iommu/dma-iommu.c                     | 44 +++++-----
 drivers/iommu/exynos-iommu.c                  | 18 +----
 drivers/iommu/intel/iommu.c                   | 23 ++----
 drivers/iommu/iommu.c                         | 53 +++++++-----
 drivers/iommu/ipmmu-vmsa.c                    | 27 +------
 drivers/iommu/mtk_iommu.c                     |  6 --
 drivers/iommu/rockchip-iommu.c                | 11 +--
 drivers/iommu/sprd-iommu.c                    |  6 --
 drivers/iommu/sun50i-iommu.c                  | 12 +--
 drivers/iommu/virtio-iommu.c                  |  8 --
 include/linux/dma-iommu.h                     |  9 ++-
 include/linux/iommu.h                         | 15 +++-
 18 files changed, 171 insertions(+), 226 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
