Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FA3B71B0
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477284; cv=none; b=uu0x/EHM3tztsXmilfFFvwLNDQNXO8S/vvknhPaWMy6Mp4HsXDT2nED9thp19Y+g2nmncdyiGk48QwtH57oKlDIV2JhTQJzCD5vnsMCJ+v4DwUfwEQOuj779Xci/YYQUNIKZz9cYbZirCK/AHklzMxSAjrJKUMleS64facdszD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477284; c=relaxed/simple;
	bh=ELVDuyLraG4tCEzT09pv2uLB8CM6aiSV+ZaKG06n9sY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LV+irRdyEP8N2AH1sJk4Ak5WIdecZwsveYvK2drmqTryyzgZmOnmDB+V+ha1E8UM5fhm81fGJzGqTi90XoJZ+sxCbTRWCE/E6LdBij334FKrltMbSUwv3vEdveElOJg3HRqdJTtpgcNQLHlJI69+3y6P8Vs2FHcwwQHHzCJERIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrBd/ghN; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrBd/ghN"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d8fcda61c8so20306155ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789477282; x=1790082082; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+F7E7Bq/M1FITHwdNffpUS733lAk0A+k2uxZSk0JCQc=;
        b=JrBd/ghNZyUQvhdgp0120qaZ4vDklUIIP5F0Ht9PoDUidwOwrH3D0J1+iagr0+eZFZ
         OpPu7pupAwLR1/LKlqmQe49UC35dP0XKklVzUfKiCz4733ai+wxStO06loQ+SeCxY3sH
         5sRl2TZLP8/5lLfbMiXO6dFpSuTkAK8Mgttnxun8t0Ol+oK+7HQvWEIGGZQJV95BvSbp
         jC0eXMvOOE5e5t6Qa37GSDriwD6ZtywDTIJCEs+Do0fruDHIhTYQlRkq8ytdQzLhe5Uw
         YEEzrcZkDKHbCsSDGBlvQSMFEe1bAdh5GoJBpW7RtRnnf3adqv7yFo8OER/b56OdUbOL
         24yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477282; x=1790082082;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+F7E7Bq/M1FITHwdNffpUS733lAk0A+k2uxZSk0JCQc=;
        b=Xz9zbwHIfrNVlv77vlg55rDZm6INkgHFxecuJt88vOqGbCzQj2LtekqaDGS/f10Tl6
         aPkBm3D3Sbz3vfaC9AcV/EWe98SvA+UhHM6cmOj8rhalbwMfBHdHDAOAbyqTLowLrO0l
         9YdsZg1MNJwfZafN7xq9t/l70pT8BgXT7YSQFFmrHkRTMhVdSPF1InVfZ2UL4Y6TqJli
         thh8nwrKTvNnlRrAyP+Cw7Zfkg8NbTUt9nnJb4z3tzATN9hvd70WbFq6z9Xvo0Nj2leH
         +Jiq8pBuEvvOLpBYDup5tA7ZcX2X0E6Jy/lEucFSugbBAv/FQzsHzwgQbbVczctyxFHy
         /reg==
X-Forwarded-Encrypted: i=1; AKwUvBw9ULAKdkhVEGC7Qz42oKvO4IU5GCCJe03fHC16FUWtl3CsG9/1uGlDFs/lZgGQCawI/yslBA==@lists.linux.dev
X-Gm-Message-State: AFuF++kmvp7t6bg3P9mI9s0X7S4kN0KBmXVKU4S4JWkBxDG/ut415uZB
	PZNCe9ZJcXVkAI68EbuePFeLMb98QJr/eOJdNRYxGMgxHfVF1WG+MZBE
X-Gm-Gg: AYBFou0ETQtLQru1UiqpWttHskBie//Z1UFUZOhZIlgZSqsgOLwuPuBcRfn0aYcghEg
	JJJQJ24V+5qhJFpIfyNV6roEimGoS7wAnEP8jDHupnVFjNeKxrjxBnrCFZUOybC8j/HYvzwQLle
	ZWjdU5YLJ9g3dokL4wmCBj/smjwQYOxwvfbWJ3/TVKcjie9KZQeDksFTKqVefmBHVsiwYY9GtlK
	6169GCGvrkrWmKntJxdPANwI/zj5xdecf6TJUKW88jXuupfN3UxNRl7oqMnWiKBk+Vy+xuFpaq9
	VTP6Li50VKb7/ObGdJBe7tIt4kpYqQ/fvU6hm+eQCXMitYeoGC1McR8gDps0dQ8R6mEAHmsIdEa
	xrifm9fcyqrgjnk4sCeEUncvNHqD/+G3TuvovgbhOuyUIx122IkM68LQl4hx2U8lx59RsLcAM0y
	r7kJQszL7OJeWtSyUudkM3xGAZVl4FstOA+VVTG167zUVaCdkfp++RfWBkNV31YxV3/+0+3qJAl
	RdfzQ==
