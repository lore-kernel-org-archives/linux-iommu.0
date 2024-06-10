Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB56BFA3
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010018; cv=none; b=YANcknIFpTYrbwvfrMctvJlvwSO++2MzT+NE39uWwUbpB1SEA3HiuQXWFxakusnTjBFUKG+XiS1+7dp4q+is0jPlN9WOWcRWhlFbXmRnQUb523UVoSxEYtk/yoXXkuxfOrTmbl8nyBgzJmXZz1QRwA+4Uvm0nFWnZN0P3YfyUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010018; c=relaxed/simple;
	bh=lXwMWVF8JncqaJ2IdYqMFQdlvzTBWJiMYc2r7xARixg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4CyiibvalCeY1124el2yUymkFg5jeDdEwtO2hFBA1z/ZSE5qxIE9icGH3jZwXSMhxVwwEuReHm7Dh9710N22HumlY7dnOIUXnITSsKK3YfdwqQCBUo+RCCQwgnuBv2qu7QJryCHdwqAVXSv+EwZCoxiQiRyawKdu+H1E8+7sGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nerIPGJa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nerIPGJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718010017; x=1749546017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lXwMWVF8JncqaJ2IdYqMFQdlvzTBWJiMYc2r7xARixg=;
  b=nerIPGJau0+FdnVoTAXh5xZRq3kGzgDFu9zN8+qMENbHhYaeilCPF3HL
   azhrdypA9v3mcsTwaXWpUsvvOIZFrwC5nxRGqV6KIYHjgAflVXwD9v++l
   jHb4TBc3sptsAT+q92Z8Rqlu1VS9k/Xakj2sNPs24CwF9soyFO4HFIYP9
   zxIgeIinUt1eGthf6Av2UwtV3DiWBRkryST1NQgwp1UKTff9DcvDPHeli
   jjG+mbvhfxH9EHOiaZi+yzjQBHbc4OjutDtEBe0yHIKICukKx5dfmNDdY
   M6YoG3vD6dRyIK0vTrauNvH5tfRI1UPJev7vP4gdkAm+417wnCPwdxNk3
   w==;
X-CSE-ConnectionGUID: uJ8wFp67QdWfNB9/ckdYrg==
X-CSE-MsgGUID: UvBk7vVRSuamZNmSZt57LA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17582052"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17582052"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:00:16 -0700
X-CSE-ConnectionGUID: zigQTUGjQ5u81Ly6CGYyQw==
X-CSE-MsgGUID: dHXKB8LTTX6N7SOxiQc5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43433312"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 02:00:02 -0700
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
Subject: [PATCH v3 21/21] iommu: Remove iommu_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:55 +0800
Message-Id: <20240610085555.88197-22-baolu.lu@linux.intel.com>
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

The iommu_domain_alloc() interface is no longer used in the tree anymore.
Remove it to avoid dead code.

There is increasing demand for supporting multiple IOMMU drivers, and this
is the last bus-based thing standing in the way of that.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ------
 drivers/iommu/iommu.c | 36 ------------------------------------
 2 files changed, 42 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba0b27afc256..bff6e7e81fa3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -778,7 +778,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 extern int bus_iommu_probe(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
-extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
 struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
@@ -1076,11 +1075,6 @@ static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
-static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
-{
-	return NULL;
-}
-
 static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c7ebdf96e4bc..8212fed27e18 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1975,42 +1975,6 @@ __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
 	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
 }
 
-static int __iommu_domain_alloc_dev(struct device *dev, void *data)
-{
-	const struct iommu_ops **ops = data;
-
-	if (!dev_has_iommu(dev))
-		return 0;
-
-	if (WARN_ONCE(*ops && *ops != dev_iommu_ops(dev),
-		      "Multiple IOMMU drivers present for bus %s, which the public IOMMU API can't fully support yet. You will still need to disable one or more for this to work, sorry!\n",
-		      dev_bus_name(dev)))
-		return -EBUSY;
-
-	*ops = dev_iommu_ops(dev);
-	return 0;
-}
-
-/*
- * The iommu ops in bus has been retired. Do not use this interface in
- * new drivers.
- */
-struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
-{
-	const struct iommu_ops *ops = NULL;
-	int err = bus_for_each_dev(bus, NULL, &ops, __iommu_domain_alloc_dev);
-	struct iommu_domain *domain;
-
-	if (err || !ops)
-		return NULL;
-
-	domain = __iommu_domain_alloc(ops, NULL, IOMMU_DOMAIN_UNMANAGED);
-	if (IS_ERR(domain))
-		return NULL;
-	return domain;
-}
-EXPORT_SYMBOL_GPL(iommu_domain_alloc);
-
 /**
  * iommu_paging_domain_alloc() - Allocate a paging domain
  * @dev: device for which the domain is allocated
-- 
2.34.1

