Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1915098A
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447760; cv=none; b=IDkTBdPzWOjR5Eoi2JAreqYuh6oZ9aQRt+K2/9bJFW1k6n+3Fk06alpUuRkTsHo42FP5WYFjeDysJJoajOQuFEbGMIfGhlCoF/DuG4jAzYgYhh++N9vTP6RM1OuoBWGjGrP48+Xg+uZPHuxsPfIRKVgOvyqkD3stZPnlKDPoC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447760; c=relaxed/simple;
	bh=e0LBAejigITG9AP6jtpikNxNxU3HNaCX57Mb/ZLuVkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7dv86bhCNYDXbr5h8sO6jEYoYdwfalYNDdFDnLyx+dDpFGv7tpvEIzzWKcYm5/cQOB39/zK+jRVKYY2q2Fq+mo5M3h77jcPGqCJB0xPMUr+q5V1BJXpuIQnYyMUfJcqezVLU5OxxyGL3bIm3d9rXUP91p8Bow8tR0pubtaUXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJfSQ1r1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJfSQ1r1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723447759; x=1754983759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e0LBAejigITG9AP6jtpikNxNxU3HNaCX57Mb/ZLuVkc=;
  b=dJfSQ1r1PQxn0kdisNIVNlr2zQyQyWQAPOaSLW1/l4UJnvo31y7plJRg
   pJ/7jVOALVKSnTMwBP1rD2FMARVAsJNoqf/5q9o9PLB6I9xz9ycIdim6D
   0jaw/D+sIVRObPrEUfHX77vupl3hekIg+rLVqdGSNT3fVkRl72HYe1+mf
   8fOtFtgh9mYIRqVKnL7sjC93exxqZrTPkuvJkFyIMeiJDnpD3c+pEEZq6
   B9BQfJ0rA/NoPrpMw/1cplPunCsLzmlN92Fx0LzdaE40DSsvvz5ZLN2Kz
   Fa31QAPDn8PIXJLhdf7F2pRltbaxYe+svNlF2MAR2BqxdF04LQtAbHNUl
   Q==;
X-CSE-ConnectionGUID: mw/6wyBgRJKgmAqjf3JPeQ==
X-CSE-MsgGUID: TGhqGwV+T1aTflRXV3gsWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21686647"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21686647"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:29:10 -0700
X-CSE-ConnectionGUID: ftLXCe6zSOeVfNj73MeBtA==
X-CSE-MsgGUID: Haii5Zw9R/2Xjpz6GDYbrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58894812"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 12 Aug 2024 00:29:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/1] soc/fsl/qbman: Use iommu_paging_domain_alloc()
Date: Mon, 12 Aug 2024 15:25:27 +0800
Message-Id: <20240812072527.9660-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in portal_set_cpu() and is attached to
pcfg->dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240610085555.88197-14-baolu.lu@linux.intel.com
---
 drivers/soc/fsl/qbman/qman_portal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e23b60618c1a..456ef5d5c199 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -48,9 +48,10 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 	struct device *dev = pcfg->dev;
 	int ret;
 
-	pcfg->iommu_domain = iommu_domain_alloc(&platform_bus_type);
-	if (!pcfg->iommu_domain) {
+	pcfg->iommu_domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(pcfg->iommu_domain)) {
 		dev_err(dev, "%s(): iommu_domain_alloc() failed", __func__);
+		pcfg->iommu_domain = NULL;
 		goto no_iommu;
 	}
 	ret = fsl_pamu_configure_l1_stash(pcfg->iommu_domain, cpu);
-- 
2.34.1

