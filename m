Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F59472
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304055; x=1711840055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=86aFWjB5alp/mq4OwyCmhytbhDjYJbntMbdQCEJ84y8=;
  b=Hxo3EqCT7RP1rZ2SwG3xYkQdHofdjPOppHwQ2ROm1kxiXphMb+Zj1Jwg
   u7LJJ22bpMi65Sj8QJjoRRaLTG6QGwgyAtHsJ4lD5p00vOIkFkr2fs0lo
   iMQCAzRaDncd3QZoEhfskW8CCZLRwI3gnJVec0xT3wvdNay6NE+rWkSyc
   5+SNT1ZDyl+62OIuK24urGsECgJfG3SD+z08rvOI/bGraBoFzDoP7J8Bt
   DhGyty3DPF1/QfBnphV5s8XxpfXtmqdRhGqucp1M48UuW7LKWvclrQu63
   5y/ZIjNtScTNWF80VCchtw8m6oVcpvT6J0cipYWJ2SSDeIFXnMrEGB2Kh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343245144"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343245144"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717888346"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="717888346"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2023 16:07:33 -0700
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
Subject: [PATCH v3 4/7] iommu/vt-d: Reserve RID_PASID from global PASID space
Date: Fri, 31 Mar 2023 16:11:34 -0700
Message-Id: <20230331231137.1947675-5-jacob.jun.pan@linux.intel.com>
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

On VT-d platforms, RID_PASID is used for DMA request without PASID. We
should not treat RID_PASID special instead let it be allocated from the
global PASID number space. Non-zero value can be used in RID_PASID on
Intel VT-d.

For ARM, AMD and others that _always_ use 0 as RID_PASID, there is no
impact in that SVA PASID allocation base is 1.

With this change, devices do both DMA with PASID and SVA will not worry
about conflicts when it comes to allocating PASIDs for in-kernel DMA.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f737ef55463..cbb2670f88ca 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
 
 	intel_iommu_enabled = 1;
 
+	/* Reserved RID_PASID from the global namespace for legacy DMA */
+	WARN_ON(iommu_alloc_global_pasid(PASID_RID2PASID, PASID_RID2PASID) !=
+		PASID_RID2PASID);
+
 	return 0;
 
 out_free_dmar:
-- 
2.25.1

