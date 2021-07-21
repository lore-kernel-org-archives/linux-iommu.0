Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B88FC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:20:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E912D6120C
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E912D6120C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E6A2400F1;
	Wed, 21 Jul 2021 18:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TewhXoRNMfQD; Wed, 21 Jul 2021 18:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CBEA40175;
	Wed, 21 Jul 2021 18:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B419C0010;
	Wed, 21 Jul 2021 18:20:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0472EC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD804402EF
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPg4loaMsVxI for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 18:20:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CF4A402AA
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:20:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE71D6E;
 Wed, 21 Jul 2021 11:20:45 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBB8F3F694;
 Wed, 21 Jul 2021 11:20:43 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 00/23] iommu: Refactor DMA domain strictness
Date: Wed, 21 Jul 2021 19:20:11 +0100
Message-Id: <cover.1626888444.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

First off, yes, this conflicts with just about everything else
currently in-flight. Sorry about that. If it stands up to initial review
then I'll start giving some thought to how to fit everything together
(particularly John's cleanup of strictness defaults, which I'd be
inclined to fold into a v2 of this series).

Anyway, this is my take on promoting the strict vs. non-strict DMA
domain choice to distinct domain types, so that it can fit logically
into the existing sysfs and Kconfig controls. The first 13 patches are
effectively preparatory cleanup to reduce churn in the later changes,
but could be merged in their own right even if the rest is too
contentious. I ended up splitting patches #2-#11 by driver for ease of
review, since some of them are more than just trivial deletions, but
they could readily be squashed (even as far as with #1 and #12 too).

I'm slightly surprised at how straightforward it's turned out, but it
has survived some very basic smoke testing for arm-smmu using dmatest
on my Arm Juno board. Branch here for convenience:

https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq

Please let me know what you think!

Robin.


Robin Murphy (23):
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
  iommu: Allow choosing DMA strictness at build time
  iommu/dma: Factor out flush queue init
  iommu: Allow enabling non-strict mode dynamically
  iommu/arm-smmu: Allow non-strict in pgtable_quirks interface

 .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
 drivers/iommu/Kconfig                         | 48 +++++++++++++++----
 drivers/iommu/amd/iommu.c                     | 21 +-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 24 ++++++----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 ----
 drivers/iommu/dma-iommu.c                     | 44 +++++++++--------
 drivers/iommu/exynos-iommu.c                  | 18 ++-----
 drivers/iommu/intel/iommu.c                   | 23 +++------
 drivers/iommu/iommu.c                         | 44 +++++++++++------
 drivers/iommu/ipmmu-vmsa.c                    | 27 ++---------
 drivers/iommu/mtk_iommu.c                     |  6 ---
 drivers/iommu/rockchip-iommu.c                | 11 +----
 drivers/iommu/sprd-iommu.c                    |  6 ---
 drivers/iommu/sun50i-iommu.c                  | 12 +----
 drivers/iommu/virtio-iommu.c                  |  8 ----
 include/linux/dma-iommu.h                     |  9 ++--
 include/linux/iommu.h                         | 10 +++-
 18 files changed, 160 insertions(+), 186 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
