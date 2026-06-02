Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C2394E91
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443417; cv=none; b=ife4WEo+/ICLlO3FkbVSrsO/FVlyP7P9eOu0DCP8JDTXjZaO+4kJIgiJdw5GP8tYKwrG79udy1HWRsaavsGCZiZcHpa0U0GN2jp726d9gkQKdhSi4fatE9NCuVzqmHENGh0cnVWg289Ce5IE6XEJsMfY/eke2MSwc9Jfz8hTZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443417; c=relaxed/simple;
	bh=lk+QXBIHW2Uv+ZVyv3jxFQlkkLl5igDptN3oRqoYpls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liyFvHj7PH1JKG+WOSWlo+p703IsyYlAJTuGOjmyLtrQj5jVh494RNffr+TLNYLPmOoQdmp4dXUvowKlSiUmXdM5dDWkWCt8iJxjr9V1/d9dYiElGTF6jIl50v4SDBgXpKgwlX7uVM6z5rM1Lj2nkgWxTU8x97GFJb3BGC1bcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUFT6DpX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUFT6DpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443412; x=1811979412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lk+QXBIHW2Uv+ZVyv3jxFQlkkLl5igDptN3oRqoYpls=;
  b=hUFT6DpX4BPz79mLTkvSOTKQLrkbz0q3v1+axo7IuC8UnF2+yakEdV/0
   j4csjRnyf+ohTbRY6hTRt9wgxeweS6YpaCaed5ZEn+6LjSAQpLRc3kV7q
   JI1AVYbBwYjIw4E8H/xvvBga1ziNcFWEdElZgebXK6RicCc96fNwiH6JI
   kzHQ/mln07Um5J840A5z0CFRhH9h2n9qBtYNz95n8bSjHiSpaOI5JjqSj
   ePMPgqLiNAMvFljKYu5lSGbJigY9yiXW69h8KCvNcOGmPxFVfDj6wKsKj
   xmgvceqmCojiYkrAECOchNhS11J3N5d61xJUtPeGvkzxSopR8wnG9kNYB
   A==;
X-CSE-ConnectionGUID: acCZXLgpQU2oEJNeF69msQ==
X-CSE-MsgGUID: nEboi31fQ7mBzV55xqRGBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369720"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:36:52 -0700
X-CSE-ConnectionGUID: YrLYTcTbSgO943930VcgJQ==
X-CSE-MsgGUID: jLMXqtcFR3aXwTJ773Y5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241068749"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 02 Jun 2026 16:36:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iommu/vt-d: Remove typo from pasid_pte_config_nested()
Date: Wed,  3 Jun 2026 07:34:22 +0800
Message-ID: <20260602233426.357499-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602233426.357499-1-baolu.lu@linux.intel.com>
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
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

