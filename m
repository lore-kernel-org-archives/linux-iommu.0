Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08C37998A
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554537; cv=none; b=QhJEq9Az9/Sand646rmwZeO/aw3N6GF6VUvPD3c24i9IYzLdii31QU6NzJzekZ3stK7OUU9k1YnWIde7bOSjgPzmlJzFpm5w/ko3EuOheJ+K0VYYDU+EYEagmEepGOT+U5DaTWinsbJ5cpS4xVo/VN+0Yd+pZVZzJ2011T8acvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554537; c=relaxed/simple;
	bh=G3caR3ol9l1UAID9NGNJUzLJRALfVwc2Uu3omiML4ws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hl0C5O/Zi5YSUQ/1vBHD0gSXinGSPlkz93CEedpYV3wXadzm9H/n8uTUjVG0ARcsJFZOz+hIQaeLWcJhMGA5TcL5GtvetB37N7VYGMw5Qyr6ODQb5hWByD0pWmk78eQipXhVIGBxmmGdKPEOEQazN/+xMK7R0m81rtYo5lJn+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGWpvrm1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGWpvrm1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84770f89b99so436173b3a.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554535; x=1784159335; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKctKavL+T1fCBJtVjfwPQ5K5bQzru9zHJrkxaBJCqQ=;
        b=pGWpvrm1YE68uGggHlaUkIYAEvYmnvPXNWY0w9+cSJEqfHnMykOgDSDxzK0ZfmyhTU
         Agds0c+4BjeE5CchqQtFnDIPzb53BUVwyIpoPnA+wIOkzcWJxgul53yfR2GxHRStmMf5
         BbIIOw4LgnHlb5K3q0kVeeil5YIxKU5DkofoZdWRQhxk1MvVsFl/jTJJvLCDv3j3TPSM
         qBmO9jP10PQrJsKPSwa0ZZ9a4OxQH4vt3C3LbwLPjqMLrcGJGcAgq0DFgp1NG5zwdGbE
         nUZgfj9AmtUbVFh6n5QWDVH0hehNzL305iORVeLKM06I2hehPvMX9vXHu4CMmKuHMbPy
         Iz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554535; x=1784159335;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKctKavL+T1fCBJtVjfwPQ5K5bQzru9zHJrkxaBJCqQ=;
        b=rIAVLIpFp91gO7NPGRhJ9zHUZftHTVR7b6zUnWPVDTwFexOlx6+gNfODzDT2PPrcSa
         hs3d/xuA8b5I44bz2rLZen3x4HARjUNI7SyhRUavSbv1UmxWdTM17ehJl7uQP+4ttqtA
         J1JRhhYlmJFKK6G/ZMXweoBGbl0OqfERFtx78pxa4yM+cl7N1hmo1sdTUTZaNC30haec
         penMpBmQj4F7wt8g4XEW2l8RC2VguwUuPqYiKgdAibLubdiNnLdngAH3hlqlengvTDn0
         693sQxEG7emQrI0mwzxs/dTAISRgU4LJxKbyc5h0nJtsUM4oZc4tWNDANsp+6l50QzrN
         U26w==
X-Forwarded-Encrypted: i=1; AHgh+Rr8CqkYU/BIjsfI42XKRtGD4NUVFAaJmLEqu1grQM589Ue7GBngUOh8b8yVGLhsKTjueKNTBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5LH2dAL09eCwkJCMpaSS+1heeKsLuVUmUoLOy8xu09J5NFAHW
	+CMXfCCa/ZqgXrQ2mNZpjkJHAt6ELnMAL4y8upKf5LpEjVwCkkKDDjJZBSpEDjXmofNhsIkI8dl
	Iz8HWYNM1y01kTA==
