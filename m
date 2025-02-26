Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D6215050
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570037; cv=none; b=NFlWi2bbvN55KB9/cyYMHG7BUrzgtg5DBKJs4610DeUvrwoBXq+oeZkCu+1wRIsAa2iZcrPgkCzZ79u1Y2e+gsPDBJmMHbDVBH27//t8RT8kWwrx53lG+XS/U/UnEackg/xD0PBkraKOuyNcxE+m7jGNZL8a/gFShzZkSGAmpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570037; c=relaxed/simple;
	bh=n4AqpTTORWeYv/AXnsauUf5eDQuFzongVKro8HhUcy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKSnOhAFht4pWFkikbmjyP6p+8OzDF5xOnqgWa1YxVhllmEu3xD2Bcng28SGFY9X6fzd/XoKSOMwZboTCOqpzzwhn176f1mNf7UUSZ6dDOWGO3vnA5Dy3ff7tZqQD8VdsyZoKpjVr0hIp7CSXGmNCFdTNPCx29IYamoAydDs+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/Zh/3uU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/Zh/3uU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570036; x=1772106036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n4AqpTTORWeYv/AXnsauUf5eDQuFzongVKro8HhUcy8=;
  b=g/Zh/3uUbFSsn3uo4nt8mO80ekENLQBemzxXnZG6BlclEiPXiQYeXn4+
   /tK+X30lWO94V72prWT/Heh4IPUiMDfC1ewOdtZ9RNWFMqnPnD1FjdyOL
   RjBoOP+JSXS54Loiy1Xw7e3LQfFR8w2cEil0EbqNFkUKjDA3XYiDpqX25
   ybCJuN2/OEqhwsg/gwK7otLXrtbGKNj7gm4VH7UP0LEm09lxDs9DJ355l
   8cvT+p/JTRDN3VJAUoblMiP2xnBHpsJ7lQTM2vk8G3Sqv2Vv1ehQKbeZ1
   qqlVywJz02364u7Z42KxjCmrL78F/1R1UWxT1O9Fh7nUnWeYpQVuMqrq6
   g==;
X-CSE-ConnectionGUID: ua7R8CPOSDe4gyPFsqTxsg==
X-CSE-MsgGUID: NZ9Q8SzkTAygwr/vHGPwww==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827076"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827076"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:34 -0800
X-CSE-ConnectionGUID: /DLs4nc+QFuC0Agg51fFaw==
X-CSE-MsgGUID: YraHlBIeRxSBG4s0gF9ESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171571"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:34 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 00/12] iommufd support pasid attach/replace
Date: Wed, 26 Feb 2025 03:40:20 -0800
Message-Id: <20250226114032.4591-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PASID (Process Address Space ID) is a PCIe extension that tags the DMA
transactions from a physical device. Most modern IOMMU hardware supports
PASID-granular address translation. This allows a PASID-capable device
to be attached to multiple hardware page tables (hwpts, also known as
domains), with each attachment tagged by a PASID.

This series builds on previous series [1] [2]. It begins by adding a missing
IOMMU API to replace the domain for a PASID. Utilizing the IOMMU PASID
attach/replace/detach APIs, this series introduces iommufd APIs for device
drivers to attach, replace, or detach PASIDs to/from hwpts at the request
of userspace. It also enforces PASID compatibility with domain requirements,
allocates PASID-compatible hwpts in iommufd, and includes self-tests to
validate the iommufd APIs.

The complete code is available at the following link [3]. Please note that
the existing iommufd self-test was broken, and a temporary fix patch is at
the top of the branch [3]. If you wish to run the iommufd self-test, please
apply that fix. We apologize for any inconvenience.

[1] https://lore.kernel.org/linux-iommu/20250226011849.5102-1-yi.l.liu@intel.com/
[2] https://lore.kernel.org/linux-iommu/20250226050130.5814-1-yi.l.liu@intel.com/
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid

Change log:

