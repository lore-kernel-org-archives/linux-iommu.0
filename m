Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9021505D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570039; cv=none; b=hipwJUSLb4wOjid40vLN3fCEKD/RnkhyC0H4lxzdA28gy9mQxc3MaeEKIVYyvYsIyiMLiXMCjEU6/pssNyjTto4QpGUiqyIr5mNWd8zqDWd5q8d2jkOrCaECiWYXqjhOMCjQA/iWTQXVYTKL02zWP0Rh6qV/vTfuJQpXLmWo++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570039; c=relaxed/simple;
	bh=TRI3PEKJ0/ovaEaPG3IyI3IyN07s7eUftu2BT5HIGZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBzac09oR7vOOyPAuA8V5qrOfWbV63o96blyrbDFlI1G2OUBnWrtb4H0n2bbyBtuMsAGRZxSPUj+Pr/wyfdedqBK/2FRMbdSsp2F0c/3zC5KIiJAqpjYBEZYL1+nTmR/DxLypJEO4P+FCVjB6B6Qrd/mHbLLwu00NYRtY9qDno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyAXDPPu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyAXDPPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570036; x=1772106036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TRI3PEKJ0/ovaEaPG3IyI3IyN07s7eUftu2BT5HIGZU=;
  b=NyAXDPPuuuB4ocUjUWX9V4fcD1HoR8xT8w2mwJ7EYp97d8CpyAxbH+3W
   WK3JWRbnKGpdjv0tbqnPlHecg5yCmcCg2G0r2QgWhErVtI+QBbVrob/G/
   Wm5glDTEPuPB7TJxCY2OPWin92SOqDU6hdFPEhLgEo5FjpXHjlX/xqj3e
   irhRs+AvfPFmw0uBwcrZfqcbHNwaQA2QBtmm1XQXVvc4NLi/HzF6Yfimf
   WrFjbRbIU5b0ftRUqBHveJlF8s0nWBjhrTPT4lwk4JyIx3SPLhqDQy5qy
   g2ZajrYeRYkN4V7LzRhHeBiPz1Ek/N09y2CSy2N4wgpamTC3a/jtglX5S
   Q==;
X-CSE-ConnectionGUID: a4SfjBhHTiq1Tv37PF38JQ==
X-CSE-MsgGUID: mXSKYjNzSsWFnZW0UmoDPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52827080"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52827080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:40:34 -0800
X-CSE-ConnectionGUID: BfAeuw3pRs+oqnrtyA7+RA==
X-CSE-MsgGUID: lqxuM7ZiQ2umTxd6OPBDMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171574"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2025 03:40:35 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Date: Wed, 26 Feb 2025 03:40:21 -0800
Message-Id: <20250226114032.4591-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226114032.4591-1-yi.l.liu@intel.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing iommu_attach_device_pasid() function allows both a valid
handle and a NULL handle, which is not consistent with the RID path where
iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
it, this adds iommu_attach_device_pasid_handle() to cover the case with
valid handle, while let the iommu_attach_device_pasid() only deals with
the case with NULL handle.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/dma/idxd/init.c   |  2 +-
 drivers/iommu/iommu-sva.c | 10 ++++++----
 drivers/iommu/iommu.c     |  8 ++++----
 include/linux/iommu.h     | 34 +++++++++++++++++++++++++++++-----
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b946f78f85e1..d11a763ef124 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -593,7 +593,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
 	 * DMA domain is owned by the driver, it should support all valid
 	 * types such as DMA-FQ, identity, etc.
 	 */
-	ret = iommu_attach_device_pasid(domain, dev, pasid, NULL);
+	ret = iommu_attach_device_pasid(domain, dev, pasid);
 	if (ret) {
 		dev_err(dev, "failed to attach device pasid %d, domain type %d",
 			pasid, domain->type);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 503c5d23c1ea..09d676ddf15e 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -115,8 +115,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
-						&handle->handle);
+		ret = iommu_attach_device_pasid_handle(domain, dev,
+						       iommu_mm->pasid,
+						       &handle->handle);
 		if (!ret) {
 			domain->users++;
 			goto out;
@@ -130,8 +131,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_handle;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
-					&handle->handle);
+	ret = iommu_attach_device_pasid_handle(domain, dev,
+					       iommu_mm->pasid,
+					       &handle->handle);
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 73a3b20b2ef9..f6dbb60ef948 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3354,9 +3354,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
  *
  * Return: 0 on success, or an error.
  */
-int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid,
-			      struct iommu_attach_handle *handle)
+int __iommu_attach_device_pasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid,
+				struct iommu_attach_handle *handle)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
@@ -3415,7 +3415,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	mutex_unlock(&group->mutex);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
+EXPORT_SYMBOL_GPL(__iommu_attach_device_pasid);
 
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38c65e92ecd0..d795de7bad8f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1122,9 +1122,24 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 int iommu_device_claim_dma_owner(struct device *dev, void *owner);
 void iommu_device_release_dma_owner(struct device *dev);
 
-int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid,
-			      struct iommu_attach_handle *handle);
+int __iommu_attach_device_pasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid,
+				struct iommu_attach_handle *handle);
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);
+}
+
+static inline int
+iommu_attach_device_pasid_handle(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t pasid,
+				 struct iommu_attach_handle *handle)
+{
+	return __iommu_attach_device_pasid(domain, dev, pasid, handle);
+}
+
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
 ioasid_t iommu_alloc_global_pasid(struct device *dev);
@@ -1139,6 +1154,8 @@ struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
 struct iommu_dirty_bitmap {};
 struct iommu_dirty_ops {};
+struct iommu_attach_handle {};
+
 
 static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
@@ -1451,8 +1468,15 @@ static inline int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 }
 
 static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
-					    struct device *dev, ioasid_t pasid,
-					    struct iommu_attach_handle *handle)
+					    struct device *dev, ioasid_t pasid)
+{
+	return -ENODEV;
+}
+
+static inline int
+iommu_attach_device_pasid_handle(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t pasid,
+				 struct iommu_attach_handle *handle)
 {
 	return -ENODEV;
 }
-- 
2.34.1

