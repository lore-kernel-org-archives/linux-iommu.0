Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA715ECE2
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960974; cv=none; b=WsUdK4YseZ8NGdO8KhfI5dyg+SwMdLjJ1tH69W5KGkSJMjc56V+Wn1cFvhpS9H3hvzcXW2r5gf0wu3XRDtTWJYpfsZlUGuvG+jbj2aHS+n78SVZU9bwA1tONf7Xq8ZTe1NcWGGS5ZQG4IVnm5ckYXjQLJ7sX7y4AGtClvZbWsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960974; c=relaxed/simple;
	bh=i2g4o4FMSNI6vy56g2mVccrM+MuXNKNyXwoqmECaK9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCYayg2BzNde7TUHHktX7lSQ1CAxY71Pfs2BOsHik4wV8I8xq7RcEz3kO+nUwOyRBCORLWfXSOkV6ZXrCcH0o+vSPruxIjWd8oZe+5AK9M1OKfuOkU/INerfhEYoZbaozW5V5BhywrQDV93bGRmFaLwDEXjQC/hopLrlFyeQJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoHlT/xK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoHlT/xK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960973; x=1748496973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2g4o4FMSNI6vy56g2mVccrM+MuXNKNyXwoqmECaK9M=;
  b=LoHlT/xKZsJ3n82UnMR7MhwE7kMuSLFeUf+MtzUztsBWfLLr6vC9Rajv
   KTzHFyJB1Z9KPW/ImITeJ77BokppLmQ+mlHyauBeGwKErN5qjizn4qDBL
   xqEXkrOsVTXsDWtBDu8fe7SG6JwJZzWzhKl6jsA+8Rl8YgHZ9QBuYHHJd
   syK3fFdNUWZUOYCdCV8GISmU5hcm3i9Cqc5v+NZ83GmEeLcLzzpvgM6kX
   HaDIIQsQEGYNSOf5Iw/Z0kqELG04NB2ibBKC0qmFJ81iYfZJzeoPLMCxI
   VgkCZ/SapkPN9Ah/jYs12Zw4PJWnCy9vWE4otZwfWDFOwVGccayAeM3zy
   Q==;
X-CSE-ConnectionGUID: /67yrUprT2SR8W83g8fWBw==
X-CSE-MsgGUID: IFg69XuBTSynY4yAOx+PKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568765"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:11 -0700
X-CSE-ConnectionGUID: ooEsLAqOTEq37Hrx3ZeYbQ==
X-CSE-MsgGUID: FAzliAhcS6u1szAMWmJLKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257473"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 02/20] iommufd: Use iommu_user_domain_alloc()
Date: Wed, 29 May 2024 13:32:32 +0800
Message-Id: <20240529053250.91284-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529053250.91284-1-baolu.lu@linux.intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace iommu_domain_alloc() with iommu_user_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..ada05fccb36a 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -127,21 +127,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt_paging->ioas = ioas;
 	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
-						      user_data);
-		if (IS_ERR(hwpt->domain)) {
-			rc = PTR_ERR(hwpt->domain);
-			hwpt->domain = NULL;
-			goto out_abort;
-		}
-		hwpt->domain->owner = ops;
-	} else {
-		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
-		if (!hwpt->domain) {
-			rc = -ENOMEM;
-			goto out_abort;
-		}
+	hwpt->domain = iommu_user_domain_alloc(idev->dev, flags);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
 	}
 
 	/*
-- 
2.34.1

