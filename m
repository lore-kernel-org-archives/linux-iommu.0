Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43883405C3C
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685981; cv=none; b=nN3BNJUHgjhePln3g9P1J2JWL9m60c0PmQvLRiEkRVfeoyNwdpBVgrxe5Pg7Z+TaaV3XpuybVM5Xmz1paLcn5Z+G+W2uSpRj4wP65UOiGeO9JXJSJ1xfoHkcx0St7lRS1ZX2gT6BVWutVhf8yU48tGcnSDLjusuJcuSmqeSSHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685981; c=relaxed/simple;
	bh=8sP1mFvvrrrYgljNGbpHcBy0tVKVMx/WfQdTGt5Mjiw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E4KdNZnorKB1XzwrPzQ89rVHp2DyTSjzxYve1r10ZzoVuRpE770+OX0aPbegiJdSh1uh8mU0fYJ2V4dsLvjI3GqBelHDmkcSfAmqVzUxin1Ph79IUCXj3yErKV2059DQ3/rY9AxKOURi5Kv/1ngU12mruE8KqqQeRyx1zQK+QWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTxiAUVp; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTxiAUVp"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dbe27199so4261795c88.1
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780685971; x=1781290771; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2G8CRf+JIwMyLPHamjVNAYiccLdKeAW/w/Ijs0l4Ss=;
        b=cTxiAUVpGKmGc5iY2GjCCxBGj9UsMIoMFZM0V+gdXz1pxpDgYXp7yLZ5Svy0B605b4
         KwSQAiVWGAJmEjU9Eg1QmDXgJvBe9SeTciCB8TTfee7PeGVMw3pICCqPer1WjqHZN5zW
         GvaVmiWsPgIONRRlebeartQemGL8WmwzWdh4ibnjDATLPHJafekqeK2vQzegGJo8Sejl
         v/TlvzZaxRz0ysyfdJ1upDarTNZoTxXkhWtZjgVp/X9rgvS+lKVsifDoZGynHKxprbpK
         xLfSdlZ3LTlfjeg4QQiwk1qulU//mx0QzGfdVB5gWm/A1Fil7zkmopmH7NLj+t+k6xHt
         0hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685971; x=1781290771;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2G8CRf+JIwMyLPHamjVNAYiccLdKeAW/w/Ijs0l4Ss=;
        b=HD6Z4bhmCWumQ4GJXX1t5h3vWeJbEoFMgi/Yx+2QlgNWGiBwnb8q3P2kR/AbP2G0ku
         PbitPAy9uU4CF49wlaqMYm/FbZ5hONUyKDjpqjINFSmIxrqQob6AfnrfxpOBkjyNCYHE
         rGMBTzPkQ6sx+cXxF3cDKodHqZbml0a7PpoZeOtmIUeCufyTeStFgBvDzY6ueL/J6xde
         s3Mup3JspTxg6/3TEzvc0qd+8ZgFJtFuEVwWT4l/as9ReyhFxJAMMmdr5vYtZn9Jgic/
         vjaQ7G6o46MobparEAtLPqz07OS49VtaiUtvo+8lbC0h6aK5awdSWfD3FLLwGO5ZLr3U
         I2pw==
X-Gm-Message-State: AOJu0YwJkTF99uCvyvyM8+UqjMozE9LxKMKyq8D0D7+Z0G6dcChJA/t8
	7So3YLK/eSjjzKSaF7gI1ld5CkHkCbs/JZPxuVSIUD+oLF8JYj1KPaBDqAwWjFZNRFgVyz2hwEx
	Z9PEOv/NZaBEAxKXuZpQrTg==
X-Received: from dlbsw11.prod.google.com ([2002:a05:7022:3a8b:b0:138:700:1c7c])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6b99:b0:137:e532:f53f with SMTP id a92af1059eb24-1380672bf32mr2439937c88.34.1780685970807;
 Fri, 05 Jun 2026 11:59:30 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:59:26 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260605185927.917517-1-loganodell@google.com>
Subject: [PATCH] iommu/iova: Move CPU magazine init to first insert
From: Logan Odell <loganodell@google.com>
To: robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, mclapinski@google.com, 
	skhawaja@google.com, Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"

A large amount of memory may be allocated for these magazines on
machines with a lot of IOMMU groups and CPU cores. Not all may be used
as some devices may be unused or be bound to drivers that do not use the
DMA-API. Furthermore, some drivers may not use all levels or CPUs.

Move the initialization of the loaded and prev magazines for each CPU on
the first attempt to try to insert a freed IOVA to them.

Signed-off-by: Logan Odell <loganodell@google.com>
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
2.54.0.1064.gd145956f57-goog

