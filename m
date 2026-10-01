Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7D2D9EFB
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895745; cv=none; b=XEQh9Igt5Wuxt2baOZwenQ365+DN/UKpeLXnY9Mpv9zKg6dnlkBw/gIHAKtapwUwtAzf228li/gCSz2ZN23kQXURqievi7jr1LN1BFU8pbbhNZSp37a1/WIsQsE8fY+TkNzUBUtTn2Y8Uyrb0ukPohwKENgvdj50vSoUy1CTHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895745; c=relaxed/simple;
	bh=00lrWxZe17VrlhuY3VaolhqUrEvdKVBmom6nqLyg/hg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hJnB2KRsz2x0VKJNZHEGiFdP61wh2IMX4cgAZ7V2o0kmh3Dt0jVrlp5aNWYiR4pisKsLCqXSp8offOiSWN9uOr/j2JchE8l01ljVSqgvlXkci44srOW8KVKabcROiPu+7ocq/c+m0K02FqeLmD19t/aDsholQVacADHf7i5gogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SagxXKGm; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SagxXKGm"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so8007824a12.2
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790895743; x=1791500543; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bxlv5ntBdZO0LQcKQEFlA8jL1mkcFGaYA5LZP7KTXI=;
        b=SagxXKGmtJjhVJx8GwOAhIzOGvc2wL7o6/poQjGs2xLm1k1JAwSs+RxqPl5MSQPpm3
         N5yejbQ7QSIXxOYmwuM9Yguuk+jpq+QIo8U9TlPNV529tLaHLLsI9gqp65rLNkOdd8e+
         acOrAtmlNgWwdFkUApYvSgaDgWWBgw6jOHitBu0V3J1hjwIMfzpkFXh7L+ssp33GgbtU
         QuS4BTR7b+zEU7KA3ZX1KvTf49W1keyOEIb7BlmXEhcDh6Em6F/oh55ojtqtsnuYkWPX
         xCXagvow/egKpmZQGXCgqPQ+aisZx9rofPofB5/vpSJWkBwmqOCoDrcNtolZiQhd3Ikc
         xPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895743; x=1791500543;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bxlv5ntBdZO0LQcKQEFlA8jL1mkcFGaYA5LZP7KTXI=;
        b=oIi9+W3L3TrRSuWTc7WbsicIz5wNXuKLG3Sc7bEXrYmrhOI70Z9AQn/d6+AzqiW3uV
         YqchlDt3P3qtk3UM/yotlzu2Z2kx48iN3o1nUzk/xetBMt3zjbtpij0gJjc68+AO83s1
         DPM4fWVSEJZNtAULrtdgzDanwMCFYab1GEBI9/esAh2t8XMUAOH0BZ39T6L4x3t5oAnr
         tOVEk55OmvTnDU0fTZ6EjUcBSY0Q+bdhyXZlrEtBI5CPw3uEPu22Q84mzYUDXC3ZZptM
         MXcaEICem+79fXtmnjlbX5CwCqu2wgSmC75xigBZl1Q1Cv5J0SGtGTfEzDAYSisLnODy
         N3Ag==
X-Forwarded-Encrypted: i=1; AKwUvBzglKy/xnV0DjPSRzI5ixH+ctI1Y4rpopaw+ljo7zhvmFUohrU6uRd7PSFke5eSnP+Te7BRtQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k9nOqTBpg9dCS0JsVUYz/jxtcaaBQ3stF0DJf9kMb1fGXdxkBJ
	i195UzYW4Z7ara7lf+rSSK2vL5CJZ8/4P1ohnCtWayabqSHx6RHxFmtkghjtYamV+UHGf4ForPL
	8FQ==
X-Received: from pgqs2.prod.google.com ([2002:a65:6902:0:b0:cc7:58af:e212])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a97:b0:3c3:a3f4:5485
 with SMTP id adf61e73a8af0-3e0bc9f8cc2mr744551637.6.1790895742383; Thu, 01
 Oct 2026 16:02:22 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:02:14 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001230219.818128-1-praan@google.com>
Subject: [RFC PATCH 0/5] iommupt: Introduce IO page table shrinker
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Logan Odell <loganodell@google.com>, iommu@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a lockless, deferred reclamation framework for IOMMU page tables
built on the generic_pt library. As VMMs and userspace drivers map and
unmap large, sparse IOVA regions through VFIO and iommufd, page table
directories are often left allocated but completely empty. generic_pt
frees a table when a single unmap covers it entirely, but tables that
empty through a series of partial unmaps stay allocated until the domain
is destroyed. Under memory pressure, this *stranded* memory cannot be
reclaimed and has resulted in OOMs.

