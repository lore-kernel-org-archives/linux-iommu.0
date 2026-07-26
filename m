Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FED37D133
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051831; cv=none; b=oG8Q/wZkvEF8BJwky3JtE9eU31MtrtnwQatWb+T8v2yo+qSkmNHS8ufvN+i66IEh8xLU0ze3eH0VECj37Fj1ZRu7S4ACl/FVQ1TdeYgobKQ365yXgD9KGLC+6cTkD3wKb2kFSXXQFzabfd0vWOwdO3zE9+1A+666pPAXWKvKHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051831; c=relaxed/simple;
	bh=l+yR4vf085/qkjSx86L3dzErQe6XQe3JPtORH57fyAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9U1nTv9+pDAmA3rpP1oX3C370BXdta2zhxpmJGbmKbymQFgeRjsQiq9qt730mvxyHPmkNFoNuB4kekT5gTPsG7Ch52eCCkVOLPjIoGp9raMJ/RtjNj9husdGGgYlV0YfbvkaCGtEboE0h9jcIINW93aPb6l9Kb6MDkproVR9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MCQqxhUh; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MCQqxhUh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785051821; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2j5MmqzQIKm0nVQwtKsxuk0VZGRhugOZ2660sRdEdrQ=;
	b=MCQqxhUhx8vgjrJJ9dzbnJikK80jXo4vbeMxhtfkNPAapGWQF9vaqO9B5+3imqvisI70/jLghV28aLOpLYJCXMOiCZhiwxSj7yE59f/NTPAtIedLIXcvlTQDcVVwDLXJEdCRglZFJu+ru7EApAi9GeE/+fDKIRZ4C7qvSYYYR9U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7n2nAV_1785051819;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n2nAV_1785051819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 15:43:39 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH 4/4] iommupt: Return zero for invalid iova_to_phys() ranges
Date: Sun, 26 Jul 2026 15:43:32 +0800
Message-Id: <90a86345b06d43437592da48f1d624c748c4d4ad.1785050951.git.xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1785050951.git.xueshuai@linux.alibaba.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DOMAIN_NS(iova_to_phys) returns a phys_addr_t and follows the IOMMU
iova_to_phys() convention of returning 0 when there is no valid
translation.

make_range() returns a negative errno if the input IOVA cannot be
represented by this page table format. Returning that errno directly
casts it to phys_addr_t. Callers treat zero as no translation and use
non-zero values as physical addresses, so this can make them consume a
bogus physical address instead of seeing a failed translation.

Match the page-table walk failure path and return 0 for range validation
failures too.

Fixes: 9d4c274cd7d5 ("iommupt: Add iova_to_phys op")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index c2752151c80a..07ec2b3ab986 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -224,7 +224,7 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
 
 	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
 	if (ret)
-		return ret;
+		return 0;
 
 	ret = pt_walk_range(&range, __iova_to_phys, &res);
 	/* PHYS_ADDR_MAX would be a better error code */
-- 
2.39.3

