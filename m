Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592515B0
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894084; x=1695430084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D66fqEUBroJKd+9d6VDZZucMlLgMXnXc4WPgDREMliU=;
  b=VsCRYDGASuerarmsSBkjxY8Gcvwgi9mEyBtd8/wDxu+HOIguHMCX2zeF
   dRpXKsATQInrtJ8babKO+znC+PPfuPtBpN6aVl12rDV9YYcYZK5SQw7a2
   u23Y9NzRIjGrB9yV2t0H7uvMc4kPn3HGQyD0h25oSeRlPaDZWY4NpNiOq
   ew5OaPbT+swMWZU4nUiQcYbYu3KLd5tfoNDJ3YcG08yLSdw44Ap5XakSP
   dj9srF4/Esr2I/xhq14Ly4CevixKOS0DO2UFA7Rwg7uCXBp5A/omdSXZr
   15cROeHvumklb5lgY7iyq+UaIIBaz/URAx140z+hxgtwfuNMO0oHqSzqo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278839"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278839"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650759929"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Date: Fri, 23 Sep 2022 08:42:00 +0800
Message-Id: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This includes patches queued for v6.1. It includes:

 - Decouple PASID and PRI from SVA
 - Add ESRTPS & ESIRTPS capability check
 - Cleanups

The whole series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.1

Please consider them for next.

Best regards,
Baolu

Lu Baolu (5):
  iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
  iommu/vt-d: Decouple PASID & PRI enabling from SVA
  iommu/vt-d: Remove pasid_set_eafe()
  iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
  iommu/vt-d: Avoid unnecessary global DMA cache invalidation

Yi Liu (1):
  iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

 drivers/iommu/intel/iommu.h         |  7 ++-
 drivers/iommu/intel/cap_audit.c     |  4 +-
 drivers/iommu/intel/iommu.c         | 87 ++++++++---------------------
 drivers/iommu/intel/irq_remapping.c |  6 +-
 drivers/iommu/intel/pasid.c         | 12 +---
 drivers/iommu/intel/svm.c           | 62 +++-----------------
 drivers/iommu/intel/Kconfig         |  5 +-
 7 files changed, 45 insertions(+), 138 deletions(-)

-- 
2.34.1

