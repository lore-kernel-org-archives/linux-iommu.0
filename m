Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15A20898C
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621138; cv=none; b=NBfSVK/1FqYaD0h582CCSgx3ktasHxJ9cmPfrEVyFteEVYe56RFP888jfmgbiOf8M0rx3ZwlnY1U+9mEp4RVmUcfdPWmdKlvlP7k8CuzKVRBLrudd+AZDP8hLaYWzN14057LBUFDAAEftjnFvHlTW3yX2t2Y4OOm1jXuI17CMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621138; c=relaxed/simple;
	bh=NY5lJL/ph7I8lBmfDBy9zWdrKc31idmHXspRQeIaaCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ovb7XGKkaVvU3fv3ppYntWUr66ibf3Hgw/yRJvm+LkFQ7Dl2dNiz8dxSloroxZDbhxSS8mqqdhcYYc8TDRcu/BKRInP0Hk7UFG0hR31YrCVL22ucTCch+Ki6OpXQZHkn4ZV/MO3tYHRwBalpTIBux6rNE9cNgX7hQ5DiIT0IRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ak3vciju; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ak3vciju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621137; x=1760157137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NY5lJL/ph7I8lBmfDBy9zWdrKc31idmHXspRQeIaaCk=;
  b=Ak3vcijuMoGZNgbHGor9eCZEJD6t8baqJ1D81YH9xYfjfvfeOexuMGN8
   lANzyzY1yHxJ05+tyBUTBmUh1EQcGcFtaZeqiQ7+jqDjLMy7/WYOjlAXm
   F2YxXl+daKYHyqUgEX0N5lc0HR49laQjsUYu5UzNqIhNNn+SIBMjiiyAp
   3odcbP8/IK+tkW+ldw7RKQBBMwz2/Ni0e+FqfJVZXdlZyWP0H8ZLLkE8p
   YCnFAbqSQ2T/z9TWgq01NdFKmAs2w4EPZEY89vkvtJZNwqShs/9wxh39j
   mKQk5G4FwhI/gfTVP8FlBOwoZ1ER5CvHCVk1hDVbn3dRHP4oWUviiwAjm
   A==;
X-CSE-ConnectionGUID: HuuhZUtmT1aqNURHnJP+/g==
X-CSE-MsgGUID: Ml/r1sFUTtm/BFqRWZ6xNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101800"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101800"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:17 -0700
X-CSE-ConnectionGUID: W5J//BOmR8S47zksTTdVWg==
X-CSE-MsgGUID: v1dGSL2ZSDab9isQPGUqqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412217"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/7] iommu/vt-d: Remove domain_update_iommu_superpage()
Date: Fri, 11 Oct 2024 12:27:20 +0800
Message-ID: <20241011042722.73930-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011042722.73930-1-baolu.lu@linux.intel.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requirement for consistent super page support across all the IOMMU
hardware in the system has been removed. In the past, if a new IOMMU
was hot-added and lacked consistent super page capability, the hot-add
process would be aborted. However, with the updated attachment semantics,
it is now permissible for the super page capability to vary among
different IOMMU hardware units.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 39 +------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ada271e7be50..29b53d955022 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -352,36 +352,6 @@ static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
 }
 
-static int domain_update_iommu_superpage(struct dmar_domain *domain,
-					 struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	int mask = 0x3;
-
-	if (!intel_iommu_superpage)
-		return 0;
-
-	/* set iommu_superpage to the smallest common denominator */
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			if (domain && domain->use_first_level) {
-				if (!cap_fl1gp_support(iommu->cap))
-					mask = 0x1;
-			} else {
-				mask &= cap_super_page_val(iommu->cap);
-			}
-
-			if (!mask)
-				break;
-		}
-	}
-	rcu_read_unlock();
-
-	return fls(mask);
-}
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -2605,20 +2575,13 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
-	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
+	int ret;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
 
-	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
-	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("%s: Doesn't support large page.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-- 
2.43.0

