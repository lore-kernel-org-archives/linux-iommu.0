Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BE446063
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887672; cv=none; b=t3ejjgE2WsyviusunkyJm/rg0v8BtmRRHhJJFmyiVDgq4gz6qFCyXmvGbQoY6uHhPp8y2xuMAMEekViFYUyud4+MoZRvHlOK0DmpvE4WCQ1R4DioJbrGM6AyJUppSFoyeVfPvnPHmJlJ/3oIZbOmSKXPELXNKSqqEgoe8PNgPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887672; c=relaxed/simple;
	bh=sC0Psn9+T0aC5GxdGeCxklvUUEZ395pym97oWYEJoOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in8j+VKjxdQsThnzAhKkYdX6+F3cl5tE3iWMTDZmQMCfKhzVD5Dj5JIM1iFcMHRYjLH9cd5oSvNFXNOM3c2899X63KUtG961P40DqjYgKEcqPKhiof7fgNYe+F0aVTpfzyz8wwdreOMqR2sqnYd/GERsMYAUBaxlDP9qCNwrpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUvnf8th; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUvnf8th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887671; x=1817423671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sC0Psn9+T0aC5GxdGeCxklvUUEZ395pym97oWYEJoOM=;
  b=HUvnf8thyrF+exWNyttE5FAsj1pen+4B9muf7kZMBAH+OaEUbL49Jdf5
   nHaJ5zv91dDmFP9l5j/FnDEyxwzB000yf3q30YvFFnXmPcl5Sd+dMX4Yv
   gYXoetfKuG9UCJ6cCi1VO+caD9esaFf+l3q/fUrcVBxRs7+EoskhkYJwu
   8N96ukcjyPwWw/JCD/Eb6ymetuzcnRLMCeVP83wVQij0VNqouwJwLMylG
   0h0TZjH8ChltZFR3ilS0kH4IxGEq2E9yJ0AIjvw9xdPeuJ8MoY9XCWgag
   6KvV7FR+Jp9FptMay2NjajjwSSyA2HU9moIfsTIrjBmlElMl9hDgDveeL
   g==;
X-CSE-ConnectionGUID: VkhvNKuJRIu6iphZY/oGgg==
X-CSE-MsgGUID: EBBNHkecSp+zwGk45Sd5oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263212"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:30 -0700
X-CSE-ConnectionGUID: BPeWgJm/SMWcLZtekETYcQ==
X-CSE-MsgGUID: ONHNiWFMS2uPP3bA/0+hIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324319"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:28 -0700
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
Subject: [PATCH v2 03/19] iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in flush loop
Date: Wed,  5 Aug 2026 07:42:57 +0800
Message-ID: <20260804234314.3087110-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
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

This change slightly affects trace_cache_tag_flush_range() behavior.
Previously, after addr/mask were overwritten, the tracepoint could record
a full-range flush even when the caller requested a narrower range.

The tracepoint should reflect caller intent. Although this helper may
widen the actual hardware invalidation range for implementation reasons,
that does not change what the caller requested, so logging the requested
range is the correct behavior.

If the actual invalidation range sent to hardware is needed, it is already
visible via the qi_submit trace event, which records the invalidation
descriptors emitted by the driver.

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

