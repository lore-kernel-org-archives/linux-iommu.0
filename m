Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5E17BD9
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614871; cv=none; b=DoUn429b2layT3ekZ94/zURGmuM49oRtSDRzj6dXHoo/4OAp5uqX0476GqYyEcYZaPkqYfi2u/5bjkhum10/PLfJA66zdke13OsuttxCa+e0XgtC4dGVad9jcXOpiMC5UJkMLiNk4megYCS0OydKK7b4D+X4NXOr/7Bj/xxNThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614871; c=relaxed/simple;
	bh=qi6Hl4CgNp5EG4CeBBeBx3gL3/YfIubhFx8kLB/C65E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2EpSbGh1qolt5PylcU7y0scVs6GHw6oydJ203zp4xStrJuA3qD+LlvQENhuGQmUDqjLPxaZZ+1YlKYcGsdQJJqchlzTVIgCi7HiQ1Cw23/NybdTVp5QernTUHPNwQaEoV1fVl8u6T2JnTgp0mVKV02OedHzlYN6t6gxo/xsi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObbklIF6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObbklIF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614869; x=1766150869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qi6Hl4CgNp5EG4CeBBeBx3gL3/YfIubhFx8kLB/C65E=;
  b=ObbklIF6nP8JZ5CWAhFRnXBfHeuxQ9wzmRz2CqSTVY7VqZFEri1v/JmN
   TijXzRO2L4DFraTdB1g/fwjl6y7K33WAMi9LHiruB62jNqQSKOWoS6mvB
   v5q+qVepgULKkpoW2AR8HAewzqn/VDgnt+OWFbeHeJy1qIcfnbSPe7nZ/
   dXxXzqS9JSGD+xYW8w/6bRSs5B1+7S+dUUoWCeBYcEDY8FLS2AMFVAU69
   hFr3ymd/eR8hG2MgVRL2WfZtYtkMLioO/0NuD1uoBAHX7gnM/VmwbmWul
   4H5104yuJ78tUzvw3Yy7Ai+H2rh+CCjqKuHa0BeqYn4X7KssgJB+z5A9w
   g==;
X-CSE-ConnectionGUID: 4VPIFl5fRRO1I7DYZPDEzA==
X-CSE-MsgGUID: hKz9FzutT1aIobzuiAY5Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542239"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542239"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:48 -0800
X-CSE-ConnectionGUID: qzywsK6aRBmd387OOm+J5g==
X-CSE-MsgGUID: EbAyAJSyQd6ryWxCxuLI0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177294"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:47 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 00/14] iommufd support pasid attach/replace
Date: Thu, 19 Dec 2024 05:27:32 -0800
Message-Id: <20241219132746.16193-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PASID (Process Address Space ID) is a PCIe extension to tag the DMA
transactions out of a physical device, and most modern IOMMU hardware
have supported PASID granular address translation. So a PASID-capable
device can be attached to multiple hwpts (a.k.a. domains), and each
attachment is tagged with a pasid.

This series is based on the preparation series [1] [2], it first adds a
missing iommu API to replace the domain for a pasid. Based on the iommu
pasid attach/ replace/detach APIs, this series adds iommufd APIs for device
drivers to attach/replace/detach pasid to/from hwpt per userspace's request,
add PASID compat domain enforcement, add PASID compat hwpt allocation in
iommufd, and adds selftest to validate the iommufd APIs.

The completed code can be found in the below link [3]. Heads up! The existing
iommufd selftest was broken, there was a temp fix patch in the top of the
branch [3]. If want to run the iommufd selftest, please apply that fix. Sorry
for the inconvenience.

[1] https://lore.kernel.org/linux-iommu/20241104131842.13303-1-yi.l.liu@intel.com/ # done
[2] https://lore.kernel.org/linux-iommu/20241204122928.11987-1-yi.l.liu@intel.com/ # done
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid

Change log:

v6:
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

Yi Liu (14):
  iommu: Introduce a replace API for device pasid
  iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of
    iommu_replace_group_handle()
  iommufd: Move the iommufd_handle helpers to device.c
  iommufd: Always pass iommu_attach_handle to iommu core
  iommufd: Pass pasid through the device attach/replace path
  iommufd: Mark PASID-compatible domain
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
 drivers/iommu/iommu.c                         |  90 ++++-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                | 123 +++++--
 drivers/iommu/iommufd/fault.c                 |  88 +----
 drivers/iommu/iommufd/hw_pagetable.c          |  15 +-
 drivers/iommu/iommufd/iommufd_private.h       |  95 ++++-
 drivers/iommu/iommufd/iommufd_test.h          |  31 ++
 drivers/iommu/iommufd/pasid.c                 | 173 +++++++++
 drivers/iommu/iommufd/selftest.c              | 231 +++++++++++-
 include/linux/iommufd.h                       |   7 +
 tools/testing/selftests/iommu/iommufd.c       | 348 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  39 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 102 +++++
 16 files changed, 1216 insertions(+), 136 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

-- 
2.34.1