v8:
 - Rebase on top of the dependency patch series
 - Check both handle and domain in the iommu_replace_device_pasid_handle()
   to support replace between domain and handle.
 - Fix a typo in patch 02 of v7 (Kevin)
 - Dropped patch 11 0f v7 as it is included in a series to add iommufd
   selftest to cover replace between domain and handle.
 - r-b tag on patch 01 of v7 (Kevin)
 - Add selftest for replace between handle and non-handle case

v7: https://lore.kernel.org/linux-iommu/20250216035228.23831-1-yi.l.liu@intel.com/
 - Remove the iommu_attach_handle related refactors, as they have been addressed
   by Nic's series.
 - Address the comments on patch 01 of v6 in a separate series [1]. Store either
   the domain or handle in group->pasid_array, and swap the order of setting
   group->pasid_array and invoking the attach operation of IOMMU drivers.
 - Introduce iommu_attach_device_pasid_handle() and iommu_replace_device_pasid_handle(),
   and remove iommu_replace_device_pasid() since iommufd consistently uses the
   _handle() API.
 - Add patch 04 to include reserved_iova only for the RID path, as the underlying
   helpers are shared by both the RID and PASID paths, but only the RID path needs
   to add reserved_iova.
 - Remove the iommu_dev.max_pasids check in patch 11 of v6. The mock IOMMU always
   supports 20-bit PASIDs, so there is no need to verify PASID support in the mock
   IOMMU driver. Additionally, the IOMMU_HWPT_ALLOC_PASID flag does not imply PASID
   support, so it should be removed to avoid misleading IOMMU driver programming.

v6: https://lore.kernel.org/linux-iommu/20241219132746.16193-1-yi.l.liu@intel.com/
 - Add kdoc to iommufd_device_get_attach_handle() to note the returned handle
   should be used with care. (Baolu)
 - Reworked the patch 07 and 08 of v5 to avoid domain allocation failure on VT-d
   after applying patch 07 of v5.
     1) Split out the intel iommu driver IOMMU_HWPT_ALLOC_PASID support out of
	patch 08
     2) Rework the PASID-compatible domain enforcement by checking the RID domain
	and idev->pasid_hwpts under the idev->igroup->lock.
 - iommufd_device_pasid_do_attach() returns -EINVAL if there is old hwpt and it's
   not the same with new hwpt. This aligns with how the iommufd_device_do_attach()
   deals it. Otherwise, attaching the same pasid to the same ioas is going to fail
   before the auto_domain loop goes to the correct hwpt. Thsi is not reasonable. So
   make this change.
 - Enhanced the pasid selftest to have non-pasid-capable device and pasid-capable
   device.
 - The order of the series is tweaked to be prepare the iommufd for pasid attach,
   add pasid attach, add PASID-compat domain enforcement and then add the PASID-compat
   hwpt allocation.
 - Rebased on top of 6.13-rc3 and some already applied patches.

v5: https://lore.kernel.org/linux-iommu/20241104132513.15890-1-yi.l.liu@intel.com/
 - Fix a mistake in patch 02 of v4 (Kevin)
 - Move the iommufd_handle helpers to device.c
 - Add IOMMU_HWPT_ALLOC_PASID check to enforce pasid-compatible domain for pasid
   capable device in iommufd
 - Update the iommufd selftest to use IOMMU_HWPT_ALLOC_PASID

v4: https://lore.kernel.org/linux-iommu/20240912131255.13305-1-yi.l.liu@intel.com/
 - Replace remove_dev_pasid() by supporting set_dev_pasid() for blocking domain (Kevin)
	- This is done by the preparation series "Support attaching PASID to the blocked_domain"
 - Misc tweaks to foil the merging of the iommufd iopf series. Three new patches are added:
	- iommufd: Always pass iommu_attach_handle to iommu core
	- iommufd: Move the iommufd_handle helpers to iommufd_private.h
	- iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of iommu_replace_group_handle()
 - Renmae patch 03 of v3 to be "iommufd: Support pasid attach/replace"
 - Add test case for attaching/replacing iopf-capable hwpt to pasid

