Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFA15FA8A
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960976; cv=none; b=G41QqmFWxKjxTthPTq3nlV9G9Vzcox/DnMSjm0bJ977w0Meya37Wgf1M+HuQtfnqcZmMlOuYkyfz9neuwpPTJFW2ZZ537eQjHrTmT1yY81FXrRh3OI2SbjuQEn3wcZ6pWHIIODl7uq9KMqqbVTCqpTJB0SsuQm2DrJ4bysSaFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960976; c=relaxed/simple;
	bh=xf05GvXEO+I215J3GQWK9zqCkzSYPhbVb/+Tz/JkYCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndpwMs/8BTbk/sxW98MFtHi/ERq4vUPJcIIFX8xI7IwWz7bVj+0VdoxO4C3aMEcrptQMe/8azMFeqreVKFQco3jgrCkRZZPJkgL3yroCSy0ibVYuW7fpoLTRVjaaOwhbjpdsbo+KSFbKWnib/aLOoDyqcuF4AVBbE9GGNu+m7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bgh5+Uq3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bgh5+Uq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960975; x=1748496975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xf05GvXEO+I215J3GQWK9zqCkzSYPhbVb/+Tz/JkYCQ=;
  b=Bgh5+Uq3rfQzo4IujodLM5ApJH6QiUAFgY81W0u2T+C5eQIRSOKgeojc
   ni4exGqvQDfPFKPX5YAZP7MYcdTqgavCsAcRhkCBwwLexYXaNWcz94lGP
   BhYpxVJyn+hpdgjhw59L/ybaRVTzq1tF1hS0UOthCi4TCCRmzWKC2BHM8
   Y+x8M86GZy6EnDx3MiU7z1iqYcvy6fyI2Gfmr2gDT3KU3ovu0hQzHf5XM
   lT2Y7DZ5IYtcER1TM52yhv08dNUhyUmJF3lgOlBCF3D5qbLHGjKFL1enO
   82PPxini4UQde6xLIDycvWpOyYMyz8jXRUhvIiHagN9NTiNUPUp5FT54B
   g==;
X-CSE-ConnectionGUID: dIfBYav+SnSrSbM/tfGt+A==
X-CSE-MsgGUID: uN8RkgHbTyS+rC3HV5wmPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568826"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:25 -0700
X-CSE-ConnectionGUID: WkFEj6PrQYqnAeoLtI1GfQ==
X-CSE-MsgGUID: eszOZrvySa+kJnN3MKgnnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257546"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:20 -0700
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
Subject: [PATCH 05/20] iommu: Add iommu_paging_domain_alloc() interface
Date: Wed, 29 May 2024 13:32:35 +0800
Message-Id: <20240529053250.91284-6-baolu.lu@linux.intel.com>
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

Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
bus. The iommu subsystem no longer relies on bus for operations. So the
bus parameter in iommu_domain_alloc() is no longer relevant.

Add a new interface named iommu_paging_domain_alloc(), which explicitly
indicates the allocation of a paging domain for DMA managed by a kernel
driver. The new interface takes a device pointer as its parameter, that
better aligns with the current iommu subsystem.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ++++++
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6648b2415474..16401de7802d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -781,6 +781,7 @@ extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
 struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags);
+struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1092,6 +1093,11 @@ static inline struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1416892ef8e..7df4a021b040 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2016,6 +2016,10 @@ static int __iommu_domain_alloc_dev(struct device *dev, void *data)
 	return 0;
 }
 
+/*
+ * The iommu ops in bus has been retired. Do not use this interface in
+ * new drivers.
+ */
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
 	const struct iommu_ops *ops = NULL;
@@ -2074,6 +2078,22 @@ struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags)
 }
 EXPORT_SYMBOL_GPL(iommu_user_domain_alloc);
 
+/**
+ * iommu_paging_domain_alloc() - Allocate a paging domain
+ * @dev: device for which the domain is allocated
+ *
+ * Allocate a paging domain which will be managed by a kernel driver. Return
+ * allocated domain if successful, or a ERR pointer for failure.
+ */
+struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
+{
+	if (!dev_has_iommu(dev))
+		return ERR_PTR(-ENODEV);
+
+	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
+}
+EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
-- 
2.34.1

