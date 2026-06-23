Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A731326A
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194501; cv=none; b=hJhNheCHaU+M9zbEHaA2agwq7EcXQBRJ58fRsQLDLMjklPGRJ7nQ8iz9Cv3vv2Q7qH9wwxcii2MIIIvapgrgm3onp5YMZrjIDIDzDp5DnT1EXt/lPaJ2xh1EpgHhz70+J8tLy/V4itau7uIDMykC8aLjaJxgC9nygKetgRswC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194501; c=relaxed/simple;
	bh=m6E+Rn72m+Z13cekoeksHLwZBnSDxbnfXy4utGqGILg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4md+iC6Euepp4JyvKH1QsF9X8f46RPWJNbR7mOA7oqs8ZtwdQT/pLFsiYCEwKd6Zs7p8lWZlZ7INkG+VPV+CLKPGUmi5m2VLfzd7m63tz0tXCcdq4gujw5WtWMi0hPVCNUCdVbCPq2S5sYwJR4918ABc2v06kNFloRf8a/DDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LN6nC9iy; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LN6nC9iy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782194490; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SzXD/1BLbzIAjyhNqSvgVoucEM0iG+bT2jteePQLrfY=;
	b=LN6nC9iyTauSe2gYIq+ilPFvTNmKv9axpGPa7Kh8XKs2vlABc2IyzWIwOdffe/mZ7DQei854yQnTZy/RIQ4d4GbLE7RHd1I0GaZLBocWHrJF6AAc7c9+goTVvQej/yCi1wCd+SLFfcw1/rJsiMKhTfRiNPyYE+xpqFKk/4zt3Lc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5SuB4._1782194482;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X5SuB4._1782194482 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 14:01:29 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH] iommu/vt-d: Fix CACHE_TAG_NESTING_DEVTLB polluting shared variables in flush loop
Date: Tue, 23 Jun 2026 14:01:22 +0800
Message-ID: <20260623060122.3796325-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.43.7

