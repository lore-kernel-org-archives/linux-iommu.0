Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE916D315
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183091; cv=none; b=AkKz7WkmgKy2gvuoTLU/gRvdOVK9Fynm0BT8X8O5f+A60BuwBm3a34AjfVdF8Kh5CBSzj/PFy+fUKnX1n8EysEHerY/v2/vXAq4dMiLkFUx3cBgcAAgNnimULfV9jbDovCYOHsTgnVq3Jk5/8QQMuO1iJrwnji5VjNOy4Znu8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183091; c=relaxed/simple;
	bh=WcWlb6fcBHnjPHaTIXbjmbe+unnTFF3EQaDn0B0m0fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWG3DOIdhIOt1yWMASaLlmAN2vyS43H3eekn6ObUqWdrBsYec4RrTi9YHsZlFnWJWg7KCnoLw75ijz6XDAF3kBoIPw9Q3qFQMV9nwQJfpVCUUPFtlVJW4cCU8BvhnfBrA8DZrqBXkUmNJM/Nq6zFUuH1PGzDDhy/Kmai1WpNJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAMEBt5O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAMEBt5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183090; x=1754719090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WcWlb6fcBHnjPHaTIXbjmbe+unnTFF3EQaDn0B0m0fs=;
  b=jAMEBt5Os0wSPC4sG/PEsUGcDP2K2MuSYVjjHtzm7j8xnoIOO8f6US46
   +4yyZr6tdz4/r2BMl8MhEGYje9Go1FlFAxnDTUyFxkEufkIxnOMbaLvwb
   EOEemaNDd3G2pZ8B5GYe5BNZ/w+hZQUdh3RBDzIaOltTvsF6pZPnWBug+
   zsj+Q/Y4K4VwRjxZxW0YpJUYmW3lhryHWYHwPIFKSojXHd9nzOEmPjzjc
   4YEKG0guuzTyVfTUcgPNvqFeq6R96E108L72OtcrjHEF3x4boXVbrzkll
   kUou/6JiPQDK6BYcet75FLy3Z5N5JUusRpkw8B5XQ0GD9vBeC4pskbRAx
   w==;
X-CSE-ConnectionGUID: UJKIEZ8QTvurgOxJImq5+g==
X-CSE-MsgGUID: U30SlOtsTVK1cUs9nIVpgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469136"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469136"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:09 -0700
X-CSE-ConnectionGUID: /S8jRWbMQmy0aB/OaSzn6g==
X-CSE-MsgGUID: Rf5PO/EdRmm+2Mr5ridiig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540890"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 3/7] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Fri,  9 Aug 2024 13:54:27 +0800
Message-Id: <20240809055431.36513-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use a global static identity domain. Reserve a static domain ID
for it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 723ea9f3f501..c019fb3b3e78 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
-- 
2.34.1

