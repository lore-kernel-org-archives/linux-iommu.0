Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8F848E
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680890515; x=1712426515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=86aFWjB5alp/mq4OwyCmhytbhDjYJbntMbdQCEJ84y8=;
  b=maUfJqyqrLEjcV18bsbpulY5ufImGse0zpfKWJ6/ZMU0QcToLjngMpja
   RumrcuUvhBo8ngSF5zFmxsguXq5eqiCk9jxQ/Md+IPR0wnBpMeR6PYVx+
   aPsKXPKcTPJEUdxbqJ8bhYv8qPnnGNrD1EH3aw7vIXsqDGYspaxu+5uqp
   QD1Ltl9q4JFn7BpFlQXITSb981tPPHP5Xip2VTGI+lERkpp+Hv6NRdKRW
   Hs+eUcNMMT+U/dcTv30eoiKNyFewk6etBKEGTRl2P4NdNXsWukuSqSya0
   U0rYKv8JXchaae5Ux9YWHgH974rmOekhmQvBjpLHXrBhwYX0BN9h1Xymv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343046492"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343046492"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="776910068"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="776910068"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 11:01:51 -0700
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
Subject: [PATCH v4 4/7] iommu/vt-d: Reserve RID_PASID from global PASID space
Date: Fri,  7 Apr 2023 11:05:51 -0700
Message-Id: <20230407180554.2784285-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
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

