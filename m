Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD67200C90
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505580; cv=none; b=Xp0ndM/QgIkf1cngymL3258a8hKh49qGq6unT2TYI3dmCkTpcVgtJREAmIJN+AnuaYkGEZisb6kfHZW493pJR6XpKMkepCO4WsvTWixTOjmY4WZIi+mkf+UwGUkp8X2/wPZBos5UtW3BTksc9SD7ED3T/15gkkdEdkv8to3JXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505580; c=relaxed/simple;
	bh=CQNBEu2JwavCGSEpJSQqW92hh61UdmjmKwLxFCOoolw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSdb784fUgfZPZNChh35CudXkxI3Y8vxy+VONrfiqOUcJQ50EFg2y5cxuNVnyi2HpdanW/nfvinNaVyUW1H4MwURWWEuDeejrY+C2Tq6Z9iNw3n4vAlZJMtvnV61sBILASfjAjQQdcHUUi9kaTiTWvTPseVZtjJuC7OxLCGitAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3fjQBv9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3fjQBv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731505579; x=1763041579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQNBEu2JwavCGSEpJSQqW92hh61UdmjmKwLxFCOoolw=;
  b=Q3fjQBv9mbsy3K2E7IGCU0hrEypfx+7imSGEVIFzvPskWjtW3gMCIwEz
   EOHz0KWaaIuk+Io72mWraFdrsF2A8t3JzG0btvKVptps4th1D4aKIiydF
   9NoXPvHtt3Gxs6BpGQRi8iqxsV0QgIbjtEsE3pqkmFucTjgxWIGUF2e5H
   67sIG3Ey1Q4XwJbJzPzJT+5axhdiO8hlNHNZP6ABiGGyfBmmFAxNe0lDG
   d0hK6KPt19YR0BS8+BiHjutktdg6eVEKS0EqHRQ3JZBF7Q5Bx57zoFwIe
   pBNgT26OgJCYBCC+T7BvlWyXDZPfv4onSRnmb5je/qVyfUzzfYjftDz7v
   Q==;
X-CSE-ConnectionGUID: 5vsZxwu4SeSVOugpgmKShA==
X-CSE-MsgGUID: 4fDeayHOSX+j++QeTZv0XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42025712"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42025712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 05:46:17 -0800
X-CSE-ConnectionGUID: X9t7aTfzTRmvl5Q51QwOqQ==
X-CSE-MsgGUID: lAhf9qYGQXKB1BRsoo04FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87445598"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 05:46:16 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v5 4/7] iommu/arm-smmu-v3: Make the blocked domain support PASID
Date: Wed, 13 Nov 2024 05:46:10 -0800
Message-Id: <20241113134613.7173-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113134613.7173-1-yi.l.liu@intel.com>
References: <20241113134613.7173-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

The blocked domain is used to park RID to be blocking DMA state. This
can be extended to PASID as well. By this, the remove_dev_pasid() op
of ARM SMMUv3 can be dropped.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7ee3cbbe3744..276738d047e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2979,13 +2979,12 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	return ret;
 }
 
-static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-				      struct iommu_domain *domain)
+static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
+					   struct device *dev, ioasid_t pasid,
+					   struct iommu_domain *old_domain)
 {
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct arm_smmu_domain *smmu_domain;
-
-	smmu_domain = to_smmu_domain(domain);
 
 	mutex_lock(&arm_smmu_asid_lock);
 	arm_smmu_clear_cd(master, pasid);
@@ -3006,6 +3005,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
 			sid_domain->ops->attach_dev(sid_domain, dev);
 	}
+	return 0;
 }
 
 static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
@@ -3087,6 +3087,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
 	.attach_dev = arm_smmu_attach_dev_blocked,
+	.set_dev_pasid = arm_smmu_blocking_set_dev_pasid,
 };
 
 static struct iommu_domain arm_smmu_blocked_domain = {
@@ -3514,7 +3515,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
-- 
2.34.1

