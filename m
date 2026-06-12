Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834A3D9DB9
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249320; cv=none; b=ntZcEVCPR+DHR8EuCS22YdToYrpWf3w7O3pXv6BVpDc8RMQCBLshIcJ++N3CYFWHEoBHjTIH8xPxnGNVNXkCQbV4A13PHW0i15WtYjVhAvV8usnAkzmY2W+ZXgW+B0Wt1ht28Yuq5W+N2Fg4pxoGwOTnOkBDCAbEVtiJb6S/gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249320; c=relaxed/simple;
	bh=kAPiUCLyMJWjlb7fejuBmEvQIEXoZ8B6yNmVTGMkDN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQVp7Ycd6pP9HCIH7/MNkC/Mc3LDn1rIL4+JEtGQXOEeEOIem61lce8IBRbScWdPVzhqtfwi2M6eJibFhJcPH8j8+u1BZoIns+BiwQRmuzdp2foxt8/lJMebyczgKsQ4qWoadxZRGF6OnRSnYoSLIEfYpZIu1FCiEr3xo2+jO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOuAS5wh; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOuAS5wh"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8423f869421so579101b3a.3
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249317; x=1781854117; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66pdCW0yOW5Nk6MUhQzAUTYI58FQ4Ifcfuf+SyuK5QE=;
        b=LOuAS5whNAZtJaqflUhV6OA3K8m5SqW6UF4KCcQCUxvudfEbJTcskJWKjZiqZDCv1a
         LR5L8xueBA8gy/8T1CaF8+/g16Gz1rhFwUGhnpVg4zS96fp9dbh+ZhlQbFty01uE+Sgn
         XtUtLHF7bJED2v3p+I59+zcyUMUAcWMWKrnsW9B3WgA/gMb3GCPN0wd9nAMsekBsvcoX
         4f1f2Yt0mgQd7Og1hl5YXH7KTZk4cpcZJcgEVzyPYVICDbO4QWbMOb33BFetg27WiG+v
         tyeLhN47e6SM/ZnyMrsK4Jz2cWcNUoPwkbh8cbrEkZ+oAwWMx1HedKPah5mbmFIJx1Nb
         yJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249317; x=1781854117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66pdCW0yOW5Nk6MUhQzAUTYI58FQ4Ifcfuf+SyuK5QE=;
        b=dojLIAd4QMXddSgpScuvgQXFZghitbKZnintho7ytfxCeoA/DTjb195FHiMUZ6Jy4f
         VpSbgJ1SsGklsT4EALLiQOkhrXUNHKHjy/sor0V4sM4DOQmU68wrlMroV5ghenu8j9tB
         osb4f3+L5EZadVjei8mqUTGOSawLvdl4qvPRqi2nMWEf2xlPyFWxdIBdmHwwGE0La1l4
         iunq9wlqyOWBfNj9dOPEz+4DGMYm3Qm+2p0yceTk8SyNeYSgVwQ4Q/ZipUlrc0ZgRbih
         8sL+f+Czu4gU7ZaJ9V0suT9nObGrueT7aUWcxJuw3sRyYEZCysDUiF+UR4Z3djQ7ziXx
         K0zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZPD5XG32D08vLP9tmjs9qkyRlagpS8NsZUV5HqocOo/5rI1dHWY3RBG0zivEdctsWZJl9pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2HgSKJ1fQV8182C9aBbsSNYAChsaZlk6EPZh1eTiXaDk36KfA
	Spw2ULXANcekxtklAEO0B1zNrLy2+0OB2XwOzo7iKPf5HcZQl3bofAl3
X-Gm-Gg: Acq92OGnO229W+LvgSOiGQolOyQE8wlMGBK1aqz5uxbjzEIINISsiN1oYe74+BPY8jd
	XodmoQg6AT+HOPQ1YTJk0fXXGegmSA9TIrVsi/YuK5u4dE6QJFDR5cDDLdbGHDWmiU92VLt6oep
	ofKTPDD/unYBgppx2w4Bf9ZjqMJMK37RVKqBVF/Ad/nr+OBFYCZujvb71xDr57R5UuNFsjfdez0
	t3K6mfb9/kBcuRTMmF/40KIopZOEBQ7FVo9bX9xZzOjJH1Q2/4HDXbN3K8TS0PnypC1/tcZZ146
	iFhtcrgiYRXosuC/Ln7NtsL79DlEnxIiV7/KZZegDTjpW6yBPLANALqNgSdkonaGPj4PbQRDUt3
	CPVqOXcUmCQUIxAne4KZBpD7SDaLTDYvv/7wWSwzpxyBN/Ha7OhhhXKWcmlYySKvsqIvsc10SSR
	B0IQ2SxirdQnDxcm4xy2EAFXsr1mbdoTeRdI5uG7yUiQ==
X-Received: by 2002:a05:6a00:218c:b0:842:708f:39a6 with SMTP id d2e1a72fcca58-8434cc08379mr1646577b3a.10.1781249316540;
        Fri, 12 Jun 2026 00:28:36 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a9bsm1278464b3a.31.2026.06.12.00.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:28:35 -0700 (PDT)
Message-ID: <27a06e00-ac47-4e5f-8033-4e89f15d0411@gmail.com>
Date: Fri, 12 Jun 2026 15:28:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
To: Baoquan He <baoquan.he@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, Rob Herring
 <robh@kernel.org>, saravanak@kernel.org, bhe@redhat.com, rppt@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 chenhuacai@kernel.org, kernel@xen0n.name, catalin.marinas@arm.com,
 will@kernel.org, alex@ghiti.fr, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
 <a3993db0-6975-455d-9674-4fd7cfcf80fc@gmail.com>
 <aiqkKe1gXPZ5LZ7t@MiWiFi-R3L-srv>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aiqkKe1gXPZ5LZ7t@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/26 20:03, Baoquan He wrote:
