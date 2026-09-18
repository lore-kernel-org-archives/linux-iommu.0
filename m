Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF1330D2A
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716669; cv=none; b=eVOY/2cWrSvYwfos8R0XcDhUwnYxNnqSZaNQm/7LAkHVxbTbkHVedIB9mkXs6f1fFa9c+oX5VhuyTzWMhrtHfBW7D45ulExtDuUpNmmlIlk03BTl8Y9M5kvXXZE86Ris898hz5Fi9ZZEgy8nEsOiTgNmMDUpyfu4NxK7XiDPn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716669; c=relaxed/simple;
	bh=A0ZxUuBFvNPTWV1BVZ21PLOvGnhXlq1pS65I/1JMwuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfLuvdXA309bKkRC6aQf7lQ7Pu/OpyVaUElmYvkwnz5eiBpByddVelsuoR3QRBC4757Hy/srHu83IPpxN8cKY9E8spAMveAKyarUg7aBDE/7kRtgPLdJ46RmO3PXmlL99RRX8Bx9tl8bLC762aq/pgS3XVL4iQI3keqe3hj+9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OddnrBSp; arc=none smtp.client-ip=91.218.175.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OddnrBSp"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=A0ZxUuBFvNPTWV1BVZ21PLOvGnhXlq1pS65I/1JMwuc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789716665; v=1; x=1790321465;
 b=OddnrBSp5q03B7tRuHJLM3xcGpfDmIYvNDZbBElvCVQ5B6GjNA2XANEUoWnkmzSpEsPIAf1i
 EBKDFtsPo6yG84TuyO+z/4ncYu+iZ2bo1iANUF2aERqxsUnYWPX6Q5qLab4glXOcQfHsUQ6Ab5p
 0LOFxLyNzVnNweqt9X1HlbEQ=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 33707ef04d706312;
	Fri, 18 Sep 2026 07:31:05 +0000
X-Mizu-Trace-ID: 33707ef04d706312
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 15:31:00 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wandun <chenwandun1@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com,
	kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
Message-ID: <aqzotDs4yDRxgcWS@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <13cfcd99-e420-478b-8ce8-06674727977d@gmail.com>
 <aqziOmx1yhy0ozkX@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqziOmx1yhy0ozkX@kernel.org>

On 09/18/26 at 10:03am, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Sep 15, 2026 at 09:01:07PM +0800, Wandun wrote:
> > On 9/2/26 15:31, Wandun Chen wrote:
> > > From: Wandun Chen <chenwandun@lixiang.com>
...snip... 
> > > ACPI systems already filter reserved memory out of the vmcore through
> > > their existing path; only DT-based systems currently fail to filter these
> > > regions, which is what this series addresses. The flag lives in memblock
> > > itself rather than in a DT-only structure, so the mechanism is generic and
                                                                     ~~~~~~~
> > > both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> > > 
> > > Since the reserved memory regions are filtered out, the vmcore is
> > > smaller in size and faster to produce. 
> > > 
> > > The series is based on linux-next and is organized as follows:
> > > 
> > > Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
> > >              flagname, switch riscv crash_mem to memblock, fold the
> > >              duplicated per-arch memblock walks into the weak
> > >              defaults, and serialize crash header preparation against
> > >              memory hotplug.
> > > Patches 5-9: NODUMP infrastructure: switch crash_core to
> > >              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
> > >              flag, add a dumpable flag to struct reserved_mem, and
> > >              mark /reserved-memory and /memreserve/ entries with
> > > 	     MEMBLOCK_NODUMP flag.
> > > Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
> > >              header.
> > 
> > Hi,
> > 
> > Gentle ping on the remaining patches of this series.
> > Patches 1, 7, 8 and 9 have been reviewed (thanks Mike and Marek);
> > Still looking for review on patches 2-6 and 10.
> 
> I'm waiting for reviews from Baoquan and Dave for crash core patches before
> applying this series.

I will go through the crash core patches, thanks for reminding.

>  
> > Would appreciate a look when you have a moment, happy to rework
> > anything based on feedback.
> > 
> > Best regards,
> > Wanun
> > 
> > > 
> > > In v5, Sashiko found some pre-existing issues related to reserved-memory,
> > > and has no dependency on this series, so these issues have been addressed
> > > in a separate series [2].
> > > 
> > > v5 --> v6:
> > > 1. Serialize crash header preparation against memory hotplug to avoid
> > >    out-of-bounds or use-after-free issues.
> > > 
> > > 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
> > >    avoiding a panic from too few regions before resize is permitted.
> > > 
> > > 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> > > 
> > > 
> > > v4 --> v5:
> > > 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
> > >    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
> > >    DT-only struct reserved_mem.
> > > 2. Switch the riscv vmcore elf header preparation to use memblock
> > >    instead of the resource tree, aligning it with arm64 and loongarch,
> > >    so riscv also can exclude reserved memory from vmcore.
> > > 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
> > >    loongarch open-coded the same logic, so fold it into shared
> > >     __weak defaults in crash_core.
> > > 4.  Drop the v4 patch that saved /memreserve/ entries into the
> > >     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
> > >     directly.
> > > 
> > > v3 --> v4:
> > > 1. Rebase this series on v7.2-rc1.
> > > 2. Add two cleanup patches (patch 02/03).
> > > 3. Simplify patch 03 to avoid checking whether initial_boot_params is
> > >    NULL multiple times, suggested by Rob.
> > > 
> > > v2 --> v3:
> > > 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
> > > 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> > > 3. Add some prepare patches.
> > > 
> > > v1 --> v2:
> > > 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
> > >    feedback [3], v2 drop that property and exclude reserve memory
> > >    by default.
> > > 2. Split some prepared patches from the original patches.
> > > 3. Address coding-style comments on patch 5 from Rob.
> > > 
> > > [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
> > > [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
> > > [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> > > 
> > > Meijing Zhao (1):
> > >   mm: memblock: add missing HugeTLB flag name
> > > 
> > > Wandun Chen (9):
> > >   riscv: build crash_mem ranges from memblock instead of resource tree
> > >   crash_core: fold duplicated memblock arch hooks into the weak default
> > >   crash_core: serialize crash header preparation against hotplug
> > >   crash_core: replace for_each_mem_range() with for_each_mem_region()
> > >   memblock: introduce MEMBLOCK_NODUMP flag
> > >   of: reserved_mem: add dumpable flag to opt-in vmcore
> > >   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
> > >   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
> > >   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
> > >     header
> > > 
> > >  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
> > >  arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
> > >  arch/riscv/Kconfig                         |  2 +-
> > >  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
> > >  arch/x86/kernel/crash.c                    |  2 +-
> > >  drivers/of/fdt.c                           |  2 +
> > >  drivers/of/of_private.h                    |  2 +
> > >  drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
> > >  include/linux/crash_core.h                 |  2 +
> > >  include/linux/memblock.h                   |  9 ++++
> > >  include/linux/of_reserved_mem.h            |  1 +
> > >  kernel/crash_core.c                        | 51 ++++++++++++++++++++--
> > >  kernel/dma/contiguous.c                    |  1 +
> > >  mm/memblock.c                              | 17 ++++++++
> > >  14 files changed, 131 insertions(+), 95 deletions(-)
> > > 
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
