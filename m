Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE371E4A4
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869348; cv=none; b=CgMdnu/BzxYl0NVMv6ngUmEq1HDJ/jyq+A0E9AHgCiqdlbTNCI61O0szYR9M16JYq21OLVS0AQR1thvOyohUbIqHngPc7o0qqHgwxYAtSowOEBuiHNdRu2dDN5YTDU1V2VxD3wop4/kGumAe4+2M7pa0+5fAc+z99sYTRgINdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869348; c=relaxed/simple;
	bh=9H1vP8ZryUBfI1vWiB2jX7vO7FnFh4cP3rcT6DRiL6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u34OZOcaMMSk995tsmcREiInQ/jxJ035YVDOTJmlg97h/p1tU8Cjy6XM3IeeZsXOAZNKLEYQwb/evQyCs42VV+LdCuNtj0/o0nJ00KrbR/4xJ7tahIuZoosrs2cUbnf7OwMrysus6RpMOuSPMq04igV3JlvQ1jAlxDxFPykDzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZesW7e0d; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZesW7e0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869346; x=1773405346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9H1vP8ZryUBfI1vWiB2jX7vO7FnFh4cP3rcT6DRiL6Q=;
  b=ZesW7e0dcsWqsD5+uW48SPP498kJddPOa6JSwT86+DoHMgN4mW+0kjQs
   zgMBcdAgVUFHyCkNYLGoi2MmiYbwUvC8Iy33C4cF3PZxGzwl8hsKO5UDs
   FJxBHsMuCl+cazzU17UMb3RDiV6XweBJacSS+Ks6zm9yd4Nt05B6pbOV1
   9RkblaCJf7Sm8oX1uHVsV1+XxR4Zc/bD8Hjb24+DFywAK8vzCCS8BIVDh
   xCZklpgWFe97PEnfP6hcgm3I+Y2QXRF2KYG42WxpQUEaGySAlQrPnLuV2
   dlHJarsAgAVz0z7UzghOfaP1TiSZoGAQ+LXXHci6SkybYgHz9jG8/DZW/
   Q==;
X-CSE-ConnectionGUID: aRrtG/1YTiqQWgVQ3AYHyQ==
X-CSE-MsgGUID: GsFqof94T+6MsprZ+qpPlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863927"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863927"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:34 -0700
X-CSE-ConnectionGUID: 8FsAMOKJSNaENHto8qS38g==
X-CSE-MsgGUID: moBsKVP7QXqfA3pbrZe+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005480"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:34 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 00/21] iommufd support pasid attach/replace
Date: Thu, 13 Mar 2025 05:35:11 -0700
Message-Id: <20250313123532.103522-1-yi.l.liu@intel.com>
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

This series builds on previous series [1]. It begins by adding a missing
IOMMU API to replace the domain for a PASID. Utilizing the IOMMU PASID
attach/replace/detach APIs, this series introduces iommufd APIs for device
drivers to attach, replace, or detach PASIDs to/from hwpts at the request
of userspace. It also enforces PASID compatibility with domain requirements,
allocates PASID-compatible hwpts in iommufd, and includes self-tests to
validate the iommufd APIs.

The complete code is available at the following link [2]. Please note that
the existing iommufd self-test was broken, and a temporary fix patch is at
the top of the branch [2]. If you wish to run the iommufd self-test, please
apply that fix. We apologize for any inconvenience.

The series is based on Jason's for-next branch plus one more patch [3].

https://web.git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-next&id=a05df03a88bc1088be8e9d958f208d6484691e43

[1] https://lore.kernel.org/linux-iommu/20250226011849.5102-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
[3] https://lore.kernel.org/linux-iommu/20250306034842.5950-1-yi.l.liu@intel.com/

Change log:

