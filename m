Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850522129E
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561686; cv=none; b=P85XZE5BYHBeV1/Cw1q2myQ1pZUL6p+BDB0ItM47krgcwCP0UVPu47I3CVeQCbIg6gQThwi23Sndf3BMt3HvFYfGYFTFkIsxeiB4IHgOmqAfxSDkQq3Az4UkiRphuP5IM86GLTBWRM+tJv7steZB55NTnldwv6DvvkHmV+Rt7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561686; c=relaxed/simple;
	bh=fTV1vB6c0+m9+jAUJWGdzYVlGQUjPWrCEoX2PhR980E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huFIa45TkgeraM4XcsTmZ7WpDSzcBYDFriwIJswZCKW9u6nb9VxlAYC6P9Ct4Jxgunyab6NvinWgpYzLAMTiyXT3obpyYDzM9nGJ0TGLUMYngvXBMkjU7PPcTZDSUXvJNBREkPkFdS6l69+0pTYj0j8EUh1P0xTfEpmk78k3epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdS/EBEm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdS/EBEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561685; x=1784097685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fTV1vB6c0+m9+jAUJWGdzYVlGQUjPWrCEoX2PhR980E=;
  b=MdS/EBEm7X/c15JeSVvHJVdVPKUxuZwfSiFK+c1B333wJH2X0aWTgWV2
   f06LjGamsPXMr5QOz3Mb7jcsrGJUaoMCCDUQ0ZuiZtIQioR39Qb70laKK
   snOsWTkXgLb4OGg43cvUjSznfFNyDaQipBvOMaq7CjWuwLEjF6MVUSHHr
   eTI8scKn+5H2ioSkVa9+bv1KosROo7edLJgt5Qy5KgwPOSmcQxzOYZ+5x
   5JtmDYhNSs4FjsyiF3AKg5oL8On3lT+ZgASxJoI/VhcXtmbfGxWT8RvO2
   obKNDFZSw4QmymHghU7xinzOIM5g3ibVCJ97DAjQ4tscIY8hMG5TTZic3
   g==;
X-CSE-ConnectionGUID: ind1duanRauNuvHDpDE6TQ==
X-CSE-MsgGUID: Ggs48zKFSVORxP5SWghtlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880818"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:24 -0700
X-CSE-ConnectionGUID: eZZn1MyVSCGiQB4AkwOfQQ==
X-CSE-MsgGUID: 8X2t+FlMQzqFKvyAp8qxgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157648911"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:19 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v5 0/8] iommufd: Destroy vdevice on device unbind
Date: Tue, 15 Jul 2025 14:32:37 +0800
Message-Id: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is to solve the lifecycle issue that vdevice may outlive idevice. It
is a prerequisite for TIO, to ensure extra secure configurations (e.g.
TSM Bind/Unbind) against vdevice could be rolled back on idevice unbind,
so that VFIO could still work on the physical device without surprise.

Changelog:
v5:
 - Further rebase to iommufd for-next 601b1d0d9395
 - Keep the xa_empty() check in iommufd_fops_release(), update comments
 - Move the *idev next to *viommu for struct iommufd_vdevice
 - Update the description about IOMMUFD_CMD_VDEVICE_ALLOC for lifecycle
 - Remove Baolu's tag for patch 4 because of big changes since v3
 - Add changelog about idev->destroying
 - Adjust line wrappings for tools/testing/selftests/iommu/iommufd.c
 - Clarify that no testing for tombstoned ID repurposing.
 - Add review tags.

v4: https://lore.kernel.org/linux-iommu/20250709040234.1773573-1-yilun.xu@linux.intel.com/
 - Rebase to iommufd for-next.
 - A new patch to roll back iommufd_object_alloc_ucmd() for vdevice.
 - Fix the mistake trying to xa_destroy ictx->groups on
   iommufd_fops_release().
 - Move 'empty' flag inside destroy loop for iommufd_fops_release().
 - Refactor vdev/idev destroy syncing.
   - Drop the iommufd_vdevice_abort() reentrant idea.
   - A new patch that adds pre_destroy() op.
   - Hold short term reference during the whole vdevice's lifecycle.
   - Wait on short term reference on idev's pre_destroy().
   - Add a 'destroying' flag for idev to prevent new reference after
     pre_destroy().
 - Rephrase/fix some comments.
 - Add review tags.

v3: https://lore.kernel.org/linux-iommu/20250627033809.1730752-1-yilun.xu@linux.intel.com/
 - No bother clean each tombstone in iommufd_fops_release().
 - Drop vdev->ictx initialization fix patch.
 - Optimize control flow in iommufd_device_remove_vdev().
 - Make iommufd_vdevice_abort() reentrant.
 - Call iommufd_vdevice_abort() directly instead of waiting for it.
 - Rephrase/fix some comments.
 - A new patch to remove vdev->dev.
 - A new patch to explicitly skip existing viommu tests for no_iommu.
 - Also skip vdevice tombstone test for no_iommu.
 - Allow me to add SoB from Aneesh.

v2: https://lore.kernel.org/linux-iommu/20250623094946.1714996-1-yilun.xu@linux.intel.com/

v1/rfc: https://lore.kernel.org/linux-iommu/20250610065146.1321816-1-aneesh.kumar@kernel.org/

The series is based on iommufd for-next


Xu Yilun (8):
  iommufd/viommu: Roll back to use iommufd_object_alloc() for vdevice
  iommufd: Add iommufd_object_tombstone_user() helper
  iommufd: Add a pre_destroy() op for objects
  iommufd: Destroy vdevice on idevice destroy
  iommufd/vdevice: Remove struct device reference from struct vdevice
  iommufd/selftest: Explicitly skip tests for inapplicable variant
  iommufd/selftest: Add coverage for vdevice tombstone
  iommufd: Rename some shortterm-related identifiers

 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |   2 +-
 drivers/iommu/iommufd/device.c                |  51 +++
 drivers/iommu/iommufd/driver.c                |   4 +-
 drivers/iommu/iommufd/iommufd_private.h       |  49 ++-
 drivers/iommu/iommufd/main.c                  |  69 +++-
 drivers/iommu/iommufd/viommu.c                |  69 +++-
 include/linux/iommufd.h                       |  10 +-
 include/uapi/linux/iommufd.h                  |   5 +
 tools/testing/selftests/iommu/iommufd.c       | 379 +++++++++---------
 9 files changed, 407 insertions(+), 231 deletions(-)


base-commit: 601b1d0d9395c711383452bd0d47037afbbb4bcf
-- 
2.25.1

