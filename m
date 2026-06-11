Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20423BD06
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143791; cv=none; b=DpSPsbupsmxDLPsR8fETQZQq8sux9YoU0MmfFselQbQzF12M4sTmgKRlO216UHOg8O0CW2tTvz2bxmGMU845pwm9Z83Vn+D4N62o9r8GCH3gNIOm5MEpDzZccaIYZFMU+WKfVGURCdNkmRtM+LUQsE/4nCoiewdWDewr0N4iJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143791; c=relaxed/simple;
	bh=7IoqrrsIUXvxJNgaFncXuFymv5csPW4jbxzDZ4eJZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rsLJdV1lKbkXSs9DphXU2itUcZIM95/h/QMOaU9odcUeIsBZC7XdqT+c5vJ2C7JwCkhi/ol6gTchvZkH3gRbWRFm2ADZz5vdzC3MjjrZKSEloZiIPYbzFsnkk/0FI5cOwoZQEY4BaSM83l47CQYVPpHE4pUTn4CwSmy2B2VdhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE9QEp/b; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE9QEp/b"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c0c3546924so49663035ad.3
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781143789; x=1781748589; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrKKxjQkCCq7BO+0b9GvAXj1oVgaGXMfePrho45byEA=;
        b=RE9QEp/bEfSx5pyk4MDOv9X2oa1F/dxxyp0K70MrXOM3KCK1Fb6vWrYlf4qrcGvPxS
         EpNMycjtDiZmpyDjXn9Vxx1WYGnpERRWQ+YxkIXDZiJOUPqG69X9w2OPHP+3H6C9JSmJ
         cHIiUPBp4zTsUK1NxSJiYfgg4DSVNStYUp5vVnB4GRzrXWl9+JXNg5TutU7BugR5+hc1
         Zqu5tVFj+UN0KpAe6/gYV2oWF7pq/WsMaNWKchohD9Gp+p1wXDfbbN2fP/PZBnrHyKH+
         eemlH42jOvA1a9qJPhA63k7trBBHr6M0Z3yMQxZQCi0TrrNVEAAxI/xKa6LzyyIHUdb8
         PNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781143789; x=1781748589;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrKKxjQkCCq7BO+0b9GvAXj1oVgaGXMfePrho45byEA=;
        b=kiuwoDvL/EQY8xC8tNJ8tY8+qyRSHvRI1Wmv9yHZ3ernhG1kbjGJ1hm0E6ewiY+mlq
         +pvpC6m4Nqxg7pRNf1sn7TeeIvRFnrNsnWbuJD6x0JMzCzHyfvhsp2/0SBAWCTssXS9B
         h412S5dMsu36K9CUNCpatFKlXXElySKqX8RL5Pkpod/CNfEiFY5LRnjomfXsBhA8llAk
         EA9A6EmEg4XjWHL/5louNdxh4GWuSoWKo3UNvl+fA1nVlFeCgsmz9RWoNYouyxEkyiOY
         477SN1yeHnZSsDWeQi1TIt7sJ8X2rg5Vd2AS9xMDVFdEMXKhCSYczD2mn9aB+XZMq0aq
         bosw==
X-Forwarded-Encrypted: i=1; AFNElJ/pwBT/Y2YOe2W3xoeVKAJBfo8FgI5YB1XWwU5EltD+UTC9/Sx+zH4yGOJGdgGgwDvG9VFjFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc2fq8EpdOvYTxzQlcvm0DrKeEmr0NJLC65kkLKqbCD15F/SuH
	xa8O5c7dgN+ITteUcp4Jstw64jzdcX/UTP0SVcO33fHsPEvJzbL+V+jE
