Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7870433E62
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008943; cv=none; b=BFlkfjS3GVHZmDf5+PzXskDZlLGwMG+KEcxUtUDa0EXOgbmOHNKtuZ35eG/QGHxru5NeOsEdyPv5oSUl/43ttCzN77r3HvUqYgiBq/cf7R6lrfMmvejOwkZGfC5eMunhKCpwmeYGkya23HZNAYom0PzzVisrPoozCPdwOXHib/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008943; c=relaxed/simple;
	bh=ZHLCtUVO6uYDOsdtlCc6ZAdxnR8tUMuzMFx7R4VBsvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtJyM66tg0O5tXLJ4/HiqbtJWYqQGTVdJ6/skXz4F69AItjcGCPYWNt83tHp6QD77vAZk4njooD5LH/XXHSPpYUNp6CQm7KonOknyS1hcIpvDLCfiFEhkV9H9Wq21rkve9E3iyPvVl51xk+rX2sZnBwqtkg4Gkb5n+FjXWQ8n5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC7W8tF6; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC7W8tF6"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso7127085ad.1
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008936; x=1786613736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAi2qaVA1OaGq4fUWHi+grRNkf4AM4PgvPmY0Rr+XE4=;
        b=NC7W8tF6H1RtB5RmviUNItlflOq48DOxESxqh7aZA9RwX2EBZlQCayPYSjhrFbu+Br
         A07ut9VK57H9R2M9+5umpfLfNG50A4lTNlbgsbs/mBIlDSbvyMkDjS07TC5Lv2/eU0yf
         5W4tWeSGzha5veIu9cFiZFsyUqmPj+8ocEGDWW+Ou5f9Fwsv6jBJU3xFltxa3VsC4/c1
         usHlUtOTJ9bCz92FbDR0nB3kIfxIZp+c8YoN+6OingMts9ZROVwh8EeY0zOtxqX+6gnL
         nloughZcsNXNoOjPOk+iSZ5HxgyEIRHoVJBLAz9ARxA4orEkflzk7SXJb+iwKKWC6paG
         0SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008936; x=1786613736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAi2qaVA1OaGq4fUWHi+grRNkf4AM4PgvPmY0Rr+XE4=;
        b=grK/k+fdYV/cNjCHOAIeAcB7xjKGt6bR98Ux0HwoPQWXi/Rv8ijOTXXpMProKdCc+f
         KfPhN7FJG6/IssqtGSBw6aPN3e5x+wjRMtSxdivB3hMqRdYs8WLBoEl56xrjyWm5m+6D
         NfG7XwFAvJbDuWSUzPWsgrkncHb1wqzKOSwqb429dlh9N21AwsU8+yePcgfDf/uvX4zt
         G01neqhvD3qVcpUydrtJJsbHXalX2RjPQYqJhNPbEhhBCbP+b2Kh76Lb0mHWsoj+xMsK
         37w6lnq6UWDx1fmfCTCYKNHtA9KuG1MZElzK+8hthYqEiFKog9qw7ClmWBmn4FTI/oFB
         7t7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoHL3fnOMXEatp/+njnuNPWYDpS2RsdlJOICFoy3ifoXB36OUp8CdscXTFjVUYp+rObI7tzrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1v4RGSzjFhGvzkBkJ+7iL3D00EGqBPMeGrQzftLgkhdrwLGIK
	4IUb96B0zpebREUBW9TYROul52d+UbRiP+gfr2K98M+Bwgnilx0WRoFY
X-Gm-Gg: AR+sD10h2qO1kHqf/kRSQoKIftjOmzJeyay4kc0EsYr+DUHzx/x5b5nb+2itxDbbEml
	76RiwOFLNKGP0kzaoMg/3fh0jcIkaqT4L6Ist4xeQUmuouR+IQgpBOhToLCc9sSfI6yX1RMbGUf
	8dp6eLmgHd9yo9aMB27Qp5Wfh7/7NIaC8/DBtCUYHev/3d2FOYPNxVQOW10tLtAvvt9WH3i3fxY
	dKPIRRpDul31LG70YodXq9sNXSmLmhnyA1YlrbCjcKrk584mYb5uycFfVX/4CvZbj/YI7jvdY8r
	421wIWyG2GGSak8n1qVMwnNRrwwQcWof0gs+XIfEZl4vs1i/MpYKxwC+KoxUhJLdz9ECPYzY1Oo
	wP/aFAPU1kZSg+5DpPUT6JwL3Tcb1/MZ0Y0M/tbrRfa6vRPcV3MELTe+wlca5ewKhgruK32LQdL
	trj4Dc8bLxdOk5+cSY3j1IIC5IZakioU9oWQx4DG7ZA+z0yFJ+z8bW4yhgAXLMd+A93Dw53YwHg
	A==
