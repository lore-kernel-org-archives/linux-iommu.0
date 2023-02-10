Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946E2F41
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676069911; x=1707605911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mh0zooOUAQYuLPgusu7lqvn1pK/p6iAkU1snPUOtILE=;
  b=dJBMw0kXwE5R1bmJvkf4gcGkuuyo/1qsXdmo0pj8Sbp3t3eHhWkj+2eV
   y907pZz3dtMgjEL0eHfJUjNCux4lr1nJ2X5nyv5WdWVmTGSHiUN1STGJH
   +Pc0fjh+Ud07IKWVNV56exw8r2cQvW5UC6wP5NB/hAmTyypwFKibEpQLD
   6rVgKl4qVO/Zute+4dL0XtOnQ1Oa5+gf6QDRIbXsXoiMzh2TWLGqaGnVZ
   LDm1D6CDYBGs7xvc959dYa12b9/yXN/c4KVAxYOsMnMmondX0hRAJ0jR7
   eL+bneaPw1g19IBSE2VZQLlR37riCpq8spBQW1/AYKoyQWl1pZu9l4SMS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310179477"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310179477"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="777093491"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="777093491"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 14:58:29 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Remove VT-d virtual command interface
Date: Fri, 10 Feb 2023 15:02:04 -0800
Message-Id: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
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
clean up in the IOASID code.

This has only been tested on x86 platforms, need help with testing on ARM
SMMU and other architectures.

I also hope to collect feedback on the upcoming clean up and enhancements
below:
1. Consolidate VT-d private SVA PASID array with IOASID common code
2. As we retain the global IOASID allocator, we need some level of resource
management. I want to restart the effort to include IOASID under misc
cgroup.
(https://lore.kernel.org/linux-iommu/20210303160205.151d114e@jacob-builder/)

Thanks,

Jacob

Jacob Pan (2):
  iommu/vt-d: Remove virtual command interface
  iommu/ioasid: Remove custom IOASID allocator

 drivers/iommu/intel/cap_audit.c |   2 -
 drivers/iommu/intel/dmar.c      |   2 -
 drivers/iommu/intel/iommu.c     |  85 ---------
 drivers/iommu/intel/iommu.h     |   8 -
 drivers/iommu/ioasid.c          | 293 +-------------------------------
 include/linux/ioasid.h          |  28 ---
 6 files changed, 9 insertions(+), 409 deletions(-)

-- 
2.25.1

