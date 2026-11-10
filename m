Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300469;
	b=1qnBiYYJ0z1jfea9FVW5NX3Vk++gDiPXVS/qsDZjxzc2nMtoT85k56HY9XcZd4kI8wqf
	 0GqLzi+4Xv4vqlWt0cmp7fUayksTuhivfjUkvssjc/sJpOPtWpLdqyoRy03PUYNqq2IwV
	 GWQt9clgKDLM7gPdYU2AOiVVM6yeKtucrvhGdgrcqP9JhSMfvKR+6lV76iIDTenBNhd2D
	 l1PLq5Glo3weCubGh2IWoqRp7nPsVpsf+z+4bT10p+D/lzfgO/RTAp1N222sc1uCFDRpZ
	 yLKGxWXfDEFgRLwfj4yeOTClu1/a0rNhFOYgBtdUhOq62Npxsi/FBSvDcqbUCmYfrjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=971CVAco0wRsepZ2O+DuyJQLTFxXmiUWfADT6vKykDg=;
	b=yvyKiKBXRUzNRDMDeDt9fmpltlsDLAGp2QdJ2OCdEOacSqCZMFTFAuowVKs6Sn06WiG8
	 KJRHyb4eUDSKBRobxqxO/gCvXF5nADJPvszO/gYEra5ePs10ux+7+neQT4PeFyXPi7wU+
	 SK6cnsJIo+XTthrbBZru2yNV2BiMVu2CD1g9aTBGFQJAqrfvFYGlWVI8wvBxopPXPxUyz
	 RvQxcE9NxgQSz8SZIlWj8znsVbkZOJcTTudF3oUExg5FGV4FT6u7R4y14w3xYI3e+L6sL
	 qFxO/xbuD2/luoc9r/a4X7C0w3cyjlswjgjPjlj0F0PYp0cfrlnWEigR36BS5mENTtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2rOEA41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D9606A321;
	Tue, 10 Nov 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2rOEA41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B911F008A1;
	Tue, 10 Nov 2026 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300468;
	bh=971CVAco0wRsepZ2O+DuyJQLTFxXmiUWfADT6vKykDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2rOEA417uw2D2zqDfgokpjiUXSld29mrsEuVXHxP9GLTFMBlE9QpzHB6cYJTRj/s
	 bNb9RuSh51wCZosf6cEmHsHb6r69dXLTOsubsj2wByaWqCyXZUHjmBKEw6LaYFbXfo
	 tOTCOlCqR3rDCMMlaykpekQZGQflPc8CBcScbJuftXTOg43KZQzuE6dJ9pYq2BHlsc
	 E13UUPMqzYhMiYC3vMc84UcC6JglBm/DDXTSCvJyPCXIVwgjYBXJuZB+eFqVYzkZk4
	 BmfdxZ6u5kOCqxW439hUAZML7ys1hMaZACoMClSmusSg0Z35PJoD2xdz7m/LBLHBsf
	 L5ZzCcDj9+wBw==
Date: Tue, 10 Nov 2026 10:47:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wandun <chenwandun1@gmail.com>
Cc: robh@kernel.org, baoquan.he@linux.dev, m.szyprowski@samsung.com,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	saravanak@kernel.org, akpm@linux-foundation.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v9 0/8] kdump: reduce vmcore size and capture time
Message-ID: <avLaJxIrrnMQngO9@kernel.org>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <7773d026-4aef-4169-866a-71ec9a91da21@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7773d026-4aef-4169-866a-71ec9a91da21@gmail.com>

Hi Wandun,

On Mon, Nov 09, 2026 at 08:23:16PM +0800, Wandun wrote:
> 
> On 10/21/26 16:30, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> > 
> > On SoCs that carve out large firmware-owned reserved memory (GPU,
> > camera ISP, ...), kdump currently dumps those carveouts as part of
> > system RAM even though their contents are firmware state that is not
> > useful for kernel crash analysis.
> > 
> > ACPI systems already filter reserved memory out of the vmcore through
> > their existing path: firmware reports those carveouts as unusable in
> > the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
> > (is_usable_memory(), efi-init.c), and the ELF header builder has
> > always skipped nomap regions; only DT-based systems currently fail
> > to filter these regions, which is what this series addresses.
> > 
> > This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
> > memblock to filter reserved memory on DT-based architectures. A new
> > flag is needed because MEMBLOCK_NOMAP can only express regions without
> > a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
> > linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
> > so kdump omits them; reusable CMA regions are different because their
> > pages are handed back to the buddy allocator and may carry crash-relevant
> > data.
> > 
> > Since the reserved memory regions are filtered out, the vmcore is
> > smaller in size and faster to produce.
> > 
> > The series is based on linux-next and is organized as follows:
> > 
> > Patches 1-3: Preparation and bugfixes: switch riscv crash_mem to
> >              memblock, fold the duplicated per-arch memblock walks
> >              into the weak defaults, and serialize crash header
> >              preparation against memory hotplug.
> > Patches 4-7: NODUMP infrastructure: switch crash_core to
> >              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
> >              flag, add a dumpable flag to struct reserved_mem, and
> >              mark /reserved-memory entries with MEMBLOCK_NODUMP.
> > Patch 8:     Skip MEMBLOCK_NODUMP regions when building the vmcore
> >              ELF header.
> 
> Hi all,
> 
> A gentle ping on this series.
> 
> I'd appreciate any further feedback, particularly on the
> MEMBLOCK_NODUMP discussion and the issues raised in the Sashiko
> review.

