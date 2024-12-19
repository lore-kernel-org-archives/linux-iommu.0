Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC421F541C
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587234; cv=none; b=eWL8aJBI6/4PmzSm80ZvvG/m0beXBMAuhc6BbaZDze9s5RFxm3ABjp7fz2eL3RTgZJ2md0+0n97zBWQ3NqhvVueJfp5yH0CZIuqpod1cozZecJ2YizfR55WxOTZD6ul4vusx8TjysuWwiN49Nr2e7ONF2J9CB61mdWM3xijmy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587234; c=relaxed/simple;
	bh=N4AtIijwvHI2dFw4ugDd/UqfYQZUw/AO0lHf5w1XcFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjprxxAsxCVrseBY/OCwAwcbM09/1BCqXanpBfbChFSzaEILqxQzH6NblaxGfZvuidlDZR5Xj8/mO9kCU6GZgLzSntcDVcDE9TTLrkB537pShS4MrlRFNZpyNWvpTVR/+7Mffu2Dpy5WfLOuu/XlwVwJMpTRKL1ZzmUCwU2la0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fl3Q2oIW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl3Q2oIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734587232; x=1766123232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N4AtIijwvHI2dFw4ugDd/UqfYQZUw/AO0lHf5w1XcFk=;
  b=fl3Q2oIW8GEUIlkscmHaqBaGYISzYjPO1IGccU/zsmC+ZZ7H84L4yma6
   UEGR2nIkpeFjOl4ZnzZ8zLC1/Rbt+7bPofBtmqniZsQpZ+57CS10PaDmg
   nX0RLYedKqHMLgkrOvrdwD/zW2sq9iIn7jhmRmZDuSITEW93Schwrm1Qs
   +Zxb+HxQbKVqIDdJX9nWNfIXIFF2F0h0qG/u6GIA5tv5BcGw1fHjf8Xqr
   w8aajsirYQdTGvUGcBzDhOczMl1uJV+UiOIU3vHBQIoxW///gzYQZojYM
   zX4QTVYNwyarYkTVuE91qwqS/FgWE2J4R0ZPgk8vzVztvQBxxdAkQWseu
   Q==;
X-CSE-ConnectionGUID: WnFUVew0QSSIe31URSLNlA==
X-CSE-MsgGUID: vM4+FCR0SV2SvO2F5pN0SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35213711"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; 
   d="scan'208";a="35213711"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 21:47:12 -0800
X-CSE-ConnectionGUID: ccIQpXfnTA6ICyhyk8tvVQ==
X-CSE-MsgGUID: KugFOm6jR5S1G+73Su1AuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97920094"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 21:47:10 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	yi.l.liu@intel.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2] iommu/vt-d: Link cache tags of same iommu unit together
Date: Thu, 19 Dec 2024 13:43:58 +0800
Message-Id: <20241219054358.8654-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache tag invalidation requests for a domain are accumulated until a
different iommu unit is found when traversing the cache_tags linked list.
But cache tags of same iommu unit can be distributed in the linked list,
this make batched flush less efficient. E.g., one device backed by iommu0
is attached to a domain in between two devices attaching backed by iommu1.

Group cache tags together for same iommu unit in cache_tag_assign() to
maximize the performance of batched flush.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v2: avoid getting cache tag struct from list head (Baolu)

 drivers/iommu/intel/cache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 09694cca8752..fc35cba59145 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -47,6 +47,7 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct cache_tag *tag, *temp;
+	struct list_head *prev;
 	unsigned long flags;
 
 	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
@@ -65,6 +66,7 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 		tag->dev = iommu->iommu.dev;
 
 	spin_lock_irqsave(&domain->cache_lock, flags);
+	prev = &domain->cache_tags;
 	list_for_each_entry(temp, &domain->cache_tags, node) {
 		if (cache_tage_match(temp, did, iommu, dev, pasid, type)) {
 			temp->users++;
@@ -73,8 +75,15 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 			trace_cache_tag_assign(temp);
 			return 0;
 		}
+		if (temp->iommu == iommu)
+			prev = &temp->node;
 	}
-	list_add_tail(&tag->node, &domain->cache_tags);
+	/*
+	 * Link cache tags of same iommu unit together, so corresponding
+	 * flush ops can be batched for iommu unit.
+	 */
+	list_add(&tag->node, prev);
+
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 	trace_cache_tag_assign(tag);
 
-- 
2.34.1

