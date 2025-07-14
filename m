Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E52223DE1
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468786; cv=none; b=si5S+e0xNLcXq6EF8nSbw57EvZ68O6XIFjc2+gZiyukrYVxxmjEl/jR5619Yldf5str4c892vcVB9h6LR6I9KEXXFeJEgYQ/ZJGFUWg9ge0iVrH/JASiXRYLjziSr873GJVRV2gE44PP3lUN5fGNiE5PDQ7C7sAjdykqFFDhpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468786; c=relaxed/simple;
	bh=64tzP1tfDuZ1RLCBuSwPHPtDvngWJGj0WwdSjW827T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxjzikgMnawak53UlljmSpBcT42RF4jNb4lg91BUWION5GszViBasw4kDs0sP1kVfoLxRnkrSN7Z0x9DPm//D8RVfTJhZKW6bOFBtl9GPaBwI+QuocJl9asaQRA8L/ps11K+VtUvy0WXEi4SxpfjCYKWYWQbC8pnucG3w2wyitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTDljtOI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTDljtOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468784; x=1784004784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64tzP1tfDuZ1RLCBuSwPHPtDvngWJGj0WwdSjW827T8=;
  b=RTDljtOIlYvpyivuSCMlJMMUZNLgHeVN3I0x/Xk2Wk4mUw7hPXUOxcJQ
   5bU0NjiUhXok5L8UbtUhC6KFU1Qm3Bz3NgKJQ4ZPJVmCXaeQit5lkm5wO
   JqivrNy6rFZXsldYoLTAb6DgHV030REFVdiquZ3Dmy56tuu9f7QqI/EWr
   9pMtVojnVFTwS0fLvihTb5wwIIYujqdH/1N2MVYX7xm6QKSJCHSEyNu0k
   rlyF91hLrnUNaJ/LMfl05jAQgxXb7vwr7vYWoT8jXkuY34I2BImicyL7t
   1RTMmnk+VVCEvO+4KthN2RM/sx/unyxhVXBIrLaQHplu58hCAHkLxu295
   w==;
X-CSE-ConnectionGUID: Y4KL2HpJTEWfc1hHYZI3EQ==
X-CSE-MsgGUID: MwT93Rg/Qk6f/x3+LXBDqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765090"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765090"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:53:04 -0700
X-CSE-ConnectionGUID: sI5papjZSYy32hU6Zm8KQQ==
X-CSE-MsgGUID: S/s6EJZzTHeJOQvwJCtiYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166227"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:53:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] iommu/vt-d: Deduplicate cache_tag_flush_all by reusing flush_range
Date: Mon, 14 Jul 2025 12:50:28 +0800
Message-ID: <20250714045028.958850-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Milon <ethan.milon@eviden.com>

The logic in cache_tag_flush_all() to iterate over cache tags and issue
TLB invalidations is largely duplicated in cache_tag_flush_range(), with
the only difference being the range parameters.

Extend cache_tag_flush_range() to handle a full address space flush when
called with start = 0 and end = ULONG_MAX. This allows
cache_tag_flush_all() to simply delegate to cache_tag_flush_range()

Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
Link: https://lore.kernel.org/r/20250708214821.30967-2-ethan.milon@eviden.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 34 ++++++++--------------------------
 drivers/iommu/intel/trace.h |  5 -----
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 071f78e67fcb..265e7290256b 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -434,7 +434,13 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 	struct cache_tag *tag;
 	unsigned long flags;
 
-	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+	if (start == 0 && end == ULONG_MAX) {
+		addr = 0;
+		pages = -1;
+		mask = MAX_AGAW_PFN_WIDTH;
+	} else {
+		addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+	}
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
@@ -475,31 +481,7 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
  */
 void cache_tag_flush_all(struct dmar_domain *domain)
 {
-	struct intel_iommu *iommu = NULL;
-	struct cache_tag *tag;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->cache_lock, flags);
-	list_for_each_entry(tag, &domain->cache_tags, node) {
-		if (iommu && iommu != tag->iommu)
-			qi_batch_flush_descs(iommu, domain->qi_batch);
-		iommu = tag->iommu;
-
-		switch (tag->type) {
-		case CACHE_TAG_IOTLB:
-		case CACHE_TAG_NESTING_IOTLB:
-			cache_tag_flush_iotlb(domain, tag, 0, -1, 0, 0);
-			break;
-		case CACHE_TAG_DEVTLB:
-		case CACHE_TAG_NESTING_DEVTLB:
-			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
-			break;
-		}
-
-		trace_cache_tag_flush_all(tag);
-	}
-	qi_batch_flush_descs(iommu, domain->qi_batch);
-	spin_unlock_irqrestore(&domain->cache_lock, flags);
+	cache_tag_flush_range(domain, 0, ULONG_MAX, 0);
 }
 
 /*
diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 9defdae6ebae..6311ba3f1691 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -130,11 +130,6 @@ DEFINE_EVENT(cache_tag_log, cache_tag_unassign,
 	TP_ARGS(tag)
 );
 
-DEFINE_EVENT(cache_tag_log, cache_tag_flush_all,
-	TP_PROTO(struct cache_tag *tag),
-	TP_ARGS(tag)
-);
-
 DECLARE_EVENT_CLASS(cache_tag_flush,
 	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
 		 unsigned long addr, unsigned long pages, unsigned long mask),
-- 
2.43.0