I'm fine with MEMBLOCK_NODUMP.
The issue Sashiko raised about bound check against cmem->max_nr_ranges
seems valid. 

I didn't check the reserved mem one.
 
> Please let me know if there are any other concerns or suggestions
> before I prepare the next revision.

I believe that should be rebased to account for reserved memory changes.
The riscv change from resources to memblock needs an Ack from riscv
maintainers.

And with all that I can take the next version via kexec tree.
 
> Thanks,
> Wandun
> 
> > 
> > v8 --> v9:
> > 1. Patch 7: Avoid a potential boot panic on SH when NODUMP marking requires
> >    memblock resizing before it is allowed, found by Sashiko in [1]. SH supports
> >    neither CONFIG_KEXEC_FILE nor CONFIG_CRASH_HOTPLUG, so skip marking when
> >    both are disabled.
> > 
> > v6 --> v8 (v7 mainly tried to fix the initrd issue on release in v6,
> > that approach is superseded here):
> > 1. Stop marking /memreserve/ regions with NODUMP. v6 marked
> >    /memreserve/ regions with NODUMP. But a bootloader may specify
> >    a /memreserve/ entry for memory that the kernel later frees
> >    (e.g. the initrd), and those pages would then be wrongly
> >    filtered out of the vmcore after being reused as normal memory.
> >    The v7 fix (clearing the flag in free_reserved_area()) caused
> >    a lockless runtime mutation of memblock.memory [2]. Better solutions
> >    exist but need extra preparation, so temporarily dropped the patch
> >    that introduced the problem to keep this series simple in v8.
> > 2. Fix a build failure in patch 2 with both ARCH_KEEP_MEMBLOCK and
> >    MEMORY_HOTPLUG are unset. There the memblock arrays live in
> >    .init.data, and the weak defaults referencing them create section
> >    mismatches, which turn into build errors when SECTION_MISMATCH_WARN_ONLY
> >    is also unset.
> > 3. RISCV recently gained crash hotplug support, so adapt its handler
> >    like x86 in patch 3: use __crash_prepare_headers() instead of
> >    crash_prepare_headers() to avoid self-deadlock.
> > 4. Update the cover letter per review feedback: describe how ACPI
> >    systems filter reserved memory and why a new flag is needed
> >    instead of reusing NOMAP.
> > 
> > v6 --> v7:
> > 1. Fix a stale MEMBLOCK_NODUMP flag issue [3]. Memory reserved and
> >    marked as NODUMP may later be freed (the initrd, for example),
> >    so the NODUMP flag must be cleared accordingly. Since the fix is
> >    part of the NODUMP infrastructure introduced by patch 5, it has
> >    been folded into that patch.
> > 2. Drop the "generic" related description in the cover letter.
> > 3. Collect the Acked-by and Reviewed-by tags received during the v6
> >    review (thanks to Baoquan, Mike, Rob and Marek). Patch 5 is the
> >    only one without a tag, as its Reviewed-by was dropped when the
> >    fix was folded in.
> > 4. Drop patch 1 of v6, which has been merged separately.
> > 
> > 
> > v5 --> v6:
> > 1. Serialize crash header preparation against memory hotplug to avoid
> >    out-of-bounds or use-after-free issues.
> > 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
> >    avoiding a panic from too few regions before resize is permitted.
> > 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> > 
> > [1] https://sashiko.dev/#/patchset/20261016061549.4181390-1-chenwandun1@gmail.com?part=7
> > [2] https://lore.kernel.org/lkml/20260922090252.B01541F000FF@smtp.kernel.org/
> > [3] https://sashiko.dev/#/message/20260917220750.GA4013814-robh%40kernel.org
> > 
> > v5: https://lore.kernel.org/lkml/20260806093519.2907771-1-chenwandun1@gmail.com/
> > v4: https://lore.kernel.org/lkml/20260630074715.4126796-1-chenwandun1@gmail.com/
> > 
> > Wandun Chen (8):
> >   riscv: build crash_mem ranges from memblock instead of resource tree
> >   crash_core: fold duplicated memblock arch hooks into the weak default
> >   crash_core: serialize crash header preparation against hotplug
> >   crash_core: replace for_each_mem_range() with for_each_mem_region()
> >   memblock: introduce MEMBLOCK_NODUMP flag
> >   of: reserved_mem: add dumpable flag to opt-in vmcore
> >   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
> >   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
> >     header
> > 
> >  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
> >  arch/loongarch/kernel/machine_kexec_file.c | 27 -----------
> >  arch/riscv/Kconfig                         |  2 +-
> >  arch/riscv/kernel/crash.c                  |  2 +-
> >  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
> >  arch/x86/kernel/crash.c                    |  2 +-
> >  drivers/of/fdt.c                           |  1 +
> >  drivers/of/of_private.h                    |  1 +
> >  drivers/of/of_reserved_mem.c               | 18 ++++++++
> >  include/linux/crash_core.h                 |  2 +
> >  include/linux/memblock.h                   |  9 ++++
> >  include/linux/of_reserved_mem.h            |  1 +
> >  kernel/crash_core.c                        | 53 +++++++++++++++++++++-
> >  kernel/dma/contiguous.c                    |  1 +
> >  mm/memblock.c                              | 16 +++++++
> >  15 files changed, 103 insertions(+), 94 deletions(-)
> > 
> 

-- 
Sincerely yours,
Mike.
