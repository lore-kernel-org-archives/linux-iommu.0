Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D3757F5
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009914; cv=none; b=klM1k2GOaiqS4deH7Oyr/+P+5Yza8uI9fdXoMwPdy/kAvou0SmS7e12Dy1/HBckvirZQuJNizOxibmldMqq3G3Pxf3xDfm1BUxBVWK/Y8Xl8ANROYRLrv9h4dtQoeFNAukDPoCnTw2WPFtJu7Ep16ksBdVX+n36ggE+OYspyT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009914; c=relaxed/simple;
	bh=oIx+E7QQWhC/YdRYd5TEuDpoPJpROL8sRrH8nFOhCTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBX6wpz3qmvgookJ4mxsmFB3Z/zC4jV9b99iFuDDJhEslEp/vmBYlRVOHC2QldiHch1CUtZp/yZ11Xms+pojNa+weKdOcYCwSLTUSIFOt1Ediuh31H5MeP5lCqsZksEuheknK74GcxUHg1MCEFzXyP5EaWDEpJ5qjxfk4xhzJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1CfF+fO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1CfF+fO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009912; x=1749545912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oIx+E7QQWhC/YdRYd5TEuDpoPJpROL8sRrH8nFOhCTw=;
  b=V1CfF+fO+clMJL4q7ejfy2Sg/ONrUj4OC8CfkgJaNQYI6ByC2L+vceRK
   r/w17WlWNy0naex/JKD43VV85jdHsN1av4JX2yeM1r20C5T9JHtyBLioI
   R63jLtGZLuJrV1cgLHjo0hGWZDZ6Gl8rm0itfj4BlvpXxcpvBl2gvOpa1
   9/3JgNHsAv0q5ouLUb7iqCpVazlyRR2cDZr9659vq/GFO0h+fZsIXP85R
   FcfN+drKqTuslzPn3zrhMYGt1TvRyUQT4Adp9Vr80QW1Qa/KnOvFtNHsr
   kdt/C7zrI8h/YstkknazmeQOFfMdi/u7Xmq3UAf+mBHtWdYW4thrpj/Qw
   g==;
X-CSE-ConnectionGUID: e+tkygbpRZ2y/ZDvMFS1+g==
X-CSE-MsgGUID: 6cWGqTGkRAaRd4YaDpIkpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581554"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:32 -0700
X-CSE-ConnectionGUID: whhgEdvaSOaveMThVGT9OA==
X-CSE-MsgGUID: 6IyxwBSmQmmkJc1+Qq2yEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432439"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:28 -0700
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
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 03/21] vfio/type1: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:37 +0800
Message-Id: <20240610085555.88197-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace iommu_domain_alloc() with iommu_paging_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3a0218171cfa..0960699e7554 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2135,7 +2135,7 @@ static int vfio_iommu_domain_alloc(struct device *dev, void *data)
 {
 	struct iommu_domain **domain = data;
 
-	*domain = iommu_domain_alloc(dev->bus);
+	*domain = iommu_paging_domain_alloc(dev);
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