X-Received: by 2002:a05:6a00:9515:b0:84c:1cd2:142e with SMTP id d2e1a72fcca58-84f4fe9e75cmr58122b3a.23.1786008936445;
        Thu, 06 Aug 2026 02:35:36 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:35:35 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 0/8] kdump: reduce vmcore size and capture time
Date: Thu,  6 Aug 2026 17:35:11 +0800
Message-ID: <20260806093519.2907771-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

On SoCs that carve out large firmware-owned reserved memory (GPU,
camera ISP, ...), kdump currently dumps those carveouts as part of
system RAM even though their contents are firmware state that is not
useful for kernel crash analysis.

This series introduces a 'dumpable' flag on struct reserved_mem and a
MEMBLOCK_NODUMP flag in memblock to filter vmcore ELF header on DT-based
architectures (arm64, riscv, loongarch). Reserved regions default to
non-dumpable and are marked MEMBLOCK_NODUMP so kdump omits them;
reusable CMA regions are explicitly marked dumpable in rmem_cma_setup()
because their pages are handed back to the buddy allocator and may carry
crash-relevant data.

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce. ACPI systems already filter
reserved memory out of the vmcore through their existing path; only
DT-based systems currently fail to filter these regions, which is what
this series addresses. The flag lives in memblock itself rather than
in a DT-only structure, so the mechanism is generic and both ACPI and
DT systems can benefit from it (suggested by Rob, thanks).

The series is based on linux-next and is organized as follows:
  Patches 1-2: Introduce MEMBLOCK_NODUMP in memblock and the dumpable
               flag on struct reserved_mem.
  Patches 3-4: Mark non-dumpable /reserved-memory and /memreserve/
               entries with MEMBLOCK_NODUMP.
  Patch 5:     Switch riscv to memblock so the NODUMP flag is visible
               to the vmcore ELF header builder; add (KEXEC_FILE &&
               CRASH_DUMP) to riscv's ARCH_KEEP_MEMBLOCK condition.
  Patches 6-8: Fold the duplicated per-arch memblock walks into the
               weak defaults in crash_core, switch to
               for_each_mem_region(), and exclude MEMBLOCK_NODUMP
               regions from the vmcore ELF header.

v4 --> v5:
1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
   (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
   DT-only struct reserved_mem.

2. Switch the riscv vmcore elf header preparation to use memblock
   instead of the resource tree, aligning it with arm64 and loongarch,
   so riscv also can exclude reserved memory from vmcore.

3. Deduplicate the vmcore elf header preparation: arm64, riscv and
   loongarch open-coded the same logic, so fold it into shared
    __weak defaults in crash_core.

4.  Drop the v4 patch that saved /memreserve/ entries into the
    reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
    directly.

v3 --> v4:
1. Rebase this series on v7.2-rc1.
2. Add two cleanup patches (patch 02/03).
3. Simplify patch 03 to avoid checking whether initial_boot_params is
   NULL multiple times, suggested by Rob.

v2 --> v3:
1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
2. Fix UAF issue when alloc_reserved_mem_array() fails.
3. Add some prepare patches.

v1 --> v2:
1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
   feedback [1], v2 drop that property and exclude reserve memory
   by default.
2. Split some prepared patches from the original patches.
3. Address coding-style comments on patch 5 from Rob.

[1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
[2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4

Wandun Chen (8):
  memblock: introduce MEMBLOCK_NODUMP flag
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
  of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
  riscv: build crash_mem ranges from memblock instead of resource tree
  crash_core: fold duplicated memblock arch hooks into the weak default
  crash_core: replace for_each_mem_range() with for_each_mem_region()
  crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
    header

 arch/arm64/kernel/machine_kexec_file.c     | 29 ------------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 -----------------
 arch/riscv/Kconfig                         |  2 +-
 arch/riscv/kernel/machine_kexec_file.c     | 33 --------------------
 drivers/of/fdt.c                           |  2 ++
 drivers/of/of_private.h                    |  1 +
 drivers/of/of_reserved_mem.c               | 35 ++++++++++++++++++++++
 include/linux/memblock.h                   |  9 ++++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 34 +++++++++++++++++++--
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 16 ++++++++++
 12 files changed, 98 insertions(+), 92 deletions(-)

-- 
2.43.0

