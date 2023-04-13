Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87963E
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358820; x=1712894820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BV5LLOlacNTt4g++kWcPPRqikSTDi86tcqNaVPEHCy0=;
  b=md9YwPsTqGUmJsqcI3YVi51hBdH+AkO846OfxXPD3en8fmdsxtCFAA6k
   lowIZA/Ua8eJtYqRkaI/jWJ7cexChMPYDpeO+fY1OfX0Cb/jZgWJ4QK5B
   OBd5XM4K7gwZthvj8pRXoxjzPnFtbJvaT+WTPIiyrPZs+cb5ApP8yCq1M
   WhONo1tePNomfF3qlBrGPF0cNUjNFLBHhIBeCMVYEfCuS2rLT5A73C2Km
   F24SuP3Eq4WglclLARaVWXYJhsrE45FlPwPpogsVlKJ1T8f7oQF6hQyxi
   nTFczV6WWZoFC4OdSbjwayLR33ub0UO7UUdSpqmJdh8ZsQXygB6q9v5D/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786599"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361047"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361047"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] iommu/vt-d: Use non-privileged mode for all PASIDs
Date: Thu, 13 Apr 2023 12:06:37 +0800
Message-Id: <20230413040645.46157-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
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

