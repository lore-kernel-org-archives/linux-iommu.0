Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43244C6A
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679338522; x=1710874522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r8qGzQ7IOXx/2adul/921u6SEIBpB6UL3KX2Be1V0J0=;
  b=Fn9ytZHfasR/dqPdiVziNC+2QLPlTaNluNERXlJMMdUD0N4SLbzKy9ir
   WqtIXB/lZ9wvf91/xpYC0D1QS1KMT4id0LbBGL2poKIifMN2QOL+WmzDa
   DCDaiXJICI8qh8LYt9A/+Oj1N3SWBrmHzsf4xuOClSDEZerX50kZIJdOn
   ZJEhY9cmu6XiR9chb+M7n58tAKUxQyLzy2Ul/T8hKR4SCXbVBDasQSbXJ
   f7C0+/DLC30wTgig2sHNIt9VcVKj3rrmywuO37TMQ9SDI/Yt/lJzLkeHE
   oNaTWwAc+wQs4WhbkRRLpCFDW94E4303JhnPGqsbJMnl6xDNZnbQV2fNz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366473721"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366473721"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927076444"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="927076444"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2023 11:55:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	X86 Kernel <x86@kernel.org>,
	bp@alien8.de,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	corbet@lwn.net,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v7 0/7] Remove VT-d virtual command interface and IOASID
Date: Mon, 20 Mar 2023 11:59:03 -0700
Message-Id: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch set removes unused VT-d virtual command interface followed by
removal of the IOASID infrastructure.

This has only been tested on x86 platforms, need help with testing on ARM
SMMU and other architectures.


Thanks,

Jacob

ChangeLog:
v7:
 - use CONFIG_IOMMU_SVA around PASID helpers in fork.c, Fixes a
   compile problem.
 - Fix extra space

v6:
 - put pasid helpers under iommu.h instead of iommu-helper.h
 - add comments for pasid allocation function to clarify inclusive range

v5:
 - rebased on v6.3-rc1
 - put removing iommu_sva_find() in a separate patch (Kevin)
 - move definition of helpers to iommu code to be consistent with
   declarations. (Kevin)
 - misc fixes

v4:
 - keep mm_pasid helpers inline as much as we can for fork performance
 - separate GFP_ATOMIC to GFP_KERNEL change for bisectability

v3:
 - moved helper functions for PASID under SVA code, avoided circular inclusion
   between mm.h and iommu.h
 - deleted makefiles
 - put rename under a different patch


Jacob Pan (5):
  iommu/vt-d: Remove virtual command interface
  iommu/sva: Move PASID helpers to sva code
  iommu/sva: Remove PASID to mm lookup function
  iommu/sva: Use GFP_KERNEL for pasid allocation
  iommu/ioasid: Rename INVALID_IOASID

Jason Gunthorpe (2):
  iommu/sva: Stop using ioasid_set for SVA
  iommu: Remove ioasid infrastructure

 Documentation/x86/sva.rst       |   2 +-
 arch/x86/kernel/traps.c         |   5 +-
 drivers/dma/idxd/device.c       |   8 +-
 drivers/dma/idxd/idxd.h         |   2 +-
 drivers/dma/idxd/init.c         |   2 +-
 drivers/dma/idxd/irq.c          |   2 +-
 drivers/iommu/Kconfig           |   5 -
 drivers/iommu/Makefile          |   1 -
 drivers/iommu/intel/cap_audit.c |   2 -
 drivers/iommu/intel/dmar.c      |   6 +-
 drivers/iommu/intel/iommu.c     |  87 +------
 drivers/iommu/intel/iommu.h     |   3 -
 drivers/iommu/intel/svm.c       |   3 +-
 drivers/iommu/ioasid.c          | 422 --------------------------------
 drivers/iommu/iommu-sva.c       |  61 ++---
 drivers/iommu/iommu-sva.h       |   4 -
 include/linux/ioasid.h          |  83 -------
 include/linux/iommu.h           |  14 +-
 include/linux/sched/mm.h        |  26 --
 kernel/fork.c                   |   5 +
 mm/init-mm.c                    |   4 +-
 21 files changed, 54 insertions(+), 693 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

-- 
2.25.1

