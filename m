Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424C1A0BF1
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147054; cv=none; b=lxvUR9Vg6/r1SIUfd1W2OUxhvPKN//if2oXHUjQ+Y54D/yVn2CdHzFfkmAFHlxl1EiwfpmbBQXF+pHbyPNFKffDlB/cKwkVBKKzp48XK2LsD7RI80sJytnS0GohN6XFcN0pjE1DALP/6dWTc3FeTfpNXLQ90qOrmiwuT+LrLu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147054; c=relaxed/simple;
	bh=tTnRmX+6RHq0ncXVXSOVD+Hvk28tzNe+cSrBE1j1oiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TiYRzqf9FeRNrDpD9433kx8Vhbnq9eDLBKJOnDhQf7akiuyfVUBgpKKNFjKba2tcQp7bLYbP7SjaWXvbcg0UCEUP077aO/efP/cAoa777Qskwl/pewyhe14FNQvZVX73iAtP4Gob6kleakuOEtUTmXI/Jfg60uSI1ZBhZrzfaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBMPtK+m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBMPtK+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147052; x=1757683052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tTnRmX+6RHq0ncXVXSOVD+Hvk28tzNe+cSrBE1j1oiE=;
  b=EBMPtK+mcEJYO6lqtsrfEhTsN5sTTvjYo6Q/AbE6aUM7QdtQDrXC0S9R
   Ty80r7Nb22rUUb6KLq1zooG0V70k8XUJNrDpw37FQKObNdHQE1fxmE1rU
   WyRmkMPPjhZSmelHLnFJrCpg8esIUQ1CNx50strLmX7Hb0ukx4EKs341I
   uonFi1sRqa+ytvKpdzVBtl3RSbHFbs4k2fZCawyAbJdx63vwICn/vsq/9
   sK5EdpCXHsC7mF25WxOkwmG0uye4uMjNQ0Idu1nzFREo93cGi/f8Y5M8n
   jlpclpM/T0Oze6qdHy+jqRgtmGCIUeJD4c3gBIhICIe/Q6Zg8rvq+bYAO
   w==;
X-CSE-ConnectionGUID: xGP0W2j8R2uIMluv1Is29A==
X-CSE-MsgGUID: 8jCHn+IJQiS8qOxsdEfgJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="13493301"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13493301"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:17:31 -0700
X-CSE-ConnectionGUID: 493sDDapRD+SfvZ18Fh2JQ==
X-CSE-MsgGUID: XdQ+CjVyRTOZhEpXBfC5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72692532"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 06:17:31 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v3 0/4] vfio-pci support pasid attach/detach
Date: Thu, 12 Sep 2024 06:17:25 -0700
Message-Id: <20240912131729.14951-1-yi.l.liu@intel.com>
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

Based on the discussion about reporting the vPASID to VM [1], it's agreed
that we will let the userspace VMM to synthesize the vPASID capability.
The VMM needs to figure out a hole to put the vPASID cap. This includes
the hidden bits handling for some devices. While, it's up to the userspace,
it's not the focus of this series.

This series first adds the helpers for pasid attach in vfio core and then
adds the device cdev ioctls for pasid attach/detach. In the end of this
series, the IOMMU_GET_HW_INFO ioctl is extended to report the PCI PASID
capability to the userspace. Userspace should check this before using any
PASID related uAPIs provided by VFIO, which is the agreement in [2]. This
series depends on the iommufd pasid attach/detach series [3].

The completed code can be found at [4], tested with a hacky Qemu branch [5].

[1] https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/
[2] https://lore.kernel.org/kvm/4f2daf50-a5ad-4599-ab59-bcfc008688d8@intel.com/
[3] https://lore.kernel.org/linux-iommu/20240912131255.13305-1-yi.l.liu@intel.com/
[4] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
[5] https://github.com/yiliu1765/qemu/tree/wip/zhenzhong/iommufd_nesting_rfcv2-test-pasid

Change log:

v3:
 - Misc enhancement on patch 01 of v2 (Alex, Jason)
 - Add Jason's r-b to patch 03 of v2
 - Drop the logic that report PASID via VFIO_DEVICE_FEATURE ioctl
 - Extend IOMMU_GET_HW_INFO to report PASID support (Kevin, Jason, Alex)

v2: https://lore.kernel.org/kvm/20240412082121.33382-1-yi.l.liu@intel.com/
 - Use IDA to track if PASID is attached or not in VFIO. (Jason)
 - Fix the issue of calling pasid_at[de]tach_ioas callback unconditionally (Alex)
 - Fix the wrong data copy in vfio_df_ioctl_pasid_detach_pt() (Zhenzhong)
 - Minor tweaks in comments (Kevin)

v1: https://lore.kernel.org/kvm/20231127063909.129153-1-yi.l.liu@intel.com/
 - Report PASID capability via VFIO_DEVICE_FEATURE (Alex)

rfc: https://lore.kernel.org/linux-iommu/20230926093121.18676-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (4):
  ida: Add ida_find_first_range()
  vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices
  vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
  iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability

 drivers/iommu/iommufd/device.c | 27 +++++++++++++-
 drivers/pci/ats.c              | 32 ++++++++++++++++
 drivers/vfio/device_cdev.c     | 51 ++++++++++++++++++++++++++
 drivers/vfio/iommufd.c         | 50 +++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c    |  2 +
 drivers/vfio/vfio.h            |  4 ++
 drivers/vfio/vfio_main.c       |  8 ++++
 include/linux/idr.h            | 11 ++++++
 include/linux/pci-ats.h        |  3 ++
 include/linux/vfio.h           | 11 ++++++
 include/uapi/linux/iommufd.h   | 14 ++++++-
 include/uapi/linux/vfio.h      | 55 ++++++++++++++++++++++++++++
 lib/idr.c                      | 67 ++++++++++++++++++++++++++++++++++
 13 files changed, 333 insertions(+), 2 deletions(-)

-- 
2.34.1

