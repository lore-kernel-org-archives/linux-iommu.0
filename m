Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EC194A7C
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216398; cv=none; b=Ym5WhyVgS6GuXhVp7BG6KNbAN6NDKJGlauBImcJTUYp7q50v8HoUUkUml6SkmYtq0FKuJnENZzhBt/TGGciWAtPw/40eRtzwHr/4TZu1ilu7KnVIJeltXHWtW9Ap8DYaH48z0wXzreAT2vY9dbMNYJR9VgjgctmdqMrh1JL/uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216398; c=relaxed/simple;
	bh=eaFBNhUleBIzqfpyP4rk34HZeakw+3KJJswLfZJ0pb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCwZVuN3cvQOeGPOse0gACT6z8NVJK5xbZ0aaHgCfp3O4Qu5M3yRXIabbv7ncPFqksqDyEn1VkRikAp9AbUKBcC4ZpSn4qBBs/3p8bywUyhW++IU78iV9nbdrW49z8+MyWEEAXQo2FhyxAO1hJKce8cXwd44wE0mK5xEbhOpN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOeaROQM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOeaROQM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736216396; x=1767752396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaFBNhUleBIzqfpyP4rk34HZeakw+3KJJswLfZJ0pb8=;
  b=IOeaROQM4FKmmQPLTScWv+3BPEK+VfRmngIZovnFwGCZGT/oufddllNy
   eGLVyQZg1LyPZl21v8gLzltps4ZaSZURN1eHxHzHktj4T8clYJP1mik/d
   YjnyxapW0O048EZoc+WmH4cuFxQfLiTeLn8uQwI0X/9bNQPh/AzBj83n5
   5TAsbCpS1R+aJ6/xepFMflZTj2cR1IN57WO8FiSvxSTHK+EYPJCmI2r6f
   CcAGbzzUI1tAsvn3BLS9mLcHJzw6yaOQBO6ruktU/aG4lokdd/D+w3oKO
   qcxwM+yZotKQZf45NHgGDCcqSax5QoJr2HEkIX7DdRiBRt7ok1mUcpMmD
   Q==;
X-CSE-ConnectionGUID: hXoludRIRvqSyKsFwxj/QA==
X-CSE-MsgGUID: xXciyimdRuSHI0AVT15ZdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47800792"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47800792"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:19:55 -0800
X-CSE-ConnectionGUID: 3v/mXa97TeaxPoAzyAW/WA==
X-CSE-MsgGUID: mpdHqoqOTB2V1lWfK7WeZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102442986"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2025 18:19:54 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu/vt-d: Link cache tags of same iommu unit together
Date: Tue,  7 Jan 2025 10:17:46 +0800
Message-ID: <20250107021746.6908-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107021746.6908-1-baolu.lu@linux.intel.com>
References: <20250107021746.6908-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

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
Link: https://lore.kernel.org/r/20241219054358.8654-1-zhenzhong.duan@intel.com
---
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
2.43.0

