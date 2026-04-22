Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4739B956
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776828966; cv=none; b=Yz+LPE6JnM4AVgf3LbQwYl9qndU9VCHkRLnhC2Gn1LWPUKrfYJKZqOOYC5/Yg+YhPA8Anlp4u8FLBvMB0ifR+mXpN4eRrDV/Dd60uOSSnuYUWKI0C+CoFQhIfRJCIO4Q0mm/OI7RqyB28/Fl3nKLa5QiAUrRATRQIHtG3lPe8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776828966; c=relaxed/simple;
	bh=GrD965rlUsrzH5tYmy8s+54juQvqaobQHSrTrLptU98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=We3Z9/SV2p/ifk/otef1skq1/qaZkTvH1/aWZHicp3uW2uW55KPWUVBBuKQgQjJ38krifCchO3r399elo64185TN0UYfM9ssE0qDjwodvCBNsHCsIcunv8lB/ZU0i0TcfrL7XEGzXHPK1ZEr4ADu9IaFM8Fdwh93p+O7jwbqNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7NzqS77; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7NzqS77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776828964; x=1808364964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GrD965rlUsrzH5tYmy8s+54juQvqaobQHSrTrLptU98=;
  b=m7NzqS77INM+xoo+W9RiAkw+1kfWjH36AZb58/A/i2nEQc9qNPe0e1o7
   RFib0VtCq8Qrtq6R4qHhXx4GzIeetbHSW8U5YAQ7gwZYrLdX5Zo+TjSIu
   ieZnyC00fDMc05VFMn6EaAsCJeCppxYZMIPNnaet51Nyy7HJvIjov39/u
   Ke5EbdMe1SBpawNPKY593+XwSTvJdPSbq9HVrcj0tad8HYX12t807+lIb
   /Xbpmnbi7KNOsY0AuP98wkbgiXEKofiGZ2ER8044oh4jRElCMYO/kCS/t
   tNVPWn/gXkuEMXh43q3PpG8ptgYLLnWwyT8WSbU0WcxGdwbta8d1C+41c
   g==;
X-CSE-ConnectionGUID: 6OfS6EmqQfay1ENdbf7KAg==
X-CSE-MsgGUID: u5u8vrWHRG6t7psLCYglRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88473585"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88473585"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 20:36:04 -0700
X-CSE-ConnectionGUID: rJQGHLY5SMS0yTS2jHzIDg==
X-CSE-MsgGUID: JBHIYVrzTIWO2QTdiP6zrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237266691"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 20:36:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/vt-d: Avoid NULL pointer dereference or refcount corruption
Date: Tue, 21 Apr 2026 23:35:37 -0400
Message-ID: <20260422033538.95000-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
fixed a NULL pointer dereference in an unlikely situation partly.

If dev_pasid is not found in the dev_pasids list, it remains NULL.
However, the teardown operations are executed unconditionally, this lead
to a NULL pointer dereference or refcount corruption.

If the domain was never attached to this IOMMU, info will be NULL, which
would cause an immediate dereference when checking --info->refcnt.

Even if info is not NULL, decrementing the refcount without having removed
a valid PASID might unbalance the count. This could lead to premature
dropping of the refcount to 0, potentially causing a use-after-free for the
remaining active devices sharing the domain.

Fix it by returning early if dev_pasid is NULL, before executing the
teardown operations.

Issue found by AI review and suggested by Kevin Tian.
https://sashiko.dev/#/patchset/20260421031347.1408890-1-zhenzhong.duan%40intel.com

Fixes: 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 52aa12dbeea1..172b96f2cedf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3545,12 +3545,13 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	}
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	if (WARN_ON_ONCE(!dev_pasid))
+		return;
+
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	if (!WARN_ON_ONCE(!dev_pasid)) {
-		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-		kfree(dev_pasid);
-	}
+	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	kfree(dev_pasid);
 }
 
 static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
-- 
2.47.3

