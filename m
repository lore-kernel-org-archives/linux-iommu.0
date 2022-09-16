Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EE7E
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663312340; x=1694848340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pYWtaQJR2f9fkvn175MQmhcRvlUrJPIA2kkVQv+bejs=;
  b=YA3q23U3o42t+91IvVdznAhX977HX0RJibw+cRxa8mWBLlmvz56cAfRz
   G0wpgfapv7KQ3j+Vv3PwRIU4oA7vHpsZooVDMOAUnb3Bjt6azqO0/0X6B
   ivykO4ycF4m/pZ60+BNH1d4R9LSO27F7kYJDMEicENFuMNBnk5CiaumVP
   PgBkGrczNn0DQsTFTOnQCR+UsxsiQbXxv8/pQj/pNk/WbasnypQfMfcie
   uI2MsWXzcSy1juEc1b/IaKTryVRmu6yZdGMZRTwisO8uQHAq7MCOw48cq
   Loj93qXVpLJ8sVR0FCVBpUE53kVXmobHylyD4KRRYniF2+vdChhWGEOKq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362896112"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362896112"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 00:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650780427"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2022 00:12:14 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com
Cc: kevin.tian@intel.com,
	baolu.lu@intel.com,
	yi.l.liu@intel.com,
	raghunathan.srinivasan@intel.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 0/2] Misc fixes to intel iommu driver
Date: Fri, 16 Sep 2022 00:12:10 -0700
Message-Id: <20220916071212.2223869-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One fix and one cleanup.

Base commit 3245cb65fd91cd514801bf91f5a3066d562f0ac4

Yi Liu (2):
  iommu/vt-d: Check correct capability for sagaw determination
  iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

 drivers/iommu/intel/cap_audit.c | 4 ++--
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/intel/iommu.h     | 2 +-
 drivers/iommu/intel/pasid.c     | 2 +-
 drivers/iommu/intel/svm.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

