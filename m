Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33E1799F
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677954; cv=none; b=AICOu2xQWs39VPg4W9Jujjvy7kImqzXp1Xwd5agvDWIJLMII+GhqQ3yy8o65XKzEDKUOkSUn71rxAnX7K6SoSyq/jf8ZF105F6JRNHH96BYGLYaWKm257vKDsAUmqbOSLzKPT6Xoxxn/sJylb84VY6fswAZE08aZvWxeMb1vf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677954; c=relaxed/simple;
	bh=MwNJmVDmBnILd7EH/BINS6Na4Ir3Qf1Ci9y4IEi1n98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpfCIugfuBecI5auZAO7DI7yZHtuiS09yxgXQXOYPU4kQ1ZLG+yu2IJ2HF0gMXY5ntfh3fdNbA0fPopjpDyT4La5x+2JxdeOvIZJSbzFe8UNLLzg4AQpUX98FIzQPKgOK3Fqmv31g5wTWYSdtV4kvkaf0qSOOpJdUFidhyyiHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSk8f5yq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSk8f5yq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677952; x=1771213952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwNJmVDmBnILd7EH/BINS6Na4Ir3Qf1Ci9y4IEi1n98=;
  b=GSk8f5yq6mTIzrE9k4bddL3SHSRrPuAL08KmR0rwxmeWBJmljwhhmKxX
   fLF6kCKsn4ZwVwkflciJAQcsrEV3JDaOVkPKJ1WNJTjilu64nwPsFy/vT
   2nLiPPsGOEql9fZBMmkxBqznNmYcYTR5T4F/FBXHJd0uQmO2XEv5ooyBc
   79ehHTsz7v8rd8chvaRXK8AZzKD2Vfnk5SDAck4/P7XKriTa6tPUOCzAG
   g9VDVGw2Xr/hI6DrXdDAZJgaNlarRO1islL54IIC0/IONdJ4fQAKwrg2t
   bdaPZDOTbjMBxo3tpJuDkQuuK2twwQd5Z1Gjvlos+PxKObU0MfOWoFNhr
   Q==;
X-CSE-ConnectionGUID: 2QqK43bHQVy0MmotFm11Rg==
X-CSE-MsgGUID: wucUzfgCRWyPRSjXSX1fzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919295"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919295"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:30 -0800
X-CSE-ConnectionGUID: XaygsWa3T6SC+wjGvvOXNQ==
X-CSE-MsgGUID: Wkc+1htmT5miwlar7C+drQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544658"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:31 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 01/13] iommu: Add iommu_attach_device_pasid_handle()
Date: Sat, 15 Feb 2025 19:52:16 -0800
Message-Id: <20250216035228.23831-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
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
index c3bf8e131a8e..95830f670e18 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3423,9 +3423,9 @@ static void *iommu_make_pasid_entry(struct iommu_domain *domain,
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
@@ -3476,7 +3476,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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

