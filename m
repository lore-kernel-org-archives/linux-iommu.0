Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030EF15B8
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232447; x=1711768447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RlLIJl5nPQ5JeRYMFs2QyAZldCJE6lCb9GnmdypnSJ8=;
  b=d7n/MCavAVFqqLqeEZeLL8xlyT2L+Q0/BBy+k0WourLDD/YbZUsRRLsU
   XM0wT+M3cLf3pm0ch+a1FVBGt5KB/mIfVQrPbZez2zgD+ov3HGy8EQOiV
   JNw66O8EfpR1PclKhj8PYFpOPS5IUmq9F+wqQsZSwF7hlbewUDhVWEj9Q
   LSydjsnGw0ieZmdItWlSuYAZtgGqmRgrIOETWihoe90JyEpyRzq4xyV+I
   4VzqpG5MdwdoNofx35uKdgBa+2s5ptRmIjdIWteYwA2bDU3Jhv/WXirhk
   huf3EtMFr3I0KDa0+l2aGezj/866fBAUWslH0XdyvobJeFKVAPgKG5Xuj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342991700"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342991700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635144724"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635144724"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 20:13:48 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 0/7] iommu/vt-d: Several fixes for intel iommu driver
Date: Thu, 30 Mar 2023 22:42:29 -0400
Message-Id: <20230331024236.2716001-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Remove two patches which are not necessary.
- Split the "Replace BUG()/BUG_ON() with WARN_ON/WARN_ON_ONCE()" patch
  into several small patches with each one addressing one issue.
- Use BIT_ULL in the "Fix operand size in bitwise operation" patch.
v1:
https://lore.kernel.org/linux-iommu/20230329124654.2698853-1-tina.zhang@intel.com/

Tina Zhang (7):
  iommu/vt-d: Fix operand size in bitwise operation
  iommu/vt-d: Remove BUG_ON on checking valid pfn range
  iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
  iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
  iommu/vt-d: Remove BUG_ON in map/unmap()
  iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
  iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()

 drivers/iommu/intel/dmar.c  |  7 +++---
 drivers/iommu/intel/iommu.c | 45 ++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.34.1

