Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367238C2C3
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611644; cv=none; b=I5MtNfiqXRl+qMgPAAGtNMudw2i5BocJSyzHxB+F3Ybk2oBIW/0m49hyuFsHHU+APQCj6ipzvbbD7EX7LXg7XQPhz6Xm0GQjCoU8EbpCN3TiflQJEn9AUEPqxWe+ApGNrg4CwYcPnytAZDhZGKUNYfdUfUsP32NgSvRALUEcqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611644; c=relaxed/simple;
	bh=ECZkvFYUed+381xaLK5V5ceV1IEVrr/yAiQkDAC7vwc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sxds7oULsmgMH5VZLqChkKL6CpUXW8xgd4LgqCVlZhQPgwDX9KFhcm9e/mlfU+7C9v6T/Mjj/L6iEqnBFCWBSdBnqY9xTSWqSmUrjmk/Mvtb0YGjqqaxPUKkKPPVielrehs9PKYxgmvdvF5VUh5S02Wgyd1+s/ZTRXDTSnnA6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liulynn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkBBc9TS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liulynn.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkBBc9TS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae47b3adacso31427555ad.3
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 00:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772611642; x=1773216442; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=49qpq9KbDR/+8tqM5T7B4wKYI1YtV2DTAFLCoKtW5+0=;
        b=KkBBc9TSVimlBBsvuI3+IzncboToZinzlLWV1OnG5iBLMoeUSG+I3lCAkapg+KN8WI
         LBPTcSINdqzzFHWKTfIl4+9FwJPHp42dGH1xSk9UDyBq6EVGqsapwCZu5eLIHFPPzy2Z
         jiC9YqVX73JLsHtFkjys9dQsEnIyuVxuaoYAqqiTg2Ah3tJqKdEkzGSWwubSLceDLNFG
         21ELqVyDdKaRggD9kpYYhEinPvyLIFb5IFqP098G4OOBNk3LnNNFeY2pNjCe6ReDgt8X
         nejIw7ABeCS5y60qEVmys3k/bqA+dQYtIqZ5nVnTVnjAHuOmgBpYU4T8NDFz4ODOMZGp
         LaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611642; x=1773216442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49qpq9KbDR/+8tqM5T7B4wKYI1YtV2DTAFLCoKtW5+0=;
        b=NheFl9P+/gXjYZPLTLTdj8q05GUADsEqQXMPXWwUwBf8IHDHJ8J7oB5xTsfFuqfgdZ
         1D8Is3hvQ+P9viDEgoT9zx41NyltzEl3XZpqLLrdJXSZwbvDOhZS+seKd7iUBqoj4e9V
         0QPn0+dCvbIIjv0D55MbqQdQPG1gwQb9M+cixXElO7uqlzJVYXB8XRvPkFoJNQ0/1DUN
         Ab6vSZvVfK/aHWg7PbIJhKdCCUJo6aisXTNJLKenedu+paL0oV+6TI1CUh+YOXgRYhhG
         ZQPdd74V615HDPgejftBQQiq/DFKk2TlQlA3ZdbOmmoDUOevxBFqF1qqLQ3Vej1QzK/a
         i9rw==
X-Gm-Message-State: AOJu0YwlV2nulPmSMiQ4YY6fXgswSUkicKpvkfQGjs8CUiOYjqlCKCkq
	C9cnPCOO3AgWh5620mpSjFVauZPDtnuxVNswRlum38rhsrUtUvA74O6Gzvj2eoAcbVjrKBcY8hz
	P2+rpS+c+8g==
X-Received: from pldd2.prod.google.com ([2002:a17:902:c182:b0:2ad:8161:bc65])
 (user=liulynn job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0f:b0:2a9:622e:fd3e
 with SMTP id d9443c01a7336-2ae6aa04cecmr13694195ad.4.1772611642026; Wed, 04
 Mar 2026 00:07:22 -0800 (PST)
Date: Wed,  4 Mar 2026 08:06:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304080636.167426-1-liulynn@google.com>
Subject: [PATCH v2] iommu/iova: Add NULL check in iova_magazine_free()
From: Lynn Liu <liulynn@google.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Lynn Liu <liulynn@google.com>
Content-Type: text/plain; charset="UTF-8"

When iova_domain_init_rcaches() fails to allocate an iova_magazine
during the initialization of per-cpu rcaches, it jumps to out_err and
calls free_iova_rcaches() for cleanup.

In free_iova_rcaches(), the code iterates through all possible CPUs to
free both cpu_rcache->loaded and cpu_rcache->prev. However, if the
original allocation failed mid-way through the CPU loop, the pointers
for the remaining CPUs remain NULL.

Since kmem_cache_free() does not explicitly handle NULL pointers like
kfree() does, passing these NULL pointers leads to a kernel paging
request fault.

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

Add a NULL check in iova_magazine_free() to safely handle partially
initialized rcaches in error paths.

Fixes: 84e6f56be9c6 ("iommu/iova: use named kmem_cache for iova magazines")
Signed-off-by: Lynn Liu <liulynn@google.com>
---
v1: https://lore.kernel.org/linux-iommu/20260214080919.390846-1-liulynn@google.com/T/#u
Changelog in v1 -> v2:
 - Update author name to full name.
 - Add Fixes tag.
 - Include the Call trace from the kernel crash.

 drivers/iommu/iova.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 18f839721813..e026be5e068b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -611,7 +611,8 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kmem_cache_free(iova_magazine_cache, mag);
+	if (mag)
+		kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
-- 
2.53.0.473.g4a7958ca14-goog

