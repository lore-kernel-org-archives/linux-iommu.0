Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9EE205ABF
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468775; cv=none; b=gAo2pQ+TJmGYoK73VfTGnAHD6YUDs1iEcsJwz6KXDA8PkGBsDyFGt0uaTP976vVxTG+NdYXxEjlQfj9TEVBZKK2//66Htyc+DrNlUcNUCvSPLZytVmQ+KUjG0leZPinvCu5rtPIol5MNqraYGBD7CLYEJJyZWZBxOzNvGdGvYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468775; c=relaxed/simple;
	bh=w6OHcfYvWgcpddF27T2R8sT+80U+FhVKBRnhQQgCvck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdXFdS/ApJoZrfZLYOrYUi4CGcvqE7MDnIIpIR+oGm4wXU0l34oi5EeAndG4chtIdnU1bkhFCHbPzVIc1pATHjxxuEc054C+N+UR55noBjuUnti7kJEPAsLbfX109Y6AmBBzYv9Q+TaOkYKq8XKCy7T7IqcgbXQUeBXitnweol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xc2jSUk5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xc2jSUk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468773; x=1784004773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6OHcfYvWgcpddF27T2R8sT+80U+FhVKBRnhQQgCvck=;
  b=Xc2jSUk5LU2sL+a3aAad40zKuABsyi4OiyWUnsbwxiutkCxkkpyZW4dT
   sqfhzqyrmVo3YukqwaEptKu6IyaHcRxRfhsDSNV1NX8WzpoRa/WQyHrV3
   Yg9H3daLih1Z8aBCvLPK2ntTyeosx74W94glBLZ0fCv1NGnSFSi6TxCiL
   RMvORpSeKYK452R4tibX9zeXbgljOGbLCuJvbgbLzcUabaGV2GQiy2VrZ
   5nU10VEeavOamvTBkQsdStL6LrbKSQVKvAwVYwVEW1dOMHFNGbY12gHz9
   DGxITva7u3GK3SLnV7ZhmmowooNRsMSHrycmqRQwBxY7w1W/66lheOCcL
   A==;
X-CSE-ConnectionGUID: Env8UZXbSji7h3AOpAC7jg==
X-CSE-MsgGUID: 1Dmt72pEQQ+N+HF4gNZD5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765047"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765047"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:52 -0700
X-CSE-ConnectionGUID: n4Z9TJjUSCinaLmyOmNjpg==
X-CSE-MsgGUID: OH7tv5bvQ62+zZEO63pAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166159"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] iommu/vt-d: Fold domain_exit() into intel_iommu_domain_free()
Date: Mon, 14 Jul 2025 12:50:21 +0800
Message-ID: <20250714045028.958850-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

It has only one caller, no need for two functions.

Correct the WARN_ON() error handling to leak the entire page table if the
HW is still referencing it so we don't UAF during WARN_ON recovery.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/2-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 38 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2e5e682a41..5c798f30dbc4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1396,23 +1396,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	}
 }
 
-static void domain_exit(struct dmar_domain *domain)
-{
-	if (domain->pgd) {
-		struct iommu_pages_list freelist =
-			IOMMU_PAGES_LIST_INIT(freelist);
-
-		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
-		iommu_put_pages_list(&freelist);
-	}
-
-	if (WARN_ON(!list_empty(&domain->devices)))
-		return;
-
-	kfree(domain->qi_batch);
-	kfree(domain);
-}
-
 /*
  * For kdump cases, old valid entries may be cached due to the
  * in-flight DMA and copied pgtable, but there is no unmapping
@@ -3406,9 +3389,24 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 
-	WARN_ON(dmar_domain->nested_parent &&
-		!list_empty(&dmar_domain->s1_domains));
-	domain_exit(dmar_domain);
+	if (WARN_ON(dmar_domain->nested_parent &&
+		    !list_empty(&dmar_domain->s1_domains)))
+		return;
+
+	if (WARN_ON(!list_empty(&dmar_domain->devices)))
+		return;
+
+	if (dmar_domain->pgd) {
+		struct iommu_pages_list freelist =
+			IOMMU_PAGES_LIST_INIT(freelist);
+
+		domain_unmap(dmar_domain, 0, DOMAIN_MAX_PFN(dmar_domain->gaw),
+			     &freelist);
+		iommu_put_pages_list(&freelist);
+	}
+
+	kfree(dmar_domain->qi_batch);
+	kfree(dmar_domain);
 }
 
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
-- 
2.43.0

