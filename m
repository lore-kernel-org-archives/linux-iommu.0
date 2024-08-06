Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7F2B9C6
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912202; cv=none; b=ppaAvR+XuJ1eDbj3vhx84pLGysNGgavemYfF08QcAWkzEChnWKalrfDED+bHV+3fj85461ZXxUowYWLgspoKEXqnsWiW+3t5TO/uO3oEJ+o91udc7fhJRw5nS2MD/PhxBVPOKIWrQqyN84biARNfzNTv6AaFoPU7yo/GFf6ZTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912202; c=relaxed/simple;
	bh=VvUjxvijcivH0pOPCUJicXjduLFqJW9qUOw2HGLvGnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFyYquKALCWJsgOSovwcYRjMqyC26Gt57x5tdhtCEKqyD0bfspaExrnIf8eS/1ARzy/OseaAucy9eiZxzzcy2NgSqx/vWvjB+MGT/yuJBsUr7RYlbEeaRb6Kvz6NbWmB4l64ldg/yznbxCsEMMJ8PNn5iRcALl2SkMmKeP5IT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHATSVgJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHATSVgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722912201; x=1754448201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvUjxvijcivH0pOPCUJicXjduLFqJW9qUOw2HGLvGnE=;
  b=FHATSVgJG6dDFnaQDCfuAN9rmfFy4erpMnvLKox3HhkBGaYV08iQsjc/
   55Bhmb7BlPvjIwBnVNVIzmvJzyaNaOm1qqA+3nbL818m15ICDw56wLazH
   Ewk1pRVFRft8RdgmF7P5i7lxMs+gBu2MgJLZwdLsZfN52xW3lmOk70FPp
   Bin5eoXqK91Zm0j5/DohQSNDMKHDFRlJBoazdvbZDVAgemevYCr6yzIUA
   HM0C6kSR+ozs7Y0vy2TE1MwUn6tKL3UYzDj5ijYhwKlkQmpug33Cifjtu
   CdCq8RXmWob+EdUjgFITo/oMoR3goVqhnqzx9cN/k1GoRLfU4oLDEEfq8
   Q==;
X-CSE-ConnectionGUID: sQA9xOQoQrCIeYPjBqcr3A==
X-CSE-MsgGUID: jCd60+NnS725Go5XiS+GlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20756282"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20756282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:43:21 -0700
X-CSE-ConnectionGUID: 37kGIGI3STG+A/xThK0ADw==
X-CSE-MsgGUID: Q0oysaFfQQKIS3bonZEuvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56572529"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2024 19:43:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity domain
Date: Tue,  6 Aug 2024 10:39:38 +0800
Message-Id: <20240806023941.93454-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806023941.93454-1-baolu.lu@linux.intel.com>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the static identity domain in place, the domain field of per-device
iommu driver data can be either a pointer to a DMA translation domain, or
NULL, indicating that the static identity domain is attached. Refactor
the code to prepare for this change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c019fb3b3e78..f37c8c3cba3c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
 	bool has_iotlb_device = false;
 	unsigned long flags;
 
+	if (!domain)
+		return;
+
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
@@ -3706,11 +3709,9 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
@@ -4321,6 +4322,11 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+		return;
+	}
+
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
-- 
2.34.1

