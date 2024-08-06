Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A4DF71
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912195; cv=none; b=C3mbgmJJlda1LrLuPv2zGL4lbtF4i4GPOUXtzil93zVXm2UOykB705DimB3kNFyf78qCeFjzJDppHXj7rhTdTlNRFEmZIrDjQ4AIDxu+Z7Yag85OP1sUPuXUdQvYFSV/HdHI5ALEYx+++UNHTU+5KJG9XaY0X8O/ktwkUHht5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912195; c=relaxed/simple;
	bh=wv58EET3WPiGTK9JJMk/b9Ols/RUHJCB3khJbO8AXvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etVzJj1/8r4gd8K1v1PFwdduoRGZw8M1P4bZn7OvOepocM9/dZZWN5jQd3zqUruU7lFPr5yp+jFS53rshmk1eLrqfx3nYBVxDVFxGEmTGYEgDEz+0N8FBnmcsmxMRToMKdfIKkR7KaRAgo5fwo3O/Z5FZm8LPLbeB9pQeAQgCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTj+KJPu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTj+KJPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722912194; x=1754448194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wv58EET3WPiGTK9JJMk/b9Ols/RUHJCB3khJbO8AXvY=;
  b=jTj+KJPuy4iI4ZqSaK8ekIaIG/ARPeS33azBqezWIkEl6Y+2P/HZAwRW
   hOhWDWx+Fr40EhuG9X/Hemf8QmydqhtWh7J3jZzzql3pk3yXiDRijGS6Q
   /CHQxF64SS0oNMPndXLBIep81qVjuB8ex/f+RZO/PBScpq12Qdiw0iM5p
   GPw/jOp8VzPG4weOBjFmbM/d3+ejhFiCt5xJNz3sKr2GM/YdJzbPpt/2P
   hyrqNayLc7pe5fz/4YZra4NIXuqQ5cCgWmGWXZuj7SLQB5lWf0yP4MNho
   iFSOnHZgZ+b0oNTgNr9rFyLM7wRG7cnuGUkDFJYHpZldkP0upfmv2YZgI
   Q==;
X-CSE-ConnectionGUID: QEmRNP6mRKmHCPm+8gv+UA==
X-CSE-MsgGUID: VnvFh1ODQxyVAToi7eosLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20756258"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20756258"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:43:14 -0700
X-CSE-ConnectionGUID: vuyOKkI0RXKNe1+yQmcZRw==
X-CSE-MsgGUID: 87et/yEaTLy55uX7/OMovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56572515"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2024 19:43:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/7] iommu/vt-d: Require DMA domain if hardware not support passthrough
Date: Tue,  6 Aug 2024 10:39:35 +0800
Message-Id: <20240806023941.93454-2-baolu.lu@linux.intel.com>
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

The iommu core defines the def_domain_type callback to query the iommu
driver about hardware capability and quirks. The iommu driver should
declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-through
capability.

Earlier VT-d hardware implementations did not support pass-through
translation mode. The iommu driver relied on a paging domain with all
physical system memory addresses identically mapped to the same IOVA
to simulate pass-through translation before the def_domain_type was
introduced and it has been kept until now. It's time to adjust it now
to make the Intel iommu driver follow the def_domain_type semantics.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..90ad794a1be7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2149,6 +2149,16 @@ static bool device_rmrr_is_relaxable(struct device *dev)
 
 static int device_def_domain_type(struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	/*
+	 * Hardware does not support the passthrough translation mode.
+	 * Always use a dynamaic mapping domain.
+	 */
+	if (!ecap_pass_through(iommu->ecap))
+		return IOMMU_DOMAIN_DMA;
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-- 
2.34.1

