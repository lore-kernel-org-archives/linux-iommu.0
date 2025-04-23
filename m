Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C66265CDA
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377800; cv=none; b=ZhqmNQ0ZIT9wOTfFEPY4EA57mgXtgYOBIynggPtkIOobcOSQAE5hxt5NXdyFZSd4o4AfHl2FSLoRwkx4epXqHu3Vkmqy84ryL0JDgrgHMORCkyS6FSVi2sXp8cDr05pWclVzq2wSa6+dVcNkw3b+ZTgS2mtYHJ+dOirqC/ymfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377800; c=relaxed/simple;
	bh=GycVYA/NvO+xmkaA5ol9tDUppgYdB32anXTkGIawxtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDNd3kCrNhXyH9mgrFfAk8FGiTt/B2k51wFzCMpM86uqT18xJxs1p5MKrAC9/bjUp82u5Js5COTJFWbNvtsPmLDn+7QEwAPrSx53RXcA6dQFBTE/zurfAc3L51xGYCwUNqNaG2w4yCh/nlcohi8WJxj22ZpqU8d9ejIwZTls2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4FEI6OA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4FEI6OA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745377798; x=1776913798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GycVYA/NvO+xmkaA5ol9tDUppgYdB32anXTkGIawxtk=;
  b=P4FEI6OAabCD/LxJ1fTL1PN67tTGLCz57mir913JoF3d4oou7UZ33Sjv
   a9PCiIIgDRDB/ujZbze+0H1oMcdxqSOJ0IMyGrz0CU9TM09np318fNpSJ
   6V/Ylzh2chuA6a9rYDEivXMIw8ssw3A5/V7WX6viMhu3v4UJwLQtMRAX8
   8lxFLjJc/m9vf79CgNEvSJK1rY33fL5YkximqZmyYR9CRrzaRUhoFAnOa
   X5Driu8bFQMTI0nt04Iwbf/F/67Ce9MLOkETgPVJGFT7ngmFxfLMrXQt3
   YKAyhCN26VLr8xKtzdt2eI0P8wJc1oAcBhWNe7HAa1n2PFR4hw2xhw8E0
   w==;
X-CSE-ConnectionGUID: neNDZwBGSfWYxPk1byqNow==
X-CSE-MsgGUID: kqLn6AueRX6QuzRU+OzXTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57145947"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="57145947"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 20:09:57 -0700
X-CSE-ConnectionGUID: 2UArvlSUTc2bYAbSg/Fneg==
X-CSE-MsgGUID: s3M7YOd5T++tWRjrts7LYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="155398708"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 22 Apr 2025 20:09:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
Date: Wed, 23 Apr 2025 11:10:20 +0800
Message-ID: <20250423031020.2189546-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the __free(kfree) attribute with kzalloc() to automatically handle
the freeing of the allocated struct iommu_domain_info on error or early
exit paths, eliminating the need for explicit kfree() calls in error
handling branches.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3a9ea0ad2cd3..12382c85495f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1337,13 +1337,14 @@ static bool first_level_by_default(struct intel_iommu *iommu)
 
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
-	struct iommu_domain_info *info, *curr;
-	int num, ret = -ENOSPC;
+	struct iommu_domain_info *curr;
+	int num;
 
 	if (domain->domain.type == IOMMU_DOMAIN_SVA)
 		return 0;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	struct iommu_domain_info *info __free(kfree) =
+		kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -1351,34 +1352,20 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	curr = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (curr) {
 		curr->refcnt++;
-		kfree(info);
 		return 0;
 	}
 
 	num = ida_alloc_range(&iommu->domain_ida, FLPT_DEFAULT_DID + 1,
 			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
-	if (num < 0) {
-		pr_err("%s: No free domain ids\n", iommu->name);
-		goto err_unlock;
-	}
+	if (num < 0)
+		return num;
 
 	info->refcnt	= 1;
 	info->did	= num;
 	info->iommu	= iommu;
-	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
-			  NULL, info, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
-		goto err_clear;
-	}
 
-	return 0;
-
-err_clear:
-	ida_free(&iommu->domain_ida, info->did);
-err_unlock:
-	kfree(info);
-	return ret;
+	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
+			       no_free_ptr(info), GFP_KERNEL));
 }
 
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
-- 
2.43.0

