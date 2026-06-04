Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E93D525B
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553137; cv=none; b=fI/otvJAdOq0wrOM8cP1cu1VJeU6oRRv90St7XenppqFtkcTU476tGO17YHYkY4ebFKQnRqCx68VHkG1L0snpujR+uy5pj+vW/dl4dr7WiHzsh9+oQTIO5/5e1DTcafH2Js4Yeot4JteTO49wu9kBb7bwL72gipcXZqOjPc+9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553137; c=relaxed/simple;
	bh=lk+QXBIHW2Uv+ZVyv3jxFQlkkLl5igDptN3oRqoYpls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klc1+mQRs6EFsV7F1zoCF+KQPlxj6PTRcK5vMbmpZJN7U64LSHV2B01qTKSwmJS0U7jH9KM4za+dm7CL9oqdnWOVOoAJlh4Zgn6BP4FRy+iamET7Jq/PeRUs/rqKF6WR7NmzBLPvPx9JzbPHziAeMF5cU0HBjRk+85nj/yoTWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxH4j3hf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxH4j3hf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553137; x=1812089137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lk+QXBIHW2Uv+ZVyv3jxFQlkkLl5igDptN3oRqoYpls=;
  b=UxH4j3hfRbTJsDQ+B56/iOBwNloA7MHEGI2v6Tr7u97WcXoI1HBkRHPK
   mduKmJYTqlDKS+nGJArjtbOnJdkmgJVNqhLYrzWtsWOsMFmwYIWJ+I87T
   4u7TRC0+gEZ9uTfhmI0NJH95eeEOWGZFX+TQZ2xq6cVT2OYtuNmA1zSjr
   jvOntW/ZXQR6mWIFhw2UqYaMjNITSd2NRkxv/6M0GGzL1t2tzfBT+JyJe
   A72YExl49BSUIRw5mvFxZ+THfHnHgcfQagxxaMcV5gFRf1cQJLcseIsnz
   8I+lIFfh3DMSPwzRdn+aNAc4xDxuHLw5wdjMsiOg8HxPPJjA2pRt/zOUx
   w==;
X-CSE-ConnectionGUID: EgCthG1WTJGvRPiinNacUg==
X-CSE-MsgGUID: sKlzYKbQRpqMYP6MXG4psg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81554250"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81554250"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:05:37 -0700
X-CSE-ConnectionGUID: ZU41HM9bS/OMStdCOuNrPQ==
X-CSE-MsgGUID: JY+tLDYbRXiurXHSdjwUug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268112164"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2026 23:05:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iommu/vt-d: Remove typo from pasid_pte_config_nested()
Date: Thu,  4 Jun 2026 14:03:08 +0800
Message-ID: <20260604060311.365074-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604060311.365074-1-baolu.lu@linux.intel.com>
References: <20260604060311.365074-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Grzelak <michal.grzelak@intel.com>

Rename pasid_pte_config_nestd() into pasid_pte_config_nested(). Do it to
match other function names ending with _nested().

Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://lore.kernel.org/r/20260509174503.831134-1-michal.grzelak@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 40910dc7363b..81353fd46b37 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -618,11 +618,11 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	intel_pasid_flush_present(iommu, dev, pasid, did, pte);
 }
 
-static void pasid_pte_config_nestd(struct intel_iommu *iommu,
-				   struct pasid_entry *pte,
-				   struct iommu_hwpt_vtd_s1 *s1_cfg,
-				   struct dmar_domain *s2_domain,
-				   u16 did)
+static void pasid_pte_config_nested(struct intel_iommu *iommu,
+				    struct pasid_entry *pte,
+				    struct iommu_hwpt_vtd_s1 *s1_cfg,
+				    struct dmar_domain *s2_domain,
+				    u16 did)
 {
 	struct pt_iommu_vtdss_hw_info pt_info;
 
@@ -720,7 +720,7 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 		return -EBUSY;
 	}
 
-	pasid_pte_config_nestd(iommu, pte, s1_cfg, s2_domain, did);
+	pasid_pte_config_nested(iommu, pte, s1_cfg, s2_domain, did);
 	spin_unlock(&iommu->lock);
 
 	pasid_flush_caches(iommu, pte, pasid, did);
-- 
2.43.0

