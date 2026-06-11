Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15071289E13
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781147376; cv=none; b=TgXKZKGRc3DSVZPSLygwgUIkJx7f3DWTZLq2m5NDWZDt+MliiPavhOzvgecq094GgvIS4JzSw967bf4y3iHd9Ln9thjwZbKorGfsRj13EkJ7Vv1wGXNIYN2a0seeq/HCHNH+A7hcCd25NYoW0WBmpBEOCT7eID5f+s+BdEwoed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781147376; c=relaxed/simple;
	bh=oKZuciULY9JBG2l4enUy3YkyVqstZ1dofPhvmB1PDVk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YB43kn8462MId0MBJZ5Vi6Lm6696HbCSUFKl2vvbmXfHtP+8npIejiQE7f0dMlMV+/n5Sx0XrU2/gq4zf2zm2ffgS3M4xDa9l/DFYXGz9ba85zQw5DSfHLh3hD1spR2Fh8VYiglDn5O6uqAaTg6vPrQrpmAeBc+uCVKwRsra7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsronQRh; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsronQRh"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b903567fdso7640367a91.1
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 20:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781147373; x=1781752173; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYAsuub7tjh5DE2NtRU43cs+1enZX+YMETetqa3OJBs=;
        b=hsronQRhavmpXWFjgTJ2pMPNjEapZBgMrOPSEERZn5u10Vf38St3ARU4Rcog9G3Knz
         Nx7i2RtVrTScpx2UH3Vzi31HwjVcUFs4vIpKHjNhyOPlSLA6lRNIH7bPshQCcjBfVlUE
         R8clFKudQcXD+QhvHcpRPky+AFACHPl6Oo1c8322YoVFr1wFit3+7TF1qDhIfzngMauS
         3R7RWU2K1ncJIjmSMPA3ebA7TY1bI6Ai3kqVH1rq4vfLZouKOisBXpLbXnepTUG9Nl5U
         uss7upViAADLdQJWsCl7zOoJN9o8cx5gOovQfQXWIzoZilQhN3N/brO4rPmwUg51YEUn
         HdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781147373; x=1781752173;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYAsuub7tjh5DE2NtRU43cs+1enZX+YMETetqa3OJBs=;
        b=IsAn8MF8eE25/SgD2Qg0UbmJGhqrSKHgfdtx0bYDfQiwumYKuNtTEhEPYsNLWQyDig
         EQj2CUy5Ocrk1JKCJPXPkny2RSnbpZCmrl5qZKPv5cYY/ZWzFvyjeEzDYjk6EOAZjBAE
         qKmgeP9+gLL/qJEcgHI+xbdtZ4Kpc4U9kuV/SawlflnV7fSgMMZ0lgymSY0+0f0xkBVa
         02qr5Wvqz/l3MQ5YmPvRecZmqglfLY+dB+gpn3YTW1agODy/MzdGAOw1hXRwenKOnujQ
         mlTVaBwoU8EUcevNaDBDMm0iq5YOpK4NlXZDnBWKctft9jecf6vVk7Ia9ZCjEm8dkBX5
         p94w==
X-Forwarded-Encrypted: i=1; AFNElJ/DmVOIrPy28x4e+GpGSWYYDYIzVlFjdWgkIIqapx0Xm1/3WM89Q9RvGRmA0S81umR0AONeSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2FNLPZqL6k0pmuf4ZBARku1Sh7JfF11Kn1xs9aGrLDE3M58gC
	K6mYKBcCxcRwpiIjJ+qH/eO8VLn+uZWMIbVAT2ADa8VvSp2mig3AlxqV
X-Gm-Gg: Acq92OG1KEoKcw7uR4lwL7KE/Nrw0FBIg0NoNVDD9l+Z/iGPUZ2JBQJmFuSokIzMpxJ
	dN5nVgJlw5Ghrm1DzwyMjlRamHrBaoQI47bVXR4XPhC/PUQN0MBebu5pEuVbWuZRB2uM52l/di8
	Td/8oOzS0mxyx/S61YEnuB4SCdXCSCGvxQ7Dtn3gBwxveIFjeF4UnH5yorJeU34nXB+f7h9U7qb
	0ifPyrqUoq6CMtsJ8XRFIdKJoyUz6nprWUzskNGCtkLXtNMHL5v8tQBN5AwkOaerYjNTz2zCM01
	5yuJOZVpO6hT0NkH4OCuUoQlGQzAAFoARk8UeRnF7Vp7AxbQp0YEdyYr1eFLKkM2zktmj4f3lx1
	iAeiOwjDOI9rYiJangGymQ+KpUgR+feoUo3rAvBcg5sB7bWpKE7kCkRYy1BwhSw0WO+VL7wQyIq
	yhkjJNwgiCHC/heq9gIRN28B09EODvnXIEeyO+i73g6g==
