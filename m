Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D2154BF0
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320499; cv=none; b=ICMYfELHKSwL5LiHbM1ERv9/i54zFopjtpyYIRUo4MCWO0HulLcmSl84YV3hNP8MgX/X/w3TOiM7/+hSRCGoGOYdVa1Ec0dMjjsIj9ReBRMgXaXW7qfvsLqH54rZF4oJYFWbPh6g08FGDyiYwnBwvLJIMhuY0PuyMMLf5sX+vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320499; c=relaxed/simple;
	bh=UxrO/dxoV1TqrOkh2j5DR4ODWbCM2/uyXJREJrXqwJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qp1MvLlkS4coFLILb2x7eIyge+JUppSqetyK/ZtMjNqXW2rD4ZSWT5LeH+b1AlRIZ3T7GojYmPxvh00/7WADj+XkJkHWv2EmJVh6g6CeAz/mfTObUPZ+oBXxYriLuctE3rfCwC0yP9nITOj/r6cBCi7hHTXZ1eat6/7JcfJ75Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MROw209L; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MROw209L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734320497; x=1765856497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UxrO/dxoV1TqrOkh2j5DR4ODWbCM2/uyXJREJrXqwJI=;
  b=MROw209LLysCuh5NIHJr9t83vHzNrrZ05J/Ff6qmRlDH6hl62kvOmfpZ
   UR3UvedDCxr7/oTgcBcR8vcD49TyQdCVH7XxmN2lqv0oHlR0iAJZPivAY
   ML/9twvFyHSzOEOmSestxpT28nrbxssg0q5NUMyDCkWv4nxXGqPqlExXL
   RB+PY2bu676lIUYzi4thayMfUi9ztJlfX6nsIJU+ab4Kx3JaTEDFgYllR
   4JqqZm1X0nJczRnxhyjvoKC2Mdm6Rp65fOglCRsripwm73zR+p8pE6vcP
   qEB4mvlsn18Yusff8B0LV/WshcrQ1RtuVeH0TjErjpXQx79hP8gKIGhvy
   g==;
X-CSE-ConnectionGUID: gRZYp6lSQxma7upJKPa8AA==
X-CSE-MsgGUID: cN1oGqsfTdK6a9a3/Np8Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="45302026"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="45302026"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 19:41:36 -0800
X-CSE-ConnectionGUID: P4jW3cMWS7u531Rj08mkCQ==
X-CSE-MsgGUID: LUrZTns3SkmdAlFWxMPrTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97127154"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 19:41:33 -0800
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
Subject: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
Date: Mon, 16 Dec 2024 11:38:09 +0800
Message-Id: <20241216033809.170366-1-zhenzhong.duan@intel.com>
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/cache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e5b89f728ad3..726052a841e0 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -48,6 +48,8 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 	struct intel_iommu *iommu = info->iommu;
 	struct cache_tag *tag, *temp;
 	unsigned long flags;
+	struct cache_tag *temp2 = list_entry(&domain->cache_tags,
+					     struct cache_tag, node);
 
 	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
 	if (!tag)
@@ -73,8 +75,15 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 			trace_cache_tag_assign(temp);
 			return 0;
 		}
+		if (temp->iommu == iommu)
+			temp2 = temp;
 	}
-	list_add_tail(&tag->node, &domain->cache_tags);
+	/*
+	 * Link cache tags of same iommu unit together, so consponding
+	 * flush ops can be batched for iommu unit.
+	 */
+	list_add(&tag->node, &temp2->node);
+
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 	trace_cache_tag_assign(tag);
 
-- 
2.34.1

