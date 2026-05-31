Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B581C3BFC
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220531; cv=none; b=qwPoRPCfRtQntFt1WsCgwroIUWQb2xP49SGyN5ZSy7Z3lcetWWXibVJYCtd9KsShXz2dvGorkftlxy95YMyBSLs6TvJFnybhzqShZcjFTTlB6w/c9K6mZ9TVToaOFCd9zFE32K/zG4C/Xe1C6GdfTQHU2nqVqPrhL07QMH9kbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220531; c=relaxed/simple;
	bh=cCpRD+G8jfA6PnzomRET50E1ZAbq/sQLvY4vRI4nWRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcoXZUpy3v9WEX8ouXi47VPQSK/lPhnP0MxqGEzRl4eYuCY4wr1qduVhLRKyI4PbQs/GqdY0k8C6VdOq5QJw0lJ+wR7oDheR9kbML5QHr8K6NV+sGxq8O8O9c2tDmVFsuYaY2FJCWCzfNWKcAdjCetMfeeuc6oQIdVmMvtqVvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W04GgP4T; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W04GgP4T"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780220526; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wXubRgIQov6KKC0DBoFpb8dlsukOt/+vAZvDFHs1O38=;
	b=W04GgP4TW9yQfr47hNiP1PZurZx5qSSM2COdFdwjp/xavkku96KHliTOINFe8WNC8N+AIxC07Qa+gKyK4XngTxFc82+0eDTasnU5kXMBxhU6gQJZ8BaN4CS3b2pFjRtnM3Zq6R5fJsOD78B8M6FohkoVyozIzZqZJkk38Rx3Tas=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3tRVlc_1780220197;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X3tRVlc_1780220197 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 31 May 2026 17:36:46 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	adrian.larumbe@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	liviu.dudau@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	alex@shazbot.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: [PATCH 0/9] iommu: introduce iova_to_phys_length for efficient IOVA-to-physical translation
Date: Sun, 31 May 2026 17:36:28 +0800
Message-ID: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260529115116.GR2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new iova_to_phys_length() interface across the
IOMMU subsystem that returns both the physical address and the PTE mapping
page size in a single page-table walk.

Motivation:

The existing iova_to_phys() only returns a physical address without any
information about the page size of the underlying PTE mapping. Callers
like VFIO and iommufd that need to traverse IOVA ranges are forced to
walk one PAGE_SIZE step at a time, even when the IOMMU has mapped large
regions using 2MB or 1GB huge pages. This results in O(n) page-table
walks where O(1) would suffice per mapping entry.

Approach:

The new callback .iova_to_phys_length returns the physical address and
sets *mapped_length to the PTE page size (e.g. 4KB, 2MB, 1GB). This
allows callers to skip ahead by the actual mapping granularity.

The migration follows an add-migrate-remove pattern to ensure every
commit in this series compiles independently (bisectable):

  1. Add the new interface with fallback to legacy iova_to_phys
  2. Migrate all IOMMU drivers (io-pgtable, generic_pt, per-SoC)
  3. Migrate callers (VFIO, iommufd, DRM)
  4. Remove the deprecated iova_to_phys from ops structs

Performance impact:

For VFIO unmap of a 2MB region mapped with 2MB pages, this reduces
page-table walks from 512 (PAGE_SIZE steps) to 1 (one per 2MB PTE),
a ~512x improvement in that path.

Guanghui Feng (9):
  iommu: introduce iova_to_phys_length in iommu_domain_ops
  iommu/io-pgtable: introduce iova_to_phys_length in io_pgtable_ops
  iommu/generic_pt: implement iova_to_phys_length
  iommu/arm-smmu: implement iova_to_phys_length
  iommu: apple-dart/ipmmu/mtk_iommu implement iova_to_phys_length
  iommu: direct page-table drivers implement iova_to_phys_length
  vfio/iommufd: use iova_to_phys_length for efficient unmap
  drm/gpu, iommu/io-pgtable: switch to iova_to_phys_length
  iommu: remove deprecated iova_to_phys from domain_ops and
    io_pgtable_ops

 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  2 +-
 drivers/iommu/apple-dart.c                    | 11 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 13 ++--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 11 +--
 drivers/iommu/exynos-iommu.c                  | 21 ++++--
 drivers/iommu/fsl_pamu_domain.c               | 26 ++++++-
 drivers/iommu/generic_pt/iommu_pt.h           | 49 ++++++++-----
 drivers/iommu/io-pgtable-arm-selftests.c      | 12 ++--
 drivers/iommu/io-pgtable-arm-v7s.c            | 25 ++++---
 drivers/iommu/io-pgtable-arm.c                | 14 ++--
 drivers/iommu/io-pgtable-dart.c               | 17 +++--
 drivers/iommu/iommu.c                         | 30 +++++++-
 drivers/iommu/iommufd/pages.c                 | 71 +++++++++++++++----
 drivers/iommu/iommufd/selftest.c              |  2 +-
 drivers/iommu/ipmmu-vmsa.c                    | 12 ++--
 drivers/iommu/msm_iommu.c                     | 25 +++++--
 drivers/iommu/mtk_iommu.c                     | 12 ++--
 drivers/iommu/mtk_iommu_v1.c                  | 15 +++-
 drivers/iommu/omap-iommu.c                    | 32 ++++++---
 drivers/iommu/rockchip-iommu.c                | 11 ++-
 drivers/iommu/s390-iommu.c                    | 15 ++--
 drivers/iommu/sprd-iommu.c                    | 13 +++-
 drivers/iommu/sun50i-iommu.c                  | 13 +++-
 drivers/iommu/tegra-smmu.c                    | 12 +++-
 drivers/iommu/virtio-iommu.c                  | 13 +++-
 drivers/vfio/vfio_iommu_type1.c               | 24 +++++--
 include/linux/generic_pt/iommu.h              | 13 ++--
 include/linux/io-pgtable.h                    | 10 ++-
 include/linux/iommu.h                         | 12 +++-
 32 files changed, 404 insertions(+), 146 deletions(-)

-- 
2.43.7

