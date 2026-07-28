Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631433BB114
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221146; cv=none; b=jUdYsJJkR2D2vvN46MiLXt9Q1Up2+odbv2RYO6L0pl7Ug3bbrhOBfj0QjjbJSBOe/tG/DjVs1/UQ57MVaV0GYPs23OifFYnApP8g3e41I7xNZuKZ4hAMCyOG7scLVU7LZshNMxfyAT38Rc6276BPfNUubCi5hQCmbHQFkBkxw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221146; c=relaxed/simple;
	bh=NFjJoarwjTziHpeWxF34h9ZK4G+OfT3+3OqIgq8m+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzQFiQsnjcRgWYR3u+jMhm7Ke/qnupW8qHek3e+HYAwIe2VpXgvbgOPco7ZmO1Xe09naczq1QvdkpUw1alLFPrfvDaXzWynRy8shZ1etTFTXYv0J7WXzgwo484KAJUTcFq+2eD8Hmjexyz4HpGOIgNoy2fhLtHtKYPrGIUP6XC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL3W3QX/; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL3W3QX/"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf49dc298bso33652195ad.0
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785221145; x=1785825945; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9PHCPemx3I5IiaOZkfCpXgJjCP/3isLoWalQDvmgro=;
        b=OL3W3QX/wIeqKLE0f8zojkpsN3W/FponttfPjlZT0F5oycWsGlAhPPSMkHq8ADTvhF
         ihR7mQC8VcoETlmuW6b62LOG9uCKAcf9I6wuBUWdQMjqu+9yVBEz33JKP/a/PJkh//EO
         xUM4Wci0d7dHnpqBjSZP757pooOZbjx0e3lpYvhKF7RsdAP46DDfOrIaGyM4cnADMMGG
         BUC4xj85nvS8Mr8x9GE3BStiXuGuat/jHC1IbesrnkvI/L04w4ymiJkkUGHTt+pn8q7M
         UOEtzqfoo9WoNaKi+XD+1dKyIU095vHGdvKWQ+6Hld23znP0qppSCxz5cnyqX7an4W6M
         I4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221145; x=1785825945;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9PHCPemx3I5IiaOZkfCpXgJjCP/3isLoWalQDvmgro=;
        b=tKcLaYQykmGm0mAot6st6y8mvwjUSPbZIguNc6zsK9EQRVl4sg/mNqv+CmS3EtnTrA
         DS/XPW+UBQ2PDPFvklcTX5zj2oA/2pQ24T7f3A7WqBhYMsBmWuFluRlasnGNPoQ4Qf7x
         QR63cZopPZUFuahdOy1P+ecwJDrOGegDJh8dEBkCp2a7mWzeHWhNzmXnfjjWyw1E7waa
         QjOjKrL9pPdxDBs20+/3rxCkYWLRJU6UWUNeQBch7aKd6lykaS/4pV1KyUOoMuol+2q+
         6ntl4AZMRz7ULe25kCUIVZNOkCi5zP4aOSokZZ29wljre5wF2rLNrbKQ6NuXkECpErmU
         euFw==
X-Forwarded-Encrypted: i=1; AHgh+RrcOc0YtFMmeCYHadBY21qp0ZRbql9OEnBXFMh5anuzEO5q1uUA/bYlXYf7vA9w829A+LoaKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBDa2PnDEJtRqeNn3QWvFX8L1eUB+9QDTaCbGnBfcq65XmS5wq
	1N1YMIPDphgRXpUF65XMGgqQ/kov4ZVC1DlLE1ixwcA7lk7Ao5JrCnep
