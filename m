Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1D23B7
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQVZLRZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697427131; x=1728963131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DxiPARvF786GMcRwOlSI1TqYVHXVvDCyQYStCbvWKqo=;
  b=AQVZLRZDunxFK3HqiHp/yy7t/hSocityubknclQGDVgSTNcS4qqOX0jh
   mqKnoYXFZo5eDbAPu52MQ46KQbrb1OWxI2lMgQ6g/gs+axaS4pddNtcPA
   CQ/kchuSTKwAPHZkSv/CByS1D70KnXVMLOkqQBJmTDCudUpFq8npuShbB
   81Iy5Hyz5xvnDjyfghw42yBHaddVACmzufRdMYxP6QJl9+2dCcZuU1V2n
   mX2QaZmaaRNhd2fEfCyTES8SbGzG9bX6HRC4QuVpg+JQtKgyHnpZpG1Sa
   DaVZG8OihCk/Zt/EbvAxWQm3G+RXN8UvQhh+y6hFJnywhnpgbr//mc5c1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365701121"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365701121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705444244"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705444244"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 20:32:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jingqi Liu <Jingqi.liu@intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.7
Date: Mon, 16 Oct 2023 11:28:26 +0800
Message-Id: <20231016032830.101321-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following patches have been queued for v6.7. They aim to:

 - Enable debugfs to dump domain attached to a pasid
 - Remove an unnecessary inline function.

All patches are based on v6.6-rc5. The series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.7

Please consider them for v6.7.

Best regards,
Baolu

Jiapeng Chong (1):
  iommu/vt-d: Remove unused function

Jingqi Liu (3):
  iommu/vt-d: debugfs: Dump entry pointing to huge page
  iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
  iommu/vt-d: debugfs: Support dumping a specified page table

 drivers/iommu/intel/iommu.h   |  14 +++
 drivers/iommu/intel/debugfs.c | 215 +++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.c   |   7 ++
 drivers/iommu/intel/pasid.c   |   9 --
 4 files changed, 195 insertions(+), 50 deletions(-)

-- 
2.34.1

