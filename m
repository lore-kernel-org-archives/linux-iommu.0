Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DA1FD6
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691480992; x=1723016992;
  h=from:to:cc:subject:date:message-id;
  bh=bZYKDkWN/NzViSoHo0Sz+w7bafCwSfAclgWR77m9hZM=;
  b=ib9tGeUWgxNxc3dfQ2ZIQM6EJY62m/lTszst/SJB1PIQp9M3VGOOFvt7
   DbszdRA0x8+UXWcahrv03y0qmvtO5IT7mhIr7i+pFR2Xpu/u5yyOwSry8
   Sxm2aMPTVVDORxCpjOLMXGEXG2iRrpiKcO2/wGE4riyOF2PffTGPhMt0V
   OHUm49OXxQtSr21bICyZcQqXFwsBwLfs3ETk+2dJGAEMb2mMmLmaK7FBQ
   nWyZeSD+vkrc9BbOe6Ogb33CiSOUMpS07+hObYyN4S1WQW6pFKHcza46p
   vfGG2oI+yQBskoisd04oib4nJk11Cvs4jMAMS3pe5fsBRWtKjnBQ7WZA6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078608"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078608"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146258"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146258"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:49:49 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 0/5] Share sva domains with all devices bound to a mm
Date: Tue,  8 Aug 2023 15:49:39 +0800
Message-Id: <20230808074944.7825-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

A sva domain's lifetime begins with binding a device to a mm and ends
by releasing all the bound devices from that sva domain. Technically,
there could be more than one sva domain identified by the mm PASID for
the use of bound devices issuing DMA transactions.

To support mm PASID 1:n with sva domains, each mm needs to keep both a
reference list of allocated sva domains and the corresponding PASID.
However, currently, mm struct only has one pasid field for sva usage,
which is used to keep the info of an assigned PASID. That pasid field
cannot provide sufficient info to build up the 1:n mapping between PASID
and sva domains.

This patch-set fills the gap by adding an mm_iommu field[1], whose type is
mm_iommu_data struct, to replace the old pasid field. The introduced
mm_iommu_data struct keeps info of both a reference list of sva domains
and an assigned PASID.


[1]: https://lore.kernel.org/linux-iommu/ZIBxPd1%2FJCAle6yP@nvidia.com/


The RFC version of this patch-set is here:
https://lore.kernel.org/linux-iommu/20230707013441.365583-1-tina.zhang@intel.com/

Tina Zhang (5):
  iommu: Add mm_get_pasid() helper function
  iommu: Call helper function to get assigned pasid value
  mm: Add structure to keep sva information
  iommu: Support mm PASID 1:n with sva domains
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
 drivers/iommu/intel/svm.c                     |  8 +--
 drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
 include/linux/iommu.h                         | 19 +++++--
 include/linux/mm_types.h                      |  3 +-
 kernel/fork.c                                 |  1 -
 mm/init-mm.c                                  |  3 --
 8 files changed, 58 insertions(+), 40 deletions(-)

-- 
2.17.1

