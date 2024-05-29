Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C015DBC6
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960972; cv=none; b=t8Bs7dktFJSP6GQ5WYRPKSA9LqXcX7zYApsU75nvNjtpAQg+z/X6i+4MOtcLgYNiS5fe52BRlbZUnOQtMimCJ18XMaQOJGXv2bNexMPB3a0JPmUnLqBMBLZ8JlmACOiHAy8ijsOr5T7SA/3FtNpWD3pFRfo+QRJxG7a2faHOgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960972; c=relaxed/simple;
	bh=WX+m07wt3DtPAOjU2K7TAng/knQriugPLDZHnttGpjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSQzlXyxiaIH1vH0CuUP3yyF82fUz9ibtqIUEG1weAGXr7LiSrwssbCNx8HCcHJz1ToGxTtnergNZLEy898fAx+NZ3pFJRUG5y1EEufnSI5UOyFWIBzJ6AnnaeskGudYH/3vl/2QKKA7TPKVqjHqWwfDsCSqJ7OjKsFkDV3OUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mh8GX1bC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mh8GX1bC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960971; x=1748496971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WX+m07wt3DtPAOjU2K7TAng/knQriugPLDZHnttGpjU=;
  b=mh8GX1bCitYYjtXpC7+RQIaGZuxxXwK2Sf8pAJ/tTYQEXdFrVE9k7O0y
   HSOwZBdmwv9dDU337ULLOqc60uIIHTd3dTrGso4iyJPqkBnrCwQXeDxcR
   E4CePT+Qp/N1hK8k/ZtOIhT5leRr5s9zEw8LlQCwEyhfK/XMN04NXLno4
   zy7/ehoGTADsgYJvG2fr7Wa9uDkLOBtHsAliSDca+Zh/9NJkM13gsUBxb
   a06xs3WAVd8XSnSwjylpzynijphHqZGHs1+a5yBstZzWFUwrJxDGKyy3Q
   205iTFrokPlcmMWZoQ0qqGluzmlnxQNJB978mtpjWcIzJxYy5bBpKxibj
   g==;
X-CSE-ConnectionGUID: qjn4ppNNSg6sMx21Ar7FTA==
X-CSE-MsgGUID: ZCqj9EoKQbaSuJwb8zDr3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568750"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568750"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:06 -0700
X-CSE-ConnectionGUID: ff5BmhNMSBOq/6aqKuHlTw==
X-CSE-MsgGUID: VRTTk5mGQciwJeBPrShRDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257451"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:01 -0700
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
Subject: [PATCH 01/20] iommu: Add iommu_user_domain_alloc() interface
Date: Wed, 29 May 2024 13:32:31 +0800
Message-Id: <20240529053250.91284-2-baolu.lu@linux.intel.com>
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

Commit <909f4abd1097> ("iommu: Add new iommu op to create domains owned
by userspace") added a dedicated iommu op to allocate a user domain.
While IOMMUFD has already made use of this callback, other frameworks
like vfio/type1 and vDPA still use the paging domain allocation interface.

Add a new interface named iommu_user_domain_alloc(), which indicates the
allocation of a domain for device DMA managed by user space driver. All
device passthrough frameworks could use this interface for their domain
allocation.

Although it is expected that all iommu drivers could implement their own
domain_alloc_user ops, most drivers haven't implemented it yet. Rollback
to the paging domain allocation interface if the iommu driver hasn't
implemented this op yet.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ++++++
 drivers/iommu/iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..6648b2415474 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -780,6 +780,7 @@ extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
+struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1086,6 +1087,11 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..f1416892ef8e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2032,6 +2032,48 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
+/**
+ * iommu_user_domain_alloc() - Allocate a user domain
+ * @dev: device for which the domain is allocated
+ * @flags: iommufd_hwpt_alloc_flags defined in uapi/linux/iommufd.h
+ *
+ * Allocate a user domain which will be managed by a userspace driver. Return
+ * allocated domain if successful, or a ERR pointer for failure.
+ */
+struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags)
+{
+	struct iommu_domain *domain;
+	const struct iommu_ops *ops;
+
+	if (!dev_has_iommu(dev))
+		return ERR_PTR(-ENODEV);
+
+	ops = dev_iommu_ops(dev);
+	if (ops->domain_alloc_user) {
+		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+		if (IS_ERR(domain))
+			return domain;
+
+		domain->type = IOMMU_DOMAIN_UNMANAGED;
+		domain->owner = ops;
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
+		domain->ops = ops->default_domain_ops;
+
+		return domain;
+	}
+
+	/*
+	 * The iommu driver doesn't support domain_alloc_user callback.
+	 * Rollback to a UNMANAGED paging domain which doesn't support
+	 * the allocation flags.
+	 */
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return __iommu_domain_alloc(ops, dev, IOMMU_DOMAIN_UNMANAGED);
+}
+EXPORT_SYMBOL_GPL(iommu_user_domain_alloc);
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
-- 
2.34.1

