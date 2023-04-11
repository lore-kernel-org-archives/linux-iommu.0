Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D1211C
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195711; x=1712731711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BV5LLOlacNTt4g++kWcPPRqikSTDi86tcqNaVPEHCy0=;
  b=nsYHUEPt8ihErHrFv12dkYEgPc0bxht1Tze5NsYKhaz3yuqPvSbH9LQA
   Kzm22uu1XhEShN3hVefnPJF+qmwvfQw744m55xBhcTuNHT5mv0YIVHiWK
   S5O/YVa81M/UcumtWj3j3ddQeyBS5/n/TKT/E8fmxK8iFGmr7owW5Gnyy
   iNART1ogd8yQEJb1qeHE5hkAZmwSRUHg5aAkzOkeOucatw+yWb1X4jOd7
   MkOCgl//gBkNya+iv1w+Aa1XsAVFq01GGH6OR6yREQeGnuI1qH+F/l5XI
   q1lomntnZkhjA7IEKcp4NcrvzhGEzIApkOw08P/RQqRHOUQfRc3iVf75o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028575"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028575"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256606"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256606"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] iommu/vt-d: Use non-privileged mode for all PASIDs
Date: Tue, 11 Apr 2023 14:48:07 +0800
Message-Id: <20230411064815.31456-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Supervisor Request Enable (SRE) bit in a PASID entry is for permission
checking on DMA requests. When SRE = 0, DMA with supervisor privilege
will be blocked. However, for in-kernel DMA this is not necessary in that
we are targeting kernel memory anyway. There's no need to differentiate
user and kernel for in-kernel DMA.

Let's use non-privileged (user) permission for all PASIDs used in kernel,
it will be consistent with DMA without PASID (RID_PASID) as well.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/r/20230331231137.1947675-2-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c771233d6f2a..f4e536fd5a28 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2316,8 +2316,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level != 4 && level != 5)
 		return -EINVAL;
 
-	if (pasid != PASID_RID2PASID)
-		flags |= PASID_FLAG_SUPERVISOR_MODE;
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
 
-- 
2.34.1

