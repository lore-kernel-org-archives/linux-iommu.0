Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DCF47798F
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520155; cv=none; b=qzAnedTWC6FB26ODIu2puQ2NqS0ufZZFlk0yx7YW8QtshS79M5bUljq7Xstrx9G2DFRBooGxTD0A/tmXahJBSlbgEtPEfB9yk42LAUTd0Q5GKlJr8MM/eFZvGFaX/Zx28SUzGHw4nfZjV1P5GmjfWCBdSdamL3OxdhCSmqm5tZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520155; c=relaxed/simple;
	bh=mF6WGnPxF9eEaT9L88PSu+8GibEvUMCU40aT6xUNpU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taOS/37XPlxEz1A5uvIzM8y7VMCig9/0ZmMA8cJfhMxpuZYWIcFTP9ctDkx3EcjLEHv9kcfabUGFlSdIpllqSYCtIdOEU46a2nIyfFHKyfUs8LtvjBH1x/4Vp6w+AyI7zyM90FCbYNMrVn3s2ippqEOUTyhIRodJ1cjATVu/ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnaZYSd5; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnaZYSd5"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccbff2e6a7so4332195ad.1
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520152; x=1789124952; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JgjLk2Wj4ezNGWQB3j7DpVIqIrI833hmatUkGCCEbj4=;
        b=LnaZYSd597mQy6pnnQ2r8dCjqi7K/V0zqknQ6z8H5Lp+9Ieyb3H/RT0m/mu7kD7AFi
         /WYDCE044LRKvwG88ewaxiEGlMZeSYGL1AtPB7yqcp3hjxQyv+lUGROP82QH3Uw0/z/l
         JOHwlnaosnRLgARLPzdG6IktsD5n8bxFY8RQH1Pv9UmCsIVYj89zRO8isoq5I80z1G/V
         vDfjdzJTIpFcb/dG14XJ3HLPTWrZjnAI+W5XxkGjEGg80K4n6poroiybdW/akhwfVazT
         U/CfkrqbsvXjbbNxG17JoUl7b7PAWamBLEaTSw+ePSAYgu2YwlJ5+fUOUbXIadcmnMre
         dJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520152; x=1789124952;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgjLk2Wj4ezNGWQB3j7DpVIqIrI833hmatUkGCCEbj4=;
        b=URkyaxEl8JCZtQKWWymYlaZRLE6Rq0hgZ3vjW7EW/SMDq4YOW/ka/QGetWDpRPVfNK
         +/xHoP4JpGfHVdvjY2kcOpHkhvhtJtfA+kFCzZMsL7bcyiXKySCj3adSMTlt/WRJVgWt
         pJtAF/TcZVgKZD4R/Tjg3zT5LYD8+ddHG7BS+fAhH3NFwD9kzPJGTE0TikHQsaed1FYC
         2Noj2+kovOPRsoneBxQ2HLMGtdoEhIqa8RVFevh+Z6CwLyOAHmmAC2uDuSsvoq5Ou9Kf
         bZfPCUnzQeSmybPPTsZ/6PRzDIadtQfBT7qN4MLL7HYK40P3f9YLl5ra4AG7X/tWrvyG
         ccvg==
X-Forwarded-Encrypted: i=1; AKwUvBx5iFcaFhCqILDReWqhrtTAALXaLF14U/tp5arxmZQZWfZOGawp/pgDTM5TKizx6A8tH0LpEQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nXpwW/hkdawbNFEBy/j38iUAfbOhueANMptCqk/1jZdfbIadXM
	1jdp5jTSlcVx46tDbp/S8gKEqFUL9yLF1o/q3Veg0+N2kj6n3iXbZ/+Y
X-Gm-Gg: AYBFou0bb8wAjfBlBWWau7G18x7Py0uCwYNPuzRqra+bH5mmdWv/oPcbSiDrR6Ond1m
	POt0+ztPgUxvrfHqlmZnj5DLSEzAqSG2KkXvHoDdesCiixx4HbC/s5uCka/eV28yOk3qsN/VYWI
	7C/248YLc3y74kNzqa5p1NkKyxV1QNHN4TocIcGANhz1SQ8SIwMvsBDA6OBoQKp68pAAvIvLu8z
	0lrG+8zIzPxPx9M1ecZOLRleVCmOzZNKU1xuYPpyW1fM/tr8W0uK77JAUqkjWciVM9MV5kr43R/
	1pgwLeaTNqu/rEriLhpKH4UOpEHPKWtyVpGejIB44kmr+JChhFkhbhVs81g6T4dP/xjfFklkQuB
	hp8W3Na/USH0RM/82P0Y2W5GtMmZNNnRiWMHJTH53B8ssaJUdBvP2lrci/qs4eZ4w7Z89DbSGq0
	sKbDrITbElhEAblQm8STFLmfVSXCtmZZn5F7TC+odShIFwx2TUk9oHIUZIQ7xUeC8i0RXiGF6WZ
	Wb57cgwxM+ujikXyA==
