Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35C37EFE7
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113217; cv=none; b=JDU48Yny7cSxEpxovpwGRQJ2RSuxy0CGqC3jdWG/LIRTikzoG+80zUX3q5QNOrqWd6inPNKuVmDzHMhyc5zY10T0TsmyMyvWsxInnf+BKI3xsdIJemi1P52uAaOZk0Y5lbADf6j16NYOqp8NTXyAYFdADpd0QjzIP5MWnePFe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113217; c=relaxed/simple;
	bh=tJ4Dq15RK4M6mzHsF8FTUDQ2iBWqSO2kO//BdFrz6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPA1TQkZhbs1ZJfGCseBgJPyG7+4LsMuWYevHPFAjkPyfBwH96NJeG8OGbKW2LR17uVNZYP2SctoSsEVH0lHM+YKC5OrBC9UU3oAiGl3eoJO/F0ToLznpaRe9XxCVEzT4sWPDduF1Qpp5JpaHByD2Ua5p37mByb+3XC3lt6olSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCyJeXBo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCyJeXBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113216; x=1806649216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJ4Dq15RK4M6mzHsF8FTUDQ2iBWqSO2kO//BdFrz6DA=;
  b=bCyJeXBovYBaW8JFkGgKRZM1zkU4IeXOh7aOBuWbb5NE45kRyUGf07Gy
   gsn+W01yITbBBTykkjfpAp6v6GW0pb4pXG7NbMmcms78pRmepRZMUfQPr
   HJWWXO2PgT6j65ukAXdF43I913sTllV/j61bDZb9HfhER1DLdLObj6wN2
   R5XLLb1j17P7FZUKTRutB/SsoVj3r4ilqSE/bi86jTVsQpXJ6ETXvpHED
   KCRKVRJ8PfiVWNdaH//fCB/ZoQotbEtnORbFy6Dty/OfuRvBKF+UGr9i7
   m8d+eIgxTUCH3ZhWe+50gbUOSoWZvvFQrVkBeSZ2wyYiFK3ibq2zAG21B
   g==;
X-CSE-ConnectionGUID: KoJ4KZyVQbuWr5mOjrrUhA==
X-CSE-MsgGUID: HpcalSgrRkK2Ho0kv+LmRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053622"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053622"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:16 -0700
X-CSE-ConnectionGUID: X8Qzb7OiQTOJnPdElU6sQw==
X-CSE-MsgGUID: acMaGRbvTRO6VXETyWiWhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847753"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] iommu/vt-d: Block PASID attachment to nested domain with dirty tracking
Date: Thu,  2 Apr 2026 14:57:24 +0800
Message-ID: <20260402065734.1687476-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Kernel lacks dirty tracking support on nested domain attached to PASID,
fails the attachment early if nesting parent domain is dirty tracking
configured, otherwise dirty pages would be lost.

Cc: stable@vger.kernel.org
Fixes: 67f6f56b5912 ("iommu/vt-d: Add set_dev_pasid callback for nested domain")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20260330101108.12594-2-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..16c82ba47d30 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -148,6 +148,7 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
 	int ret;
@@ -155,10 +156,13 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
+	if (s2_domain->dirty_ops)
+		return -EINVAL;
+
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
+	ret = paging_domain_compatible(s2_domain, dev);
 	if (ret)
 		return ret;
 
-- 
2.43.0

