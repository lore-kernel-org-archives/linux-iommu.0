Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB3C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 16:58:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B1922CEA
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 16:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yYmkbmLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B1922CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C319FDB6;
	Mon, 19 Aug 2019 16:58:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C98A5DB1
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 16:58:38 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6AE5589B
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 16:58:38 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4065F22CE9;
	Mon, 19 Aug 2019 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566233918;
	bh=mg0gLjBJ0WIunBTl79cLKXwCZCkpdcfCd712xJ5p4GI=;
	h=Date:From:To:Cc:Subject:From;
	b=yYmkbmLC8KxsMPsZ7lMV6Yoz9OAK5ijlevtbKZB8ZQyqJm2YqSk4+GFFHJBS73Rvh
	w+t6atCdjcCZd1Q00C2uzW/OXxWtVyhUXBSXcuVXjYcC2HimTQggpPBbRn23UDbL+R
	vyYX5FAA8Ze/a4qf29LWEHkO+21IZed7DH9tyJws=
Date: Mon, 19 Aug 2019 17:58:34 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/core: Batched unmap support for 5.4
Message-ID: <20190819165833.je2wqqemvfky42ps@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

Please pull this series to enable batched unmap support in the IOMMU
core API. Later patches will enable this for Arm SMMUv3, and I suspect
other IOMMU hardware can also benefit from the changes.

The rough idea is to track the current range being unmapped on the stack
of the caller, so that the actual unmap operation in the IOMMU hardware
can be deferred. This deferral allows for optimisations such as batch
submission to the hardware, range invalidation or coalescing of the
operations depending on the hardware capabilities. Crucially, it can
reduce cacheline contention via locks or atomics in the driver code,
which are traditionally exercised on every unmap call to the driver.

Given that this reworks the IOMMU API, the diff is a little messy so
please can you queue this as part of your core changes and let me know
when you have a stable branch? That way, I can use it to resolve any
conflicts with subsequent Arm SMMU driver changes.

If you run into any trouble, please let me know and I'll see what I can
do to help.

Thanks,

Will

--->8

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/batched-unmap

for you to fetch changes up to 3951c41af4a65ba418e6b1b973d398552bedb84f:

  iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->tlb_add_page() (2019-07-29 17:22:59 +0100)

----------------------------------------------------------------
Will Deacon (13):
      iommu: Remove empty iommu_tlb_range_add() callback from iommu_ops
      iommu/io-pgtable-arm: Remove redundant call to io_pgtable_tlb_sync()
      iommu/io-pgtable: Rename iommu_gather_ops to iommu_flush_ops
      iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes
      iommu: Introduce iommu_iotlb_gather_add_page()
      iommu: Pass struct iommu_iotlb_gather to ->unmap() and ->iotlb_sync()
      iommu/io-pgtable: Introduce tlb_flush_walk() and tlb_flush_leaf()
      iommu/io-pgtable: Hook up ->tlb_flush_walk() and ->tlb_flush_leaf() in drivers
      iommu/io-pgtable-arm: Call ->tlb_flush_walk() and ->tlb_flush_leaf()
      iommu/io-pgtable: Replace ->tlb_add_flush() with ->tlb_add_page()
      iommu/io-pgtable: Remove unused ->tlb_sync() callback
      iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->unmap()
      iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->tlb_add_page()

 drivers/gpu/drm/panfrost/panfrost_mmu.c |  24 +++++---
 drivers/iommu/amd_iommu.c               |  11 ++--
 drivers/iommu/arm-smmu-v3.c             |  52 +++++++++++-----
 drivers/iommu/arm-smmu.c                | 103 ++++++++++++++++++++++++--------
 drivers/iommu/dma-iommu.c               |   9 ++-
 drivers/iommu/exynos-iommu.c            |   3 +-
 drivers/iommu/intel-iommu.c             |   3 +-
 drivers/iommu/io-pgtable-arm-v7s.c      |  57 +++++++++---------
 drivers/iommu/io-pgtable-arm.c          |  48 ++++++++-------
 drivers/iommu/iommu.c                   |  24 ++++----
 drivers/iommu/ipmmu-vmsa.c              |  28 +++++----
 drivers/iommu/msm_iommu.c               |  42 +++++++++----
 drivers/iommu/mtk_iommu.c               |  45 +++++++++++---
 drivers/iommu/mtk_iommu_v1.c            |   3 +-
 drivers/iommu/omap-iommu.c              |   2 +-
 drivers/iommu/qcom_iommu.c              |  44 +++++++++++---
 drivers/iommu/rockchip-iommu.c          |   2 +-
 drivers/iommu/s390-iommu.c              |   3 +-
 drivers/iommu/tegra-gart.c              |  12 +++-
 drivers/iommu/tegra-smmu.c              |   2 +-
 drivers/iommu/virtio-iommu.c            |   5 +-
 drivers/vfio/vfio_iommu_type1.c         |  27 +++++----
 include/linux/io-pgtable.h              |  57 ++++++++++++------
 include/linux/iommu.h                   |  92 +++++++++++++++++++++-------
 24 files changed, 483 insertions(+), 215 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
