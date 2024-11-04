Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DC2D05E
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726336; cv=none; b=uT7fSmeFUmnhqi8C9rmW+5dm9TurN6Khi2l6J+QbmTAVi9wtpCHQi1XhP350Sf8K1PmaU+aPgGZ57uS3bJY1j4qfhkA447O7guv07M9lry51loNpc6kAXsVpIRloL/Wl27eWTZXkNv1CtdUEqyUyu3yXJRAjGKN2TxpIOiogWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726336; c=relaxed/simple;
	bh=Dmr05mRaAdC7Bz59Vi6kWS9raQPNT9XV+Xyt7csrPTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9RV/O9xQEmMpQAEfdzzzIjtlJF4rpHv9CughKUA/j7agcJYn/EHfZQdPTh6DWIdCjY7VUfwp0kpov6j2zLDfIPI0xbhCKBAtfbhgP5B3Dcu9xspBTqSZCPe11cuJevd9uHh5AaL6K8o2Y69beP9Ox6UFceq5yCG9V5NDTX9Kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpLzv0ct; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpLzv0ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726335; x=1762262335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dmr05mRaAdC7Bz59Vi6kWS9raQPNT9XV+Xyt7csrPTg=;
  b=mpLzv0ct7ls1DPf6VUgAvBTExsZgXHtisJwOv8ctfw+krpz/J1iLV50z
   yL8BE48qDb4HEtnM74ZzCwDHmJiD6oMpQm24mqznxWGoTULbh4965qqfQ
   SpWzdxMG8ub5bMk0uaviZFd0mwG1SQF1Xxj3G76kSakRiyp2vcRZ3Verc
   y2QYLRI5d1SYnr/rQ9Gd8+A5AR0WCfuhwSknlwKzxz6dLPeTjtboEmmw3
   rFh+a5THwTcO2hTI8UXXSKmOQiABvdqUd6+2puOhFqucWum8CW+bSnyh1
   A/X9TZ4iyjc0RMCfrrVjBbo/X2jVKe8wbpjqh7YwGWNVT+MOInlb9qBQ9
   Q==;
X-CSE-ConnectionGUID: NrfGrcyBRY2j8KbO57OloA==
X-CSE-MsgGUID: 2dcs0tXGQ/uVZo3rlgjg0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41003762"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41003762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:18:55 -0800
X-CSE-ConnectionGUID: p9BXugeSTr6u6OrQJYsByA==
X-CSE-MsgGUID: mW8GoJzgQU2zc0VgM2Yx7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83999512"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 04 Nov 2024 05:18:54 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v4 09/13] iommu/vt-d: Consolidate the dev_pasid code in intel_svm_set_dev_pasid()
Date: Mon,  4 Nov 2024 05:18:38 -0800
Message-Id: <20241104131842.13303-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104131842.13303-1-yi.l.liu@intel.com>
References: <20241104131842.13303-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the domain_add_dev_pasid() and domain_remove_dev_pasid().

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c |  6 +++---
 drivers/iommu/intel/iommu.h |  6 ++++++
 drivers/iommu/intel/svm.c   | 28 +++++++---------------------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c5b07ccbe621..0e0e9eb5188a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4257,8 +4257,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void domain_remove_dev_pasid(struct iommu_domain *domain,
-				    struct device *dev, ioasid_t pasid)
+void domain_remove_dev_pasid(struct iommu_domain *domain,
+			     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4302,7 +4302,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_remove_dev_pasid(domain, dev, pasid);
 }
 
-static struct dev_pasid_info *
+struct dev_pasid_info *
 domain_add_dev_pasid(struct iommu_domain *domain,
 		     struct device *dev, ioasid_t pasid)
 {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 009f518722e0..8e7ffb421ac4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1232,6 +1232,12 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 void domain_update_iommu_cap(struct dmar_domain *domain);
 
+struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid);
+void domain_remove_dev_pasid(struct iommu_domain *domain,
+			     struct device *dev, ioasid_t pasid);
+
 int dmar_ir_support(void);
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3b5e3da24f19..925afca7529e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -201,43 +201,29 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct dev_pasid_info *dev_pasid;
 	unsigned long sflags;
-	unsigned long flags;
 	int ret = 0;
 
-	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
-	if (!dev_pasid)
-		return -ENOMEM;
-
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-
-	ret = cache_tag_assign_domain(to_dmar_domain(domain), dev, pasid);
-	if (ret)
-		goto free_dev_pasid;
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
-		goto unassign_tag;
+		goto out_remove_dev_pasid;
 
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	domain_remove_dev_pasid(old, dev, pasid);
 
 	return 0;
 
-unassign_tag:
-	cache_tag_unassign_domain(to_dmar_domain(domain), dev, pasid);
-free_dev_pasid:
-	kfree(dev_pasid);
-
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
-- 
2.34.1

