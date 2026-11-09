Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227014;
	b=N7YA1Lsqeit0a8Fazc5F0Iq12oq2FmwhShSvqYWWNFrp4Z/drzmz9XnNWGYxXCPadbkw
	 vrmk1ag2yVuOzWINHP54ztiu7tqe0uS0ieueu0oaGMgwGrQu0KQj0HxpaagdUd19flo/P
	 ZzN5Krx7rZATgTF7Gg/rault0VTPMg+Fix+9R/XIDEhiKfJmT3EJqjiiB1MqQpsxzTAHI
	 O0w0guFG2ng7z7NB7cxSkckb7XD3ii4crKbh5KX6pfaDXFQg87yBTcmnwjMNRZHRHMlXQ
	 F6YJgL03bv8OFbRNXan7Q94GvulVvKstYid+SIhc1IvbX4NVlvd6gyp2xh0f4AzGyPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+tF8l8wiFwVnoygmXpYnREIWubWMOLu/o49/XwgRJmA=;
	b=P8jqfKgGHUTTuP4Dp9KVvIB07PvfeJqBrVVgPd66HLpO+txg6Z8fvTm/H30R8eF4R4II
	 dWbC8F/mMQ8U6eGOQqLYrt7lgesxQNNjwP+QAhPjGeQtFlDBruFRXYxV6dTyjpKVqg4AU
	 m4I47HqvXECIhpetzZ0FeOICgS8mAJ9bPFBOoas+vpSfq9/PxxfzPmMeTflmti+CJWTVo
	 Nw4wrqTGCY/cSMardm5F60gZ5tT3MZou4bot9pzOAL7+qfskn/uemQFYO7WngYIXEuyVj
	 pm6eQxbb+/qDxdbIiyXmv0oGjaNnJ/TGtyjctd1suFbR7GUkzWvv8onGhTfvXvAbyiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bDTLuzuR;
	arc=none smtp.remote-ip=74.125.227.203
