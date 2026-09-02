Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373D353A75
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334295; cv=none; b=R2zqmqUbk4IoPSrje18sVL8aMJi2SOWhxBJiDt7lDs8XnfQgJKNopyTP/d7TRDiJWl0AMK3mPdBGATzNEXp8UpIDCiPggn6URG8vx3Wj3MdMi6kgY79+rvyUcxPVYqx6HKPmitYTxKEt2PWgO/8glXK/GxF0pjrucjLvKVntX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334295; c=relaxed/simple;
	bh=RWIEXwoFCLRI4LG31OsYGEbdius9ZAooyaqbm1078lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4D5eBveXA0Ln4QrDf8Uietu/paLDLHuglYO7ludoWzdEtCza1WeBTjhsgxarbj5GVSKOo0S2JaHX5zJmcu7jFSdoKA5NRo7sn8lh8rTlk0j2PcWxNSgdWGF0HyvcKc9Y9OmdJ1zGk2r2wfPMFyuOT8MEIgCyOt6AXsxbhEc/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG3zx2lL; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG3zx2lL"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7a25cd87dso588220a12.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334293; x=1788939093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5vjeiQCLsTjdZkQJr1qZRy9fU+p/hRxqt/dZCpjN/k=;
        b=rG3zx2lLE0HupEIKv2dSc4NNPtCWPHtGb03Ev8dHvL3zkBm4gwFlzlDBT0wPTC5aOo
         bNJxvP4qsIRcVBniHSYqdEWir+4gFqPO0BUWS667aPA0wnboEza5MFF8WF85O+Ls+TmX
         7W6VROaX/0n8YHgJoJpHxb34nSRCmDSjBQPdoR/q8fi2Jm9CKPulqyQ0JYuQfNQZCHly
         /YZDTBUpc19x3AXmZ8WDJWEw4A5ghtjxbQXjs7MDZLoiir5WITu6IkKQG6gpY+NVvzd8
         nBHjBS5zsPty7OgFosicSMGBtVmZK/kA1RVZnu4JFDr6tnkf/zG8lO2VeU7le2KqPfm7
         F3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334293; x=1788939093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5vjeiQCLsTjdZkQJr1qZRy9fU+p/hRxqt/dZCpjN/k=;
        b=l8ai89YafcBVWf5nXSYa8wvNAL6wS/EfV93hWZalL0KDcs/UheP9xrwhGN6t3JsYAz
         pHv9nXazAWUaNYeSeupEZjDNfQMHwVPMniYG0pufxBrVieFqXQJ9bUlZMdzx/xDFn/ps
         YKmRw5nvh0+4kDpKUfoli4YEmjIcvXoFy50Fj9u7hc13relSI5P/8YGoOWQaL8SP6ob4
         XSb0X18ym/UGjuq5tbD6+CP4qvMFpqLK2g+btLR5d8MnmqXB/f0lztHngX4PCJr9spDW
         i25QzQ2MPeaMlLYxpggG0UcTPDLC8D4ms5p9sXn3fIQfEJvR0hNsxP+JonZtLFwsD7qh
         9/LA==
X-Forwarded-Encrypted: i=1; AKwUvBzXCWmwDeHyrp+nWfCiCp/52Vu/fBISY5IqhdqXBEYmF/Nhz8lU4n2nOyUJb8pwiDe+id3jcw==@lists.linux.dev
X-Gm-Message-State: AFuF++lqR4jQZ4v4ZyXQJJjZpa7Yq45gYw0I1UGbhsxOonf0FVjpahOi
	IpcOSY9EhjIbSFZtp6a8miP8JTxN8df8j/idh7whRT5WOCkO2AE3EfUF
