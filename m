Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F27290D
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676356843; x=1707892843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1u/JJeVuODzW0/XB3QzKmkN+I+j74f09XavCGEHqoRM=;
  b=bApr2iRX0j4rtJT38uGXpRqwo8xYJlvipAmKdq3cNB3Ae/ievXBgCnV5
   jpp634urOXivJVs4hDOFlIhZgO+G3NGNKICeONcVFLZ/fmog9+Dkh552T
   hz2mEIYh30kAn9ATkyDAY835wRAyG1ajaSDtOlYAwIcNQCdpFucfPirvN
   aDN2GYt3KRL/1yAZj1wnOMzX+ouAQcfJFbUgg85bKZTnk/Dd7DqRQsK5P
   mvTvbRRi5gb1Wki6m9VSsbwhvkzUstR16HRl4jByAgU9vmO+PJetsCkqy
   utuzv4bWLPysTDww5hT/l2x7JABtHMsf/ouz0UitvZug0i8KKtW2nQLSh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333229928"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333229928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:40:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="811907109"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="811907109"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2023 22:40:35 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/3] Remove VT-d virtual command interface and IOASID
Date: Mon, 13 Feb 2023 22:44:11 -0800
Message-Id: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi all,

This patch set removes unused VT-d virtual command interface followed by
removal of the IOASID infrastructure.

This has only been tested on x86 platforms, need help with testing on ARM
SMMU and other architectures.


Thanks,

Jacob

Jacob Pan (2):
  iommu/vt-d: Remove virtual command interface
  iommu: Remove ioasid infrastructure

Jason Gunthorpe (1):
  iommu/sva: Stop using ioasid_set for SVA

 Documentation/x86/sva.rst       |   2 +-
 arch/x86/kernel/traps.c         |   5 +-
 drivers/dma/idxd/device.c       |   8 +-
 drivers/dma/idxd/idxd.h         |   2 +-
 drivers/dma/idxd/init.c         |   2 +-
 drivers/dma/idxd/irq.c          |   2 +-
 drivers/iommu/intel/cap_audit.c |   2 -
 drivers/iommu/intel/dmar.c      |   6 +-
 drivers/iommu/intel/iommu.c     |  87 +------
 drivers/iommu/intel/iommu.h     |   9 -
 drivers/iommu/intel/svm.c       |   3 +-
 drivers/iommu/ioasid.c          | 422 --------------------------------
 drivers/iommu/iommu-sva.c       |  55 ++---
 drivers/iommu/iommu-sva.h       |   4 -
 include/linux/ioasid.h          |  83 -------
 include/linux/iommu.h           |  11 +-
 include/linux/sched/mm.h        |  12 +-
 include/uapi/linux/iommu.h      |   1 +
 mm/init-mm.c                    |   4 +-
 19 files changed, 46 insertions(+), 674 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

-- 
2.25.1

