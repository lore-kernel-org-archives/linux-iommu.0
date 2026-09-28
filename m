Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4F3515EF
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566767; cv=none; b=k2Ez/an5EBU+Pqsw7Ef3I2bAbPOlfY6zNxABqNbHrnKdmvY5pYSn1XOXUbSnMKG3TqC1LCjGpGGj+a5hhaflaFqQI3DPNCEcm7idl/b5nVNxVvih4mKXvj6wSGVkegfeqOdPwmOeunSqeunM9pkpQZwfoXgfvF3GCCme0XezSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566767; c=relaxed/simple;
	bh=EGNVYAwTr7rKbSsK9M+IVrkc5C3CMUwBnCSK5k6iy6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JP1yVlAuIKADg2Vyd38GVrCGGQMdg1IqrmfL3jIsUkZi8ByEleSqK+v+5mXQsOUb4Dmkd+dFCiht29zkJb3p/C1b/AtyGACKpY1HZrbWm2xvjLN2WSUy1xak0tvU2vL1ioO7gGeatOL3EJNO8EBsJvEk0eOLvPYjqMlyKInBTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkDdeOx4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkDdeOx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566766; x=1822102766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EGNVYAwTr7rKbSsK9M+IVrkc5C3CMUwBnCSK5k6iy6Y=;
  b=nkDdeOx4fNDNasRX96TDTR6XZ0KyPurThwjQiaODv9CaAggN7S9VBMbT
   E1ZSamvB6u1N72uwAWNGNX7cRCrxknAwjkiIUBUz1oavvQttz8A2+tJRh
   iLjJLufwzlmJ4e03HTvWvrAIrE1/ghDcZyFx8SMqPRHQ+H6inQYHHWE+U
   GOCtVo3sox7N0J9k3MkQ3GqbWxwbIBACide22kKQlRs7KtytrK7Gd6QhF
   1RmeXZGi83EPyRUUAeXl+3W7efnKYjix/JbJP5fxJhVw7DVphYNEHQcjm
   w4gOMnzwQ64yQHjJu3K2g25q/jOIeOibbk535KjGdZ73u33fVPphxiiTp
   g==;
X-CSE-ConnectionGUID: +h1KJYVDRpi0mwhgY0F5Rw==
X-CSE-MsgGUID: QaYltX8bSeKO2H+/i0OP6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917215"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917215"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:25 -0700
X-CSE-ConnectionGUID: L3BHSds4QWiRXcN5o0ViaQ==
X-CSE-MsgGUID: 5VFduzyHStm0vypCKhKl1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004102"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] iommu/vt-d: Use old domain parameter when attaching the blocking domain
Date: Mon, 28 Sep 2026 11:27:19 +0800
Message-ID: <20260928032722.2868623-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

blocking_domain_attach_dev() drops the old domain’s iopf reference using
info->domain, but that value may already be cleared by
device_block_translation().

On attach failure fallback paths, this can cause the function to drop a
NULL-domain ref instead of @old, leaking the real old-domain reference.
Repeated leaks grow info->iopf_refcount, keep the device stuck on the
iopf queue, and can trigger WARN_ON(info->iopf_refcount) when PRI is
disabled.

Use the core-provided @old parameter directly. It always identifies the
correct domain to release and matches other attach paths.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c9e246e8f8e2..1fb9b80f3b5e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2899,9 +2899,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev,
 				      struct iommu_domain *old)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-
-	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
+	iopf_for_domain_remove(old, dev);
 	device_block_translation(dev);
 	return 0;
 }
-- 
2.43.0

