Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3C2746C
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995955; cv=none; b=ZgZmAcZoob1YZZGn1boKLV3uh/ZigzMIjzhVwxhV103tjoW9b/s1x6LJvmIsPLXStp9xWoatVtUzJfRO3TjFPFy12KvMc5u8ZhuYvLCsE8Lm0GohTuWZpqXvyA3/6jeCGLQksKRLu9m9OQuUihPCzektXWEhBf9dO6H0dP2symU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995955; c=relaxed/simple;
	bh=eeVeMBSN/ZNuVnGC2vNd5G2PEDWqGuN9/+4isAPmluw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdScmYRhKWOCBtaW9DB5BtvjvBlvEgEm3u0IYkLNM8XT6AOu79FmeCYMAS7hPoGTrSalFNVVDlqfLuZQlOuPGD+6oK6Qbtd5bV80sT49NuPHQ0odD+ofellRQAh+L8RDhH3Y649/rYhSwrXh6xSwsNa6EcRkXWKHMlem0PlbEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gx9hnx3U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gx9hnx3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750995954; x=1782531954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eeVeMBSN/ZNuVnGC2vNd5G2PEDWqGuN9/+4isAPmluw=;
  b=Gx9hnx3UZuRYTCKiTgGWnsULXJagCV846opJiikL3ySGylUk1yGYAGSj
   HJo794ynyA6OJjC0B67UPuFmnMFUDmHSZZ0B272E3FnoLxbM7g84AN9YG
   cakiU55jUUI3joMWL4bnUa5M1736A14S8N0gd3rOwPGR6ntfRtF1aUPRW
   WPMcvhMogWlB2bnT8jzcxmK6HYJSatHd0sQV7soumwnZYdgGK5+NxNZBF
   z/O85G/xqIJLhi/tGGCITNppl9ss1IXxNdGF51w7dg1q3RChtkNzDqKlH
   bdRWRuSmLTU7phip9qphFZHg+/4A8wu/mqa4F1X7Ks1NcK24ERXv4cDJl
   Q==;
X-CSE-ConnectionGUID: gFT+jKjgTAmWxlY4utaK9A==
X-CSE-MsgGUID: CzTIVzgQTQO3oxRWFHgtVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53454183"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53454183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 20:45:53 -0700
X-CSE-ConnectionGUID: 40NeaaZLRWazC4p/0ImNbA==
X-CSE-MsgGUID: BljgX8CIQyOSYqt0x4txAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176374825"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 20:45:50 -0700
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
Subject: [PATCH v3 0/5] iommufd: Destroy vdevice on device unbind
Date: Fri, 27 Jun 2025 11:38:04 +0800
Message-Id: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
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
v3:
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

The series is based on v6.16-rc1

Xu Yilun (5):
  iommufd: Add iommufd_object_tombstone_user() helper
  iommufd: Destroy vdevice on idevice destroy
  iommufd/vdevice: Remove struct device reference from struct vdevice
  iommufd/selftest: Explicitly skip tests for inapplicable variant
  iommufd/selftest: Add coverage for vdevice tombstone

 drivers/iommu/iommufd/device.c          |  42 +++
 drivers/iommu/iommufd/driver.c          |   4 +-
 drivers/iommu/iommufd/iommufd_private.h |  35 ++-
 drivers/iommu/iommufd/main.c            |  20 +-
 drivers/iommu/iommufd/viommu.c          |  47 ++-
 tools/testing/selftests/iommu/iommufd.c | 388 ++++++++++++------------
 6 files changed, 337 insertions(+), 199 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1

