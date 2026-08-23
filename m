Received: from sg-3-28.ptr.tlmpb.com (sg-3-28.ptr.tlmpb.com [101.45.255.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216A30E82E
	for <iommu@lists.linux.dev>; Sun, 23 Aug 2026 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477136; cv=none; b=Ouq3CfgXKqD+GfKV/egFQMipPWlloqC04THDiJroTv9wLtN5+hY4X5P1oD1s0SFZQevk+AYLYEBBXZyAPeMK65bQLXda1Jp5xR2Ct5VAw4pNX1pznQK+Vjdx4jObM5Q124zP5M0380aaU6tFeV1xVGlJHhsHyWfw/pICgFO0Q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477136; c=relaxed/simple;
	bh=mFmuc8txXQV1mSCtBgY5fi2jVBmaQsTnfcp0PU4WNA4=;
	h=Subject:Message-Id:Mime-Version:Content-Disposition:Cc:
	 Content-Type:To:From:Date; b=YGy+KuK4jydg4JOAB8pfJ10eoZlQHelWVzBApo5q21rq4fXqXgx0fmOgwqm4hB9YdnZxUc2D21NM2SLXD8WJ9nRqHosC3B1gc6OyV5/8msXxFC1e4IEnoWogvONJHe5GmkXo5FulpvcJqdWX78sGQki7rWUxiFJ70nwbYdxQSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=pErTlrf0; arc=none smtp.client-ip=101.45.255.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="pErTlrf0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1787477081; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=T2ArGZLXfhkmEHUMH8ojDXGpECLiQ7Phad9SUPlEop8=;
 b=pErTlrf0uAdA8bRJT1sqjLNDqiKZV+DLKbohni3lqSb/OTBrKVhiTuGWZvZJvcoYha0WmZ
 yXRsdwtmD68lJhuG5hlHnYYp2wW1lvsCNP4wSHp5jSmwkNQQgnbIYJFzeMpFWLaxq25bcc
 YdZ2OiGGbb3PM64ZxfNZx7+uB0WGVQZZiFLqDxhpaUnrW5AHnr1IamugY0/Qp0iQvDi222
 JMKzCaw73lo5wBtwouQl0h497kVJnRfUnzYC+KAVP9gv3yocwCRM4i9arthvPThyNKKnUl
 fsNsiLTMSnX5EAPiatM/qdShauK6WMJszPYsxFRYML3NnD+FINpnQ5+a90WQbw==
Subject: [PATCH] iommu/sva: remove iommu_sva_present flag
Content-Transfer-Encoding: 7bit
Message-Id: <aoq8VGFL/Mdjd/M5@hostpc>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Disposition: inline
X-Lms-Return-Path: <lba+26a8abc58+6c80e2+lists.linux.dev+liuzhaoyu.zackary@picoheart.com>
Cc: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Received: from hostpc ([124.160.26.250]) by smtp.feishu.cn with ESMTPS; Sun, 23 Aug 2026 17:24:39 +0800
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<baolu.lu@linux.intel.com>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Date: Sun, 23 Aug 2026 17:24:36 +0800

The global iommu_sva_present bool merely mirrors
!list_empty(&iommu_sva_mms) under the same mutex. Remove it and rely
on list_for_each_entry to handle the empty list case, which is a no-op.

Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
---
 drivers/iommu/iommu-sva.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 9742cb593577..9827cb804363 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -11,7 +11,6 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static bool iommu_sva_present;
 static LIST_HEAD(iommu_sva_mms);
 static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 						   struct mm_struct *mm);
@@ -137,11 +136,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_domain;
 	domain->users = 1;
 
-	if (list_empty(&iommu_mm->sva_domains)) {
-		if (list_empty(&iommu_sva_mms))
-			iommu_sva_present = true;
+	if (list_empty(&iommu_mm->sva_domains))
 		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
-	}
+
 	list_add(&domain->next, &iommu_mm->sva_domains);
 out:
 	refcount_set(&handle->users, 1);
@@ -182,11 +179,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
 		list_del(&domain->next);
-		if (list_empty(&iommu_mm->sva_domains)) {
+		if (list_empty(&iommu_mm->sva_domains))
 			list_del(&iommu_mm->mm_list_elm);
-			if (list_empty(&iommu_sva_mms))
-				iommu_sva_present = false;
-		}
 
 		iommu_domain_free(domain);
 	}
@@ -334,8 +328,6 @@ void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
 	struct iommu_mm_data *iommu_mm;
 
 	guard(mutex)(&iommu_sva_lock);
-	if (!iommu_sva_present)
-		return;
 
 	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
 		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
-- 
2.34.1