X-Gm-Gg: Acq92OFIgpgDD5im3KcHx4pmLo+eS+YGWAWjnjcJou/03r8sgFM8aBk/oA6XTG3sP5i
	XXpzKAyA3RHKgDAahT670O2z6HxAbh7nGIhEc9D4DY0nKiWgYaCl1splkH3CvOmEbdE15H3veJ0
	TLRMB1BzNmbtXMai32OA7ZLc1dlKKmeUH/JLJidghA1hU1UgXU+cka9apS0PyOGTh5aYkH1pLzE
	tVIj6LK2FRtETX//qepf3VYPHOaxVXBNlFRlGvPTSwIGP1+jN37NCODpNNFquuEehc2NpNF6NKQ
	CcLpw6OMr2qhLqGdA+63FDVocx941JpZigBZKwWAzuk11imMuwl99IQ4b17OBII0A43h84UqvpB
	DL6uhe93OvBWJJZH+4zC7xJMaq8dUpOUwez01kyo8PVJJK3Djz1uoRajUsQzZQeJ6FRBV3xXLQA
	yYz/KihofqpySUfVJt9vkjFWd7YzqdHcNdl8jJyXa9iA==
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id d9443c01a7336-2c2f21a11f5mr7037195ad.21.1781143789049;
        Wed, 10 Jun 2026 19:09:49 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa404fsm256644005ad.37.2026.06.10.19.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 19:09:48 -0700 (PDT)
Message-ID: <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
Date: Thu, 11 Jun 2026 10:09:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, Rob Herring
 <robh@kernel.org>, saravanak@kernel.org, bhe@redhat.com, rppt@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/27/26 11:29, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
>
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.
>
> This series introduces an opt-in 'dumpable' flag [1] on struct
> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> DT-based architectures (arm64, riscv, loongarch). By default reserved
> regions are treated as non-dumpable; CMA regions are explicitly opted
> in because their pages are returned to the buddy allocator and may
> carry key crash-analysis data.
>
> The series is organized as follows:
> Patches 1-3: Pre-existing fixes and a small prep change.
> Patches 4-5: Restructure to allow appending /memreserve/ entries.
> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
> Patch 8: Add generic kdump helpers.
> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>                elfcorehdr preparation.
Hi,

Gentle ping on this series.

Status summary:
-patch 03: respun separately per Rob's suggestion, picked up for 7.2
-patch 06: Acked-by: Marek Szyprowski -patch 09: Acked-by: Will Deacon 
The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still 
awaiting review. your feedback would be greately appreciated. I know we 
are at the end of 7.1 -rc cycle, I don't want to rush this series, just 
collecting more feedback, and will send next version based on 7.2-rc1. 
If spliting the series into smaller logical group would make review 
easier, please let me know. Best regards, Wandun
>
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
>
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>     feedback [1], v2 drop that property and exclude reserve memory
>     by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
>
> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4
>
> Wandun Chen (11):
>    of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
>    kexec/crash: provide crash_exclude_mem_range() stub when
>      CONFIG_CRASH_DUMP=n
>    of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
>      fails
>    of: reserved_mem: zero total_reserved_mem_cnt if no valid
>      /reserved-memory entry
>    of: reserved_mem: split alloc_reserved_mem_array() from
>      fdt_scan_reserved_mem_late()
>    of: reserved_mem: add dumpable flag to opt-in vmcore
>    of: reserved_mem: save /memreserve/ entries into the reserved_mem
>      array
>    of: reserved_mem: add kdump helpers to exclude non-dumpable regions
>    arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
>    riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
>    loongarch: kdump: exclude non-dumpable reserved memory regions from
>      vmcore
>
>   arch/arm64/kernel/machine_kexec_file.c     |   6 ++
>   arch/loongarch/kernel/machine_kexec_file.c |   6 ++
>   arch/riscv/kernel/machine_kexec_file.c     |   4 +
>   drivers/of/fdt.c                           |  11 +-
>   drivers/of/of_private.h                    |   3 +
>   drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
>   include/linux/crash_core.h                 |   6 ++
>   include/linux/of_reserved_mem.h            |  15 +++
>   kernel/dma/contiguous.c                    |   1 +
>   9 files changed, 157 insertions(+), 12 deletions(-)
>

