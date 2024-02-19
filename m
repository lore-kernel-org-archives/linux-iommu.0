Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1712D03B
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341723; cv=none; b=LV2H5p0AlYUgyyVLpPdYxY6b546rl8Q33xAdZVqxw5x2b1hv7ot9WXrfp7z6lwoqAgsuigSu6T9xAFMrVT0BKBl8+vSC+b7f8uh2z3Q4SaLWvAmH83Bg75f5Pt+WCP4N+1OtpIgjOLQ7oqg4k7cZYSQrSVhVJlqgDIjXAZqmdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341723; c=relaxed/simple;
	bh=MrZgKSOW1tjC5BJ1Aj4vy1HeG1IeCVgQtjxOHw/lyVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZPIZKOvUrjQTY9MWpHM0TgGLKkBoO0XvpycIGFHMY7Q3MsSJLWrQzrSr6GIySx7hskB0ZrE+mIVvtGEImA/FlSm4cLWdUv5bg9r2ToVcdfYcJFc2I1T9IcMHXQnqlvJWGMY7oo/eeXHvRyTVPVRPzPSwPSOnTCI1SUUiiqqP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPl5sCRQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPl5sCRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341722; x=1739877722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrZgKSOW1tjC5BJ1Aj4vy1HeG1IeCVgQtjxOHw/lyVA=;
  b=GPl5sCRQpuehZoDDCMa03BX4lisoJBZ8YFQm1h4UZQCfCKbTNMHO+8iF
   gnG09ZOT0prQTNC3WAYWOuEQrDVfcukkTZ/5sU7LrNnO3PE6F7SSjAld+
   XOE4TmsL73mhwZ5YtwCkfVQLIThPlpYbFZT77ij93Qmivgtud1zu2aG2Z
   w07J0tjwC77Q0cezWXrgKAXOX3t0TXltFSzNORvKedRugwgll6vtWsVCI
   zOI+uPfkNmgmheN6Lb/YV0+V3KcCs36pa0ak8ZSqlMyoifExPrbuxd9Vp
   tBDih3+6yGlZJMBnyMhtM8rKOAr0cynigS4fgSp8/8Fsp6wvCBC1k2Q2e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823362"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826822"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:00 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] iommu/vt-d: Update iotlb in nested domain attach
Date: Mon, 19 Feb 2024 19:15:55 +0800
Message-Id: <20240219111601.96405-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Should call domain_update_iotlb() to update the has_iotlb_device flag
of the domain after attaching device to nested domain. Without it, this
flag is not set properly and would result in missing device TLB flush.

Fixes: 9838f2bb6b6b ("iommu/vt-d: Set the nested domain to a device")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-5-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  | 1 +
 drivers/iommu/intel/iommu.c  | 4 +---
 drivers/iommu/intel/nested.c | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9b27edb73aa9..4145c04cb1c6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1066,6 +1066,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
+void domain_update_iotlb(struct dmar_domain *domain);
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e3dbcae95975..711c3e3fe095 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -396,8 +396,6 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	return nid;
 }
 
-static void domain_update_iotlb(struct dmar_domain *domain);
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -1218,7 +1216,7 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 	return NULL;
 }
 
-static void domain_update_iotlb(struct dmar_domain *domain)
+void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 6a75f6eb18f1..d5af5925a31c 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -65,6 +65,8 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	domain_update_iotlb(dmar_domain);
+
 	return 0;
 }
 
-- 
2.34.1

