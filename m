Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CE2064F8
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907975; cv=none; b=hSUTncqXc9EeEJ0tCN7Fc1/fqSSQoANcXoo2uQfgHPCqVNP4kXGrdNbb5a0mzzsbvIlY/KNbuf/x4+MgjJ87CVwZMuJIzENbRQkp3tSKWBYWPkDXHPMH4j9ptfEvFnUmxvSZAlnSHhnwwZeLYZko7mMqfuLQQo89iMZMPpvtKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907975; c=relaxed/simple;
	bh=xFPrtyXkYT63Q3iV+uXRCl2QqkXdlVNS1B7jsbIWhVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6CoohWFKOJ77P0FOTCZpz+h6rcY8wEB6vSkgIdnQE1soXiO584/3rcP8hLUk00y9RtLHIoz7xdDaZmQaNWXilmDKghKFnbn7Dy7a3QkKzqZco/mIBK45hahLzgW6ITm0U03iAZKOurknThpZ763cDSSwO9iACawC0jwX03OFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqZpa9e5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqZpa9e5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907973; x=1762443973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFPrtyXkYT63Q3iV+uXRCl2QqkXdlVNS1B7jsbIWhVU=;
  b=gqZpa9e5NbB5XjmNupuL9Ij50Y0YXukg2P3PlUmevm/pVEzHsh5zxPtH
   DIlKF06eCDqwlEeRsDRmPtS1O854YB8IER8yGUqtQ/6J9fi7R7OZymGEy
   OZIpbkYQcZ/wMIK6d9xAf+LBQ3VZztgz/e14G/1GhUU3olPyqlFfn9E+p
   VZ2mh1hnQXMXlFXV3WaUoVYWuDlgwAOxoDIT34U+gGP9ItiKBqU1JxvbC
   v3mpF7rMYmNZi0DV1geqkg82nCW+8AC48Zr84ttVWgCQ3WIrhrUXENzkg
   PpcUxaKjfaTcpyDyYxWLv2kA6k163b4pn54OePwmDsIgIuj1psfldLpLP
   w==;
X-CSE-ConnectionGUID: vDXmALQpTLyz94CCvaEdlg==
X-CSE-MsgGUID: eGqZFOLtQh22iDEZ8Ht7MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48174243"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48174243"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:46:10 -0800
X-CSE-ConnectionGUID: p2pV8O81RamnA+KI0/0DfQ==
X-CSE-MsgGUID: OsBReICiRwC1UIoXEsHQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89468213"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 07:46:10 -0800
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
	willy@infradead.org
Subject: [PATCH v5 05/13] iommu/vt-d: Consolidate the struct dev_pasid_info add/remove
Date: Wed,  6 Nov 2024 07:45:58 -0800
Message-Id: <20241106154606.9564-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106154606.9564-1-yi.l.liu@intel.com>
References: <20241106154606.9564-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_add_dev_pasid() and domain_remove_dev_pasid() are added to consolidate
the adding/removing of the struct dev_pasid_info. Besides, it includes the cache
tag assign/unassign as well.

This also prepares for adding domain replacement for pasid. The set_dev_pasid
callbacks need to deal with the dev_pasid_info for both old and new domain.
These two helpers make the life easier.

intel_iommu_set_dev_pasid() and intel_svm_set_dev_pasid() are updated to use
the helpers.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 91 +++++++++++++++++++++++++------------
 drivers/iommu/intel/iommu.h |  6 +++
 drivers/iommu/intel/svm.c   | 28 +++---------
 3 files changed, 74 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 402ba1058794..a1e9dbca6561 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4038,8 +4038,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+void domain_remove_dev_pasid(struct iommu_domain *domain,
+			     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4047,10 +4047,12 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	if (!domain)
+		return;
+
+	/* Identity domain has no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
-	}
 
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
@@ -4068,7 +4070,52 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
-	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *domain)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
+	domain_remove_dev_pasid(domain, dev, pasid);
+}
+
+struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	unsigned long flags;
+	int ret;
+
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return ERR_PTR(-ENOMEM);
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret)
+		goto out_free;
+
+	ret = cache_tag_assign_domain(dmar_domain, dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return dev_pasid;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ERR_PTR(ret);
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
@@ -4079,7 +4126,6 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
-	unsigned long flags;
 	int ret;
 
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
@@ -4095,17 +4141,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
-	if (!dev_pasid)
-		return -ENOMEM;
-
-	ret = domain_attach_iommu(dmar_domain, iommu);
-	if (ret)
-		goto out_free;
-
-	ret = cache_tag_assign_domain(dmar_domain, dev, pasid);
-	if (ret)
-		goto out_detach_iommu;
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
 
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
@@ -4114,24 +4152,17 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_unassign_tag;
+		goto out_remove_dev_pasid;
 
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	domain_remove_dev_pasid(old, dev, pasid);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
-out_unassign_tag:
-	cache_tag_unassign_domain(dmar_domain, dev, pasid);
-out_detach_iommu:
-	domain_detach_iommu(dmar_domain, iommu);
-out_free:
-	kfree(dev_pasid);
+
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b3912633ce25..df0261e03fad 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1228,6 +1228,12 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
 
+struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid);
+void domain_remove_dev_pasid(struct iommu_domain *domain,
+			     struct device *dev, ioasid_t pasid);
+
 int dmar_ir_support(void);
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4a2bd65614ad..6c0685ea8466 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -115,43 +115,29 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
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

