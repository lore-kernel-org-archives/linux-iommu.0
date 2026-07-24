Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEC2931CE
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900701; cv=none; b=UHNdrEKP3iNSmhzZaWu9Ptc4cJxx19iJxu6Xri38BNNHxNze5ygGibC5F1jjDkbchG5Iz3qslqTOzO1GCtQCxbYj2Zv0RbhcXnzyFu1D1D0lAJEvchDJKwYwvKYdsHS2OrrN6SC3kOZNDWPu3Uix2vbRr/HDQ0QfwxZmurbRp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900701; c=relaxed/simple;
	bh=lKQonR4ehLSrdg7Q9EQmcaFN4H/cXaBULLkvW6+uEfg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IJCWLD3xiAqDpV20J8c6ZKLiWFPIN9n5nTpSqqgVzNEQfe2G/p+TchXougrG3ijiRGF1fm3fUHSSFU6JtKdGsGV1ilM6aeduaqdQ//veqwb8iNd/FFHSAtCbsoiS2JBHkVo82PeHFpP9rjP9lqLVqCKScC9LocVOiF1UqVz+EH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uxbo3iTy; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uxbo3iTy"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so5051035e9.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784900698; x=1785505498; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1lx/Tz8Zmq/2rMr5850VaaKZJq/iHDsvqGoxRZtlKNQ=;
        b=Uxbo3iTyKox25zcoZWvnmNRzUO7+SDmMF+CiDoTrT98cJ20e/U62qq1bpLavaoFi2t
         WqtVEthL22GlTI9Nt4JAN6YMNA5t7mzSKrvcuRZs0GZg+0qaHWcDCZ3yNxfaDiRhobEd
         5WHrXWcAdeGHlkI78nswNNaQ90kElCuJrnZzubwtPzHY2xXvF9usBHrpH+DKPv+WNU+D
         mz4HljcTZp5V/pRnMuW3mlNyDw0xFH6N/u2t7y36QghEQvgR5crV/DguaRpuFw6JSwK4
         pfbLOrMhYbmj1fiLcluz3UgC8n75szx1QAx0BkEezbqIwL3W3asXjIAaBEYP1OboeYvc
         PiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900698; x=1785505498;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lx/Tz8Zmq/2rMr5850VaaKZJq/iHDsvqGoxRZtlKNQ=;
        b=jD0fLvPJtXYW2AeOBNcfZ7qE+nXkeIHWA3tQbmHPDPA/CaYsyKAGzCo0pV+pEbblI8
         KEFU3ASLpdgUpgY6gi8DWGGh/eEjRVCONNUkciFxU6Z6nS0l+pE4kJEPXU9+krw/fBHM
         /CFA1UfMtjiLPJMZ5z/R/BSSKSxDmz4wOGuFW6CLoPgMICIJIwev+42DGFcY9D8f2vLz
         W1fYv1i3YJevbqM5dDdUvCtZWzDRtdvdG+yMw5oHFnrdnC0DrLbV7G2925Nzjfn6bwp0
         uOJ11mUV4Apymbf+X3Ru1d8AB4PJ1fkLcLJwde6G93JpIobHlnfTHSomLgWKE/ZzzYer
         yHWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMY4/yPWEyEuzqakXg0N9zs/oeFELOwUlqQBy+sATOD3rQaIhWMuf8By16wP2utyHyHNBcAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWbTUUcyPtz5kMbVfWarA91pzYINmRwVXCSKpQIXx+Q7Q7a0lL
	MGjZdHCWc5JtyM38NslEaD7Zsp64jLPU1rOCnAA22BzGn+4kpyzGBAe1ZEUq+0Z9KTR53tF0rM0
	QmPiRcg58awzTZ234itIpnQ==
X-Received: from wmna5.prod.google.com ([2002:a05:600c:685:b0:493:c773:ff79])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d0:b0:495:5d5b:7533 with SMTP id 5b1f17b1804b1-49573ccd91fmr79588505e9.13.1784900697966;
 Fri, 24 Jul 2026 06:44:57 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:44:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724134419.1051078-1-mclapinski@google.com>
Subject: [PATCH v2 RESEND] iommu/iova: Move CPU magazine init to first insert
From: Michal Clapinski <mclapinski@google.com>
To: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>, 
	Logan Odell <loganodell@google.com>, Michal Clapinski <mclapinski@google.com>
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

