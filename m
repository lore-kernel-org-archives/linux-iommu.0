Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE53B6BEC
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499930; cv=none; b=RVeVlaDPv0+dkfINg/SbrvGfYbZpnWf9NmlenRD0HozEfi5vkJZqm7WWPrgvddg3k7apCs2VwsQ1Ftw69rW8qRQvVrT6BLuH1F1zh7d1+DcFWL05ABaItCvyPKxRyf+LV54ZGLOyi1WJV8p3ZUZv7arOPqnXrymQ1q9nit3zWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499930; c=relaxed/simple;
	bh=qc9ObS28Yc0NyJr/nfSr3lxR6/9iY1F17KorOe0lDqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWt1gjIdizKQZJcst/aKvDvWYRXidg9cTSoOzBgAjt1x3CYEBKHbrd3FHBufE3l3ZT2cSwbfObYglKmYYNNiq0pEpbYi7BYgPW+MyAKVrjO0uDBitkG9unobA7XorK2GBr4em6uNorxziWoSocMb6+Y6zgvDNMrarDcayFbr+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JZRveM7Q; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JZRveM7Q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499920; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RvkO+y14NMb6z4vGqoWJi7g9KwkBNoDEzCeK4sEpHZA=;
	b=JZRveM7QKnT02hEPxicYS8XqUakRmmFA5bXhFeCJ3xFvG2qQUUO7guKOg3LWlBISIyfUHcjr2JvOBnvwZqM6SYsuj5LSH650aGfzdpEA/MzVKXLR0NFxgq1nRvHtaofNR8KVT6zZT2JF2X+UcdDKoc4fmqeZgVHb+wg+vBdMQ7w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fQu8_1780499884;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fQu8_1780499884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:38 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Subject: [PATCH v3 00/32] iommu: introduce iova_to_phys_length and remove iova_to_phys
Date: Wed,  3 Jun 2026 23:17:32 +0800
Message-ID: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new iova_to_phys_length() interface to the IOMMU
subsystem, migrates all drivers and callers to it, and finally removes the
legacy iova_to_phys() interface.

Motivation
==========

The existing iommu_iova_to_phys() returns only the physical address for a
given IOVA. Callers that need to walk a range of IOVA space (most notably
VFIO and IOMMUFD during unmap) have no way to learn the size of the mapping
backing an IOVA, so they are forced to iterate in fixed PAGE_SIZE steps.
When the underlying mapping uses large pages (e.g. 2MB or 1GB), this results
in a separate page table walk for every 4KB, which is highly inefficient for
large regions.

iommu_iova_to_phys_length() returns both the physical address and the page
size of the PTE backing the IOVA in a single page table walk. Callers can
then advance by the actual mapping granularity instead of PAGE_SIZE,
dramatically reducing the number of page table walks during teardown of
large mappings.

The new helper translates a missing mapping to PHYS_ADDR_MAX (rather than 0)
so that a zero physical address can be distinguished from a translation
failure, and the legacy iommu_iova_to_phys() is reimplemented on top of it.

Approach
========

The series is structured to keep the tree bisectable at every step: the new
interface is added first with a fallback to the legacy callback, every
driver and caller is migrated, and only then is the old interface removed.

  - Core and page table layer (patches 1-5):
    Add iova_to_phys_length to iommu_domain_ops and io_pgtable_ops, the
    core iommu_iova_to_phys_length() helper with a fallback to the legacy
    iova_to_phys, and implement it in the io-pgtable arm, arm-v7s and dart
    formats as well as the generic_pt framework.

  - Driver migration (patches 6-22):
    Implement iova_to_phys_length in all remaining IOMMU drivers:
    arm-smmu-v3, arm-smmu, qcom_iommu, apple-dart, ipmmu-vmsa, mtk_iommu,
    exynos, fsl_pamu, msm, mtk_v1, omap, rockchip, s390, sprd, sun50i,
    tegra-smmu and virtio.

  - Caller migration (patches 23-28):
    Switch VFIO and IOMMUFD to iova_to_phys_length for efficient,
    granularity-aware unmap, update the iommufd selftest, migrate the
    DRM panfrost and panthor drivers, and switch the io-pgtable selftests
    to the new interface.

  - Removal (patches 29-32):
    Drop the now-unused iova_to_phys wrappers from the io-pgtable arm,
    arm-v7s and dart formats, and finally remove iova_to_phys from
    iommu_domain_ops and io_pgtable_ops.

