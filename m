Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179923A3
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195697; x=1712731697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZpgBJnJOIEMCQ5fkecKmHR/Jc+ND/1NNnUwHTFQSc34=;
  b=by8+KtVosJEv3cTsCHGN/bn72mQR2xEq3eTgoIV1QzyZ1ncwNIbpL3+C
   vcygLmrI48P0+3biDwvTzCHleVAiBijGTnXZoTfJL/QeXR3N66Y/V6j18
   sLXjVShHKyIF62F7CEszy3DRVSHSkfdZ0qxFi5EJNNiUwSwAG4exhclWt
   u5NSSvpWUYMjFqaCxLv8o+SiTxwvx/uKBaWhHgKL2aZGQTwGJ2jNJ7r8h
   ygzcdncG/5F56W46VXISn+5p7Hy+z5Pruvu1UxK/9Ts8bKUsFNGP7bJnx
   kcXM51LoVg+odXVhCk9RaiRehCmljcHjwNJQjcKUTG4bM12qZ+K6bMJu3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028488"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028488"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256482"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256482"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] [PULL REQUEST] Intel IOMMU updates for Linux v6.4
Date: Tue, 11 Apr 2023 14:47:58 +0800
Message-Id: <20230411064815.31456-1-baolu.lu@linux.intel.com>
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
changes in the IOMMU driver. It has been reviewed by the driver's
maintainers. Please feel free to let me know if it's inappropriate to
route it through the iommu tree.

The whole series is based on v6.3-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.4

Please pull them for x86/vt-d branch.

Best regards,
Baolu

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
  iommu/vt-d: Fix operand size in bitwise operation
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

