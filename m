Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB763E
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358809; x=1712894809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s73Dwcw/j+M9Z+7wT2sD+XtVqUA+ffONLeb/NudPzz8=;
  b=d+4kjgeGPGvy8vBtOvmv81A5cC/KCjjYfsgF2vJLtpuD+HGqxCP4kQZB
   J+4cXYYigavGphlElDM+zPdrMNvBLzTX/gP28xroDVOYN52a+vQxMqWOb
   reRdqI6eeS5SwBEaT3TMYptGSnQ4+c7qvYzEUTDKuPUieDmM7VoHkp17K
   hxLdQyTcW6ZTLg/VV/gi6GQnZNlzR+c05bgf45z3c2sKQjHl4XcQu4mI7
   5vXloRfuQf/iTto/EdAqPBpQRyT5WZlsJv4RhHvZN4hsllzDzcp4E3xnS
   cbvzE3WxiivtctVtCvZ/nvD9mMaTnz8F+OokV22HEEZi4vS7QLDkfjUsn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323702320"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323702320"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935360955"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935360955"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:42 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] [PULL REQUEST] Intel IOMMU updates for Linux v6.4
Date: Thu, 13 Apr 2023 12:06:28 +0800
Message-Id: <20230413040645.46157-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This includes patches queued for v6.4. They are:

 - Allow the VT-d driver to support non-PRI IOPF
 - Remove PASID supervisor request support
 - Various small and misc cleanups

This series also includes an idxd patch to avoid driver regression after
changes in the IOMMU driver. It has been reviewed and acked by the
maintainers.

The whole series is based on v6.3-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.4

Please pull them for x86/vt-d branch.

Best regards,
Baolu

Change log:
 - v2:
   - Avoid using "fix" wording in the commit message of a cleanup patch,
     no functional change. [David Laight]
   - Add Acked-by from Vinod Koul to the idxd patch.

 - v1: https://lore.kernel.org/linux-iommu/20230411064815.31456-1-baolu.lu@linux.intel.com/

Christophe JAILLET (1):
  iommu/vt-d: Do not use GFP_ATOMIC when not needed

Jacob Pan (2):
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/vt-d: Remove PASID supervisor request support

Lu Baolu (7):
  dmaengine: idxd: Add enable/disable device IOPF feature
  iommu/vt-d: Allow SVA with device-specific IOPF
  iommu/vt-d: Move iopf code from SVA to IOPF enabling path
  iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
  iommu/vt-d: Move PRI handling to IOPF feature path
  iommu/vt-d: Remove unnecessary checks in iopf disabling path
  iommu/vt-d: Remove extern from function prototypes

Tina Zhang (7):
  iommu/vt-d: Make size of operands same in bitwise operations
  iommu/vt-d: Remove BUG_ON on checking valid pfn range
  iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
  iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
  iommu/vt-d: Remove BUG_ON in map/unmap()
  iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
  iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()

 drivers/iommu/intel/iommu.h         |  36 +++---
 drivers/iommu/intel/pasid.h         |   7 --
 drivers/dma/idxd/init.c             |  31 ++++-
 drivers/iommu/intel/dmar.c          |   7 +-
 drivers/iommu/intel/iommu.c         | 173 +++++++++++++++++-----------
 drivers/iommu/intel/irq_remapping.c |   2 +-
 drivers/iommu/intel/pasid.c         |  43 -------
 7 files changed, 155 insertions(+), 144 deletions(-)

-- 
2.34.1