Received: from mail-pi2-f11.google.com (mail-pi2-f11.google.com [74.125.227.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3633606D81F
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 12:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3633606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bDTLuzuR
Received: by mail-pi2-f11.google.com with SMTP id 41be03b00d2f7-cdb56646435so122345a12.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227013; x=1794831813; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+tF8l8wiFwVnoygmXpYnREIWubWMOLu/o49/XwgRJmA=;
        b=bDTLuzuRhnF13cZK5Naxg6nD1/T6X0Tz3msgLgrO0QsK/HAjIuVtVNLNV497yN+r/S
         7CInX+ja7a1l1MF/jGwKFLIWf9gVN3GWu69GEZlLvA5mLle/gUfpkhI2xEzh14CXtO1e
         /ACvM5get8OI1s23bxCV+1CB77NQsJ/b2pxvsQ410pQGXUaiEOZVXFOkaneVOQMd7JkF
         aYE5QmPFkEuBF20hGnVTHKS0dWHUoSrkLLnb2dmOJiWElJa2bTlVEn2p2cjc2FW6tyJx
         LVpSKGViUz1aaVrpj/owpp+RoeTnk7UI9owkk3UkTC+7O3DFO8rllC0cTa5wY/sNWjXO
         /6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227013; x=1794831813;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tF8l8wiFwVnoygmXpYnREIWubWMOLu/o49/XwgRJmA=;
        b=lAmpk0FadmTa8+0ZOCk3JXKaW5rhbVqNZSD7Y6Cr2bT2PaYR2gjjz49sY+oWDaaSRa
         f/zXu0IulIB4vcaOqXQN4R+HXfMMSuEIScG5eFtGE3nHNAL7Cs0wbHbNyw1CQssMTgvy
         GuGQ2Omzk+Typ95so0CYIIq3/MMVIaWT3HQXPvQABBMOGjFqeSrBfQ1Iv4tgc8kn2Mw+
         mwbgu7n82XFK+5bv3i18yXzc0KRMTPWNgWAZZi8O68O89eZX7/WiBD8vaFbfVXpNZ3Je
         tJ3b+Q6S8dZ3e/Giobcy1wH5BOWoFhXAeQu862vLfEe5gclRnFy4/9fZ7ucPPGEN1gDt
         uuwA==
X-Forwarded-Encrypted: i=1; AL+hErFka4JNjHexZ9B/E2DEkEw2ZWTxFXM9sVZo/BOsntnhSnT2cT6DraZjiEkgPpbHmcD0cm5Zng==@lists.linux.dev
X-Gm-Message-State: APuU4Z/AIOshyBPIBkslBlgeCUJX2YXSclix1V5JHxP7LNb5b5BejNY5
	1mhFZJzdIo7vBNb7C50u1QG2ajBYbDzYOjJOMTlareoYXhD+zeBfL3Dz
X-Gm-Gg: AYBFou3wpzzr3gmjnZF9CT8jyRCZjYsnul9BdRQ26o5DocH7T/P7ScYWmWldDPfEACT
	nAsxk722jZg3Gg/esXkvoY93eN21/dtNDFYHmcQll1tZ4WOA1zoQA4Qt7tJL0MEeKH+KjILVC+2
	CpFLjRrPdmsJqulMcArQYfKDiJmgK0yUMg8RgeNnEvukjzUDNlwREubgihmNULTJpTJ2rIBGIjZ
	H66YU2eLXndSG8JlMzZJNmapfQd0bYDz4N5n5QTPcQmG21KVuzoMzhCbycdh645xxHQXRqNmVmD
	02zBnIeQFJfaFpqH6JXVUpnEeFWB3N7MshBnO9oy9XkNFC6JzgqFyRNIKKXyLmYAACfkpZSqpBk
	AP0QUrTiO3TagrNZXg3MdqEeOJLVbGab+oj+6Zn9DrZhVEUSUz2ZRy94zcBVzlXBqs1rOKxntwD
	mgHLJ4c4Jl6tp4tBA8X1Dik/M2hGfO4OV8n/mNpPK/otxL7gL29GqbpUOeqLJdu3cQPQsVf9Lni
	NKehct50ERFsKeuA6se9ZV48bDgq3BNOPH3tTlkWIp8k9x1swbW0fb99P89R28EZ2SqBvozmTWf
	5r+II5o+Fy9Yrqtw+Zx3kOUvRSMN7GgENkE=
X-Received: by 2002:a05:6a20:7f89:b0:3eb:afe0:20aa with SMTP id adf61e73a8af0-3eed2e06bb1mr3837559637.20.1794227012895;
        Mon, 09 Nov 2026 04:23:32 -0800 (PST)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96816fc6sm1622392a12.5.2026.11.09.04.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 04:23:31 -0800 (PST)
Message-ID: <7773d026-4aef-4169-866a-71ec9a91da21@gmail.com>
Date: Mon, 9 Nov 2026 20:23:16 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org,
 m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/26 16:30, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
> 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path: firmware reports those carveouts as unusable in
> the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
> (is_usable_memory(), efi-init.c), and the ELF header builder has
> always skipped nomap regions; only DT-based systems currently fail
> to filter these regions, which is what this series addresses.
> 
> This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
> memblock to filter reserved memory on DT-based architectures. A new
> flag is needed because MEMBLOCK_NOMAP can only express regions without
> a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
> linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
> so kdump omits them; reusable CMA regions are different because their
> pages are handed back to the buddy allocator and may carry crash-relevant
> data.
> 
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce.
> 
> The series is based on linux-next and is organized as follows:
> 
> Patches 1-3: Preparation and bugfixes: switch riscv crash_mem to
>              memblock, fold the duplicated per-arch memblock walks
>              into the weak defaults, and serialize crash header
>              preparation against memory hotplug.
> Patches 4-7: NODUMP infrastructure: switch crash_core to
>              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
>              flag, add a dumpable flag to struct reserved_mem, and
>              mark /reserved-memory entries with MEMBLOCK_NODUMP.
> Patch 8:     Skip MEMBLOCK_NODUMP regions when building the vmcore
>              ELF header.

Hi all,

A gentle ping on this series.

I'd appreciate any further feedback, particularly on the
MEMBLOCK_NODUMP discussion and the issues raised in the Sashiko
review.

Please let me know if there are any other concerns or suggestions
before I prepare the next revision.

Thanks,
Wandun

> 
> v8 --> v9:
> 1. Patch 7: Avoid a potential boot panic on SH when NODUMP marking requires
>    memblock resizing before it is allowed, found by Sashiko in [1]. SH supports
>    neither CONFIG_KEXEC_FILE nor CONFIG_CRASH_HOTPLUG, so skip marking when
>    both are disabled.
> 
> v6 --> v8 (v7 mainly tried to fix the initrd issue on release in v6,
> that approach is superseded here):
> 1. Stop marking /memreserve/ regions with NODUMP. v6 marked
>    /memreserve/ regions with NODUMP. But a bootloader may specify
>    a /memreserve/ entry for memory that the kernel later frees
>    (e.g. the initrd), and those pages would then be wrongly
>    filtered out of the vmcore after being reused as normal memory.
>    The v7 fix (clearing the flag in free_reserved_area()) caused
>    a lockless runtime mutation of memblock.memory [2]. Better solutions
>    exist but need extra preparation, so temporarily dropped the patch
>    that introduced the problem to keep this series simple in v8.
> 2. Fix a build failure in patch 2 with both ARCH_KEEP_MEMBLOCK and
>    MEMORY_HOTPLUG are unset. There the memblock arrays live in
>    .init.data, and the weak defaults referencing them create section
>    mismatches, which turn into build errors when SECTION_MISMATCH_WARN_ONLY
>    is also unset.
> 3. RISCV recently gained crash hotplug support, so adapt its handler
>    like x86 in patch 3: use __crash_prepare_headers() instead of
>    crash_prepare_headers() to avoid self-deadlock.
> 4. Update the cover letter per review feedback: describe how ACPI
>    systems filter reserved memory and why a new flag is needed
>    instead of reusing NOMAP.
> 
> v6 --> v7:
> 1. Fix a stale MEMBLOCK_NODUMP flag issue [3]. Memory reserved and
>    marked as NODUMP may later be freed (the initrd, for example),
>    so the NODUMP flag must be cleared accordingly. Since the fix is
>    part of the NODUMP infrastructure introduced by patch 5, it has
>    been folded into that patch.
> 2. Drop the "generic" related description in the cover letter.
> 3. Collect the Acked-by and Reviewed-by tags received during the v6
>    review (thanks to Baoquan, Mike, Rob and Marek). Patch 5 is the
>    only one without a tag, as its Reviewed-by was dropped when the
>    fix was folded in.
> 4. Drop patch 1 of v6, which has been merged separately.
> 
> 
> v5 --> v6:
> 1. Serialize crash header preparation against memory hotplug to avoid
>    out-of-bounds or use-after-free issues.
> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
>    avoiding a panic from too few regions before resize is permitted.
> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> 
> [1] https://sashiko.dev/#/patchset/20261016061549.4181390-1-chenwandun1@gmail.com?part=7
> [2] https://lore.kernel.org/lkml/20260922090252.B01541F000FF@smtp.kernel.org/
> [3] https://sashiko.dev/#/message/20260917220750.GA4013814-robh%40kernel.org
> 
> v5: https://lore.kernel.org/lkml/20260806093519.2907771-1-chenwandun1@gmail.com/
> v4: https://lore.kernel.org/lkml/20260630074715.4126796-1-chenwandun1@gmail.com/
> 
> Wandun Chen (8):
>   riscv: build crash_mem ranges from memblock instead of resource tree
>   crash_core: fold duplicated memblock arch hooks into the weak default
>   crash_core: serialize crash header preparation against hotplug
>   crash_core: replace for_each_mem_range() with for_each_mem_region()
>   memblock: introduce MEMBLOCK_NODUMP flag
>   of: reserved_mem: add dumpable flag to opt-in vmcore
>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
>     header
> 
>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
>  arch/loongarch/kernel/machine_kexec_file.c | 27 -----------
>  arch/riscv/Kconfig                         |  2 +-
>  arch/riscv/kernel/crash.c                  |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
>  arch/x86/kernel/crash.c                    |  2 +-
>  drivers/of/fdt.c                           |  1 +
>  drivers/of/of_private.h                    |  1 +
>  drivers/of/of_reserved_mem.c               | 18 ++++++++
>  include/linux/crash_core.h                 |  2 +
>  include/linux/memblock.h                   |  9 ++++
>  include/linux/of_reserved_mem.h            |  1 +
>  kernel/crash_core.c                        | 53 +++++++++++++++++++++-
>  kernel/dma/contiguous.c                    |  1 +
>  mm/memblock.c                              | 16 +++++++
>  15 files changed, 103 insertions(+), 94 deletions(-)
> 

