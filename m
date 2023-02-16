Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3F5663
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553403; x=1708089403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MybL6PZvO8vl1RhV9+iwIm6F1rZbvNks5EmjDZ1/Cx8=;
  b=Evqkm0itCyQ4OsmhzBxJlDrplTp1Eg2UE5UBUJXbk5YtfgxzboZDLZyj
   2mTXcAeo7/n3MaQmbC9/3rimqxkC7H3dOHvHv/i470m2AjXBPBXHasbCB
   ZSLSJxYXYsEMBcz3wkPY1LgQd9UVoNq63pAQKh/yoyay73laz9sZrxnQo
   E9ahX4ovYKrOEsCY5W09YVtUHeT6fRFMnQyvRRIQgRsY0rHazzVlnVruy
   7+o3R0718D4q9kUt78ZlBIXWdPce58BBUGQS4DWzdzy7nLVR/R4+G6/3s
   c/9QMBZOwQ2heN/eznY6Ruxk/UOooM7flUJZ+jw2Rx3a7ZjpRcmeEVHeR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883291"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674908"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674908"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.2-rc8
Date: Thu, 16 Feb 2023 21:08:12 +0800
Message-Id: <20230216130816.151824-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below iommu/vt-d fixes are queued for your fixes branch.

- Two performance optimizations
- Fix PASID directory pointer coherency
- Fix missed rollbacks in error path

Please consider it for the iommu/fixes branch.

Best regards,
Lu Baolu

Jacob Pan (2):
  iommu/vt-d: Avoid superfluous IOTLB tracking in lazy mode
  iommu/vt-d: Fix PASID directory pointer coherency

Lu Baolu (1):
  iommu/vt-d: Fix error handling in sva enable/disable paths

Tina Zhang (1):
  iommu/vt-d: Allow to use flush-queue when first level is default

 drivers/iommu/intel/iommu.c | 26 ++++++++++++++++++++------
 drivers/iommu/intel/pasid.c |  7 +++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.34.1

