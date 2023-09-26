Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9E134BC
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 09:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720911; x=1727256911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TNdNMjdyY903iNYTtJMXeD069ihbZWkt8cAbuDlkz7w=;
  b=l600VaGs0bYG7uRwCOeS+5SZXxSIvH5dSnsQsnVeQIAryMmxgh+TI+vG
   42ojxsrPAP2tc0KD30Rt6IPmdC13bzEMPJEu/9dK/u7u65dDTtN7Xu829
   a5TbQV6PdnVub3hkgwQC6rJNFi82SBon8pyMNH4c7EvJZ6fPm1AX0etN1
   4GqcE75qyFy0n6WSrAB1/a2PJsblQKQAyQA10rO7pEbKvn7L0ZNvSyDCr
   ITH4kUJH1ajfnK8pFRD9xTyve8WXNP8gFJHCGTWamR2qeSvuH/LPLLnk+
   zKbM5svZH/ae3RlxvSLIWZ93IC7OJN/Ul8ZNeH9lQhz5ntF3S88fzSdB7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412442878"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412442878"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725372986"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="725372986"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 02:31:22 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: joro@8bytes.org,
	cohuck@redhat.com,
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [RFC 0/3] vfio-pci support pasid attach/detach
Date: Tue, 26 Sep 2023 02:31:18 -0700
Message-Id: <20230926093121.18676-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the pasid attach/detach uAPIs for userspace to attach/detach
a PASID of a device to/from a given ioas/hwpt. Only vfio-pci driver is
enabled in this series. After this series, PASID-capable devices bound
with vfio-pci can report PASID capability to userspace and VM to enable
PASID usages like Shared Virtual Addressing (SVA).

This series first adds the helpers for pasid attach in vfio core and then
add the device cdev ioctls for pasid attach/detach, finally exposes the
device PASID capability to user. It depends on iommufd pasid attach/detach
series [1].

Complete code can be found at [2]

[1] https://lore.kernel.org/linux-iommu/20230926092651.17041-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid

Regards,
	Yi Liu

Kevin Tian (1):
  vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices

Yi Liu (2):
  vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
  vfio/pci: Expose PCIe PASID capability to userspace

 drivers/vfio/device_cdev.c         | 45 ++++++++++++++++++++++++
 drivers/vfio/iommufd.c             | 48 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c        |  2 ++
 drivers/vfio/pci/vfio_pci_config.c |  2 +-
 drivers/vfio/vfio.h                |  4 +++
 drivers/vfio/vfio_main.c           |  8 +++++
 include/linux/vfio.h               | 11 ++++++
 include/uapi/linux/vfio.h          | 55 ++++++++++++++++++++++++++++++
 8 files changed, 174 insertions(+), 1 deletion(-)

-- 
2.34.1

