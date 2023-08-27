Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6E810
	for <iommu@lists.linux.dev>; Sun, 27 Aug 2023 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693125860; x=1724661860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A99f/vSmttkQu1rgN3cJfgNjbHrZ49f9siOvVvM4wJ0=;
  b=TugMZG3VEbuYAtqCu/VAX0g/NNlqRJA0DrZ2U1xATN906yiwem7W/o3U
   fU7Z6wjYHv5/6FCGyiJI0cP76hEbQo2ohlbhxIAQSL1QaxuXcOsmafh7r
   geZ1MafPLw2O4/3MzqlUsnDOQ2kBjj+ncs9Aus7LIWjFWIKeSVS3s2nyG
   9o3iwiz+uWYaEsXI06kwq7tXyusPkmVEKNrw0neHiigJIFu0Lpz2xM62V
   qTBLBwsl9tbK8vJ+ZNlCIpgBCDqoSt6Cb/NAhDTufTIJadanDt3F4cKTs
   hZwi5VZBPQIcj+nPWvrc79yVjBz9hr05ACZESqaF+bXU2Q/89Rym2vYQm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="359919890"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="359919890"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 01:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="984561787"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="984561787"
Received: from yzhu-ivm3.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.213.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 01:44:16 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 0/5] Share sva domains with all devices bound to a mm
Date: Sun, 27 Aug 2023 16:43:56 +0800
Message-Id: <20230827084401.819852-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to share sva(shared virtual addressing) domains with all
devices bound to one mm.

Problem
-------
In the current iommu core code, sva domain is allocated per IOMMU group,
when device driver is binding a process address space to a device (which is
handled in iommu_sva_bind_device()). If one than more device is bound to
the same process address space, there must be more than one sva domain
instance, with each device having one. In other words, the sva domain
doesn't share between those devices bound to the same process address
space, and that leads to two problems:
1) device driver has to duplicate sva domains with enqcmd, as those sva
domains have the same PASID and are relevant to one virtual address space.
This makes the sva domain handling complex in device drivers.
2) IOMMU driver cannot get sufficient info of the IOMMUs that have
devices behind them bound to the same virtual address space, when handling
mmu_notifier_ops callbacks. As a result, IOMMU IOTLB invalidation is
performed per device instead of per IOMMU, and that may lead to
superfluous IOTLB invalidation issue, especially in a virtualization
environment where all devices may be behind one virtual IOMMU.

Solution
--------
This patch-set tries to fix those two problems by allowing sharing sva
domains with all devices bound to a mm. To achieve this, a new structure
pointer is introduced to mm to replace the old PASID field, which can keep
the info of PASID as well as the corresponding shared sva domains.
Besides, function iommu_sva_bind_device() is updated to ensure a new sva
domain can only be allocated when the old ones cannot work for the IOMMU.
With these changes, a device driver can expect one sva domain could work
for per PASID instance(e.g., enqcmd PASID instance), and therefore may get
rid of handling sva domain duplication. Besides, IOMMU driver (e.g., intel
vt-d driver) can get sufficient info (e.g., the info of the IOMMUs having
their devices bound to one virtual address space) when handling
mmu_notifier_ops callbacks, to remove the redundant IOTLB invalidations.

Arguably there shouldn't be more than one sva_domain with the same PASID,
and in any sane configuration there should be only 1 type of IOMMU driver
that needs only 1 SVA domain. However, in reality, IOMMUs on one platform
may not be identical to each other. Thus, attaching a sva domain that has
been successfully bound to device A behind a IOMMU A, to device B behind
IOMMU B may get failed due to the difference between IOMMU A and IOMMU
B. In this case, a new sva domain with the same PASID needs to be
allocated to work with IOMMU B. That's why we need a list to keep sva
domains of one PASID. For the platform where IOMMUs are compatible to each
other, there should be one sva domain in the list.

v2:
 - Add mm_get_enqcmd_pasid().
 - Update commit message.

v1: https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

Tina Zhang (5):
  iommu: Add mm_get_enqcmd_pasid() helper function
  iommu: Introduce mm_get_pasid() helper function
  mm: Add structure to keep sva information
  iommu: Support mm PASID 1:n with sva domains
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
 drivers/iommu/intel/svm.c                     |  8 +--
 drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
 include/linux/iommu.h                         | 27 ++++++++--
 include/linux/mm_types.h                      |  3 +-
 kernel/fork.c                                 |  1 -
 mm/init-mm.c                                  |  3 --
 8 files changed, 66 insertions(+), 40 deletions(-)

-- 
2.34.1

