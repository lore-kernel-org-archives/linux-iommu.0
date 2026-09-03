Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD051421256
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420708; cv=none; b=U63jwtjyYtu0HQ094HkjL81kDRL0ioZdRsTvTV6pG+ZC5/XUy+xziWGNQ4AQ1VvGU264XqZvXjoM5fZ+Sc7NI1l330YIrICQTnFjqZTt2snnV0kOfXAktmkcTEsj6oeZ76GcoMVw/TQWPpWpXMDnRyqiWIhnHLN3AuOU8VszteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420708; c=relaxed/simple;
	bh=NC0fL+3z3CsRseYh+wLnv3kKCfUxQED7UU0UKSGeaAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW+aHR2XF8vMYX9WNtnUkL7Vpz1Tck0AmVWJ829imjJABk3Qr7W8REy1sc/OUOeAYiya/vt1aIb7CXIjuIxcZjcXAL5S0QSVogrmRJ4izcaoRr3DwHvuetNhr4Mjr3eungI1qY3qwuHU1exmIzzaiqs3WMI04867brxhhY0xvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXsH8Q+D; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXsH8Q+D"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=NC0fL+3z3CsRseYh+wLnv3kKCfUxQED7UU0UKSGeaAM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788420703; v=1; x=1789025503;
 b=LXsH8Q+D/8BO9v7k3BJJ+jwYjFjDbm7V8y0uYJTM0V60gH2X/r58rvYLdyr2f1Szs87nVh/k
 vIzrB0wBWiWtBxABGi5LJ9inda+bwS50QsqI0bOa7FSgpGCQsUzkNT4Zgf6dUuzSEmVk0E7yiLy
 ZMoMeFwqfpHjeHtDNZfD8GZ0=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 75b7dedc017cd645;
	Thu, 03 Sep 2026 07:31:43 +0000
X-Mizu-Trace-ID: 75b7dedc017cd645
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 15:31:39 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
	alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
Message-ID: <apkiW8gn9Z5XaVQh@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <apfkDlcMYrgiuGYA@fedora>
 <6aef2f48-1cc5-408d-a5a2-2b4b4d45ad7b@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aef2f48-1cc5-408d-a5a2-2b4b4d45ad7b@gmail.com>

On 09/03/26 at 03:05pm, Wandun wrote:
> 
> 
> On 9/2/26 16:53, Baoquan He wrote:
> > Hi Wandun,
> > 
> > On 09/02/26 at 03:31pm, Wandun Chen wrote:
> >> From: Wandun Chen <chenwandun@lixiang.com>
> >>
> >> On SoCs that carve out large firmware-owned reserved memory (GPU,
> >> camera ISP, ...), kdump currently dumps those carveouts as part of
> >> system RAM even though their contents are firmware state that is not
> >> useful for kernel crash analysis.
> >>
> >> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
> >> reserved memory on DT-based architectures (arm64, riscv, loongarch).
> >> Reserved regions default are marked MEMBLOCK_NODUMP so kdump omits them;
> >> reusable CMA regions are different because their pages are handed back
> >> to the buddy allocator and may carry crash-relevant data.
> >>
> >> ACPI systems already filter reserved memory out of the vmcore through
> >> their existing path; only DT-based systems currently fail to filter these
> >> regions, which is what this series addresses. The flag lives in memblock
> >> itself rather than in a DT-only structure, so the mechanism is generic and
> >> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> > 
> > Thanks for the effort. I am not against this patchset, and I haven't
> > went through it carefully. Just from the cover letter, you mentioned
> > generic, I am wondering if this can be generic for excluding other
> > memory regions. Asking this because I try to find a way to exclude
> > unwanted memory regions too, please check below link where there's
> > the relevant discussion. We definitely don't like inventing wheels
> > time after time. Do you think this memblock region excluding can
> > be used in other places of kernel?
> > 
> > https://lore.kernel.org/all/aoLFai0gzzH2bGgy@MiWiFi-R3L-srv/T/#u
> 
> 
> Thanks for taking a look, and for the pointer to the crash-wipe thread.
> 
> To answer your question directly: the exclusion mechanism in this series
> is already generic, memblock_mark_nodump() is the entry point. Any code
> that wants a region out of the vmcore just marks it MEMBLOCK_NODUMP, when
> preparing vmcore elf header by walking memblock, these regionss are skipped;
> This series is simply one caller, marking the DTS /reserved-memory and
> /memreserve/ regions with MEMBLOCK_NODUMP.

