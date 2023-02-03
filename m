Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6567290B
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675465244; x=1707001244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EO0ERNsg/JaJf9M549xNqhj8+NRaDqR0k8t51qqu0po=;
  b=K9QI17wKf+nd+rQUPbTgWs+EhXmf1FkK+P8A1dt7HxXka9eBAdJPlJxh
   6EI1fMvtyIMPl1qXYo8JR1FpwuAfngiAnbSgEEGw1ns1L1CCCsFf8mPcy
   WnSE5dqmndUMWyEYOMEONNs+DbZCcPGc0wm+RzbmUtR2Ae4E6H5+RpOwn
   6m9cerAzuZnF8CCNvQWhiNbyKxzySWfYFsm3ffAHc4rmOAfV4/ETNhucS
   sXCEac53kkAJPWDbgk8mMAkMmbtKLhkK3ohhQj2NBjPGgCh00rnFpx6EU
   IoYh3uJC1JXNJLQvkQ/wm6NFoQip19EFJ3bL6FCEpPfSPS05Ewyo0fPYj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="316877107"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="316877107"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 15:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="839753006"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="839753006"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2023 15:00:44 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	stable@vger.kernel.org,
	Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [PATCH] iommu/vt-d: Avoid superfluous IOTLB tracking in lazy mode
Date: Fri,  3 Feb 2023 15:04:17 -0800
Message-Id: <20230203230417.1287325-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel IOMMU driver implements IOTLB flush queue with domain selective
or PASID selective invalidations. In this case there's no need to track
IOVA page range and sync IOTLBs, which may cause significant performance
hit.

This patch adds a check to avoid IOVA gather page and IOTLB sync for
the lazy path.

The performance difference on Sapphire Rapids 100Gb NIC is improved by
the following (as measured by iperf send):

w/o this fix~48 Gbits/s. with this fix ~54 Gbits/s

Cc: <stable@vger.kernel.org>
Tested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b4878c7ac008..705a1c66691a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4352,7 +4352,13 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
-	iommu_iotlb_gather_add_page(domain, gather, iova, size);
+	/*
+	 * We do not use page-selective IOTLB invalidation in flush queue,
+	 * There is no need to track page and sync iotlb. Domain-selective or
+	 * PASID-selective validation are used in the flush queue.
+	 */
+	if (!gather->queued)
+		iommu_iotlb_gather_add_page(domain, gather, iova, size);
 
 	return size;
 }
-- 
2.25.1