> On 06/11/26 at 11:09am, Wandun wrote:
>>
>>
>> On 6/11/26 10:09, Wandun wrote:
>>>
>>>
>>> On 5/27/26 11:29, Wandun Chen wrote:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> On SoCs that carve out large firmware-owned reserved memory (GPU
>>>> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
>>>> those carveouts as part of system RAM even though their contents are
>>>> firmware state that is not useful for kernel crash analysis.
>>>>
>>>> This series introduces an opt-in 'dumpable' flag [1] on struct
>>>> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
>>>> DT-based architectures (arm64, riscv, loongarch). By default reserved
>>>> regions are treated as non-dumpable; CMA regions are explicitly opted
>>>> in because their pages are returned to the buddy allocator and may
>>>> carry key crash-analysis data.
>>>>
>>>> The series is organized as follows:
>>>> Patches 1-3: Pre-existing fixes and a small prep change.
>>>> Patches 4-5: Restructure to allow appending /memreserve/ entries.
>>>> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
>>>> Patch 8: Add generic kdump helpers.
>>>> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>>>>                elfcorehdr preparation.
>>> Hi,
>>>
>>> Gentle ping on this series.
>>>
>>> Status summary:
>>> -patch 03: respun separately per Rob's suggestion, picked up for 7.2
>>> -patch 06: Acked-by: Marek Szyprowski -patch 09: Acked-by: Will Deacon
>>> The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
>>> awaiting review. your feedback would be greately appreciated. I know we
>>> are at the end of 7.1 -rc cycle, I don't want to rush this series, just
>>> collecting more feedback, and will send next version based on 7.2-rc1.
>>> If spliting the series into smaller logical group would make review
>>> easier, please let me know. Best regards, Wandun
>>
>> Apologies for the formatting issue in my previous email.
>> Here is the properly formatted version.
>>
>> Gentle ping on this series.
> 
> Thanks for the effort, the overral looks good to me at 1st glance. I will
> check if there's concern on generic part. And meanwhile, I am wondering
> if there's any chance x86 or other ARCH-es w/o OF/FDT can also choose to
> not dump some areas, e.g GPU stolen memory. Surely, that's another story.

Thanks for the review, Baoquan.

IIUC, reserved memory is already excluded from vmcore on x86.

Reserved memory is typed as E820_TYPE_RESERVED in the e820 table, and
insert into iomem resource tree with IORESOURCE_MEM flag. The x86 kdump
patch uses walk_system_ram_res() which scan iomem resource tree, and
only collects ranges with IORESOURCE_SYSTEM_RAM flag, so reserved
regions are excluded.


Best regards,
Wandun
> 
>>
>> Status summary:
>> - patch 03: respun separately per Rob's suggestion, picked up for 7.2
>> - patch 06: Acked-by: Marek Szyprowski
>> - patch 09: Acked-by: Will Deacon
>>
>> The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
>> awaiting review. Your feedback would be greatly appreciated.
>>
>> I know we are at the end of 7.1-rc cycle, I don't want to rush this
>> series, just collecting more feedback, and will send next version based
>> on 7.2-rc1.
>>
>> If splitting the series into smaller logical groups would make review
>> easier, please let me know.
>>
>> Best regards,
>> Wandun
>>
>>
>>>>
>>>> v2 --> v3:
>>>> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
>>>> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
>>>> 3. Add some prepare patches.
>>>>
>>>> v1 --> v2:
>>>> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>>>>     feedback [1], v2 drop that property and exclude reserve memory
>>>>     by default.
>>>> 2. Split some prepared patches from the original patches.
>>>> 3. Address coding-style comments on patch 5 from Rob.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-
>>>> robh@kernel.org/
>>>> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-
>>>> chenwandun%40lixiang.com?part=4
>>>>
>>>> Wandun Chen (11):
>>>>    of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
>>>>    kexec/crash: provide crash_exclude_mem_range() stub when
>>>>      CONFIG_CRASH_DUMP=n
>>>>    of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
>>>>      fails
>>>>    of: reserved_mem: zero total_reserved_mem_cnt if no valid
>>>>      /reserved-memory entry
>>>>    of: reserved_mem: split alloc_reserved_mem_array() from
>>>>      fdt_scan_reserved_mem_late()
>>>>    of: reserved_mem: add dumpable flag to opt-in vmcore
>>>>    of: reserved_mem: save /memreserve/ entries into the reserved_mem
>>>>      array
>>>>    of: reserved_mem: add kdump helpers to exclude non-dumpable regions
>>>>    arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
>>>>    riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
>>>>    loongarch: kdump: exclude non-dumpable reserved memory regions from
>>>>      vmcore
>>>>
>>>>   arch/arm64/kernel/machine_kexec_file.c     |   6 ++
>>>>   arch/loongarch/kernel/machine_kexec_file.c |   6 ++
>>>>   arch/riscv/kernel/machine_kexec_file.c     |   4 +
>>>>   drivers/of/fdt.c                           |  11 +-
>>>>   drivers/of/of_private.h                    |   3 +
>>>>   drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
>>>>   include/linux/crash_core.h                 |   6 ++
>>>>   include/linux/of_reserved_mem.h            |  15 +++
>>>>   kernel/dma/contiguous.c                    |   1 +
>>>>   9 files changed, 157 insertions(+), 12 deletions(-)
>>>>
>>>
>>