No functional change is intended for translation results; the change is
purely about exposing mapping size and using it to make range operations
more efficient.

Guanghui Feng (32):
  iommu: introduce iova_to_phys_length in iommu_domain_ops
  iommu/io-pgtable-arm: introduce iova_to_phys_length in io_pgtable_ops
  iommu/io-pgtable-arm-v7s: introduce iova_to_phys_length in
    io_pgtable_ops
  iommu/io-pgtable-dart: introduce iova_to_phys_length in io_pgtable_ops
  iommu/generic_pt: implement iova_to_phys_length
  iommu/arm-smmu-v3: implement iova_to_phys_length
  iommu/arm-smmu: implement iova_to_phys_length
  iommu/qcom_iommu: implement iova_to_phys_length
  iommu/apple-dart: implement iova_to_phys_length
  iommu/ipmmu-vmsa: implement iova_to_phys_length
  iommu/mtk_iommu: implement iova_to_phys_length
  iommu/exynos: implement iova_to_phys_length
  iommu/fsl_pamu: implement iova_to_phys_length
  iommu/msm: implement iova_to_phys_length
  iommu/mtk_v1: implement iova_to_phys_length
  iommu/omap: implement iova_to_phys_length
  iommu/rockchip: implement iova_to_phys_length
  iommu/s390: implement iova_to_phys_length
  iommu/sprd: implement iova_to_phys_length
  iommu/sun50i: implement iova_to_phys_length
  iommu/tegra-smmu: implement iova_to_phys_length
  iommu/virtio: implement iova_to_phys_length
  vfio: use iova_to_phys_length for efficient unmap
  iommufd: use iova_to_phys_length for efficient unmap
  iommufd/selftest: switch to iommu_iova_to_phys_length
  drm/panfrost: switch to iova_to_phys_length
  drm/panthor: switch to iova_to_phys_length
  iommu/io-pgtable: selftests switch to iova_to_phys_length
  iommu/io-pgtable-arm: remove deprecated iova_to_phys wrapper
  iommu/io-pgtable-arm-v7s: remove deprecated iova_to_phys wrapper
  iommu/io-pgtable-dart: remove deprecated iova_to_phys wrapper
  iommu: remove iova_to_phys from domain_ops and io_pgtable_ops

 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  2 +-
 drivers/iommu/apple-dart.c                    | 11 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 13 +--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 11 +--
 drivers/iommu/exynos-iommu.c                  | 20 +++--
 drivers/iommu/fsl_pamu_domain.c               | 26 +++++-
 drivers/iommu/generic_pt/iommu_pt.h           | 84 ++++++++++++++-----
 drivers/iommu/io-pgtable-arm-selftests.c      | 12 +--
 drivers/iommu/io-pgtable-arm-v7s.c            | 25 +++---
 drivers/iommu/io-pgtable-arm.c                | 16 ++--
 drivers/iommu/io-pgtable-dart.c               | 21 +++--
 drivers/iommu/iommu.c                         | 38 +++++++--
 drivers/iommu/iommufd/pages.c                 | 74 +++++++++++++---
 drivers/iommu/iommufd/selftest.c              |  2 +-
 drivers/iommu/ipmmu-vmsa.c                    | 10 ++-
 drivers/iommu/msm_iommu.c                     | 21 +++--
 drivers/iommu/mtk_iommu.c                     | 11 ++-
 drivers/iommu/mtk_iommu_v1.c                  | 13 ++-
 drivers/iommu/omap-iommu.c                    | 29 ++++---
 drivers/iommu/rockchip-iommu.c                | 10 ++-
 drivers/iommu/s390-iommu.c                    | 18 ++--
 drivers/iommu/sprd-iommu.c                    | 17 ++--
 drivers/iommu/sun50i-iommu.c                  | 14 ++--
 drivers/iommu/tegra-smmu.c                    | 11 ++-
 drivers/iommu/virtio-iommu.c                  | 12 ++-
 drivers/vfio/vfio_iommu_type1.c               | 27 ++++--
 include/linux/generic_pt/iommu.h              | 13 +--
 include/linux/io-pgtable.h                    | 11 ++-
 include/linux/iommu.h                         | 12 ++-
 32 files changed, 423 insertions(+), 175 deletions(-)

-- 
2.43.7

