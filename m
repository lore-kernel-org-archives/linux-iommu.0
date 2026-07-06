Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E7378828
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350455; cv=none; b=rr0gbXIBpyKkqUbWFRl9ZrQyUxcGwwP+Y2La/m5ex2Lf1Eg5GoJJhAisadIUSBw3icZ+xh/P0qxq7PDzeCHeR1+d42/G6cIs3IkFCDVJ6GEYDq+ekLpp8XR8wfVoU/fjb/jR2aDWNe9cW/EzlJ/pGy2KTzSEIve9yZx6ZyDJkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350455; c=relaxed/simple;
	bh=lKQonR4ehLSrdg7Q9EQmcaFN4H/cXaBULLkvW6+uEfg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p+LVGc2uR5EG+7IS9ScEvZAg3HeMkgzIY1Uz2yiZ4Hg9oVpTOeD/dtETT7CvaUGGHIv4Mf6Ge+rzp5gB5GlD3EwWGGqgf8iYtLYTBXS0FpNaqfgyNyUBOtyx3d9odNrJDPyxQehJQ1ZptEZMNj9tR5jhPVGW0mstetCK8UjqiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfI1INL4; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfI1INL4"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c126399a328so320127166b.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783350452; x=1783955252; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lx/Tz8Zmq/2rMr5850VaaKZJq/iHDsvqGoxRZtlKNQ=;
        b=kfI1INL4mHkpStlD+Tkr7EG7dT7C3cscW7AhCv5L+iGgq9N6bk1ByE6xIOJoZU7gzo
         8CmghEZjbshNvyGXje18lkrHMqAtj906TOIt6Bkr9D6PvwQ2Gcb7Oil+bKbpxVTJNLaE
         aaW2E4H9AUTooLvDMPzBZlx4MxyFcLjVFHSlU9VdR3QawkBRtuKenPH/JXcBycCfCuPV
         5QbtZHDdq1OeiAi3Sqi/Q5feJ1wXusx9ZLk8bcBM0QIQ+O4+zYd1mzgIVbkWlO63tfix
         7YIEM2lmBe4iBNRVX3xFB2cYdcEQFiOWUeEPu1G2orBUurB6FwzOHoBcQOmld9mgmoXX
         /G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350452; x=1783955252;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lx/Tz8Zmq/2rMr5850VaaKZJq/iHDsvqGoxRZtlKNQ=;
        b=dQprhBvJ7424obzzHjRUiwI3yCiomORqBjag86FtVYvwjzn/zcVhbnqIMxa29KzoLB
         AHZBWRQ8BS/2bnmPpTk1z2ts086wbmC3eAZHqHEKR8joyPajWfYw2G7fy+qLxs7D83up
         C8SXeYkgtfL/CRN3yqClZmw4Lfrgy/wmSR5pQnKp4hYCkNkoIsLHuuNFMqZ9/WYso0rz
         czsm4548bMWBElOFrJGnGpPHSeFNdruN2iRWcVpuu8abx7Br4rJ4ncs3uCdkAovhyhqA
         CgoGy1fjbyHqf5fSU/ghJQwL3UrJywYNsFAAFtCy/Uq1XBkpEfRGNagnrd7sbDBjMgK5
         1gbA==
X-Forwarded-Encrypted: i=1; AHgh+RqAKcNRqbWjE3qiHUGxlcF2X/8bUpw+rrRvfXXGfsSeBqeH7a9rsjTq3ZHIb6ovbQNAM6bvpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGpLYm36BHyydREx+lPo7QrhHQYNwD9rtxoJhNWHkJaV27mXde
	EmCvzUdRQSojJitXeqRcwftMqDrD1Te+mIRw2MH5yUiO69D/Rgg+lrXThkYu7RFjZRKZHP1m1y3
	GEutu1dZuv3K7txkeIjNaXA==
X-Received: from edqu19.prod.google.com ([2002:aa7:d893:0:b0:698:878f:fb60])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:bac5:b0:c12:15b5:876a with SMTP id a640c23a62f3a-c15a67fa6f0mr51152166b.17.1783350452355;
 Mon, 06 Jul 2026 08:07:32 -0700 (PDT)
Date: Mon,  6 Jul 2026 17:07:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260706150727.4098614-1-mclapinski@google.com>
Subject: [PATCH v2] iommu/iova: Move CPU magazine init to first insert
From: Michal Clapinski <mclapinski@google.com>
To: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Logan Odell <loganodell@google.com>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Logan Odell <loganodell@google.com>

A large amount of memory may be allocated for these magazines on
machines with a lot of IOMMU groups and CPU cores. Not all may be used
as some devices may be unused or be bound to drivers that do not use the
DMA-API. Furthermore, some drivers may not use all levels or CPUs.

Move the initialization of the loaded and prev magazines for each CPU on
the first attempt to try to insert a freed IOVA to them.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
v2: only rebase
---
 drivers/iommu/iova.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 021daf6528de..1a4bbf45dbb9 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -621,6 +621,9 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
+	if (!mag)
+		return;
+
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 
 	for (i = 0 ; i < mag->size; ++i) {
@@ -737,14 +740,7 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 		}
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
-
 			spin_lock_init(&cpu_rcache->lock);
-			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
-			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
-			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
-				ret = -ENOMEM;
-				goto out_err;
-			}
 		}
 	}
 
@@ -777,8 +773,20 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
+	if (!cpu_rcache->loaded) {
+		cpu_rcache->loaded = iova_magazine_alloc(GFP_ATOMIC | __GFP_NOWARN);
+		if (!cpu_rcache->loaded)
+			goto unlock;
+	}
+
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
+	} else if (!cpu_rcache->prev) {
+		cpu_rcache->prev = iova_magazine_alloc(GFP_ATOMIC | __GFP_NOWARN);
+		if (!cpu_rcache->prev)
+			goto unlock;
+		swap(cpu_rcache->prev, cpu_rcache->loaded);
+		can_insert = true;
 	} else if (!iova_magazine_full(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
@@ -799,6 +807,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 	if (can_insert)
 		iova_magazine_push(cpu_rcache->loaded, iova_pfn);
 
+unlock:
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 
 	return can_insert;
@@ -831,9 +840,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
-	if (!iova_magazine_empty(cpu_rcache->loaded)) {
+	if (cpu_rcache->loaded && !iova_magazine_empty(cpu_rcache->loaded)) {
 		has_pfn = true;
-	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+	} else if (cpu_rcache->prev && !iova_magazine_empty(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		has_pfn = true;
 	} else {
-- 
2.55.0.795.g602f6c329a-goog

