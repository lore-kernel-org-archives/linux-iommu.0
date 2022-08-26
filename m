Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B623A5
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661517345; x=1693053345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nR3gxr2N4uNie5DvjwJIj1xPMYgHUtoK1ifCTVOf+bw=;
  b=A7ip8/Rm/04nQHdvrL1rT5J4spCtZsyn/XrP7SztVn7PGVHD2SFZqhHI
   nFmQVBKlFuKaB6Z99Cv+DngXr5Ioct1qg3tj5+73J0VjFDgb8CUii6Ct/
   hnw4Yat+qqyEHBDLl2Y+sAx4Ge9v4EAjzdZAxCyp1V3z5bV4i16WSWjwD
   CHElWwhbggtZqTtpKnzcfcTkijRBmxdI3mjMvpY7RSyGg/1b+pb2LaXCl
   UqjPfCjVxSDdcwqdCNKzkj/WNuDUwlrZhVshccJsCX7rwAujPcEOmU5ma
   O68gW+XuVDXMC/615IWV/QWPndsmP9Cz9K6+/bTtvJim2ncCN52sP7v23
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="292074510"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292074510"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606751935"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:35:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc: Eric Auger <eric.auger@redhat.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/3] iommu: Retire detach_dev callback
Date: Fri, 26 Aug 2022 20:30:11 +0800
Message-Id: <20220826123014.52709-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This is a follow-up series after several discussions on blocking domain.
The latest discussion could be found here.

https://lore.kernel.org/linux-iommu/20220510140238.GD49344@nvidia.com/

As .detach_dev equals to setting the blocking domain to the device, this
callback is not needed anymore. This replace .detach_dev callback in the
IOMMU drivers with a static blocking domain and retires this callback.

With .detach_dev retired, rename .attach_dev to .set_dev as it actually
means setting an iommu domain to the device.

This series depends on below series which includes blocking domain
support for VT-d and SMMUv3 drivers.
[1] https://lore.kernel.org/linux-iommu/20220826121141.50743-1-baolu.lu@linux.intel.com/

This series is available on github:
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-blocking_domain-v2

Please review and suggest.

Best regards,
baolu

Change log:
v2:
 - Replace .detach_dev callback with static block domain ops;
 - Rename .attach_dev to .set_dev.

v1:
 - https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/

Lu Baolu (3):
  iommu: Replace detach_dev with real blocking domains
  iommu: Retire detach_dev domain ops
  iommu: Rename attach_dev to set_dev

 include/linux/iommu.h                       |  6 ++--
 drivers/iommu/amd/iommu.c                   | 24 ++++++++++++--
 drivers/iommu/apple-dart.c                  | 26 ++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 25 +++++++++++++--
 drivers/iommu/exynos-iommu.c                | 25 +++++++++++++--
 drivers/iommu/fsl_pamu_domain.c             | 24 ++++++++++++--
 drivers/iommu/intel/iommu.c                 |  4 +--
 drivers/iommu/iommu.c                       | 35 ++++-----------------
 drivers/iommu/ipmmu-vmsa.c                  | 24 ++++++++++++--
 drivers/iommu/msm_iommu.c                   | 25 +++++++++++++--
 drivers/iommu/mtk_iommu.c                   | 24 ++++++++++++--
 drivers/iommu/mtk_iommu_v1.c                | 24 ++++++++++++--
 drivers/iommu/omap-iommu.c                  | 22 +++++++++++--
 drivers/iommu/rockchip-iommu.c              | 22 +++++++++++--
 drivers/iommu/s390-iommu.c                  | 27 ++++++++++++++--
 drivers/iommu/sprd-iommu.c                  | 25 +++++++++++++--
 drivers/iommu/sun50i-iommu.c                | 25 +++++++++++++--
 drivers/iommu/tegra-gart.c                  | 22 +++++++++++--
 drivers/iommu/tegra-smmu.c                  | 25 +++++++++++++--
 drivers/iommu/virtio-iommu.c                |  2 +-
 22 files changed, 368 insertions(+), 74 deletions(-)

-- 
2.25.1