X-Received: by 2002:a17:90b:570e:b0:36d:df4f:ab2 with SMTP id 98e67ed59e1d1-377a75cc2b7mr1151650a91.13.1781147373379;
        Wed, 10 Jun 2026 20:09:33 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86585b5356sm107409a12.14.2026.06.10.20.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 20:09:32 -0700 (PDT)
Message-ID: <a3993db0-6975-455d-9674-4fd7cfcf80fc@gmail.com>
Date: Thu, 11 Jun 2026 11:09:22 +0800
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
 <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
Content-Language: en-US
In-Reply-To: <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/26 10:09, Wandun wrote:
> 
> 
> On 5/27/26 11:29, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> On SoCs that carve out large firmware-owned reserved memory (GPU
>> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
>> those carveouts as part of system RAM even though their contents are
>> firmware state that is not useful for kernel crash analysis.
>>
>> This series introduces an opt-in 'dumpable' flag [1] on struct
>> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
>> DT-based architectures (arm64, riscv, loongarch). By default reserved
>> regions are treated as non-dumpable; CMA regions are explicitly opted
>> in because their pages are returned to the buddy allocator and may
>> carry key crash-analysis data.
>>
>> The series is organized as follows:
>> Patches 1-3: Pre-existing fixes and a small prep change.
>> Patches 4-5: Restructure to allow appending /memreserve/ entries.
>> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
>> Patch 8: Add generic kdump helpers.
>> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>>                elfcorehdr preparation.
> Hi,
> 
> Gentle ping on this series.
> 
> Status summary:
> -patch 03: respun separately per Rob's suggestion, picked up for 7.2
> -patch 06: Acked-by: Marek Szyprowski -patch 09: Acked-by: Will Deacon
> The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
> awaiting review. your feedback would be greately appreciated. I know we
> are at the end of 7.1 -rc cycle, I don't want to rush this series, just
> collecting more feedback, and will send next version based on 7.2-rc1.
> If spliting the series into smaller logical group would make review
> easier, please let me know. Best regards, Wandun

Apologies for the formatting issue in my previous email.
Here is the properly formatted version.

Gentle ping on this series.

Status summary:
- patch 03: respun separately per Rob's suggestion, picked up for 7.2
- patch 06: Acked-by: Marek Szyprowski
- patch 09: Acked-by: Will Deacon

The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
awaiting review. Your feedback would be greatly appreciated.

I know we are at the end of 7.1-rc cycle, I don't want to rush this
series, just collecting more feedback, and will send next version based
on 7.2-rc1.

If splitting the series into smaller logical groups would make review
easier, please let me know.

Best regards,
Wandun


>>
>> v2 --> v3:
>> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
>> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
>> 3. Add some prepare patches.
>>
>> v1 --> v2:
>> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>>     feedback [1], v2 drop that property and exclude reserve memory
>>     by default.
>> 2. Split some prepared patches from the original patches.
>> 3. Address coding-style comments on patch 5 from Rob.
>>
>> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-
>> robh@kernel.org/
>> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-
>> chenwandun%40lixiang.com?part=4
>>
>> Wandun Chen (11):
>>    of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
>>    kexec/crash: provide crash_exclude_mem_range() stub when
>>      CONFIG_CRASH_DUMP=n
>>    of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
>>      fails
>>    of: reserved_mem: zero total_reserved_mem_cnt if no valid
>>      /reserved-memory entry
>>    of: reserved_mem: split alloc_reserved_mem_array() from
>>      fdt_scan_reserved_mem_late()
>>    of: reserved_mem: add dumpable flag to opt-in vmcore
>>    of: reserved_mem: save /memreserve/ entries into the reserved_mem
>>      array
>>    of: reserved_mem: add kdump helpers to exclude non-dumpable regions
>>    arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
>>    riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
>>    loongarch: kdump: exclude non-dumpable reserved memory regions from
>>      vmcore
>>
>>   arch/arm64/kernel/machine_kexec_file.c     |   6 ++
>>   arch/loongarch/kernel/machine_kexec_file.c |   6 ++
>>   arch/riscv/kernel/machine_kexec_file.c     |   4 +
>>   drivers/of/fdt.c                           |  11 +-
>>   drivers/of/of_private.h                    |   3 +
>>   drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
>>   include/linux/crash_core.h                 |   6 ++
>>   include/linux/of_reserved_mem.h            |  15 +++
>>   kernel/dma/contiguous.c                    |   1 +
>>   9 files changed, 157 insertions(+), 12 deletions(-)
>>
> 