Thanks, for memory not allocated from memblock, e.g buddy, is it still
good?

> 
> x86 currently builds the vmcore elf header from iomem_resource, not
> memblock; it could be switched to memblock, but that would bring no
> benefit for the problem this series solves, so this series makes no
> x86 change. I'd personally be in favor of switching to memblock for
> a unified implementation across architectures.
> 
> Best regards
> Wandun
> 
> 
> > 
> >>
> >> Since the reserved memory regions are filtered out, the vmcore is
> >> smaller in size and faster to produce. 
> >>
> >> The series is based on linux-next and is organized as follows:
> >>
> >> Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
> >>              flagname, switch riscv crash_mem to memblock, fold the
> >>              duplicated per-arch memblock walks into the weak
> >>              defaults, and serialize crash header preparation against
> >>              memory hotplug.
> >> Patches 5-9: NODUMP infrastructure: switch crash_core to
> >>              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
> >>              flag, add a dumpable flag to struct reserved_mem, and
> >>              mark /reserved-memory and /memreserve/ entries with
> >> 	     MEMBLOCK_NODUMP flag.
> >> Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
> >>              header.
> >>
> >> In v5, Sashiko found some pre-existing issues related to reserved-memory,
> >> and has no dependency on this series, so these issues have been addressed
> >> in a separate series [2].
> >>
> >> v5 --> v6:
> >> 1. Serialize crash header preparation against memory hotplug to avoid
> >>    out-of-bounds or use-after-free issues.
> >>
> >> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
> >>    avoiding a panic from too few regions before resize is permitted.
> >>
> >> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> >>
> >>
> >> v4 --> v5:
> >> 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
> >>    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
> >>    DT-only struct reserved_mem.
> >> 2. Switch the riscv vmcore elf header preparation to use memblock
> >>    instead of the resource tree, aligning it with arm64 and loongarch,
> >>    so riscv also can exclude reserved memory from vmcore.
> >> 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
> >>    loongarch open-coded the same logic, so fold it into shared
> >>     __weak defaults in crash_core.
> >> 4.  Drop the v4 patch that saved /memreserve/ entries into the
> >>     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
> >>     directly.
> >>
> >> v3 --> v4:
> >> 1. Rebase this series on v7.2-rc1.
> >> 2. Add two cleanup patches (patch 02/03).
> >> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
> >>    NULL multiple times, suggested by Rob.
> >>
> >> v2 --> v3:
> >> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
> >> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> >> 3. Add some prepare patches.
> >>
> >> v1 --> v2:
> >> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
> >>    feedback [3], v2 drop that property and exclude reserve memory
> >>    by default.
> >> 2. Split some prepared patches from the original patches.
> >> 3. Address coding-style comments on patch 5 from Rob.
> >>
> >> [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
> >> [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
> >> [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> >>
> >> Meijing Zhao (1):
> >>   mm: memblock: add missing HugeTLB flag name
> >>
> >> Wandun Chen (9):
> >>   riscv: build crash_mem ranges from memblock instead of resource tree
> >>   crash_core: fold duplicated memblock arch hooks into the weak default
> >>   crash_core: serialize crash header preparation against hotplug
> >>   crash_core: replace for_each_mem_range() with for_each_mem_region()
> >>   memblock: introduce MEMBLOCK_NODUMP flag
> >>   of: reserved_mem: add dumpable flag to opt-in vmcore
> >>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
> >>   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
> >>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
> >>     header
> >>
> >>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
> >>  arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
> >>  arch/riscv/Kconfig                         |  2 +-
> >>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
> >>  arch/x86/kernel/crash.c                    |  2 +-
> >>  drivers/of/fdt.c                           |  2 +
> >>  drivers/of/of_private.h                    |  2 +
> >>  drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
> >>  include/linux/crash_core.h                 |  2 +
> >>  include/linux/memblock.h                   |  9 ++++
> >>  include/linux/of_reserved_mem.h            |  1 +
> >>  kernel/crash_core.c                        | 51 ++++++++++++++++++++--
> >>  kernel/dma/contiguous.c                    |  1 +
> >>  mm/memblock.c                              | 17 ++++++++
> >>  14 files changed, 131 insertions(+), 95 deletions(-)
> >>
> >> -- 
> >> 2.43.0
> >>
> 
