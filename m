Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF2125AC
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690237244; x=1721773244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7pEMVnY38ePZ+dddDqL9MVthVOhVNl5Cd66gkfRILA=;
  b=D6h2fTu7td3cNghvWmZ5ItxtXY06oTaZmFIWJ7Ro43nVZzOiQIOpKTcs
   Bnoflweq99VGp4FfgkgnlOelbyDCWZMrED//FbwQQD8A/SAwjTdvywGn0
   SuaP7YwPzc3MAuXEjp0JNDmF+7vPYoxQkjpw/p5ql5TpxWa9d38InNKT5
   pZr9tOiXsqQNCMsmDNesdko+d/k48YslnosTVjEfp44/Ee2EohIM8qOM7
   9aCSuRMLFgCdmRo9oPGSG8n9ytV+JQiyuEmx4OodB0VwmOY73z+yeRpUZ
   nQMnqGPpZenYO2w0araGE6s1Eo+3qfOjvkfGxk0fSjtD+a50ZG9s2Sry0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398476728"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="398476728"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899675512"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="899675512"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 15:20:41 -0700
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
Subject: [PATCH v11 6/8] iommu/vt-d: Prepare for set_dev_pasid callback
Date: Mon, 24 Jul 2023 15:25:36 -0700
Message-Id: <20230724222538.3902553-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
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

