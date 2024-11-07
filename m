Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9920FAAD
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982165; cv=none; b=JjdP18OR76uq06gRY5iyAUFupgK2MkecZFUFfgvh1xurTbtWHfopLAapHA7FRIgY37dyFE7OeBKnMdcCQuRLHD9+VWGgfNVsLJUMmOLGZ6+UPuc3Ip8SFtwbIq4QarB1xJjErcRI/6JOrbOU42iUeFxDyOLIf+l4554fTHIPF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982165; c=relaxed/simple;
	bh=eN1brumGZm1DOEHRsvSaTj1vMJ7Ez8a6+p6iWljH5ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCqqze3zxz0xgEg/xmg6N6mFar+sg/rtTv9TlUISChUA8KIlQ2SjtWqfh2VxpuElPpMZc65YXgERW/LeqbQVtCTyrKjCYgVWGWTQ5NrDLnirT4iGxwzcGlrnW+SWa/zMJQQzFPttOSQL05M+CvSKMIfa5MraDThKS8a8dIE6fAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asGW7IJR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asGW7IJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730982163; x=1762518163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eN1brumGZm1DOEHRsvSaTj1vMJ7Ez8a6+p6iWljH5ac=;
  b=asGW7IJRUwbgCGtcu4yYrOitRZ01sHp007STN2D3W37vqyPi3G1/Qjom
   oTKN8GecPbNWqCzjZEJCiSBqH3ouEIfq5U66ZRMfnEHCj0rrU4PBAMyly
   l/xC36gIGEd5glU0b1gUIpvhCmw/VTzEhEUytLspBgFuBABa8ZEaE54Wv
   wSChKNnuhg001iMx48Ci8IY93pqPSdTvg/VYVojHmKz38jBfTDn6j1Iai
   cCfi4tW2IRR8NGBO7NovCIO6M+Q7XyYjvNI9W5UtUOO1dxWAHT4cp+J9J
   34br1Lw3kDZrpkEYCIGOtSQOsLxaAtlJYvv/j0A4EuzHERaWTCWSpIPgQ
   Q==;
X-CSE-ConnectionGUID: tH+31C8OSXWxo3wh+5N9NA==
X-CSE-MsgGUID: Uo5jJARKQoCVcok0diAfnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34744647"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34744647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:22:40 -0800
X-CSE-ConnectionGUID: Z5LRhY+9RWKaAiOTCaOfug==
X-CSE-MsgGUID: kgrfU8pSS+SNokB0q93yJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="90180596"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 04:22:41 -0800
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
Subject: [PATCH v6 09/13] iommu/vt-d: Make intel_svm_set_dev_pasid() support domain replacement
Date: Thu,  7 Nov 2024 04:22:30 -0800
Message-Id: <20241107122234.7424-10-yi.l.liu@intel.com>
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

Make intel_svm_set_dev_pasid() support replacement.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 8 ++++----
 drivers/iommu/intel/iommu.h | 5 +++++
 drivers/iommu/intel/svm.c   | 5 +++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3c1b92fa5877..06a7c4bf31e0 100644
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
2.34.1

