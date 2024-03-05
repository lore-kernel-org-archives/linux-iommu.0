Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B45C912
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641664; cv=none; b=Dpdlzl+sr5HvmV2Dl1vY62NllXlae4UooiShAGFH2BOVWeOMetnUrIM94AWSNo7FtYrMhVz1hSI0tPhym//sGX7/zQErRjfpQwRpzRNMKrMxZMPaAbXcJdbiSnjWnOpb/XXcksdQSuOlQ6BIxPOtlhYeSXcICd25nJsk6IS+3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641664; c=relaxed/simple;
	bh=ZowgDUVcvv+doVk6YVMSxDhTJIb10vanJKzULJxdQqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txbCVi+AuPMip9k/YHyzOKG24OjL/L55v5+MT4d1GxaU+h/j0EPyH6aYnWcJrExiBO0n02qqjZwXDF7+YcgWorQfVKwKFXAFaR4c1s3fe8S5eI4Q1c5n/hO+kUWhNv8gAsh5cfyzzzkSmQM0iNdY9UbmxHmOqiV5/4fwwtRlaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h38YFYa+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h38YFYa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641661; x=1741177661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZowgDUVcvv+doVk6YVMSxDhTJIb10vanJKzULJxdQqE=;
  b=h38YFYa+v0wsrOdkE2zZLgycP6CPGYbBwhgQxcFnQqFNFGTM/5JeOoqK
   MsFJAsafi11X9ilVWLv+DIzHgwjs/cwQir69+sasIYEY6Gw87WYVJ45sB
   YIhgG+P1oc2kz2MGuN2mOLv9uN4u6mKx+G+nrm8CxBXN4mXoX62nCTwT5
   IDLtNVgil41UYm3X1wG2tmpwUCjMg8sjZHexg6ezrPw4d5WNdjajwDs4a
   ItmCTszJPlKC+N5DnRUETJjTB3qm1Ldg69R/oivV5YdKuivk/3ooNJzuO
   S+pgNfm8Tmk722UAPYzVyAgXZ/vFH5H2zcl7iYjSt+7KY8wAY6FqkJ4G7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648526"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330155"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] iommu/vt-d: Remove scalabe mode in domain_context_clear_one()
Date: Tue,  5 Mar 2024 20:21:21 +0800
Message-Id: <20240305122121.211482-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305122121.211482-1-baolu.lu@linux.intel.com>
References: <20240305122121.211482-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_context_clear_one() only handles the context entry teardown in
legacy mode. Remove the scalable mode check in it to avoid dead code.

Remove an unnecessary check in the code as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240305013305.204605-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d682eb6ad4d2..50eb9aed47cc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2175,9 +2175,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	struct context_entry *context;
 	u16 did_old;
 
-	if (!iommu)
-		return;
-
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!context) {
@@ -2185,14 +2182,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
-	if (sm_supported(iommu)) {
-		if (hw_pass_through && domain_type_is_si(info->domain))
-			did_old = FLPT_DEFAULT_DID;
-		else
-			did_old = domain_id_iommu(info->domain, iommu);
-	} else {
-		did_old = context_domain_id(context);
-	}
+	did_old = context_domain_id(context);
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
@@ -2203,9 +2193,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 				   DMA_CCMD_MASK_NOBIT,
 				   DMA_CCMD_DEVICE_INVL);
 
-	if (sm_supported(iommu))
-		qi_flush_pasid_cache(iommu, did_old, QI_PC_ALL_PASIDS, 0);
-
 	iommu->flush.flush_iotlb(iommu,
 				 did_old,
 				 0,
-- 
2.34.1

