Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30613AD1C
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747959815; cv=none; b=N28zYYpfCCfqFXwQ/J4ylwxVeg7BpzcZdLZfAnw0Z0Ib+M23i7YpPJ7lMLEoOsoGd4j5bfHgQYbo3GPerqEglNRU+fRKTwTbr0s25Jhe7iTTBsysknNWq2kcjCxfzG6GVUu3XyaRlkGSzKqj1oAvF5vXIhL1L3tks39sKJzshYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747959815; c=relaxed/simple;
	bh=ni6/WBCjdM2RubNKz7PsaUr5XBFthV8eQFmuWwqwsnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRSuPpg8RPPL8vBkzn4e7g/6stVm00FSe0UEfsbAC+LCN62b0GsrZY0whYOddHIv9PvIAB8TGis2Q8ev7X7DlAgs8gW4sdO3uVZxA2mpgrx6RinGlxbqoV1xfYwrE+5tmsB6m4N+KFgYcLQMkVt6zxodzz7/fXbzueepjXqko4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbwIBKAY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbwIBKAY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747959814; x=1779495814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ni6/WBCjdM2RubNKz7PsaUr5XBFthV8eQFmuWwqwsnA=;
  b=KbwIBKAYJQE0T4zTCIwAp6oQMvQm6siTtPHLY42rs1papxPDuHZ+XehI
   SvC+kjOkZGNSouzSoHBH5byWuWp7AvwLYcQ8PmY3zrp3sI2Je3jjv833I
   0RdKBKk4DLLVVuxfZqDoEGNBTmjJgZbQkqd8FvDWqpA8GHfg4lY1C4HzQ
   k041N+RJ7rfJ+bozqpA/QRVmpMb5EjnQL57NHSECYtTFFesSixzoG6+xD
   veA9t0j+PzWxQOq/tfCCEeGBPa1RdFfYktCkuI0wBPAmJUNqSTgx0zHHW
   aXL80wx8P4YZc/11x7Id7361hxte2HHXH38KbkGTVJD176+K4GD/WbBEU
   Q==;
X-CSE-ConnectionGUID: 4ZXPqOqaQbyT9R86YnYL6w==
X-CSE-MsgGUID: Y2APtahYS0SzJrw6Zi8wSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="67570558"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="67570558"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 17:23:33 -0700
X-CSE-ConnectionGUID: i5JzeATaSPiTz7BG0vKbSQ==
X-CSE-MsgGUID: soLVEmIvSPu5NF+ajCyZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140665149"
Received: from ww-dev.sh.intel.com ([10.239.48.95])
  by orviesa009.jf.intel.com with ESMTP; 22 May 2025 17:23:31 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	yi.l.liu@intel.com,
	dwmw2@infradead.org,
	jroedel@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] iommu/vt-d: Remove the redundant logic in first_level_by_default()
Date: Fri, 23 May 2025 16:10:56 +0800
Message-ID: <20250523081056.223082-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This original implementation included redundant logic to determine whether
first-stage translation should be used by default. Simplify it and
preserve the original behavior:
- Returns false in legacy mode (no scalable mode support).
- Defaults to first-level translation when both FLTS and SLTS are
  supported.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb0b993bebb4..228da47ab7cd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1366,15 +1366,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  */
 static bool first_level_by_default(struct intel_iommu *iommu)
 {
-	/* Only SL is available in legacy mode */
-	if (!sm_supported(iommu))
-		return false;
-
-	/* Only level (either FL or SL) is available, just use it */
-	if (ecap_flts(iommu->ecap) ^ ecap_slts(iommu->ecap))
-		return ecap_flts(iommu->ecap);
-
-	return true;
+	return sm_supported(iommu) && ecap_flts(iommu->ecap);
 }
 
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
-- 
2.43.0

