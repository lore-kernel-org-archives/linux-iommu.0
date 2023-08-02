Received: from mgamail.intel.com (unknown [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B04125AC
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691011168; x=1722547168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTcWjAJeCsBne8ZdeKn434F2uIWuBkEgxK9GMvAl9eo=;
  b=mQM0I3/D+cQAIK9LOL8GTQjFoT2lv/VsTPhF+0jfFyxvlMlGOUIFyAMV
   6R4Z9Vsw4Tz5VbtnuOH7ckP/ouhrEcnBsujNxZqWZF48ybbK33+abYvbY
   KCuJMzNYV0kuJ5ivZXJUYDZP2r2ieSMhmKFUe0x+MdFwGY7SWywqlwLts
   I6AlgHyLpwn5JlVJjd1Sa/7im8lEvIX5eX9b8r/Dwi0jiuxhD9ooOfLQ4
   CIb31hkb4qLnJlRjXaWsbqS5YbjP2ws4pE45ZG6nENcgSVEDkmwmhOvg1
   5PagDOXOBwUtwIGKdau/HuJu8cplg7LU8B0d38R9RbQQR9vk86hdEqWod
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372436171"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372436171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729290796"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729290796"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 14:19:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Will Deacon" <will@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v12 6/8] iommu/vt-d: Prepare for set_dev_pasid callback
Date: Wed,  2 Aug 2023 14:24:25 -0700
Message-Id: <20230802212427.1497170-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The domain_flush_pasid_iotlb() helper function is used to flush the IOTLB
entries for a given PASID. Previously, this function assumed that
RID2PASID was only used for the first-level DMA translation. However, with
the introduction of the set_dev_pasid callback, this assumption is no
longer valid.

Add a check before using the RID2PASID for PASID invalidation. This check
ensures that the domain has been attached to a physical device before
using RID2PASID.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bdde38a5e43a..4a41aca6a2ba 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1475,7 +1475,8 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
-	qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
+	if (!list_empty(&domain->devices))
+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-- 
2.25.1

