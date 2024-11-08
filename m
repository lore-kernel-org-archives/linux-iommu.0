Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD317591
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032126; cv=none; b=iz269w33aBVcITd8DK8NQvLAs8tew2dNrtLS1r0XDdoTkT0AwQEzT5SavwqR3hmaWsErZ2rAaLWdco1ZqYKkfNyxZRC93iNo6vzwx4RuPsKvH7DJxF4G0IyKk5nLXihKUUoIPi0i8Jlw30gnXSGjAporMY5FR2HW7H8FvYLnKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032126; c=relaxed/simple;
	bh=pqHDOW5sBvGO4ig/n9Yg0pA/3ZOlK4rABgySVhuXXYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHaQhY43feT6XQXB2KWfnMUAv2QFRnhH5WBAgytRM/+dmKdY91KZdDJK048xAYc2LPNnP5cRqifbmvv7yqBYT7RVGbHBP8mMJDV2jRmTmcLfN1Ovwv7+krwIkDzabNR39AtRVtjLjvfPMICMPDeAr7O3sjZRPA6VdTxUVSIQzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcRl68Bs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcRl68Bs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032125; x=1762568125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqHDOW5sBvGO4ig/n9Yg0pA/3ZOlK4rABgySVhuXXYc=;
  b=NcRl68BsE/0DKcrL0zsOo6svsWVNOTERzse2BaLIe2KEzn5pCEH7wxVM
   rOgswW4dU7FdTk1PmkFf+bNy0WsEUVmw3TmGWQervfTOcqy3DA4HsyJOt
   fjiwJQjuOxS1DU3LfaoJZUy1UWITE0hAC8BtH46IAAf4VInCO5Ihz6c6W
   O3wkjggbRzo3BYeb28bQXvlsGDxaM2V74i0aXdAzL1psz7Nm8hW2lo4nY
   AUfzhHTsACJpscz2dNwpykfkIQzpgGQpKbTtUPkbF5Tq9OH0FEDz46YWr
   JBBRlpBj8rwMd0Mf1gVFiBEn0LvXmVt7krrFBgya/AXnSzrFy8sd2+ICJ
   Q==;
X-CSE-ConnectionGUID: pslXcvjQRiWX47jRMSmdvw==
X-CSE-MsgGUID: KHbtxACfQvW/76bV2bJ9uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007839"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:20 -0800
X-CSE-ConnectionGUID: munm1iUKQb+yfylhPl+4Cw==
X-CSE-MsgGUID: T2T+qyOwRmeTIHSyHLNfNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213831"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:15 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] iommu/vt-d: Make intel_svm_set_dev_pasid() support domain replacement
Date: Fri,  8 Nov 2024 10:14:00 +0800
Message-ID: <20241108021406.173972-10-baolu.lu@linux.intel.com>
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

Make intel_svm_set_dev_pasid() support replacement.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-10-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 8 ++++----
 drivers/iommu/intel/iommu.h | 5 +++++
 drivers/iommu/intel/svm.c   | 5 +++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f3ccbe516dcb..251cfebe6226 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1752,10 +1752,10 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	intel_context_flush_present(info, context, did, true);
 }
 
-static int __domain_setup_first_level(struct intel_iommu *iommu,
-				      struct device *dev, ioasid_t pasid,
-				      u16 did, pgd_t *pgd, int flags,
-				      struct iommu_domain *old)
+int __domain_setup_first_level(struct intel_iommu *iommu,
+			       struct device *dev, ioasid_t pasid,
+			       u16 did, pgd_t *pgd, int flags,
+			       struct iommu_domain *old)
 {
 	if (!old)
 		return intel_pasid_setup_first_level(iommu, dev, pgd,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cdca7d5061a7..d23977cc7d90 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1250,6 +1250,11 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 void domain_remove_dev_pasid(struct iommu_domain *domain,
 			     struct device *dev, ioasid_t pasid);
 
+int __domain_setup_first_level(struct intel_iommu *iommu,
+			       struct device *dev, ioasid_t pasid,
+			       u16 did, pgd_t *pgd, int flags,
+			       struct iommu_domain *old);
+
 int dmar_ir_support(void);
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6c0685ea8466..f5569347591f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -127,8 +127,9 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
-					    FLPT_DEFAULT_DID, sflags);
+	ret = __domain_setup_first_level(iommu, dev, pasid,
+					 FLPT_DEFAULT_DID, mm->pgd,
+					 sflags, old);
 	if (ret)
 		goto out_remove_dev_pasid;
 
-- 
2.43.0