This series refcounts leaf directories natively in struct ioptdesc and
registers a domain-aware MM shrinker that prunes empty directories under
system memory pressure.

This is an RFC to align on the design. It has known issues, listed below,
and is not intended for merging as-is.

Design
======
 - Refcounting: the __page_refcount of a leaf directory's struct ioptdesc
   counts its valid leaf entries, plus one for the table itself. Map takes
   a reference with atomic_inc_not_zero() before installing a leaf, and
   unmap drops it after clearing one. Leaf entries are counted only in the
   table that holds them, so map and unmap never update refcounts on the
   shared tables above it.
 - Queueing: when the refcount drops to 1, the directory is empty and is
   logged with its IOVA into a per-domain xarray (reclaim_list). Only
   non-DMA domains are queued.
 - Claim: under memory pressure, the shrinker walks the queued directories
   and claims each with atomic_cmpxchg(refcount, 1, 0). A map that finds
   the refcount at 0 fails atomic_inc_not_zero() and retries, so it never
   reuses a claimed directory.
 - Sever: a format-agnostic top-down walk (sever_branch) clears the parent
   slot with cmpxchg, severing the dead branch from the live tree.
 - Free: the domain's IOTLB is flushed so the IOMMU drops any cached
   pointers to the severed tables. A single synchronize_srcu() then waits
   for in-flight map walkers before the pages are freed.

The cost is one atomic operation per leaf entry on map and unmap, plus an
xarray insert when a directory becomes empty.

Known issues
============
These are understood and will be addressed in the next version:

 - Map vs. shrinker retry: on a claimed directory, map returns -EAGAIN,
   which __map_range() already uses to re-descend into the cached table
   pointer, i.e. the dead directory. It needs a distinct error and a retry
   from the top.
 - Unmap vs. shrinker hand-off: an unmap that fully covers a queued
   directory, or a large-page map over an empty range, frees it directly
   while the xarray still references it.
 - xarray keys: the key is the IOVA where the emptying unmap started, so a
   directory can be queued under several keys and nr_reclaimable
   over-counts. Keying by the table's PFN makes entries unique.
 - A failed sever leaves the refcount at 0 instead of restoring it to 1.
   The top-level table, which has no parent, should never be queued.
 - iommufd allocates paging domains without iommu_domain_init(), so their
   reclaim_list is not initialised.
 - Combined with the observability series, pages must be uncharged from
   their domain at sever time, as they are freed after the domain may be
   gone.

Open questions
==============
 - Leaf directories with child tables: a leaf directory above the last
   level (e.g. one holding a 2M leaf) can gain a child table, which is not
   counted, and could then be reclaimed while the child is live. Should
   child tables be counted at install, or counting be restricted to
   last-level directories?
 - SRCU in reclaim context: the shrinker can run from direct reclaim
   inside a map's SRCU read section, where synchronize_srcu() would wait on
   itself. Should the free be deferred (work item / call_srcu), or is a
   different scheme preferred?
 - IOTLB flush granularity: flush_iotlb_all() is used after severing.
   Would a range-based paging-structure flush be preferred?
 - DMA-API domains are excluded since their unmap can run in IRQ context.
   Should the per-leaf atomics also be skipped for them?

Upcoming Work / Roadmap
=======================
An IO page table observability series, which attributes page table memory
to its domain and exposes it via fdinfo, is posted separately as an RFC.
The two series are independent; this one applies on v7.3-rc5 by itself.

There's an alignment session at Linux Plumbers Conference 2026 for these [1].

[1] https://lpc.events/event/20/contributions/2624/

Pranjal Shrivastava (5):
  iommu: Add reclaim_list xarray to struct iommu_domain
  iommupt: Implement refcounting logic for Leaf entries
  iommupt: Add lockless sever_branch helper
  iommupt: Introduce lockless page table shrinker
  iommupt: Return real page count to the shrinker core

 drivers/iommu/Makefile              |   2 +-
 drivers/iommu/generic_pt/iommu_pt.h |  81 ++++++++++++++++-
 drivers/iommu/generic_pt/shrinker.c | 135 ++++++++++++++++++++++++++++
 drivers/iommu/iommu.c               |   2 +
 include/linux/generic_pt/iommu.h    |  29 ++++++
 include/linux/iommu.h               |   3 +
 6 files changed, 249 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/shrinker.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