X-Received: from pfblh15.prod.google.com ([2002:a05:6a00:710f:b0:845:eada:32d2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9513:b0:845:db8d:f631 with SMTP id d2e1a72fcca58-84842ec1f1dmr4624788b3a.7.1783554534952;
 Wed, 08 Jul 2026 16:48:54 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:44 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-1-skhawaja@google.com>
Subject: [RFC PATCH v2 00/10] dma-mapping: Add preservation of direct allocations
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

This is an RFC v2 to discuss the preservation of DMA allocations for
devices that are using direct allocation mode. Note preservation here
means preservation of physical memory using KHO only. IOVAs and IOMMU
mappings are out of scope.

The complexity and need of this was discussed in the thread mentioned
below. It was proposed to allow preservation of only a subset of
allocations with minimum support. Offline discussion with Will Deacon
concluded that this series is still needed, because we still want to use
coherent allocations for Arm sMMUv3 ste/cds, so sending this v2.

https://lore.kernel.org/all/aepfYzkI7NsVGCF0@google.com/
https://lore.kernel.org/all/aepRy7Gp7Ng85Zr7@willie-the-truck/

Note DMA allocation allows memory allocation from various allocators in
various configurations. This RFC supports preservation with,

- Direct Allocation Only.
- Pages allocated through alloc_page (Buddy allocator).
- No CMA support.
- No DMA pools.
- No device coherent memory regions.

Note that this series does not include/use the page-split and page
refcount fixes during KHO restore, that are in review here:
https://lore.kernel.org/all/20260703020832.1731864-1-praan@google.com/

The changes are also pushed here:
https://github.com/samikhawaja/linux/tree/dma-alloc-preserve-direct-v2

Testing:

This patch series includes a Kunit test, for testing dma allocation
preservation, by using the KHO stubs added in a separate patch series:
https://lore.kernel.org/all/20260521193202.746810-1-skhawaja@google.com/

The following test runs are executed in qemu.

Run on x86:

   KTAP version 1
   1..1
       KTAP version 1
       # Subtest: dma_direct_liveupdate
       # module: direct_test
       1..5
           KTAP version 1
           # Subtest: test_dma_direct_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent: pass:5 fail:0 skip:0 total:5
       ok 1 test_dma_direct_coherent
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_non_coherent: pass:5 fail:0 skip:0 total:5
       ok 2 test_dma_direct_non_coherent
           KTAP version 1
           # Subtest: test_dma_direct_coherent_atomic
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 3 test_dma_direct_coherent_atomic
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent_atomic
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_non_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 4 test_dma_direct_non_coherent_atomic
       ok 5 test_dmam_preservation
   # dma_direct_liveupdate: pass:5 fail:0 skip:0 total:5
   # Totals: pass:21 fail:0 skip:0 total:21
   ok 1 dma_direct_liveupdate

Run on arm64:

   KTAP version 1
   1..1
       KTAP version 1
       # Subtest: dma_direct_liveupdate
       # module: direct_test
       1..5
           KTAP version 1
           # Subtest: test_dma_direct_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent: pass:5 fail:0 skip:0 total:5
       ok 1 test_dma_direct_coherent
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_non_coherent: pass:5 fail:0 skip:0 total:5
       ok 2 test_dma_direct_non_coherent
           KTAP version 1
           # Subtest: test_dma_direct_coherent_atomic
           ok 1 size=128
           ok 2 size=4096
           ok 3 size=8192
           ok 4 size=12288
           ok 5 size=32768
       # test_dma_direct_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 3 test_dma_direct_coherent_atomic
           KTAP version 1
           # Subtest: test_dma_direct_non_coherent_atomic
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 1 size=128
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 2 size=4096
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 3 size=8192
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 4 size=12288
       # test_dma_direct_non_coherent_atomic: DMA allocation using pool, expecting -EOPNOTSUPP
           ok 5 size=32768
       # test_dma_direct_non_coherent_atomic: pass:5 fail:0 skip:0 total:5
       ok 4 test_dma_direct_non_coherent_atomic
       ok 5 test_dmam_preservation
   # dma_direct_liveupdate: pass:5 fail:0 skip:0 total:5
   # Totals: pass:21 fail:0 skip:0 total:21
   ok 1 dma_direct_liveupdate

Looking forward to your feedback on this.

Changelog:

rfc v2:

  - Add dma_is_from_cma() to check if an allocation is from CMA.
  - Add dma_is_from_dev_coherent() to check if an allocation is from a device coherent region.
  - Add support for preserving device-managed DMA allocations (dmam_alloc_*).
  - Add KUnit test suite for dma-direct liveupdate preservation.

Samiullah Khawaja (10):
  dma: Add DMA allocation preservation KHO ABI
  dma/pool: Add an API to check if DMA allocation is from pool
  dma: contiguous: Add API to check if an allocation is from CMA
  dma-coherent: Allow checking if allocation is from dev coherent region
  dma-direct: Add API to preserve/restore allocations
  dma-mapping: Add API to preserve/restore DMA allocation
  dma-mapping: Add support of preserving dmam allocations
  dma: contiguous: Export is_from_cma helper for kunit
  dma: pool: Export the is_from_pool helper for kunit
  dma-direct: Add KUnit test for liveupdate preservation

 include/linux/dma-direct.h        |  29 +++++
 include/linux/dma-map-ops.h       |  10 ++
 include/linux/dma-mapping.h       | 100 ++++++++++++++
 include/linux/kho/abi/dma_alloc.h |  32 +++++
 kernel/dma/Kconfig                |  12 ++
 kernel/dma/Makefile               |   1 +
 kernel/dma/coherent.c             |  11 ++
 kernel/dma/contiguous.c           |  27 ++++
 kernel/dma/direct.c               | 189 +++++++++++++++++++++++++++
 kernel/dma/direct_test.c          | 208 ++++++++++++++++++++++++++++++
 kernel/dma/mapping.c              | 132 +++++++++++++++++++
 kernel/dma/pool.c                 |  17 +++
 12 files changed, 768 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h
 create mode 100644 kernel/dma/direct_test.c


base-commit: ec4084bc445027a52f600e30a976928be1ba1950
-- 
2.55.0.795.g602f6c329a-goog

