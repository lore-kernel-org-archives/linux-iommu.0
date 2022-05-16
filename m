Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0BC433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 02:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5277840232;
	Mon, 16 May 2022 02:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQ0X4guSh45C; Mon, 16 May 2022 02:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2221240492;
	Mon, 16 May 2022 02:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC922C0032;
	Mon, 16 May 2022 02:01:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27CA8C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F15C409A1
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 80NEDRKFIhp2 for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0480D4099F
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652666474; x=1684202474;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qa54zhyfxnhTnC4Kw0P1pvvl+nghPS35LumwnwyE9CY=;
 b=lNBEmAaXHzrPsC3mmO40UUHEKZ5SBBBFPT/GXqdJf9FGKCDXA+oP9yGy
 WrR6ZxKqypdKgPZaPUzqwnS2yxOJtHtHtA1u+1eh9QvQQzmGuGFkhTWTP
 O1LQjjYHWMegEaq9FFRvmTKTPFWuOoejzd5lElexfrUiCbxbKG7ItdpJb
 7AqdP6u3KGvTgZiQAsSHbq8tMGiqjBMCO6waLpU1vfPqEmlYx3OBQNuwr
 ZcQVqZfH0NAsIVzBFZ3z4z3lBzCEj78aXbXair8VyCt7bfh7GCS18qHKB
 9Xhgo/MVBDKw8vifQeCxhr44uy18aHY5/1bNafgx0RUy6dM1tGrq8OLXi w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270829224"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="270829224"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2022 19:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="713172146"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 0/5] iommu: Make blocking domain static for group
Date: Mon, 16 May 2022 09:57:54 +0800
Message-Id: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Hi folks,

This is a follow-up series after several discussions on blocking domain.
The latest discussion could be found here.

https://lore.kernel.org/linux-iommu/20220510140238.GD49344@nvidia.com/

This makes blocking domain static by:

- Each IOMMU driver is required to report domain ops for the blocking
  domain in its iommu_ops. Some IOMMU drivers support detaching domain
  by clearing an entry in the device context, while others not. To
  distinguish this capability among the IOMMU drivers, a flag is added
  to the domain ops.

- Similar to the default domain, each iommu group also has a static
  blokcing domain. The blocking domain is allocated when the first
  device joins the group and freed after the last device leaves.

- As .detach_dev equals to either setting the default domain or blocking
  domain to the device, this callback is not needed anymore. It is
  removed in this series.

Please kindly review and suggest. Very appreciated.

Best regards,
baolu 

Lu Baolu (5):
  iommu: Rename attach_dev to set_dev in domain ops
  iommu: Add blocking_domain_ops field in iommu_ops
  iommu: Make blocking domain static for iommu group
  iommu: Use blocking domain for empty domain attaching
  iommu: Remove .detach_dev from iommu domain ops

 include/linux/iommu.h                       |  13 ++-
 include/trace/events/iommu.h                |   7 --
 drivers/iommu/amd/iommu.c                   |  15 ++-
 drivers/iommu/apple-dart.c                  |  15 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  15 ++-
 drivers/iommu/exynos-iommu.c                |  15 ++-
 drivers/iommu/fsl_pamu_domain.c             |  15 ++-
 drivers/iommu/intel/iommu.c                 |  15 ++-
 drivers/iommu/iommu-traces.c                |   1 -
 drivers/iommu/iommu.c                       | 122 ++++++++++----------
 drivers/iommu/ipmmu-vmsa.c                  |  15 ++-
 drivers/iommu/msm_iommu.c                   |  15 ++-
 drivers/iommu/mtk_iommu.c                   |  15 ++-
 drivers/iommu/mtk_iommu_v1.c                |  15 ++-
 drivers/iommu/omap-iommu.c                  |  15 ++-
 drivers/iommu/rockchip-iommu.c              |  15 ++-
 drivers/iommu/s390-iommu.c                  |  15 ++-
 drivers/iommu/sprd-iommu.c                  |  14 ++-
 drivers/iommu/sun50i-iommu.c                |  15 ++-
 drivers/iommu/tegra-gart.c                  |  15 ++-
 drivers/iommu/tegra-smmu.c                  |  15 ++-
 drivers/iommu/virtio-iommu.c                |   5 +-
 24 files changed, 299 insertions(+), 113 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
