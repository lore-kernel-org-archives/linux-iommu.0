Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD418623
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885332; x=1727421332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wn3wXR37JoGGgItNRNp+OOoXXPlkBH9261CwXM5sCbI=;
  b=ghLshLQFp3ZIrb1P3oa12v0F3kttXa8hmnkcmbw/EY9ZOLEDuI2XTES6
   qt1u/TNt04b7ELfWAe6ddixmPstmd4qE0JCXIxWiE+YnpxxaNy2NQh3hd
   V9COZ3CshbvpVjJpaiKGovfHS3Di8JYnRv3P5+WIOyWYk6YN7lqwkXLJc
   XFfpJrbVzaNBcro/6LDXO5rz/T7AhjAhA5BOOtIOrHAgqgep9vMbqUdFh
   FgI5SdCJd8vtL6mNCX7pDQ8GhSW6shjYEQpSYqnd76dYA3rQHMryzjW9J
   zPXVjQidw9zIC4QiX5oYVqiSzVNUTWV8IcUGL5wtlIrUCCMj4/yUrX3cG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914817"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914817"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784601954"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784601954"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:30 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v2 0/6] iommufd support allocating nested parent domain
Date: Thu, 28 Sep 2023 00:15:22 -0700
Message-Id: <20230928071528.26258-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU hardwares that support nested translation would have two stages
address translation (normally mentioned as stage-1 and stage-2). The page
table formats of the stage-1 and stage-2 can be different. e.g., VT-d has
different page table formats for stage-1 and stage-2.

Nested parent domain is the iommu domain used to represent the stage-2
translation. In IOMMUFD, both stage-1 and stage-2 translation are tracked
as HWPT (a.k.a. iommu domain). Stage-2 HWPT is parent of stage-1 HWPT as
stage-1 cannot work alone in nested translation. In the cases of stage-1 and
stage-2 page table format are different, the parent HWPT should use exactly
the stage-2 page table format. However, the existing kernel hides the format
selection in iommu drivers, so the domain allocated via IOMMU_HWPT_ALLOC can
use either stage-1 page table format or stage-2 page table format, there is
no guarantees for it.

To enforce the page table format of the nested parent domain, this series
introduces a new iommu op (domain_alloc_user) which can accept user flags
to allocate domain as userspace requires. It also converts IOMMUFD to use
the new domain_alloc_user op for domain allocation if supported, then extends
the IOMMU_HWPT_ALLOC ioctl to pass down a NEST_PARENT flag to allocate a HWPT
which can be used as parent. This series implements the new op in Intel iommu
driver to have a complete picture. It is a preparation for adding nesting
support in IOMMUFD/IOMMU.

Complete code can be found:
https://github.com/yiliu1765/iommufd/tree/iommufd_alloc_user_v2

Change log:

v2:
 - Require domain_alloc_user op if IOMMU_HWPT_ALLOC passes non-zero flags (Kevin)
 - IOMMUFD core should check kernel known flags while iommu driver needs
   to check supported flags as well (Jason)
 - Minor tweaks per Baolu's comment

v1: https://lore.kernel.org/linux-iommu/20230919092523.39286-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (6):
  iommu: Add new iommu op to create domains owned by userspace
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd/hw_pagetable: Accepts user flags for domain allocation
  iommufd/hw_pagetable: Support allocating nested parent domain
  iommufd/selftest: Add domain_alloc_user() support in iommu mock
  iommu/vt-d: Add domain_alloc_user op

 drivers/iommu/intel/iommu.c                   | 28 +++++++++++++++++
 drivers/iommu/iommufd/device.c                |  2 +-
 drivers/iommu/iommufd/hw_pagetable.c          | 31 ++++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h       |  3 +-
 drivers/iommu/iommufd/selftest.c              | 19 ++++++++++++
 include/linux/iommu.h                         | 11 ++++++-
 include/uapi/linux/iommufd.h                  | 12 ++++++-
 tools/testing/selftests/iommu/iommufd.c       | 24 +++++++++++---
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 11 +++++--
 10 files changed, 124 insertions(+), 19 deletions(-)

-- 
2.34.1