X-Gm-Gg: AYBFou003fyoxxbC4EcReVkyrQm/5i9CUuGf1JcFF8v4qrmO9/rdJsPnqFtyyg7bjRi
	0lGGOhELcG3b0fyOfDi2LkO9XXGsey4OhoIFusBLjoXf0Q4Qm0+jU92MyWvEhTmjZpa6sCfVo7v
	4KJtmCYbY9c5zeT7iGCdJ/EcQVsBvfrgX4Rv3UxykvDYyM8oJmD+sVlQFNvQH6ugekFRy+gR1mB
	/swUqheVwReR28oC8K4OBjdAFL/r3I2OSDRwILJ8Z98yshaXL/HXhMESWSlpTii97VKcHFFAZY8
	bgCJdgDpajH3dqm4L0vNdl7ipvZAM0lxYOfMJ7bAhoTVN/wWviCYGGrsPqhPfPB8/5J23gRMH9I
	84S/n53f+k4oycsyB4aKjaBFD5QKMhaPdaSjTsWsKAY0s+mg6byKlv4uzcAagm+n0WICGpsFE8T
	RPfchLPsf1lVEccHSGWVY0nVKodKZgJeAzBbP0ftxwIkAl/iBA/wif57aouirVXx7nQyokFsFD
X-Received: by 2002:a05:6a00:148e:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-85ed1d0414dmr5028771b3a.5.1788334293213;
        Wed, 02 Sep 2026 00:31:33 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:31:32 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
Date: Wed,  2 Sep 2026 15:31:06 +0800
Message-ID: <20260902073116.802752-1-chenwandun1@gmail.com>
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

This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
reserved memory on DT-based architectures (arm64, riscv, loongarch).
Reserved regions default are marked MEMBLOCK_NODUMP so kdump omits them;
reusable CMA regions are different because their pages are handed back
to the buddy allocator and may carry crash-relevant data.

ACPI systems already filter reserved memory out of the vmcore through
their existing path; only DT-based systems currently fail to filter these
regions, which is what this series addresses. The flag lives in memblock
itself rather than in a DT-only structure, so the mechanism is generic and
both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce. 

The series is based on linux-next and is organized as follows:

Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
             flagname, switch riscv crash_mem to memblock, fold the
             duplicated per-arch memblock walks into the weak
             defaults, and serialize crash header preparation against
             memory hotplug.
Patches 5-9: NODUMP infrastructure: switch crash_core to
             for_each_mem_region(), introduce the MEMBLOCK_NODUMP
             flag, add a dumpable flag to struct reserved_mem, and
             mark /reserved-memory and /memreserve/ entries with
	     MEMBLOCK_NODUMP flag.
Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
             header.

In v5, Sashiko found some pre-existing issues related to reserved-memory,
and has no dependency on this series, so these issues have been addressed
in a separate series [2].

v5 --> v6:
1. Serialize crash header preparation against memory hotplug to avoid
   out-of-bounds or use-after-free issues.

2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
   avoiding a panic from too few regions before resize is permitted.

3. Reordered the patches, put pre-existing bugfixes earlier in the series.


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
1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
2. Fix UAF issue when alloc_reserved_mem_array() fails.
3. Add some prepare patches.

v1 --> v2:
1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
   feedback [3], v2 drop that property and exclude reserve memory
   by default.
2. Split some prepared patches from the original patches.
3. Address coding-style comments on patch 5 from Rob.

[1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
[2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
[3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/

Meijing Zhao (1):
  mm: memblock: add missing HugeTLB flag name

Wandun Chen (9):
  riscv: build crash_mem ranges from memblock instead of resource tree
  crash_core: fold duplicated memblock arch hooks into the weak default
  crash_core: serialize crash header preparation against hotplug
  crash_core: replace for_each_mem_range() with for_each_mem_region()
  memblock: introduce MEMBLOCK_NODUMP flag
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
  of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
  crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
    header

 arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
 arch/riscv/Kconfig                         |  2 +-
 arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
 arch/x86/kernel/crash.c                    |  2 +-
 drivers/of/fdt.c                           |  2 +
 drivers/of/of_private.h                    |  2 +
 drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
 include/linux/crash_core.h                 |  2 +
 include/linux/memblock.h                   |  9 ++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 51 ++++++++++++++++++++--
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 17 ++++++++
 14 files changed, 131 insertions(+), 95 deletions(-)

-- 
2.43.0

