Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C83E0C7B
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167862; cv=none; b=HAM5waITTwoR4Fw6gbKRGf7XigSCKkgv5WjaGLPdijtlz0WVUuPToSPmIQlJJMS3wHWEch7PQGMu7cxiSaUfD+q+2lKG6kUXIUTGTAAVXn3ClyuQ2v84DKgV9wlL1ZTDEklZdrTkpl4hmgDkD/YHXwxCAmlVCJ/NPxZX4/1fntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167862; c=relaxed/simple;
	bh=+STRKREutXOyFTtv+83VpeyUbfK8/iLir6ikDZIoTY8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c1VqlHy+CzewnO6Q3ziZ414+PmsAVO3eHnbuGAlrnAebpZxw5prcJyXp9M0zeFACRwHxeOm86E+kvUVTJ4SmPmhG52YpxEo5BJCQHzTVLivKsUpk0Jl3N9PvjjxQayqHxHHzcNJSZPW3x/nbGXpn+BCGktiDfmmzh76yOu747yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngcowUbD; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngcowUbD"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so1959645a12.0
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785167860; x=1785772660; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYdmGeZqdcTZT2Ey5trUwgkVjKGLhBqyrb9UPgD7TCM=;
        b=ngcowUbDHBaM4rEB7CJhJfRWnR04t6Zk1m3kd5gBV3IGI4dOYiBtO4aQIq/BIlX0ce
         tvIu7KunpT3HLFxMr3Vp3svGFYH2TbhQPAmOS83H67r68CqIcz/tijK5ffgYg05shD/5
         UbvV8NLlD5WW75FKREV5XOvhl4STOCs5umRvvOwicvpy5XvMXDqRJ9WVstVyveMOSGWK
         336+EhNJyWGaDAIDf1U21BLhVjco+OwApXOQuOUF7NZgg3zXJGYSnPXs12o9ro1KuT4f
         Ju7U/ijsscPesSJLBJxbOZqpSR/9p/fJAfWZSL7bOCHEgVt+KfSos62RLvehJejRNinL
         kadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167860; x=1785772660;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fYdmGeZqdcTZT2Ey5trUwgkVjKGLhBqyrb9UPgD7TCM=;
        b=ghfEFe6rYLSnYUnTuDscmdhmprR/c48iQyLDlw0YsVvzVSSkFYI5diiz/i+L0hC4SL
         Xo8oOWwEnocajHJpPPW7AoCW3qTd7dBQM/qjniON9Zu5fDb8CqxZALnwHNKFR3V3N0k3
         DRUIg8v5x0r+df3AtLaZqMI72HC6dGTmMSRT5YXbAbmhFhb94kY3AU2XC2BbWO5EwRBm
         OcV6Duq39N9tWDg0tBxkbVRxOv6cTrIFM4Nf314zkouTidmSS2BqP34FsLPvA+bBIeXJ
         A6pneM0CbP+mKzYNwIpuAQgvXlcn7OY/UNF1JDMfw6bU5ntrhh2uDaBtjzfUfmfCfnVt
         fycg==
X-Gm-Message-State: AOJu0YykSdO/47F/Nm6kac9mf9jrRUzSd2gQox/3JsbIcDWrbY2wz9+I
	ro2gxVHwi0KjEQUgPNNm3JRZhmK8yd70gvNpU6Zo8F8evgJd4RdiG62lQDtbnxUf81jli6++57b
	oTVOTrGoyImrkmLIF9xQNQA==
X-Received: from dltt19.prod.google.com ([2002:a05:701a:c973:b0:13c:e20a:efb6])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3393:b0:3c3:b57b:628f with SMTP id adf61e73a8af0-3c67df285fcmr9621374637.48.1785167860167;
 Mon, 27 Jul 2026 08:57:40 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:57:20 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727155720.2692587-1-loganodell@google.com>
Subject: [PATCH v3] iommu/iova: Move CPU magazine init to first insert
From: Logan Odell <loganodell@google.com>
To: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
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
Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
v2: only rebase
v3: Combine the initilaization logic with new magazine logic in __iova_rcache_insert
---

Change-Id: I987b6dfb2b1125d8da8618fff540f315b99bad13
---
 drivers/iommu/iova.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 021daf6528de..82d52eb12e4c 100644
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
@@ -739,12 +742,6 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 
 			spin_lock_init(&cpu_rcache->lock);
-			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
-			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
-			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
-				ret = -ENOMEM;
-				goto out_err;
-			}
 		}
 	}
 
@@ -777,19 +774,23 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
-	if (!iova_magazine_full(cpu_rcache->loaded)) {
+	if (cpu_rcache->loaded && !iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (cpu_rcache->prev && !iova_magazine_full(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
 		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
 
 		if (new_mag) {
-			spin_lock(&rcache->lock);
-			iova_depot_push(rcache, cpu_rcache->loaded);
-			spin_unlock(&rcache->lock);
-			schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
+			if (cpu_rcache->loaded && !cpu_rcache->prev) {
+				cpu_rcache->prev = cpu_rcache->loaded;
+			} else if (cpu_rcache->loaded) {
+				spin_lock(&rcache->lock);
+				iova_depot_push(rcache, cpu_rcache->loaded);
+				spin_unlock(&rcache->lock);
+				schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
+			}
 
 			cpu_rcache->loaded = new_mag;
 			can_insert = true;
@@ -831,9 +832,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
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
2.55.0.229.g6434b31f56-goog

