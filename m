Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AD409107
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820830; cv=none; b=DjqRCHC3/jwDixtady2bjmz0ka072sr7NRHgnjndROZsxnXkluuKO4gUqmPFxTQQdjK1pd+f9hAysYkIohW5SrK8dpw9fRpLg6MxaNN4NXSh1oUf59GW1EYdP1tpxs22nsnZUEF/QEqwUd/K/QFexmyyQydq+GYS2tlSxzfRbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820830; c=relaxed/simple;
	bh=w7L5Tp+hZz2TDhwz1Qm9WD2gfKZhpAFFy+VHrf2oVjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLLwUKvfpXf0U5LwAtQ8h+mjWz6Nfl7VXj9PEc2IIezYFvnePmwRjj2wUUuNcybp7VKPiPQzKvZdlcMuPfguPWnO3WEkEdRnXMqhgIUbLRyiqsERSUweXXRNjh4BiJnY77gA6zhCEmoAsGkPOjtBBW8ldz8zVypDuuZWFIhrz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0UpjjFv; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0UpjjFv"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-84347ad88edso3651792b3a.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820828; x=1783425628; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQJzhkIkVPlkRxcrVSAS1/qxSmuU/Saa7J0AIvXGGuk=;
        b=q0UpjjFvprSSgwxxyot76MSp9qtdp0uxt2j1o47UjBiSWLrIPi9gTfk9GaeMELlhMk
         71CzZkmqGQUauvk7ou4A13hO3H1L6nfrwBnK9faiDP27e9KYj//DNErY18kDVWu29p4Q
         pmY7z19e0/fAup13XulvJYhTKFY7oixg56vbGmozRNREPqYwQWcXVIWs0FKeAvOCFVHD
         IZcndRBWQze4uJHWVL1OB+4TulRFCQXQT76OQQwcnRb6gfKsCeNgetRrUHPDXo+7uByc
         MzzqNpoUzEEamjF7vYBFZUkQScsZgy/K47rxYouxl0xZRBrurrdCTvkWwgPJCVkzNuLi
         iIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820828; x=1783425628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQJzhkIkVPlkRxcrVSAS1/qxSmuU/Saa7J0AIvXGGuk=;
        b=MFtVY6/uvl0zVv6k1C8yvAbvu0A88CTApYQ3JJtOV3akR27acW99f0reonbvNKreQg
         X17Dc8T3uxptEwkTnwdGeAUQXOpDY4Uk6FWk0NPZi26n0Mci3un3wp/WVntoK8949IfM
         sf4svkYJTduJbWjlbT7qr1+9PsEZAu/95xdcQK+72NF3s7ma5rSw1BRXg6hJsBZEvzxh
         yzlGQ8GrFBQhntYRgswarQuLZGyVI+WYjhUUWNZuBgYa6Yxmzq2ZrkaQlmxx4l2qwGam
         uGDSW6EHX5+KlnpJNHJbysM/py8rgVlwiC976SJ34gQvPYvBPKcr51t+YtU94VvJjhds
         gBSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqD5weyLPFbXbQh/crZHysK3AeKe2g2yE+UuLNOtVYubIGCRnFS3H7OPNTtrPyTyzliXFnLoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5zR6yzc2bzAhrZ73WpdDt/770x4h5XebqYkawQA/eklyYwT0q
	DnOr5yyaPsFGhXb6BS0ZcBVqnCcbjoaigwImaklLFsVxnYJWHZliVnsN
X-Gm-Gg: AfdE7cl8KJrGN37pue50pWlSbZ/VlwIOoQwNJrPBjkc7Qt4sFw5WfkLqR8h2X0Hbxxp
	TC6mnWQjk1s5M4mwHr/MbDLHpKhQwpGEZWI124suryiRishHqbju/76SDtjexbiY3ScXheVxgtK
	HSU1FGDPhlkhFANgIEA4HEx2dgiXWuyDCIkaXHcHDIFVIwlg/qu1URJW+3+JsSAdz9+9w6mNCKC
	HO5jni6LRTt1czvUewP2KCepnAiliG05a/uTwgdqAhDhYZ7entGFhYuQkip2ENnKLVQeQIZX8++
	/OGJhGQ59SwC6O3G9QMLOZc4uCs0j3mzUogRyDH1SW1uKOnivs8hZPYR+69M7FBHWVPC5RevptT
	zJ2aPEg3vS0mHyOAbVDPDrrRpvTV4jd7w3+QYN0Dd6z8ZXtEFWpNr1G+/1XSSp7M/rjFNoay1zK
	RovoXVDw6t5oGK25LGpHAf
X-Received: by 2002:a05:6a00:1ca1:b0:847:902a:57b5 with SMTP id d2e1a72fcca58-8479f2175cbmr2758259b3a.35.1782820827394;
        Tue, 30 Jun 2026 05:00:27 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02cd39asm1834294b3a.34.2026.06.30.05.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:00:26 -0700 (PDT)
Message-ID: <e6028d44-781f-4d21-bef9-eba0547df03d@gmail.com>
Date: Tue, 30 Jun 2026 20:00:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] riscv: kdump: exclude non-dumpable reserved
 memory regions from vmcore
To: Pratyush Yadav <pratyush@kernel.org>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, robh@kernel.org,
 saravanak@kernel.org, bhe@redhat.com, rppt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, catalin.marinas@arm.com,
 will@kernel.org, alex@ghiti.fr, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, ruirui.yang@linux.dev, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
 <20260630074715.4126796-10-chenwandun1@gmail.com>
 <2vxzechoi8o0.fsf@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <2vxzechoi8o0.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 19:12, Pratyush Yadav wrote:
> On Tue, Jun 30 2026, Wandun Chen wrote:
> 
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> Apply the same non-dumpable reserved memory filtering to RISC-V kdump
>> as was done for arm64. Use of_reserved_mem_kdump_exclude() to drop
>> flagged regions from the elfcorehdr PT_LOAD segments, and
>> of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.
>>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> ---
>>  arch/riscv/kernel/machine_kexec_file.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
>> index 59d4bbc848a8..25359d583bc3 100644
>> --- a/arch/riscv/kernel/machine_kexec_file.c
>> +++ b/arch/riscv/kernel/machine_kexec_file.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/elf.h>
>>  #include <linux/slab.h>
>>  #include <linux/of.h>
>> +#include <linux/of_reserved_mem.h>
>>  #include <linux/libfdt.h>
>>  #include <linux/types.h>
>>  #include <linux/memblock.h>
>> @@ -64,6 +65,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>  
>>  	nr_ranges = 1; /* For exclusion of crashkernel region */
>>  	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
>> +	nr_ranges += of_reserved_mem_kdump_nr_ranges();
>>  
>>  	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
>>  	if (!cmem)
>> @@ -77,6 +79,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>  
>>  	/* Exclude crashkernel region */
>>  	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>> +	if (!ret)
>> +		ret = of_reserved_mem_kdump_exclude(cmem);
>>  	if (!ret)
>>  		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> 
> Nit: can you do the usual pattern of if (err) goto err; instead?
> 
Sure, will fix in the next version.

Best regards,
Wandun

> So this would look like:
> 
> 	/* Exclude crashkernel region */
> 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> 	if (ret)
> 		goto out;
> 
> 	ret = of_reserved_mem_kdump_exclude(cmem);
> 	if (ret)
> 		goto out;
>         
> 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> out:
> 	...
> 
> With this,
> 
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> 

