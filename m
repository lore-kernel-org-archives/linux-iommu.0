Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18892D60B
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000448; cv=none; b=gdR7yP52A+fGOvv+mrl3F42XHyn5OTuRFIpXjeHnEHWGOtDOybCoeykjW3teCI/CXh8VjvTovGxPKPXj2VIMR5qaO6vJ2A1sQKUdrGtWnTn8uIb3x2VWm3KJATS3ighAriPbge6Tx2ZPE+V3pfeqTUsbvGUbilQ7xHkMxC2PSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000448; c=relaxed/simple;
	bh=qVQIcSHSJ4R57qtQzHqo/LOuOIYQCzdxlV3v9opOJ34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyGSHQ7ZW49Gal0Au8RVAhIgb7MIXqNH7xtG3nNRbGgpLjZFI+nimsUMrxvEmq9Pz/NE5qJ9U7eeyy4JEniRPG0MQIjAHzz/SagshOJniPse5Z/5R4lI7eV8opEKkjSdWIDRIpMECngFYG0UbHWsDe2vUrCOgSyz1jydbPsABrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7OLLwig; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7OLLwig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000446; x=1740536446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVQIcSHSJ4R57qtQzHqo/LOuOIYQCzdxlV3v9opOJ34=;
  b=R7OLLwigWihZDCx/o2BM/QIbFAPmUyqaYO23EhEYoyOR4r1hxDSp4VKc
   wB2lyFJYJ5sAcvHQAT9KoyYnknczCktToMAPlhp9V37/ri2pPNM+K6OTj
   2eWQDlMJS+Hyp9BgKbmsKBR3gQfQjGoZgKazns3HyeVO6H2B0Gpz12j0W
   LLUjOEBJNk77Du3eek7sRMni5xd54tTaNM+Gnoz2yuRrrr8GDhR8WJ/WQ
   KuszVNLA2h65QQBQsJ6GuNUCvEd4r0elJymnmErH+oPaRiGLK3L66FeJX
   Qmqy6xm5vBEbTMbKbnnKWq43aCJc0hoP9OH0HRkDdflCD2FjoORgSKSgD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273113"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273113"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418295"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] iommu/vt-d: Remove treatment for revoking PASIDs with pending page faults
Date: Tue, 27 Feb 2024 10:14:37 +0800
Message-Id: <20240227021441.50434-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227021441.50434-1-baolu.lu@linux.intel.com>
References: <20240227021441.50434-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <tina.zhang@intel.com>

Commit 2f26e0a9c986 ("iommu/vt-d: Add basic SVM PASID support") added a
special treatment to mandate that no page faults may be outstanding for
the PASID after intel_svm_unbind_mm() is called, as the PASID will be
released and reused after unbind.

This is unnecessary anymore as no outstanding page faults have been
ensured in the driver's remove_dev_pasid path:

- Tear down the pasid entry, which guarantees that new page faults for
  the PASID will be rejected by the iommu hardware.
- All outstanding page faults have been responded to.
- All hardware pending faults are drained in intel_drain_pasid_prq().

Remove this unnecessary code.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240219125723.1645703-2-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 40edd282903f..a815362c8e60 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -408,13 +408,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
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
2.34.1

