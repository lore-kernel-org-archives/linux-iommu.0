Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A043305C
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011118; cv=none; b=bh9JFumQmQNVi4oD1q5Q6yoOuiFARLQZLvUoLu6dsOYjePRgXubVl4MwX/YJQqNKe+kYP3pRINcZjo/Wvx5lovJ4LvZaFQUS3RifYdb032et2hDa7aOD/6V5e7WEvYIFiiCNaOSSsXBcW67521hUx3dvCO2S+iPEFtDaujey4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011118; c=relaxed/simple;
	bh=GrMks8wwD581o3AfzSr5fNGlq3w7/eLjXayhOzSr/3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oBIWL9V9qgyhKy5iKA1nodFB/tiH1Pq3XQ8debNa0c0IXzUOw75wDh1sxg9h2cbNXU326QiKtVhKyCVrMMJZl7GY/JXbG+5jlioSA9AAg/d7Vf4zkyV9CN7Ac/5uHhxfvKXj107Nm3Xup6JpHd2VAvC6Cqgd1dH+x92tzdVV8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hvQmoFjh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hvQmoFjh"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260806101153euoutp01a12c21bfa5b10de0c30ee9125c1a6b80~JL6UR0KFv1891618916euoutp01F
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 10:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260806101153euoutp01a12c21bfa5b10de0c30ee9125c1a6b80~JL6UR0KFv1891618916euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786011113;
	bh=IMZ8qkfhOLZiwmIb3BHX25zuCyq2Sc5EP83poQE1J/s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hvQmoFjhsU8p1u0MmlmWQL29zelrY+Be3zf5/NM0om2nSLLwwR8OCwjwyRhkzh+89
	 I3vMFQhnKJhD6HIP4oad6vEoWfBmu1Nz/d9n4e3A7pkAPAn110O65kmbZUBmOTYOw2
	 iQHtEA2bshV4VP0X4zV7Rhe85gM+nMNaHDF2ggf4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260806101152eucas1p213e701b4891db43e93acd1f9d3447abe~JL6T8R35N1126211262eucas1p2s;
	Thu,  6 Aug 2026 10:11:52 +0000 (GMT)
Received: from [106.120.50.46] (unknown [106.120.50.46]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260806101151eusmtip1bacb3c8e11470851538ac16bd48c8b84~JL6Sik-9k2357923579eusmtip1r;
	Thu,  6 Aug 2026 10:11:51 +0000 (GMT)
Message-ID: <ef2c73d6-99ee-47fb-a3bc-620201a9ee83@samsung.com>
Date: Thu, 6 Aug 2026 12:11:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 0/8] kdump: reduce vmcore size and capture time
To: Wandun Chen <chenwandun1@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh@kernel.org, saravanak@kernel.org,
	rppt@kernel.org, baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	pratyush@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org, iommu@lists.linux.dev
Cc: kernel@xen0n.name, alex@ghiti.fr, akpm@linux-foundation.org,
	ruirui.yang@linux.dev, robin.murphy@arm.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260806101152eucas1p213e701b4891db43e93acd1f9d3447abe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260806093541eucas1p169d6fcb31de09012bdfca326867e86d6
X-EPHeader: CA
X-CMS-RootMailID: 20260806093541eucas1p169d6fcb31de09012bdfca326867e86d6
References: <CGME20260806093541eucas1p169d6fcb31de09012bdfca326867e86d6@eucas1p1.samsung.com>
	<20260806093519.2907771-1-chenwandun1@gmail.com>

On 06.08.2026 11:35, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
>
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
>
> This series introduces a 'dumpable' flag on struct reserved_mem and a
> MEMBLOCK_NODUMP flag in memblock to filter vmcore ELF header on DT-based
> architectures (arm64, riscv, loongarch). Reserved regions default to
> non-dumpable and are marked MEMBLOCK_NODUMP so kdump omits them;
> reusable CMA regions are explicitly marked dumpable in rmem_cma_setup()
> because their pages are handed back to the buddy allocator and may carry
> crash-relevant data.
>
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce. ACPI systems already filter
> reserved memory out of the vmcore through their existing path; only
> DT-based systems currently fail to filter these regions, which is what
> this series addresses. The flag lives in memblock itself rather than
> in a DT-only structure, so the mechanism is generic and both ACPI and
> DT systems can benefit from it (suggested by Rob, thanks).
>
> The series is based on linux-next and is organized as follows:
>   Patches 1-2: Introduce MEMBLOCK_NODUMP in memblock and the dumpable
>                flag on struct reserved_mem.
>   Patches 3-4: Mark non-dumpable /reserved-memory and /memreserve/
>                entries with MEMBLOCK_NODUMP.
>   Patch 5:     Switch riscv to memblock so the NODUMP flag is visible
>                to the vmcore ELF header builder; add (KEXEC_FILE &&
>                CRASH_DUMP) to riscv's ARCH_KEEP_MEMBLOCK condition.
>   Patches 6-8: Fold the duplicated per-arch memblock walks into the
>                weak defaults in crash_core, switch to
>                for_each_mem_region(), and exclude MEMBLOCK_NODUMP
>                regions from the vmcore ELF header.
>
> v4 --> v5:
> 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
>    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
>    DT-only struct reserved_mem.
>
> 2. Switch the riscv vmcore elf header preparation to use memblock
>    instead of the resource tree, aligning it with arm64 and loongarch,
>    so riscv also can exclude reserved memory from vmcore.
>
> 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
>    loongarch open-coded the same logic, so fold it into shared
>     __weak defaults in crash_core.
>
> 4.  Drop the v4 patch that saved /memreserve/ entries into the
>     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
>     directly.

v5 looks much better, at least from the reserved memory regions perspective.


> v3 --> v4:
> 1. Rebase this series on v7.2-rc1.
> 2. Add two cleanup patches (patch 02/03).
> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
>    NULL multiple times, suggested by Rob.
>
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
>
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>    feedback [1], v2 drop that property and exclude reserve memory
>    by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
>
> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> [2] https://protect2.fireeye.com/v1/url?k=05b72ed7-643c3bed-05b6a598-74fe4860008a-295907342918bd15&q=1&e=c408484d-fdd8-4fe4-8eee-690e883afb73&u=https%3A%2F%2Fsashiko.dev%2F%23%2Fpatchset%2F20260520091844.592753-1-chenwandun%2540lixiang.com%3Fpart%3D4
>
> Wandun Chen (8):
>   memblock: introduce MEMBLOCK_NODUMP flag
>   of: reserved_mem: add dumpable flag to opt-in vmcore
>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
>   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
>   riscv: build crash_mem ranges from memblock instead of resource tree
>   crash_core: fold duplicated memblock arch hooks into the weak default
>   crash_core: replace for_each_mem_range() with for_each_mem_region()
>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
>     header
>
>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------------
>  arch/loongarch/kernel/machine_kexec_file.c | 27 -----------------
>  arch/riscv/Kconfig                         |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------------
>  drivers/of/fdt.c                           |  2 ++
>  drivers/of/of_private.h                    |  1 +
>  drivers/of/of_reserved_mem.c               | 35 ++++++++++++++++++++++
>  include/linux/memblock.h                   |  9 ++++++
>  include/linux/of_reserved_mem.h            |  1 +
>  kernel/crash_core.c                        | 34 +++++++++++++++++++--
>  kernel/dma/contiguous.c                    |  1 +
>  mm/memblock.c                              | 16 ++++++++++
>  12 files changed, 98 insertions(+), 92 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

