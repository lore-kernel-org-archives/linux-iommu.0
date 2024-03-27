Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90B12D74F
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544082; cv=none; b=MuaMKBa5hAAxsWNwvzZ2JDG1oPmRDd8AB6xTHpezIt3sTfSfjpo2sh6hboWxnReky45YGM/Ws1LmkuokmsN4zcLNNkdoZGr/BLeZ9lmZcV/nmVI0yyfKE4deQrZ577ntMxgaoeR+q90/L+y3963+gMQ4Nxml/XDStTTHmKYPA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544082; c=relaxed/simple;
	bh=Y0yk1EQ0N/cEN4LfgQerw9xeU7LIwKvo9GmaA3dmRVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+8Rzcr2gAH9ES0U4Q1bOSbCDuSZJEPXQbey4srLhvyyFmZ8FcC/PFz6EEW4SRc5t41dbKcSPNQYvzIEmjCXvooCyHh0A7FjsokczTLT0R5SbXlPwBwfce0YRvfiLTmBjJjGL/piPrE7W1UqTzv6K+NprVCzWc8bpQjNXIVmJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMp4zKwl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMp4zKwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711544081; x=1743080081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0yk1EQ0N/cEN4LfgQerw9xeU7LIwKvo9GmaA3dmRVw=;
  b=dMp4zKwl7ocQ50Zu/Zst1uq+UGXhF8y9IG8v5R/qeb/rsh7bgoznHsPs
   goOf7nhLUTsndCh7T2boplU+2me+CMRuUys1UBYCUREnuqsCcDTO2eRVi
   vF2CSM4K6Qxx4kBuOYOsYlM0oD6zUePznFGDjHJDtpwQzb1Re8biIPA29
   LrSZ+wblm4ULBeFlSDtwVUssLyziuaRtM0TT7wlQeRwctW/kpSNYOHSpD
   sdvB/G8JdAIXPBknHWmNV5TgH1n+6DJqsrUNC9S0izB0tpsbsBo7y0g4j
   E7JpDwT8qPuUc5oNB7gfCE/UZoRxTuNofoyhkGsC5/uRbyinFMaGUBlOF
   g==;
X-CSE-ConnectionGUID: NO6ZNHueRoqBIDpbsbxXAQ==
X-CSE-MsgGUID: rWsllyCxRp+f1hsvFYa2JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17271792"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17271792"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 05:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="20811201"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2024 05:54:36 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	jacob.jun.pan@intel.com
Subject: [PATCH 1/2] iommu: Pass domain to remove_dev_pasid() op
Date: Wed, 27 Mar 2024 05:54:32 -0700
Message-Id: <20240327125433.248946-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327125433.248946-1-yi.l.liu@intel.com>
References: <20240327125433.248946-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing remove_dev_pasid() callbacks of the underlying iommu drivers get
the attached domain from the group->pasid_array. However, the domains
stored in group->pasid_array are not always correct. For example, the
set_dev_pasid() path updates group->pasid_array first and then invoke
remove_dev_pasid() callback when error happened. The remove_dev_pasid()
callback would get the updated domain. This is not correct for the
devices that are still attached with an old domain or just no attached
domain.

To avoid the above problem, passing the attached domain to the
remove_dev_pasid() callback is more reliable.

Fixes: 386fa64fd52baadb ("arm-smmu-v3/sva: Add SVA domain support")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 ++-------
 drivers/iommu/intel/iommu.c                 | 11 +++--------
 drivers/iommu/iommu.c                       |  9 +++++----
 include/linux/iommu.h                       |  3 ++-
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5ed036225e69..ced041777ec0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3044,14 +3044,9 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+				      struct iommu_domain *domain)
 {
-	struct iommu_domain *domain;
-
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
-	if (WARN_ON(IS_ERR(domain)) || !domain)
-		return;
-
 	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..45c75a8a0ef5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4587,19 +4587,15 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *domain)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
 	struct intel_iommu *iommu = info->iommu;
-	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
 	unsigned long flags;
 
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (WARN_ON_ONCE(!domain))
-		goto out_tear_down;
-
 	/*
 	 * The SVA implementation needs to handle its own stuffs like the mm
 	 * notification. Before consolidating that code into iommu core, let
@@ -4610,7 +4606,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	}
 
-	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 098869007c69..681e916d285b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3330,14 +3330,15 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 }
 
 static void __iommu_remove_group_pasid(struct iommu_group *group,
-				       ioasid_t pasid)
+				       ioasid_t pasid,
+				       struct iommu_domain *domain)
 {
 	struct group_device *device;
 	const struct iommu_ops *ops;
 
 	for_each_group_device(group, device) {
 		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid);
+		ops->remove_dev_pasid(device->dev, pasid, domain);
 	}
 }
 
@@ -3375,7 +3376,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
 	if (ret) {
-		__iommu_remove_group_pasid(group, pasid);
+		__iommu_remove_group_pasid(group, pasid, domain);
 		xa_erase(&group->pasid_array, pasid);
 	}
 out_unlock:
@@ -3400,7 +3401,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
-	__iommu_remove_group_pasid(group, pasid);
+	__iommu_remove_group_pasid(group, pasid, domain);
 	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
 	mutex_unlock(&group->mutex);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..40dd439307e8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -578,7 +578,8 @@ struct iommu_ops {
 			      struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
-	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
+	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
+				 struct iommu_domain *domain);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
-- 
2.34.1

