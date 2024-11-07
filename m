Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188120FAAD
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982163; cv=none; b=MSMAV01Xi4cAh8i22iQ9px70J4GunUrTlHneOFF0zqJe5GUMdw7bJNGBB9VBLmXhTN61FiAVNG6k1/oQdzEYxCh5lXj5bWjIVOYcFYTBjjtZbsIcC+DeRG1jkGM5l5oxQqj0nFDyJ3vePX8u1pHhQK3NNLDVFfYAHaYfSOhC1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982163; c=relaxed/simple;
	bh=BGpYuh/YYhfW/hLpJaRocFAPmWSngUp5Fa1W/C5ceWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCGi3f1Jq5yvPmhwDppHbxW6VYgJ1R3C9zpFSCiELLWWldKj86FOcE9XxIC1TIOEujxyFuDuIJyDlDE6E04MXDTTjbDpn9IRu+oLq2OnYMhjYFHWgSGIr8Th5Z8JxbMytqw2FcM6smxY0LoNFy2rvILGmEr605O7D0vz6lbBkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu6VI1CX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu6VI1CX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730982161; x=1762518161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGpYuh/YYhfW/hLpJaRocFAPmWSngUp5Fa1W/C5ceWc=;
  b=Gu6VI1CXLZ3PgyHseWmujHlW6pQlI3y+zgS5la+WK3N0fTXftR5/L8pB
   P/XSlXXJbXC2lZaYOfG0C8ufrCJOUQnbfdkXKxT3Ofw8CtfSpho3npTAF
   GX+0moAHNgwBGk9GOK38l16kxI6gXagiL7ysiIkXL3lrEan8Jh9Vp+48W
   66M9dHEdm+ySeLp9EWbWxCUzWGD4GwhiLZM5wIum0C/NyUka8etn63ugZ
   HcCoiHvvWQlSiIQhEhVnsfwzX32cFNGDLVITTdVkkoWH+pV46bnWXtmyP
   IbSlRo7vigm3FRDpNC/a4aWzecMj7hItkEjuwiM1VWyv/xK9+e+t9U+Ep
   g==;
X-CSE-ConnectionGUID: Dpzjs3nST4GEbpimK2m6rw==
X-CSE-MsgGUID: lX7hrZ9vSxWnSPNb+8Ap+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34744616"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34744616"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:22:38 -0800
X-CSE-ConnectionGUID: dDcCdXDfTOuEBg9DrT/h4w==
X-CSE-MsgGUID: nO8csxGES2W7eDa47BoNuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="90180576"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 04:22:39 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v6 06/13] iommu/vt-d: Add iommu_domain_did() to get did
Date: Thu,  7 Nov 2024 04:22:27 -0800
Message-Id: <20241107122234.7424-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107122234.7424-1-yi.l.liu@intel.com>
References: <20241107122234.7424-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

domain_id_iommu() does not support SVA type and identity type domains.
Add iommu_domain_did() to support all domain types.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
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
2.34.1