v9:
 - Drop patch 01 of v8 (Nic)
 - Add patch 01 and 02 to support reusing iommufd_attach_handle
 - Pass @pasid to iommufd_hwpt_paging_alloc() instead of passing IOMMU_NO_PASID
   when calling iommufd_hw_pagetable_attach()
 - Consolidate the RID and PASID path. The RID and PASID path shares almost all
   the path from driver facing API to the place invoking underlying iommu driver
   callback. (Jason)
   *) Add patch 06, 07, 08, 09, 10 and 11 to use iommufd_attach_handle track
      attached hwpt and devices of a group.
   *) Patch 11 adds pasid_attach array to track iommufd_attach_handles used in
      the RID path and PASID path.
   *) Extend the existing attach/detach/replace API to support a pasid parameter
      to support PASID.
 - Rename "PATCH v8 05/12] iommufd: Mark PASID-compatible domain" to be
   "[PATCH v9 13/21] iommufd: Enforce PASID-compatible domain in PASID path"
   as this patch now adds pasid_compat flag and its check followed by Jason's
   remark.
 - Add description that the user that wants to use PASID should first attach
   its RID path to pasid-compatible domain.
 - Add back patch 11 0f v7 as it not included in any other series now
 - Drop the mixed_replace tests of v8 as it is not considered to be iommufd
   selftest
 - Add r-b tags got in v8. For the patches that have minor changes, I kept the
   r-b tags with a "v8 - v9" change log in individual patches. For the patches
   that have non-trivial change, I dropped the r-b tags to get more attention
   from reviewers.

v8: https://lore.kernel.org/linux-iommu/20250226114032.4591-1-yi.l.liu@intel.com/
 - Rebase on top of the dependency patch series
 - Check both handle and domain in the iommu_replace_device_pasid_handle()
   to support replace between domain and handle.
 - Fix a typo in patch 02 of v7 (Kevin)
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

Yi Liu (21):
  iommu: Clear handle->domain in detach
  iommu: Wrap pasid_array entry creation and setting
  iommu: Introduce a replace API for device pasid
  iommufd: Pass @pasid through the device attach/replace path
  iommufd/device: Only add reserved_iova in non-pasid path
  iommufd/device: Replace idev->igroup with local variable
  iommufd/device: Check !igroup->hwpt in
    iommufd_device_attach_reserved_iova()
  iommufd/device: Lift iommufd_attach_handle handling to upper level
    helpers
  iommufd/device: Use iommufd_attach_handle track attachment
  iommufd/device: Replace device_list with device_array
  iommufd/device: Move attached device tracking to handle
  iommufd/device: Add pasid_attach array to track per-PASID attach
  iommufd: Enforce PASID-compatible domain in PASID path
  iommufd: Support pasid attach/replace
  iommufd: Enforce PASID-compatible domain for RID
  iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
  iommufd: Allow allocating PASID-compatible domain
  iommufd/selftest: Add set_dev_pasid in mock iommu
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add test ops to test pasid attach/detach
  iommufd/selftest: Add coverage for iommufd pasid attach/detach

 drivers/iommu/intel/iommu.c                   |   3 +-
 drivers/iommu/intel/nested.c                  |   2 +-
 drivers/iommu/iommu-priv.h                    |   4 +
 drivers/iommu/iommu.c                         | 153 +++++++-
 drivers/iommu/iommufd/device.c                | 364 ++++++++++++------
 drivers/iommu/iommufd/hw_pagetable.c          |  23 +-
 drivers/iommu/iommufd/iommufd_private.h       |  14 +-
 drivers/iommu/iommufd/iommufd_test.h          |  32 ++
 drivers/iommu/iommufd/selftest.c              | 228 ++++++++++-
 drivers/vfio/iommufd.c                        |  10 +-
 include/linux/iommufd.h                       |   9 +-
 include/uapi/linux/iommufd.h                  |   3 +
 tools/testing/selftests/iommu/iommufd.c       | 344 +++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  41 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 102 +++++
 15 files changed, 1136 insertions(+), 196 deletions(-)

-- 
2.34.1

