Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C58210EF
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0nHVIcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367573; x=1736903573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=d+uzZx1oyEx1QzOM2baBuSxQRBzOVEJRVFY6ELaYdYg=;
  b=Y0nHVIcyLlcYnGQ2GgDISan43bnY2QjmWPkLOLvkfWTOJgmxFxikaxa7
   Y9D6i5OKb1w5c/YXtVQuANyCsZEKVNgh0K4tDTRw/0rMb0yxD4ggfXaxG
   y+gl2cgei0Sj8AS3krg1K9lN0hmkf8LCuwSNKsb5cR8cKJzowOX6StM00
   yjWXDIr9u+0VuRku5kBCsMXzGp3M1iMJ54OPwQef1d1Uye026dPUI4i7O
   kyqLsvkS8mXEEQPjTfJaq1YurC2SAZN49g9bg4UzIeUuWcEhok1uy8NEp
   yCDkJ0VMex/oaPgRCSuBAz4rDfnyA8OU7nALsBjOiMC5YxmwvHnOOb/fd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004380"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004380"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427230"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427230"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:12:51 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 01/11] iommu/vt-d: Retire the treatment for revoking PASIDs with pending pgfaults
Date: Tue, 16 Jan 2024 09:11:36 +0800
Message-Id: <20240116011146.18645-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Revoking PASIDs with pending page faults has been achieved by clearing the
pasid entry and draining the pending page faults in both hardware and
software. The temporary treatment can be retired now.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e1cbcb9515f0..a88051b9d802 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -407,13 +407,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 			if (svm->notifier.ops)
 				mmu_notifier_unregister(&svm->notifier, mm);
 			pasid_private_remove(svm->pasid);
-			/*
-			 * We mandate that no page faults may be outstanding
-			 * for the PASID when intel_svm_unbind_mm() is called.
-			 * If that is not obeyed, subtle errors will happen.
-			 * Let's make them less subtle...
-			 */
-			memset(svm, 0x6b, sizeof(*svm));
 			kfree(svm);
 		}
 	}
-- 
2.39.3

