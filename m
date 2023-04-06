Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB80ECA
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680766270; x=1712302270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ae+X9iE65CfoVc9MkVjB/EyKmz0fsDdcA/WLSxzMHPg=;
  b=f5esDDuI67ENPTB0HwL+94Ws575SDjMUPLCgmhAGN85P6JzHvrEK05Kr
   QiT1OCiXYHdJkzxAvP/kaSLsGRPHJfVLbHV7aN7YJrQtw4qC281fJU+ME
   KYu8uTWo8DTo1DR6WoN4aKuzQjYNmEPrd+YlyMncErEUx0SipBGOj/E+G
   AJacW2ms6gZleu+FUKSXpr24Oo3Ks+Uo1YYs1GrdXbnpZZboauGLlMY+5
   6SghcwHvoyN6aDPjMlzwn2O7yW79b0TBW1awxZONOn39HHY1Yqh+X8G6h
   KIH5qgSMGeWwtIF3bos+xDhr+7K1Ky8mBTF4yDquOeKhYeMxkMnoWSbmx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428956734"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="428956734"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687033962"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687033962"
Received: from test.bj.intel.com ([10.238.158.71])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 00:31:08 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [v3 0/7] iommu/vt-d: Several fixes for intel iommu driver
Date: Thu,  6 Apr 2023 02:59:37 -0400
Message-Id: <20230406065944.2773296-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes several small fixes.

v3:
- Remove the unnecessary domain->pgd checkings.

v2:
- Remove two patches which are not necessary.
- Split the "Replace BUG()/BUG_ON() with WARN_ON/WARN_ON_ONCE()" patch
  into several small patches with each one addressing one issue.
- Use BIT_ULL in the "Fix operand size in bitwise operation" patch.
  https://lore.kernel.org/linux-iommu/20230331024236.2716001-1-tina.zhang@intel.com/
    
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

 drivers/iommu/intel/dmar.c  |  7 +++----
 drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.34.1