X-Received: by 2002:a17:902:fb48:b0:2d7:203b:9863 with SMTP id d9443c01a7336-2db1232c6a9mr51752645ad.1.1788520152439;
        Fri, 04 Sep 2026 04:09:12 -0700 (PDT)
Received: from [10.240.227.78] ([114.111.24.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db148404d1sm8326655ad.6.2026.09.04.04.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 04:09:11 -0700 (PDT)
Message-ID: <a859f6dd-cc65-4bce-b4a0-0b757248f6d2@gmail.com>
Date: Fri, 4 Sep 2026 19:08:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
To: Baoquan He <baoquan.he@linux.dev>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
 alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <apfkDlcMYrgiuGYA@fedora> <6aef2f48-1cc5-408d-a5a2-2b4b4d45ad7b@gmail.com>
 <apkiW8gn9Z5XaVQh@fedora> <edd83cd6-663f-43f5-8058-99e59d941d5b@gmail.com>
 <aplAA9-NX3pw9Wmb@fedora>
From: Chen Wandun <chenwandun1@gmail.com>
In-Reply-To: <aplAA9-NX3pw9Wmb@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 5:38 PM, Baoquan He wrote:
> On 09/03/26 at 03:43pm, Wandun wrote:
>>
>>
>> On 9/3/26 15:31, Baoquan He wrote:
>>> On 09/03/26 at 03:05pm, Wandun wrote:
>>>>
>>>>
>>>> On 9/2/26 16:53, Baoquan He wrote:
>>>>> Hi Wandun,
>>>>>
>>>>> On 09/02/26 at 03:31pm, Wandun Chen wrote:
>>>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>>>
>>>>>> On SoCs that carve out large firmware-owned reserved memory (GPU,
>>>>>> camera ISP, ...), kdump currently dumps those carveouts as part of
>>>>>> system RAM even though their contents are firmware state that is not
>>>>>> useful for kernel crash analysis.
>>>>>>
>>>>>> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
>>>>>> reserved memory on DT-based architectures (arm64, riscv, loongarch).
>>>>>> Reserved regions default are marked MEMBLOCK_NODUMP so kdump omits them;
>>>>>> reusable CMA regions are different because their pages are handed back
>>>>>> to the buddy allocator and may carry crash-relevant data.
>>>>>>
>>>>>> ACPI systems already filter reserved memory out of the vmcore through
>>>>>> their existing path; only DT-based systems currently fail to filter these
>>>>>> regions, which is what this series addresses. The flag lives in memblock
>>>>>> itself rather than in a DT-only structure, so the mechanism is generic and
>>>>>> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
>>>>>
>>>>> Thanks for the effort. I am not against this patchset, and I haven't
>>>>> went through it carefully. Just from the cover letter, you mentioned
>>>>> generic, I am wondering if this can be generic for excluding other
>>>>> memory regions. Asking this because I try to find a way to exclude
>>>>> unwanted memory regions too, please check below link where there's
>>>>> the relevant discussion. We definitely don't like inventing wheels
>>>>> time after time. Do you think this memblock region excluding can
>>>>> be used in other places of kernel?
>>>>>
>>>>> https://lore.kernel.org/all/aoLFai0gzzH2bGgy@MiWiFi-R3L-srv/T/#u
>>>>
>>>>
>>>> Thanks for taking a look, and for the pointer to the crash-wipe thread.
>>>>
>>>> To answer your question directly: the exclusion mechanism in this series
>>>> is already generic, memblock_mark_nodump() is the entry point. Any code
>>>> that wants a region out of the vmcore just marks it MEMBLOCK_NODUMP, when
>>>> preparing vmcore elf header by walking memblock, these regionss are skipped;
>>>> This series is simply one caller, marking the DTS /reserved-memory and
>>>> /memreserve/ regions with MEMBLOCK_NODUMP.
>>>
>>> Thanks, for memory not allocated from memblock, e.g buddy, is it still
>>> good?
>>
>> Yes, still good, only need to pass the physical range to memblock_mark_nodump().
> 
> That's interesting. If drivers or any component allocate memory from
> buddy, then you will call memblock_mark_nodump() to mark the region
> specifically (memblock_setclr_flag will split regions if it's a sub
> region of existing memblock region), it won't impact anything?

IIUC, it won't impact anyting; memblock_mark_nodump() only set
the MEMBLOCK_NODUMP bit on the matching memblock.memory regions,
and from the buddy allocator's view, there is nothing changed.

The only effect is the region split you already pointed out: marking
a sub-range costs up to two extra entries in the memblock.memory
region array.


Best regards,
Wandun


> 
>>
>>>
>>>>
>>>> x86 currently builds the vmcore elf header from iomem_resource, not
>>>> memblock; it could be switched to memblock, but that would bring no
>>>> benefit for the problem this series solves, so this series makes no
>>>> x86 change. I'd personally be in favor of switching to memblock for
>>>> a unified implementation across architectures.
>>>>
>>>> Best regards
>>>> Wandun
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Since the reserved memory regions are filtered out, the vmcore is
>>>>>> smaller in size and faster to produce.
>>>>>>
>>>>>> The series is based on linux-next and is organized as follows:
>>>>>>
>>>>>> Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
>>>>>>               flagname, switch riscv crash_mem to memblock, fold the
>>>>>>               duplicated per-arch memblock walks into the weak
>>>>>>               defaults, and serialize crash header preparation against
>>>>>>               memory hotplug.
>>>>>> Patches 5-9: NODUMP infrastructure: switch crash_core to
>>>>>>               for_each_mem_region(), introduce the MEMBLOCK_NODUMP
>>>>>>               flag, add a dumpable flag to struct reserved_mem, and
>>>>>>               mark /reserved-memory and /memreserve/ entries with
>>>>>> 	     MEMBLOCK_NODUMP flag.
>>>>>> Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
>>>>>>               header.
>>>>>>
>>>>>> In v5, Sashiko found some pre-existing issues related to reserved-memory,
>>>>>> and has no dependency on this series, so these issues have been addressed
>>>>>> in a separate series [2].
>>>>>>
>>>>>> v5 --> v6:
>>>>>> 1. Serialize crash header preparation against memory hotplug to avoid
>>>>>>     out-of-bounds or use-after-free issues.
>>>>>>
>>>>>> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
>>>>>>     avoiding a panic from too few regions before resize is permitted.
>>>>>>
>>>>>> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
>>>>>>
>>>>>>
>>>>>> v4 --> v5:
>>>>>> 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
>>>>>>     (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
>>>>>>     DT-only struct reserved_mem.
>>>>>> 2. Switch the riscv vmcore elf header preparation to use memblock
>>>>>>     instead of the resource tree, aligning it with arm64 and loongarch,
>>>>>>     so riscv also can exclude reserved memory from vmcore.
>>>>>> 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
>>>>>>     loongarch open-coded the same logic, so fold it into shared
>>>>>>      __weak defaults in crash_core.
>>>>>> 4.  Drop the v4 patch that saved /memreserve/ entries into the
>>>>>>      reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
>>>>>>      directly.
>>>>>>
>>>>>> v3 --> v4:
>>>>>> 1. Rebase this series on v7.2-rc1.
>>>>>> 2. Add two cleanup patches (patch 02/03).
>>>>>> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
>>>>>>     NULL multiple times, suggested by Rob.
>>>>>>
>>>>>> v2 --> v3:
>>>>>> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
>>>>>> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
>>>>>> 3. Add some prepare patches.
>>>>>>
>>>>>> v1 --> v2:
>>>>>> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>>>>>>     feedback [3], v2 drop that property and exclude reserve memory
>>>>>>     by default.
>>>>>> 2. Split some prepared patches from the original patches.
>>>>>> 3. Address coding-style comments on patch 5 from Rob.
>>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
>>>>>> [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
>>>>>> [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
>>>>>>
>>>>>> Meijing Zhao (1):
>>>>>>    mm: memblock: add missing HugeTLB flag name
>>>>>>
>>>>>> Wandun Chen (9):
>>>>>>    riscv: build crash_mem ranges from memblock instead of resource tree
>>>>>>    crash_core: fold duplicated memblock arch hooks into the weak default
>>>>>>    crash_core: serialize crash header preparation against hotplug
>>>>>>    crash_core: replace for_each_mem_range() with for_each_mem_region()
>>>>>>    memblock: introduce MEMBLOCK_NODUMP flag
>>>>>>    of: reserved_mem: add dumpable flag to opt-in vmcore
>>>>>>    of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
>>>>>>    of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
>>>>>>    crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
>>>>>>      header
>>>>>>
>>>>>>   arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
>>>>>>   arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
>>>>>>   arch/riscv/Kconfig                         |  2 +-
>>>>>>   arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
>>>>>>   arch/x86/kernel/crash.c                    |  2 +-
>>>>>>   drivers/of/fdt.c                           |  2 +
>>>>>>   drivers/of/of_private.h                    |  2 +
>>>>>>   drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
>>>>>>   include/linux/crash_core.h                 |  2 +
>>>>>>   include/linux/memblock.h                   |  9 ++++
>>>>>>   include/linux/of_reserved_mem.h            |  1 +
>>>>>>   kernel/crash_core.c                        | 51 ++++++++++++++++++++--
>>>>>>   kernel/dma/contiguous.c                    |  1 +
>>>>>>   mm/memblock.c                              | 17 ++++++++
>>>>>>   14 files changed, 131 insertions(+), 95 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>
>>

