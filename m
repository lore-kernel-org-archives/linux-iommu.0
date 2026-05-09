Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9533F8BE
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348710; cv=none; b=BVXerLZP0xjDwjG8+wVpskcJYFdMYqZSdjP/RR2hBi079dwLsAJAPi1DqFsVyFW0UuLzHYr1Hh+hrWq0xuHo8rEFjkE9r+uDmxDMD7BN71NMzVQKsJ3XbNTmcUS+F4R1Fw/wKK0Ue+QYJllMn04M0hv0AvOjr3QAgcDFhcl1TaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348710; c=relaxed/simple;
	bh=MJrjIRkU9VgyxMXB9VRxXJUH1BjymHLlgf244bw2WRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLpYjgKKC9GWdGLH/jjuuPGMZBgeQU59ASXKAY/HbCF6hRfKDn58v1Tx2AOgDcZtb4xdpBvdbr+aiVN/2G1/iFi2BBELkfRVaU6DUNeitFb42PqBvf0M5F04swv2unJ+j6PyTlumlHl2LT61uPrYnopxA1G0cEnagcrYOIrNT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjOOJ1y5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjOOJ1y5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778348708; x=1809884708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MJrjIRkU9VgyxMXB9VRxXJUH1BjymHLlgf244bw2WRs=;
  b=gjOOJ1y57vzQvQubMSujCNoBUXcBsrQAR/P8WJalTf7ZDtN47DpmDSCA
   KHC5G+KJ0xBHRZ7YsxAdO7liW7T457ngzADPwXeIaGpGOaonCR3sw0dRv
   CsR9fdsWEu6Hlb/9t7B06ie+XvOpSap5wfIU3h0+xpslPWL6aaixbzqGl
   fAQqmGnzwvUr2eCY+i2B4Okrfk68MWSrKSN3HNxkYdrkxXn/2+lDmWIjD
   aXPZN37FpqV374/hbxnhysruYewUP14VmVQBP0SYUeu3hKA19YVtzldrq
   ks/RBHciaqliOqF+bstP2yWT5s+yr5Zm+cudyvWr6SmwtR+ubj5s9mvpH
   A==;
X-CSE-ConnectionGUID: scHgP/R7RgCRt7Q8BR039A==
X-CSE-MsgGUID: 7TUEF+AcR/e9UTEKCGcn3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79337441"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79337441"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 10:45:07 -0700
X-CSE-ConnectionGUID: +TPEgRKfQFq+zJEXlygVUQ==
X-CSE-MsgGUID: uaurjwtyRYqcQbjlktvb9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="275178354"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by orviesa001.jf.intel.com with ESMTP; 09 May 2026 10:45:06 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
Subject: [PATCH] iommu/vt-d: remove typo from pasid_pte_config_nested()
Date: Sat,  9 May 2026 19:45:03 +0200
Message-ID: <20260509174503.831134-1-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Rename pasid_pte_config_nestd() into pasid_pte_config_nested(). Do it to
match other function names ending with _nested().

Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
---
 drivers/iommu/intel/pasid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 89541b74ab8c..3b39a9ea338c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -618,7 +618,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	intel_pasid_flush_present(iommu, dev, pasid, did, pte);
 }
 
-static void pasid_pte_config_nestd(struct intel_iommu *iommu,
+static void pasid_pte_config_nested(struct intel_iommu *iommu,
 				   struct pasid_entry *pte,
 				   struct iommu_hwpt_vtd_s1 *s1_cfg,
 				   struct dmar_domain *s2_domain,
@@ -720,7 +720,7 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 		return -EBUSY;
 	}
 
-	pasid_pte_config_nestd(iommu, pte, s1_cfg, s2_domain, did);
+	pasid_pte_config_nested(iommu, pte, s1_cfg, s2_domain, did);
 	spin_unlock(&iommu->lock);
 
 	pasid_flush_caches(iommu, pte, pasid, did);
-- 
2.45.2

