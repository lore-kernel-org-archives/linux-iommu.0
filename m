Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BB627
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916206; x=1707452206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xI4jwcAkfh2lcTA8rQSFT0GKdDkIDlByxF+6Yr7jRrA=;
  b=R7n0rwasejq4mdpxA5r2WLaLOnW3EOKoDRHcBPNz8IAx7bb9RthnGf+c
   p9bTbopbqdZdcZAY8ZcshRwEDYP68VtpbqLjKS+KcGBECMy1PMCIxQbIo
   lGS/XRgDAgNqJurEtT5Hbuq6PPys6/unugElf+20jK7Zb5UUWf9aB6S1i
   j2tnz985dOpBAAgiQUVIIdCfuF5G2p0l5BSMB0aTZVSCj1X16xsntSbqB
   GechTpoIV/BUtfs3UO5oFG2ZIjMKkbo643qWSGvWKnMRqeAPQn3cgvuLD
   GkTtbOl0uZ1YOHJFeQD/lYIDT6GDVC/iXkiMG9BQ5+phB2TUYW9yaRbmJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600691"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600691"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982071"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982071"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:44 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com
Subject: [PATCH 0/6] iommufd: Add iommu capability reporting
Date: Wed,  8 Feb 2023 20:16:36 -0800
Message-Id: <20230209041642.9346-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd gives userspace the capabilty to manipulating iommu subsytem.
e.g. DMA map/unmap etc. In the near future, it will also support iommu
nested translation. Different platform vendors have different implementation
for the nested translation. So before set up nested translation, userspace
needs to know the hardware iommu capabilities. For example, Intel platform
supports guest I/O page table to be the first stage translation structure.

This series reports the iommu capability for a given iommufd_device which
has been bound to iommufd. It is a preparation work for nested translation
support[1]. In this series, Intel VT-d capability reporting is added. Other
vendors may add their own reporting based on this series.

[1] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting_vtd_v1

Regards,
	Yi Liu

Lu Baolu (2):
  iommu: Add new iommu op to get iommu hardware information
  iommu/vt-d: Implement hw_info for iommu capability query

Nicolin Chen (2):
  iommufd/selftest: Set iommu_device for mock_device
  iommufd/selftest: Add coverage for IOMMU_DEVICE_GET_INFO ioctl

Yi Liu (2):
  iommufd: Add IOMMU_DEVICE_GET_INFO
  iommufd/device: Add mock_device support in iommufd_device_get_info()

 drivers/iommu/intel/iommu.c                   | 19 ++++
 drivers/iommu/intel/iommu.h                   |  1 +
 drivers/iommu/iommufd/device.c                | 91 +++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |  2 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 +++
 drivers/iommu/iommufd/main.c                  |  3 +
 drivers/iommu/iommufd/selftest.c              | 26 ++++++
 include/linux/iommu.h                         |  8 ++
 include/uapi/linux/iommufd.h                  | 63 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 18 +++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 ++++++
 11 files changed, 271 insertions(+), 1 deletion(-)

-- 
2.34.1

