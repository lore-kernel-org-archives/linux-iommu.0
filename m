Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90025411680
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811715; cv=none; b=Lh3IwV14khRQsM82mWd5JNjzpTvEn2R3WrZNpF8XzwI3Y3/7tfyG3N7keFxcaRIzcE1Qo5DIGaHrU+jXZ3f43YnyzoCvUaT9bQxVwGctf6rt9xBePRYBi+t/tqmkVc9FRLTRvdO4fz2VkkCHf2PP5MSsUIxt/tN2FL6lU3BYBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811715; c=relaxed/simple;
	bh=zamAuPAssF3V8Notwmfjg78q2xg+FerxZ7Cp1BRqTfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfQAQfiLXsEtzvsQ+hN5NLGboobdhw7X0xG+byjtILIPavsAlY7+feQksAs489I6hh9Ayv0Ez917+SodMRNOdthLiNTsIeknh7bTIvrW1QbzGvRryob6F/UXsRM9aPjV6smc13V04rwypYXEk0wI6VwqXRxGd34a22ZmDLj3NTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZOoQswc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZOoQswc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811711; x=1817347711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zamAuPAssF3V8Notwmfjg78q2xg+FerxZ7Cp1BRqTfQ=;
  b=XZOoQswcsFjNub4KSqsY0cgqH2t6gFlPJaYrfA6nDExCPqjgd1BnfVQi
   aAzm1COY17bycVBOKuutsXh5JeDiZqK0S3HofwWgfqlGRiBfkNqklayvF
   Ywe0/8livODt1mFnpgly8I96UxvMr6BOl8qnokXlVEgLCVFlV1Hkksq8W
   spQPDxHHGFD1tfqHNY4L2PfhTR5nR47n1cdZl7OH6uVG/vKKNwFXfw0tA
   kp0C24xn3nI0gT0Z3XZoNfW3SIPU3YKcvq4QeAOiPTfbHXuWxzwp/y1MX
   1vX3DmBuOrGb3X4YnvpptVDUAq+rbsAeFe6WUkUM+vxknu80ZybdxUjyV
   Q==;
X-CSE-ConnectionGUID: gjwaQTZYQBGlQ9TmbLpLmQ==
X-CSE-MsgGUID: pxo+pcNGTCaBRZ9DJdIqqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231240"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:30 -0700
X-CSE-ConnectionGUID: KkZTRTv4T0CA6CT725rIzw==
X-CSE-MsgGUID: +D5owHTnQ0yS8ZdX+TZaGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587431"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in flush loop
Date: Tue,  4 Aug 2026 10:36:57 +0800
Message-ID: <20260804023714.3080506-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Feng <guanghuifeng@linux.alibaba.com>

In cache_tag_flush_range(), the CACHE_TAG_NESTING_DEVTLB case modifies the
shared local variables 'addr' and 'mask' before falling through to
CACHE_TAG_DEVTLB. This causes all subsequent CACHE_TAG_DEVTLB entries in
the same loop iteration to incorrectly use the full-range flush parameters
(addr=0, mask=MAX_AGAW_PFN_WIDTH) instead of the precisely calculated PSI
range. This is not the intended behavior, as regular DEVTLB entries should
always perform targeted range-based invalidation.

Fix this by having CACHE_TAG_NESTING_DEVTLB directly call
cache_tag_flush_devtlb_psi() with the full-range constants and break,
instead of modifying shared variables and falling through. This ensures
CACHE_TAG_DEVTLB always uses the original calculated addr and mask for
precise range flush.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index fdc88817709f..26a758b0f501 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -454,9 +454,8 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			 * affected by a change in S2. So just flush the entire
 			 * device cache.
 			 */
-			addr = 0;
-			mask = MAX_AGAW_PFN_WIDTH;
-			fallthrough;
+			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
+			break;
 		case CACHE_TAG_DEVTLB:
 			cache_tag_flush_devtlb_psi(domain, tag, addr, mask);
 			break;
-- 
2.43.0

