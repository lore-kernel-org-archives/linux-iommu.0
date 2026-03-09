Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5013E9588
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081713; cv=none; b=gZC29ObIdhJ6z3mWQ+u6y1nSlWtnPlYt9XzR8yn88vSU5TzbAH/JEyTG4EReOyPxG1K91qT/11Srv0yeb7FC4BZUt4EQZwM3aBao1TLpjFB0Ut/iZVBX4ty0gwk4uO35a1lE5hAXMfMGxQBNrMNX1mhUSmQlPvhPBZ2ktnE7rms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081713; c=relaxed/simple;
	bh=7N1fI8PqA8FJAPjT4sPdXU28pehg/xUAbFEayCIIGBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDSmWrNi9T8Zqsz/34IPjsvKtr/vv8pJO7Khlio4rzOFtFGW6NWlB7IvwgxvifCfHSRfZQSQZi5RH6xyQv+0PAmHGZ2O7v1289m3qwh9Lp8SkGSaBsU0bDC/b06BgIdevASw81M8IzKP45HMNpr+ld3epXjwFeeayI/EbNGsvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liulynn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5QXnDG3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liulynn.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5QXnDG3"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae467f128fso83613495ad.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773081710; x=1773686510; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hz64vv1silEx2K5G0qlx0K9YkRrg4DOJtsc274SDqRk=;
        b=a5QXnDG3KLRqICai0GvP+QMY1JrJhmxLmbY5ySB54v5ffqy6BP0U+8+O4mtUifTig/
         gQx7AtUE9NpwULdgk2309YTWr7aDBRW3SS2t4wa9K/0vLUt4/LZ3WKlYXn20m29+0A/4
         XpE3N5eSz0lNx0vGKPpxr+JjCZjcSQP5n8rx+NFV+GcrvQ46i6JZipsCPCUhLX1AuTRS
         NDDIY8W+S9m92AtLGI6yDushX4PfEuOVXD4eYBD8JsR1X5leKRHXXjN3vxs1Whqp0B8L
         +KMeYeiKLYlOcdcLf3/IY/il8ZgV8o4Iw0uXOeWysa8E2hqM+F/8WiN4TEv25Ec6A5QF
         pEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081710; x=1773686510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz64vv1silEx2K5G0qlx0K9YkRrg4DOJtsc274SDqRk=;
        b=GJIV6cUJuWXwnuaY0NLjPUSgViuQBcFm6LzecJNwXY167ct+YFuLcR6/+82pu4HPVI
         KkfCVrv8u4c50lV9nm9Euyum+DDwL5Q1NXYOkmElwB7uZw7DPfTOdWBQLTzZl0N0SIeV
         RR/ecL5zy33bYBp9Jiji7FDNzJ2bgQAFl6FV1XSLfpM9g13HGzenDvVf0qgAmv+H8meT
         krwLMIESUbIimX9MsiEGfKwyDvWOluzM/Uweq+a3HkjE4b3xyprLz8Ax0QcV1Y4cieCb
         N4+QvgXuTmNWSaIGH1cHNK5KXE11FWe0EcqfZYLzu6WwPJ/d7WgNXMIS3lNIRWhD6Skw
         mkOg==
X-Gm-Message-State: AOJu0YwKOg6Dyd80dDAvvCNNMJmGxZjmrFR7C/vX1yT7mip5criEvHKb
	Pb+E3kZwF1/PcRh0WtjLUpVPZXjM3IyRulHmdwfqbUqsirTEvZUTsNPjASGs9EmCWfOhPWJIw+c
	qmp4fL3R53w==
X-Received: from plhz1.prod.google.com ([2002:a17:902:d9c1:b0:2a9:6267:c081])
 (user=liulynn job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4585:b0:2ae:50ec:fa27
 with SMTP id d9443c01a7336-2ae825300d4mr137272155ad.45.1773081710404; Mon, 09
 Mar 2026 11:41:50 -0700 (PDT)
Date: Mon,  9 Mar 2026 18:41:04 +0000
In-Reply-To: <116b79a2-fadb-4796-8cb7-9c2dfde54999@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <116b79a2-fadb-4796-8cb7-9c2dfde54999@arm.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309184104.2321071-1-liulynn@google.com>
Subject: [PATCH v3] iommu/iova: Add NULL check in iova_magazine_free()
From: Lynn Liu <liulynn@google.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Lynn Liu <liulynn@google.com>
Content-Type: text/plain; charset="UTF-8"

In iova_domain_init_rcaches(), when an iova_magazine allocation fails,
the code jumps to the error path and calls free_iova_rcaches().

In free_iova_rcaches(), the code iterates through all possible CPUs to
free both cpu_rcache->loaded and cpu_rcache->prev. However, if the
original allocation failed mid-way through the CPU loop, the pointers
for the remaining CPUs remain NULL. free_iova_rcaches() then blindly
attempts to free these NULL pointers, which causes a kernel paging
request fault in kmem_cache_free().

The crash can be observed when fault injection triggers a failure in
iova_magazine_alloc():

pc : _compound_head include/linux/page-flags.h:251 [inline]
pc : virt_to_folio include/linux/mm.h:1395 [inline]
pc : virt_to_slab mm/slab.h:215 [inline]
pc : kmem_cache_free+0x90/0x5c4 mm/slub.c:4769
...
Call trace:
 trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
 kmem_cache_free+0x90/0x5c4 mm/slub.c:4768
 iova_magazine_free drivers/iommu/iova.c:623 [inline]
 free_iova_rcaches+0x114/0x344 drivers/iommu/iova.c:894
 iova_domain_init_rcaches drivers/iommu/iova.c:762 [inline]
 iova_domain_init_rcaches+0x3d0/0x528 drivers/iommu/iova.c:717

These changes update iova_domain_init_rcaches() to check for allocation
failure immediately after each individual magazine allocation.
Correspondingly, update free_iova_rcaches() to break the cleanup loop
when it encounters a NULL pointer, ensuring only successfully allocated
resources are processed.

Fixes: 84e6f56be9c6 ("iommu/iova: use named kmem_cache for iova magazines")
Signed-off-by: Lynn Liu <liulynn@google.com>
---
v3:
 - Split magazine allocation checks in iova_domain_init_rcaches().
 - Add early breaks in free_iova_rcaches() to safely handle partial allocations as suggested.
 Link to v2: https://lore.kernel.org/linux-iommu/116b79a2-fadb-4796-8cb7-9c2dfde54999@arm.com/T/#t

v2:
 - Update author name to full name.
 - Add Fixes tag.
 - Include the Call trace from the kernel crash.
 Link to v1: https://lore.kernel.org/linux-iommu/20260214080919.390846-1-liulynn@google.com/T/#u

 drivers/iommu/iova.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 18f839721813..cf6cd9f23b97 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -740,8 +740,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 
 			spin_lock_init(&cpu_rcache->lock);
 			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
+			if (!cpu_rcache->loaded) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
 			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
-			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
+			if (!cpu_rcache->prev) {
 				ret = -ENOMEM;
 				goto out_err;
 			}
@@ -886,7 +890,11 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			break;
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+			if (!cpu_rcache->loaded)
+				break;
 			iova_magazine_free(cpu_rcache->loaded);
+			if (!cpu_rcache->prev)
+				break;
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
-- 
2.53.0.473.g4a7958ca14-goog

