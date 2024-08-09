Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523616C866
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183087; cv=none; b=sjSzG/DbpsrlEKwYPsCJ3c9TlFSf1Vui/1kx0b0Y7RvTDbDCPREmqUxuXydn9opWe3a50MQ0x0WyKdI2ahM4UhGuIxW1iqo1PMpVxGDld7N+2EgDGqT7KxD90M0mUouDBBFbtSbZw2i4lmlf0ZBJBs5QUaXNsIuuclMYip5WURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183087; c=relaxed/simple;
	bh=B+6em4UthMTuByvNjr21u/tD+rVpRmRx6QqDm8rjcJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+UEqL2yURiZM+3pQCGaIDJriYrSsCtj5v+wmaUzD18N2t9ffGP2AKWQoHe73fD/Y8PsRzQ4iXyixA5RhvRCWdOF51VOoGL9yRQiPVmCtebKYnY8nxvR2bSJIN61w0Nzu8QWig3RBmrORPgvU3qYbit3nQ8wr0urVAijKlLG+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+ERBb8C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+ERBb8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183086; x=1754719086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+6em4UthMTuByvNjr21u/tD+rVpRmRx6QqDm8rjcJU=;
  b=B+ERBb8CI9/RdwxncSKLzdx0wfLrS4tLcjYj6KsQZEsuxyE7afwswWDi
   Ngq7Lfh4WdMtSYAi41pR7bLqvWjxdG60n5kJMjWwgCIxT1PPEqJWk7JTb
   13+05T+EQbPzFkw8Kmc47chYBN/G2jo2gH8e4Ktkuw3SaxPln3Iv9KQ/Y
   b90vZJB2xEFTCjpt96yBe2gJGEuAaRHcVg0ssCFgu5+oVaJqAOGtqd5vA
   QQCe1pasFwFzuspQm0qs2fMQ/YM6GAjB2DM+x8hVxNoPn1gOY92KX5SCs
   ysM2QJ4uDAQlEV8/dsxmApV487BhmMeBoxOU3nu7p/aFz8FXxV+UHqF4L
   g==;
X-CSE-ConnectionGUID: i4s9+j1RTv67D4tRa+Zu6Q==
X-CSE-MsgGUID: gNkUeeWvTLie5d09PbJ+CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469115"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:05 -0700
X-CSE-ConnectionGUID: hNMVCE8xQ5mjuc2GGhrVZg==
X-CSE-MsgGUID: 228R14gBSQ2lng4quV72hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540867"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 1/7] iommu/vt-d: Require DMA domain if hardware not support passthrough
Date: Fri,  9 Aug 2024 13:54:25 +0800
Message-Id: <20240809055431.36513-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

