Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30A1CDFAC
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649952; cv=none; b=WLN+RqIDPrZ54aXN2RhZxoRAJUw/WkSmSk2Ju3Bp2oVJK33GiRWAw9dVCrot/qUxg9pcutqOCcN4HCDwBlelgNxNSuHvb9WOIXqMd3H1N/If4ZVpma26/CFNNY8n2fHwsLGH2SMeEBG9EeBmqpYBsEQ94pZPXAtzfpV67KINgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649952; c=relaxed/simple;
	bh=vuELy65mSEkFSS4Pp5QKW+t12TCjfp+XHGnzUf51AS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iF+EEpmb1TvUGsh0leUZFMsaNm6KeaL77q9fxcgakgsiUXJLuS999YIQB/lFR0JyF/4e3dxHSgm3/3xOwH2RXQMH6a9A8aTe5QMDICP55cG40BvKR7Q9NFrnJ9UT32WIrYcZN/OiYfH8RL32R1OR0UszYEN6ZsqxTszrglhcpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZMG/3UG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZMG/3UG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649951; x=1784185951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vuELy65mSEkFSS4Pp5QKW+t12TCjfp+XHGnzUf51AS0=;
  b=VZMG/3UGqB1jUwylTgp8moEEXXbDMl9BlUfsv7a+K9u6LY2kxrWbDqz9
   bfH3sNa4re3Hifc6DD9hqnkLc1EbuaN69lChVVPJxJGsnqX9bOQa1SnYZ
   UY+CoKgwxgohHUyYYX4l4m1Lt4BfIaVPux/kcHYUCbdhEFKVmB9KRyqtY
   oqBVqwlk7PjgYskgNmdohnXWq1GzbzUJ5gp3sOyrdruDFdpD47FF2yiDr
   +Twm9JgtsOouk3Q/8AY5VNuqMrLoDNCA0dwUUGtwa/QHBxrsIQGU7akbJ
   nQaPBiKnirWCotFhP8GFUp9MBLtQ0CSt+aoV0rK0+741SPahFst+dTXZU
   A==;
X-CSE-ConnectionGUID: ARXNwqWiQkaoPx7w4k+b4Q==
X-CSE-MsgGUID: 9Y40NGDuT2O42yCFrFfFzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540773"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540773"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:30 -0700
X-CSE-ConnectionGUID: lD+C8upLR9OwSnrALXTfDw==
X-CSE-MsgGUID: dUtpagpnQcC7iAjyx6ZZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453617"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:26 -0700
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
Subject: [PATCH v6 0/8] iommufd: Destroy vdevice on device unbind
Date: Wed, 16 Jul 2025 15:03:41 +0800
Message-Id: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
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
v6:
 - Fix compile error for ARM platform in Patch 5
 - Adjust some more line wrappings in Patch 6
 - Add review tags.

v5: https://lore.kernel.org/linux-iommu/aHdFWV9k9M7tRpD0@yilunxu-OptiPlex-7050/
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

 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |   3 +-
 drivers/iommu/iommufd/device.c                |  51 +++
 drivers/iommu/iommufd/driver.c                |  10 +-
 drivers/iommu/iommufd/iommufd_private.h       |  49 ++-
 drivers/iommu/iommufd/main.c                  |  69 +++-
 drivers/iommu/iommufd/viommu.c                |  69 +++-
 include/linux/iommufd.h                       |  17 +-
 include/uapi/linux/iommufd.h                  |   5 +
 tools/testing/selftests/iommu/iommufd.c       | 377 +++++++++---------
 9 files changed, 419 insertions(+), 231 deletions(-)

-- 
2.25.1