v3: https://lore.kernel.org/kvm/20240628090557.50898-1-yi.l.liu@intel.com/
 - Split the set_dev_pasid op enhancements for domain replacement to be a
   separate series "Make set_dev_pasid op supportting domain replacement" [1].
   The below changes are made in the separate series.
   *) set_dev_pasid() callback should keep the old config if failed to attach to
      a domain. This simplifies the caller a lot as caller does not need to attach
      it back to old domain explicitly. This also avoids some corner cases in which
      the core may do duplicated domain attachment as described in below link (Jason)
      https://lore.kernel.org/linux-iommu/BN9PR11MB52768C98314A95AFCD2FA6478C0F2@BN9PR11MB5276.namprd11.prod.outlook.com/
   *) Drop patch 10 of v2 as it's a bug fix and can be submitted separately (Kevin)
   *) Rebase on top of Baolu's domain_alloc_paging refactor series (Jason)
 - Drop the attach_data which includes attach_fn and pasid, insteadly passing the
   pasid through the device attach path. (Jason)
 - Add a pasid-num-bits property to mock dev to make pasid selftest work (Kevin)

v2: https://lore.kernel.org/linux-iommu/20240412081516.31168-1-yi.l.liu@intel.com/
 - Domain replace for pasid should be handled in set_dev_pasid() callbacks
   instead of remove_dev_pasid and call set_dev_pasid afteward in iommu
   layer (Jason)
 - Make xarray operations more self-contained in iommufd pasid attach/replace/detach
   (Jason)
 - Tweak the dev_iommu_get_max_pasids() to allow iommu driver to populate the
   max_pasids. This makes the iommufd selftest simpler to meet the max_pasids
   check in iommu_attach_device_pasid()  (Jason)

v1: https://lore.kernel.org/kvm/20231127063428.127436-1-yi.l.liu@intel.com/#r
 - Implemnet iommu_replace_device_pasid() to fall back to the original domain
   if this replacement failed (Kevin)
 - Add check in do_attach() to check corressponding attach_fn per the pasid value.

rfc: https://lore.kernel.org/linux-iommu/20230926092651.17041-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (12):
  iommu: Add iommu_attach_device_pasid_handle()
  iommu: Introduce a replace API for device pasid
  iommufd: Pass @pasid through the device attach/replace path
  iommufd/device: Only add reserved_iova in non-pasid path
  iommufd: Mark PASID-compatible domain
  iommufd: Support pasid attach/replace
  iommufd: Enforce PASID-compatible domain for RID
  iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
  iommufd: Allow allocating PASID-compatible domain
  iommufd/selftest: Add set_dev_pasid in mock iommu
  iommufd/selftest: Add test ops to test pasid attach/detach
  iommufd/selftest: Add coverage for iommufd pasid attach/detach

 drivers/dma/idxd/init.c                       |   2 +-
 drivers/iommu/intel/iommu.c                   |   3 +-
 drivers/iommu/intel/nested.c                  |   2 +-
 drivers/iommu/iommu-priv.h                    |   4 +
 drivers/iommu/iommu-sva.c                     |  10 +-
 drivers/iommu/iommu.c                         | 121 +++++-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                | 139 ++++---
 drivers/iommu/iommufd/hw_pagetable.c          |  15 +-
 drivers/iommu/iommufd/iommufd_private.h       |  32 +-
 drivers/iommu/iommufd/iommufd_test.h          |  37 ++
 drivers/iommu/iommufd/pasid.c                 | 155 ++++++++
 drivers/iommu/iommufd/selftest.c              | 238 +++++++++++-
 include/linux/iommu.h                         |  34 +-
 include/linux/iommufd.h                       |   7 +
 tools/testing/selftests/iommu/iommufd.c       | 350 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  46 ++-
 tools/testing/selftests/iommu/iommufd_utils.h | 123 ++++++
 18 files changed, 1230 insertions(+), 89 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

-- 
2.34.1