X-Received: by 2002:a17:903:3d0d:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2dd6c6eb7a4mr138425825ad.13.1789477281468;
        Tue, 15 Sep 2026 06:01:21 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd87e5sm67187695ad.58.2026.09.15.06.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 06:01:20 -0700 (PDT)
Message-ID: <13cfcd99-e420-478b-8ce8-06674727977d@gmail.com>
Date: Tue, 15 Sep 2026 21:01:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, m.szyprowski@samsung.com
Cc: mark.rutland@arm.com, kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
 ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 15:31, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
> 
> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
> reserved memory on DT-based architectures (arm64, riscv, loongarch).
> Reserved regions default are marked MEMBLOCK_NODUMP so kdump omits them;
> reusable CMA regions are different because their pages are handed back
> to the buddy allocator and may carry crash-relevant data.
> 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path; only DT-based systems currently fail to filter these
> regions, which is what this series addresses. The flag lives in memblock
> itself rather than in a DT-only structure, so the mechanism is generic and
> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> 
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce. 
> 
> The series is based on linux-next and is organized as follows:
> 
> Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
>              flagname, switch riscv crash_mem to memblock, fold the
>              duplicated per-arch memblock walks into the weak
>              defaults, and serialize crash header preparation against
>              memory hotplug.
> Patches 5-9: NODUMP infrastructure: switch crash_core to
>              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
>              flag, add a dumpable flag to struct reserved_mem, and
>              mark /reserved-memory and /memreserve/ entries with
> 	     MEMBLOCK_NODUMP flag.
> Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
>              header.

Hi,

Gentle ping on the remaining patches of this series.
Patches 1, 7, 8 and 9 have been reviewed (thanks Mike and Marek);
Still looking for review on patches 2-6 and 10.

Would appreciate a look when you have a moment, happy to rework
anything based on feedback.

Best regards,
Wanun

> 
> In v5, Sashiko found some pre-existing issues related to reserved-memory,
> and has no dependency on this series, so these issues have been addressed
> in a separate series [2].
> 
> v5 --> v6:
> 1. Serialize crash header preparation against memory hotplug to avoid
>    out-of-bounds or use-after-free issues.
> 
> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
>    avoiding a panic from too few regions before resize is permitted.
> 
> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> 
> 
> v4 --> v5:
> 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
>    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
>    DT-only struct reserved_mem.
> 2. Switch the riscv vmcore elf header preparation to use memblock
>    instead of the resource tree, aligning it with arm64 and loongarch,
>    so riscv also can exclude reserved memory from vmcore.
> 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
>    loongarch open-coded the same logic, so fold it into shared
>     __weak defaults in crash_core.
> 4.  Drop the v4 patch that saved /memreserve/ entries into the
>     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
>     directly.
> 
> v3 --> v4:
> 1. Rebase this series on v7.2-rc1.
> 2. Add two cleanup patches (patch 02/03).
> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
>    NULL multiple times, suggested by Rob.
> 
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
> 
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>    feedback [3], v2 drop that property and exclude reserve memory
>    by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
> 
> [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
> [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
> [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> 
> Meijing Zhao (1):
>   mm: memblock: add missing HugeTLB flag name
> 
> Wandun Chen (9):
>   riscv: build crash_mem ranges from memblock instead of resource tree
>   crash_core: fold duplicated memblock arch hooks into the weak default
>   crash_core: serialize crash header preparation against hotplug
>   crash_core: replace for_each_mem_range() with for_each_mem_region()
>   memblock: introduce MEMBLOCK_NODUMP flag
>   of: reserved_mem: add dumpable flag to opt-in vmcore
>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
>   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
>     header
> 
>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
>  arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
>  arch/riscv/Kconfig                         |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
>  arch/x86/kernel/crash.c                    |  2 +-
>  drivers/of/fdt.c                           |  2 +
>  drivers/of/of_private.h                    |  2 +
>  drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
>  include/linux/crash_core.h                 |  2 +
>  include/linux/memblock.h                   |  9 ++++
>  include/linux/of_reserved_mem.h            |  1 +
>  kernel/crash_core.c                        | 51 ++++++++++++++++++++--
>  kernel/dma/contiguous.c                    |  1 +
>  mm/memblock.c                              | 17 ++++++++
>  14 files changed, 131 insertions(+), 95 deletions(-)
> 

