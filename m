Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA115099D
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565561; cv=none; b=smab6O+qbGKsLno/vS/8qMXzajNxKo+K+CyJ+fNPR7qT137WHN+Zk1Tgrxie7LIHp9YiqNZkzW9HliOiWfI06U3wLx38Fnq/H+AFfp+6rsOdLpZRETt3x8CwzQQiBC8wXL/d0XQdC+OlifXaO4cWKROZ/ihncQVxbZyJcDV5B6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565561; c=relaxed/simple;
	bh=TRKYfuD2WUYVwQf8GGp61mD5fLEMIqOQUZVLgnPcros=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzDlMGTYYBatOHlpCVdpsPBq9D3dWMItJruMTCge6XududKl3h2UbJ1EimoLkscv3ieF6tnvKzM9o0yNVj8LtJe+Q4wR2MP2r2QdlEudLsDb0G7PnW4ukkc4rPynfUYf1uO0wCcCX9wTbdyWJIL2TZZFklvokBdu6+0MTKNtBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrwCsxl5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrwCsxl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565560; x=1751101560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TRKYfuD2WUYVwQf8GGp61mD5fLEMIqOQUZVLgnPcros=;
  b=RrwCsxl5TQPaF4qhnYjQf4MGZAxYPuo+z67JH0vmwuJjTLlcVu63F7Bd
   cSE+CQk9pz8zI7IEI4W6Qzk3ALLTFwKMScaAgmRHoPcgf6wsnyw1lY55F
   WXNMlo8aSI18AumvE6avi6+QYtscISMI+sZtoXkALNonuuljj4PNsYRy3
   IAT/ZGVr7GMSx1J6T2Hydeo+r+xaAl27rBZacRkJJ+OmtgLOuqe0FUvgv
   XC0lwNzAjH0lSTaWGCH6pUVlIEOjRbRlQDv9rZXIhodeC5PfhctiD6E+9
   O+MGxzhTWaM1r4aNg3eqVhB1uXYi9+hQi2Cl21iJKbDim49QtFKc+uHxA
   A==;
X-CSE-ConnectionGUID: BePvu80eQ/ex0JmjNG0JvQ==
X-CSE-MsgGUID: rnKoTnbCQOG0PtX2mKVQgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613668"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613668"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:05:59 -0700
X-CSE-ConnectionGUID: /eQzefUkTzeV3ou46PgWtw==
X-CSE-MsgGUID: GbnGfY7BTMydtxRsW/dEuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517036"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:05:59 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/7] iommufd support pasid attach/replace
Date: Fri, 28 Jun 2024 02:05:50 -0700
Message-Id: <20240628090557.50898-1-yi.l.liu@intel.com>
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
device can be attached to multiple hwpts (a.k.a. domains), each attachment
is tagged with a pasid.

This series is based on a preparation series [1], it first adds a missing
iommu API to replace domain for a pasid. Based on the iommu pasid attach/
replace/detach APIs, this series adds iommufd APIs for device drivers to
attach/replace/detach pasid to/from hwpt per userspace's request, and adds
selftest to validate the iommufd APIs.

The completed code can be found in below link [2]. Heads up! The existing
iommufd selftest was broken, there was a fix [3] to it, but not been
upstreamed yet. If want to run the iommufd selftest, please apply that fix.
Sorry for the inconvenience.

[1] https://lore.kernel.org/linux-iommu/20240628085538.47049-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
[3] https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/

Change log:

v3:
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

Yi Liu (7):
  iommu: Introduce a replace API for device pasid
  iommufd: Pass pasid through the device attach/replace path
  iommufd: Support attach/replace hwpt per pasid
  iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add test ops to test pasid attach/detach
  iommufd/selftest: Add coverage for iommufd pasid attach/detach

 drivers/iommu/iommu-priv.h                    |   3 +
 drivers/iommu/iommu.c                         |  80 ++++++-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                |  31 +--
 drivers/iommu/iommufd/iommufd_private.h       |  15 ++
 drivers/iommu/iommufd/iommufd_test.h          |  30 +++
 drivers/iommu/iommufd/pasid.c                 | 157 +++++++++++++
 drivers/iommu/iommufd/selftest.c              | 206 ++++++++++++++++-
 include/linux/iommufd.h                       |   6 +
 tools/testing/selftests/iommu/iommufd.c       | 207 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  28 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 +++++++
 12 files changed, 808 insertions(+), 34 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

-- 
2.34.1

