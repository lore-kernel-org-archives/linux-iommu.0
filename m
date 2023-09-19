Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D338DED
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115526; x=1726651526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P2SZV7XNPkJc7Awaa/pjBYWEEgfBie06vXhRPpUVPPM=;
  b=Mox+UEkQp5NT2HzlZ6Mc8vkAN6uzEoI8rPbBt0Bznh8kc3TA6oii75UQ
   zQ2M4wM4rQiejywPnmNNPguWI0WPsjHXRiOO11jqV5Pz9V7mzZSZuXyUL
   /7PRISqQP6w8VsvQlcKuKnzrk2g8jT9eDOceqP5hpoBb1OswBWMpH7YbH
   Eyn6IErU4KQTJZGbvA+2fnKWoMveKG+o4Ge7m4RMiqjgEd9GsD+viQRv2
   fu9p51B9dndLMONLxQcuU8AmZm6wB7BT26X4yMSzmBL/bmULgrNoMTEJ+
   YINkQZZaXo4Fww5ljwuxyxKd0d95IeGiowFm0qH1+oiMTyR/NQRzBIQve
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368818"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368818"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804612"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804612"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:24 -0700
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
Subject: [PATCH 0/6] iommufd support allocating nested parent domain
Date: Tue, 19 Sep 2023 02:25:17 -0700
Message-Id: <20230919092523.39286-1-yi.l.liu@intel.com>
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
https://github.com/yiliu1765/iommufd/tree/iommufd_alloc_user_v1

Regards,
	Yi Liu

Yi Liu (6):
  iommu: Add new iommu op to create domains owned by userspace
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd/hw_pagetable: Accepts user flags for domain allocation
  iommufd/hw_pagetable: Support allocating nested parent domain
  iommufd/selftest: Add domain_alloc_user() support in iommu mock
  iommu/vt-d: Add domain_alloc_user op

 drivers/iommu/intel/iommu.c                   | 20 ++++++++++++
 drivers/iommu/iommufd/device.c                |  2 +-
 drivers/iommu/iommufd/hw_pagetable.c          | 31 ++++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h       |  3 +-
 drivers/iommu/iommufd/selftest.c              | 16 ++++++++++
 include/linux/iommu.h                         |  8 +++++
 include/uapi/linux/iommufd.h                  | 12 ++++++-
 tools/testing/selftests/iommu/iommufd.c       | 24 +++++++++++---
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 11 +++++--
 10 files changed, 111 insertions(+), 18 deletions(-)

-- 
2.34.1

