Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B657C432BE
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A490A60200
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 17:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A490A60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63BB1608E4;
	Wed,  4 Aug 2021 17:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZgQWquT7aFx; Wed,  4 Aug 2021 17:16:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 264966069C;
	Wed,  4 Aug 2021 17:16:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D330CC0010;
	Wed,  4 Aug 2021 17:16:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67DDEC000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 501DA6069C
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e9XogPoQnFlt for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:16:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC99C605A3
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 17:16:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDA831B;
 Wed,  4 Aug 2021 10:16:03 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 017C73F66F;
 Wed,  4 Aug 2021 10:16:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v3 00/25] iommu: Refactor DMA domain strictness
Date: Wed,  4 Aug 2021 18:15:28 +0100
Message-Id: <cover.1628094600.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 dianders@chromium.org, Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org, rajatja@google.com,
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

v1: https://lore.kernel.org/linux-iommu/cover.1626888444.git.robin.murphy@arm.com/
v2: https://lore.kernel.org/linux-iommu/cover.1627468308.git.robin.murphy@arm.com/

Hi all,

Round 3, and the patch count has crept up yet again. But the overall
diffstat is even more negative, so that's good, right? :)

Once again, to driver/platform maintainers CC'd on cookie cleanup
patches this is just a heads-up and the rest of the changes should not
affect your platforms. I hope I've now fixed the silly bug which broke
bisection between patches #1 and #12 on 32-bit Arm.

The new patches are in the middle, reworking how the SMMU drivers and
io-pgtable implement non-strict mode such that the later changes fall
into place even more easily. Turns out I didn't need the major
refactoring of io-pgtable that I had in mind, and I'm almost kicking
myself that as soon as I put the option of *not* using the existing
quirk on the table, an even cleaner and more logical solution was
staring right out at me.

Due to that signifcant change and the consequent redesign of the final
patch to make dynamic switching look viable in the face of concurrency,
I have not applied the tested-by tags from v2. They were very much
appreciated though, thanks!

Proper changelogs on the individual patches this time since otherwise
I'd have lost track...

Cheers,
Robin.


CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Yong Wu <yong.wu@mediatek.com>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Robin Murphy (25):
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
  iommu: Indicate queued flushes via gather data
  iommu/io-pgtable: Remove non-strict quirk
  iommu: Introduce explicit type for non-strict DMA domains
  iommu/amd: Prepare for multiple DMA domain types
  iommu/arm-smmu: Prepare for multiple DMA domain types
  iommu/vt-d: Prepare for multiple DMA domain types
  iommu: Express DMA strictness via the domain type
  iommu: Expose DMA domain strictness via sysfs
  iommu: Only log strictness for DMA domains
  iommu: Merge strictness and domain type configs
  iommu/dma: Factor out flush queue init
  iommu: Allow enabling non-strict mode dynamically

 .../ABI/testing/sysfs-kernel-iommu_groups     |  6 +-
 .../admin-guide/kernel-parameters.txt         |  8 +-
 drivers/iommu/Kconfig                         | 80 +++++++++----------
 drivers/iommu/amd/iommu.c                     | 22 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 11 +--
 rivers/iommu/arm/arm-smmu/arm-smmu.c         | 19 ++---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  9 ---
 drivers/iommu/dma-iommu.c                     | 63 +++++++++------
 drivers/iommu/exynos-iommu.c                  | 19 +----
 drivers/iommu/intel/iommu.c                   | 23 ++----
 drivers/iommu/io-pgtable-arm-v7s.c            | 12 +--
 drivers/iommu/io-pgtable-arm.c                | 12 +--
 drivers/iommu/iommu.c                         | 55 ++++++++-----
 drivers/iommu/iova.c                          | 12 ++-
 drivers/iommu/ipmmu-vmsa.c                    | 28 +------
 drivers/iommu/mtk_iommu.c                     |  7 --
 drivers/iommu/mtk_iommu_v1.c                  |  1 -
 drivers/iommu/rockchip-iommu.c                | 12 +--
 drivers/iommu/sprd-iommu.c                    |  7 --
 drivers/iommu/sun50i-iommu.c                  | 13 +--
 drivers/iommu/virtio-iommu.c                  |  8 --
 include/linux/dma-iommu.h                     |  9 ++-
 include/linux/io-pgtable.h                    |  5 --
 include/linux/iommu.h                         | 23 +++++-
 24 files changed, 187 insertions(+), 277 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
