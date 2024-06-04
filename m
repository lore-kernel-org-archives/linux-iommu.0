Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BC13DB83
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466045; cv=none; b=DCb04MsAnw+UFiYr3ZaFMSEMrvgimB6K0KbhCz+nOZgMJymPJmqTLynoRyQpXuvEf0d3exOyE40vU1W3og3F1wBJ8HBr/FheEwdxXBjIRah3WYPjRkmwUMZIaegR35ODvlJWnlCVMzsSH2BvU4/a3B6w+d3PAh1FAyWR6ggRHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466045; c=relaxed/simple;
	bh=i2g4o4FMSNI6vy56g2mVccrM+MuXNKNyXwoqmECaK9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEC2yR72Z4SzLDLe8KsHy2tZ13IiyYt4rHDQHDXbSJ0outr+UQi7A3KmzOtpzuoV+onTYik9sOcrdh1culjQo4UL68DDcwP33AOqAHs8/Ixb1FyAsJSCb9M5Sfs7L5OjeYVCipjhREi7oa0IaPkSe2D2nu0t98s2OZ3iTNFF4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGomGvjh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGomGvjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466044; x=1749002044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2g4o4FMSNI6vy56g2mVccrM+MuXNKNyXwoqmECaK9M=;
  b=MGomGvjh19dTkPR0w1aBpGbXedA+oPSkuq190ZKphcsIsv7LtWHsbPZg
   CrbBz91rhpz2nCsFCd9MJBd8AfOhkQZOxFtZ6cFBh7xvFSBnx6+UkL5m8
   Ygifn6WgLQ7EyDVUrXtmnVLkanpi8h5nRpw5KvEQYi3WclSbzuxkj/4oS
   x0sEMDl0jjIl2XYdb2RSdvbOY72jCGTn29vSaDdpT3t0nBi49j2/7COVL
   JcVhHTi4Xd9hOIi/H/HUUk0s7AjjRpuxgXEsbyCltfaUd6WDF0YFP3vFf
   UMU1fenTMFsbzJiqYoZhk73i8Dh/g7J9wN8KsPWc6/X7JYrh1KNxF3pW9
   g==;
X-CSE-ConnectionGUID: BR2IAx86ROOKjFKFQ7WrLg==
X-CSE-MsgGUID: WqrzZXtfRu2rsk1OrxoNbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384862"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384862"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:04 -0700
X-CSE-ConnectionGUID: cJdjhM31QJCIcg5kz7jpwA==
X-CSE-MsgGUID: PJKNfxZORvC21A1XdJMlrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661791"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:53:59 -0700
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
Subject: [PATCH v2 02/22] iommufd: Use iommu_user_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:14 +0800
Message-Id: <20240604015134.164206-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
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

