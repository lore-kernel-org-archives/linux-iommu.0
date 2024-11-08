Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01634146D40
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032112; cv=none; b=qaNdXNcv+yumiN0G6u45ADacGjh0iCZallCEJu0HhhakNCqs+7XxJMhDJtEw/uSeCQDirZd3erGOjnSdzMUz57KPV5qLxoZ+LH4Uvaz25WM1wVHQ4FA1QwTM0AT/Ibyg7nuK6N/9fUzmrX0DFiIy20ODFgyc5ZUjSCkkn0/R5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032112; c=relaxed/simple;
	bh=LQpx7CSmSpTBh60RHww69MTJ763Qtw2J6tMyE6wshwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXkfYAeAxGiUtf/YFdp/JEduzt5jWgZREeKwBQR+W+oHuH6lJDvJraPlq26XPYoPSgoidsBiJ3phQDJdQhSiGSYdovBWowfWZ7xhDCEFvBMr3srSfriqBSF3hKtXFXi0/GESeFACShBbnEfIIqCD6zlIBDu8wyp332bv4szt54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIRt4RXG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIRt4RXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032111; x=1762568111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQpx7CSmSpTBh60RHww69MTJ763Qtw2J6tMyE6wshwU=;
  b=SIRt4RXGiNrqcBHBIgSlmSQdf80r89VPqdb3HFH4ILMBcVoyElJs+Or2
   S+q2vLzUXLrp0Pp826eb31HJAWCQlX4o4vxJxzRbb/HPu3Y7F/cGTy9rW
   wCUDOR66pFi2PXo1t+x5+E5Ur3LlcI7IBghJDQEPKpe04c985FQkO4ZH2
   ivQXjXvNheWIiVxSnqHouwc6yiV1j3kg0MmaoBx09OQVTLwa18JnH1gJ/
   UIqsds5ZZq1j1eiXZSRVg8Cy28jiCTqK85derS8B257jnvDxhV5YhhCAt
   1njXibK5XinDYqu+j3q/aL1FgBjfKB2yBP6P3BBWUd0GSu3iiqNNWdKzC
   w==;
X-CSE-ConnectionGUID: +1i91y6GTmCvZduizKkLPw==
X-CSE-MsgGUID: 3R6gofYCTdKe3U4SaBbSuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007797"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007797"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:10 -0800
X-CSE-ConnectionGUID: IF9fWNraSY+lul1foHWNcQ==
X-CSE-MsgGUID: H1Go0SzvR8qaStFPqcuCaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213803"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:08 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] iommu/vt-d: Add iommu_domain_did() to get did
Date: Fri,  8 Nov 2024 10:13:57 +0800
Message-ID: <20241108021406.173972-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

domain_id_iommu() does not support SVA type and identity type domains.
Add iommu_domain_did() to support all domain types.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-7-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 16 ++++++++++++++++
 drivers/iommu/intel/pasid.h |  7 -------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index df0261e03fad..cdca7d5061a7 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -806,6 +806,13 @@ static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
 	return container_of(dom, struct dmar_domain, domain);
 }
 
+/*
+ * Domain ID reserved for pasid entries programmed for first-level
+ * only and pass-through transfer modes.
+ */
+#define FLPT_DEFAULT_DID		1
+#define NUM_RESERVED_DID		2
+
 /* Retrieve the domain ID which has allocated to the domain */
 static inline u16
 domain_id_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
@@ -816,6 +823,15 @@ domain_id_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	return info->did;
 }
 
+static inline u16
+iommu_domain_did(struct iommu_domain *domain, struct intel_iommu *iommu)
+{
+	if (domain->type == IOMMU_DOMAIN_SVA ||
+	    domain->type == IOMMU_DOMAIN_IDENTITY)
+		return FLPT_DEFAULT_DID;
+	return domain_id_iommu(to_dmar_domain(domain), iommu);
+}
+
 /*
  * 0: readable
  * 1: writable
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 06d1f7006d01..082f4fe20216 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -22,13 +22,6 @@
 #define is_pasid_enabled(entry)		(((entry)->lo >> 3) & 0x1)
 #define get_pasid_dir_size(entry)	(1 << ((((entry)->lo >> 9) & 0x7) + 7))
 
-/*
- * Domain ID reserved for pasid entries programmed for first-level
- * only and pass-through transfer modes.
- */
-#define FLPT_DEFAULT_DID		1
-#define NUM_RESERVED_DID		2
-
 #define PASID_FLAG_NESTED		BIT(1)
 #define PASID_FLAG_PAGE_SNOOP		BIT(2)
 
-- 
2.43.0

