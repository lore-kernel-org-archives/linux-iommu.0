Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9913E02D
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466051; cv=none; b=NYGAzKhCxnGLO9YA/nugGV9bSWcpzeZtlWI9njGqnQfdV+WMW3TY0F9aRlb/LykuUc+HxZANfcA5gXQA3bmPY2XF1Ym5KP7gwyf84RnXdMgTELHOywLMCudCMgfwXLdOT6Aj6fGNPWBRIsB4QVwJCpOkVd4G+iBPs943fC+xwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466051; c=relaxed/simple;
	bh=Ku98pK7UgGN8K4Vqi8YCUxqt/MmWDBRD7GnhYQUhVEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5QhcMzvtj81WWX7zrGwaGcXnkyFdexwCmNqO9si9JmpwQ8E0gG97NbwqOwHfg05wnWMvsEbBaMb7MmplDgf0MvMmdyKpPw4cr9xtYZYX/7hlEjKvGKoaFQtzpSAxrOc3JiaN/mo+dj3jqJ4Xrt8pw/jQUAl/yBEVPnqUjmDFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tu0ikfkQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tu0ikfkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466049; x=1749002049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ku98pK7UgGN8K4Vqi8YCUxqt/MmWDBRD7GnhYQUhVEg=;
  b=Tu0ikfkQj4Vspfm9oTzKBauZYeBpaWgaTBVCjKiJpUWr4nKIhDgir9Mk
   xXn5nzQVqn6Yx8mLhxdnFx4hud9Kj7FUq3OY82T5SKSgyHS+gCVX1x3F/
   wWIfjuiUFoX/1SqBty6VTVXG+NZAP40xAxRlZvO3PNFMVFZbvRoxE0ZeI
   DUSUEqCw+VzCB7NMem9zu5rCLm1hFBP6XhoJkhACsxv5rGRm5OL4q5ZOP
   eGSprL73B7U16TFK9nwA1vBZXOz2FRWy/D3CUosxgxeLaPEY1kdZUwh8m
   xFOt8rpqa22oJ/g5X8CK4hDDrlxpCWsT15UuK4HxJ1fiusP7MeLLMSAQw
   A==;
X-CSE-ConnectionGUID: xKKjj8IFSfayMQH8tg7X2w==
X-CSE-MsgGUID: ZCtz9i/rSHOJynaB0K/r7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384883"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:09 -0700
X-CSE-ConnectionGUID: 3OptiiBcRb6wogYJZJBjmw==
X-CSE-MsgGUID: 7UBZgbTGTcmFgOeAWR9vHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661800"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:04 -0700
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
Subject: [PATCH v2 03/22] vfio/type1: Use iommu_user_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:15 +0800
Message-Id: <20240604015134.164206-4-baolu.lu@linux.intel.com>
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
 drivers/vfio/vfio_iommu_type1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3a0218171cfa..1d553f7f7c26 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2135,7 +2135,7 @@ static int vfio_iommu_domain_alloc(struct device *dev, void *data)
 {
 	struct iommu_domain **domain = data;
 
-	*domain = iommu_domain_alloc(dev->bus);
+	*domain = iommu_user_domain_alloc(dev, 0);
 	return 1; /* Don't iterate */
 }
 
@@ -2192,11 +2192,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * us a representative device for the IOMMU API call. We don't actually
 	 * want to iterate beyond the first device (if any).
 	 */
-	ret = -EIO;
 	iommu_group_for_each_dev(iommu_group, &domain->domain,
 				 vfio_iommu_domain_alloc);
-	if (!domain->domain)
+	if (IS_ERR(domain->domain)) {
+		ret = PTR_ERR(domain->domain);
 		goto out_free_domain;
+	}
 
 	if (iommu->nesting) {
 		ret = iommu_enable_nesting(domain->domain);
-- 
2.34.1

