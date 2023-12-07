Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361815CE
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcLqoK4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701915858; x=1733451858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BlyFybv+wIkSnOIH0bgSDQUnQo1Qmc4Q1qqIz58xmyg=;
  b=DcLqoK4uqAI3ePp5gUDv8cm6mF0CGB6ehXBTMa8cy8SZTQAYPBNfbcvf
   xD/Hy4NxV0dxj0d3oU+GW5OEd9E9khrH0ONj1/SolBVLXxmwHdvuZ772C
   SOtgYJEgYG090IXdDCpDmxxLzVj0Q8Xg4v3Zbva1PKvlv10YXoW0fh9xy
   Fp8SRnFlH5nkZzNa06qKMsDBI51u6fQ39WjOTZPuCL68OX0ZapiFdPY2M
   G65JDkVszESdOOwseIyJHgGBRfy66ZOIWHSnaE2KGJzZJ5OBnPowqB8V+
   Mreu8qk4wOnG/C7Ib6ULdS4d3HL9ibbhVjkSUCmnbeYHO1MP6//IMj1+g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391331285"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391331285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="805848827"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="805848827"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2023 18:24:15 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Set owner token to sva and nested domains
Date: Thu,  7 Dec 2023 10:19:38 +0800
Message-Id: <20231207021938.306738-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a9c362db3920 ("iommu: Validate that devices match domains") added
an owner token to an iommu_domain. This token is checked during domain
attachment to RID or PASID through the generic iommu interfaces.

The sva and nested domains are attached to device or PASID through the
generic iommu interfaces. Therefore, they require the owner token to be
set during allocation. Otherwise, they fail to attach.

Set the owner token for sva and nested domains.

Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 1 +
 drivers/iommu/iommu.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index b5a5563ab32c..014d4a4e7586 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -108,6 +108,7 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 	domain->s1_cfg = vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
 	domain->domain.type = IOMMU_DOMAIN_NESTED;
+	domain->domain.owner = &intel_iommu_ops;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	spin_lock_init(&domain->lock);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d25468d53a6..d0a28667479a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3617,6 +3617,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
+	domain->owner = ops;
 	domain->iopf_handler = iommu_sva_handle_iopf;
 	domain->fault_data = mm;
 
-- 
2.34.1