X-Gm-Gg: AR+sD13S+g9dyvVXYnwwr9pVR1QmWLPvnXANMOH7/fgkVXPH5v3xNSwIIoSQe9WgCuh
	LY2cT1hrGH1kf7/f/7vJV5agHGi+jLBnfudlJM6KxoAhZIiq2P4hKMwou5OMpKftPjuOfxX0iEP
	z7ayFtUUOKADgNotP15ttVWQNR6nu9tu5fy3uTJefG2bd0CsfOG/HTtaguRdz8f69+iYb0ao84E
	d0nCPwN8BHAohkMTnMnQdn6B5+HH6Bnv4A5YYzR1Bal/s081Zgt9+DFw0CalX4Qsh4exXsiXuVa
	0GiEyLHPpoUHuugSZY53aicGLiyaFE3dLIcMTEF3FBvZ+S0EBKcBhbewfdbazLsTg3WGJtYhiJV
	CnDELHitlhxhrf9/N5lM4B2HGLGS5qOqVO228Ip6a84xn/Rd//cCK0heLTMnykouXXUX2qSUGbT
	xxLzB4RMV/wA==
X-Received: by 2002:a17:903:b90:b0:2ca:d9b3:715e with SMTP id d9443c01a7336-2d015c9b773mr13766995ad.9.1785221144689;
        Mon, 27 Jul 2026 23:45:44 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e1e26sm46147345ad.22.2026.07.27.23.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 23:45:43 -0700 (PDT)
Message-ID: <14ae96c1-707c-4999-bc9d-65ec74fbeff2@gmail.com>
Date: Tue, 28 Jul 2026 14:45:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] kdump: reduce vmcore size and capture time
To: Rob Herring <robh@kernel.org>, m.szyprowski@samsung.com
Cc: chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
 bhe@redhat.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, iommu@lists.linux.dev, zhaomeijing@lixiang.com,
 catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, robin.murphy@arm.com
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
 <20260723234126.GA3253409-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260723234126.GA3253409-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 07:41, Rob Herring wrote:
> On Tue, Jun 30, 2026 at 03:47:04PM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> On SoCs that carve out large firmware-owned reserved memory (GPU
>> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
>> those carveouts as part of system RAM even though their contents are
>> firmware state that is not useful for kernel crash analysis.
> 
> What about reserved regions on ACPI based systems?

ACPI based systems already filter out these reserved regions from vmcore.
In the EFI memory map, firmware carveouts are reported with the type
EFI_RESERVED_TYPE. This type of memory gets the nomap flag set in
memblock.memory (is_usable_memory() returns false in reserve_regions()
and mark these regions with nomap flag), during prepare_elf_headers(),
for_each_mem_range() filters out these nomap regions. Therefore, the
memory reserved on ACPI based systems will not be dumped into the vmcore.
> 
>> This series introduces an opt-in 'dumpable' flag [1] on struct
>> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
>> DT-based architectures (arm64, riscv, loongarch). By default reserved
>> regions are treated as non-dumpable; CMA regions are explicitly opted
>> in because their pages are returned to the buddy allocator and may
>> carry key crash-analysis data.
> 
> I never like seeing the same change being made to each architecture. 
> That's generally a sign of restructuring needed. loongarch and arm64 
> prepare_elf_headers() look about the same. riscv version uses 
> walk_system_ram_res() for some reason. 
> 
> Perhaps the dumpable flag belongs in memblock instead? Then at least we 
> wouldn't need more DT APIs exposed to the arch code, and the code stays 
> independent of the firmware API.

Agreed on both points. Adding the flag to memblock can indeed eliminate
the duplicated code in prepare_elf_headers, and avoid expose APIs to the
arch code.

I will add a dumpability marker to memblock for future extensibility
and to avoid duplicating the same code across different architectures.

I'm inclined to add a nodump flag, similar to nomap, by default all memory
is dumpable, and only the small fraction of memory that carries this flag
would be excluded from the vmcore, What do you think about this approach?

walk_system_ram_res() in riscv could be reworked into the same form as in
the arm64/loongarch architectures, will do in next version.

> 
> I'd really like Marek's review on the reserved memory code changes.

Marek, could you take a look when you have a chance about the reserved
memory code changes, I'm happy to respin and address any feedback.

> 
> Rob

Best regards,
Wandun

