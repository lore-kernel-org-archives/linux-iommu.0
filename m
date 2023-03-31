Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E009472
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304054; x=1711840054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HlcZA4KeerUzEWCR/cSspUC1VQcP8r9snsO4hSuDpJo=;
  b=LPXPVsVV49RCCnyH83kRYpJdEeVxQQt5YIJK7cgUnGgECmERjHTfEfEh
   bTC3nZFeRJqE6DRWjDXhbKXf4r/J+xcOLQvpzWWa+dNnjYtfdFqp9R9pc
   Zhh0w6E/K8T3koqtOG5LJTz++4NLOSSNMcsr4rD6ar6yMuEo5TWjJyihI
   sgC51QCoxXnmBN2YC7qvWMvIfO2zs8zt6SP4+LxNXwSGDmvGIeUym45f+
   LC4v34ad2zStgn8Gmd3OTZnRuzXfKFVf6bdaNwIMBgGbJ6v02Q6k8Sxpt
   kWqzrcZXJcDhub1lyOSKAN6oTQXTOuQJ9VcJ+XmTyO4vxOtgJW4B2zGAO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343245124"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343245124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717888337"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="717888337"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2023 16:07:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 1/7] iommu/vt-d: Use non-privileged mode for all PASIDs
Date: Fri, 31 Mar 2023 16:11:31 -0700
Message-Id: <20230331231137.1947675-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supervisor Request Enable (SRE) bit in a PASID entry is for permission
checking on DMA requests. When SRE = 0, DMA with supervisor privilege
will be blocked. However, for in-kernel DMA this is not necessary in that
we are targeting kernel memory anyway. There's no need to differentiate
user and kernel for in-kernel DMA.

Let's use non-privileged (user) permission for all PASIDs used in kernel,
it will be consistent with DMA without PASID (RID_PASID) as well.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0768dcae90fd..9f737ef55463 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2338,8 +2338,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level != 4 && level != 5)
 		return -EINVAL;
 
-	if (pasid != PASID_RID2PASID)
-		flags |= PASID_FLAG_SUPERVISOR_MODE;
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
 
-- 
2.25.1

