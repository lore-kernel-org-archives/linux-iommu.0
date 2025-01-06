Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2A3597B
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185660; cv=none; b=mY74l0GXe2cwZo/ApTp20m2rD7aKDlHkZseCTbwAdD/iXlVALyrddzXxcwE+v/9wScSDEgul8dcTke2VGMp+w7kbBc3i4+Y1ddJrHxsQKH/q7f7TiRZRc/oB3y3gr0bbeloeUcx6m+mbsNTciN631k/aV//Z24X4DJ/61+hMk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185660; c=relaxed/simple;
	bh=Irf7TksMonOv1Z7QByLxUqPJAN1fAil/ez87c0wzuwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5stiZjDsVpsdimnz382xCDwSq3Ab3zPjyRbKLsSCDKdoaO2kuY4HN3751GIcsWN/wJJ7bzSw0z8Y2hmNWYpI4pQaDpZbOMZrWw4iJZ//t/JuyMHA7I0n+IIQWw/qtiFK5Q3yGRW2ya/SO7YyTOvkjF29OYAcAtozAthpXd9Sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UM7L/pCo; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UM7L/pCo"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844ef6275c5so509238339f.0
        for <iommu@lists.linux.dev>; Mon, 06 Jan 2025 09:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736185657; x=1736790457; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+OIAvhGznZ4LhzgR7qEdmgYN2V+vMWzwyMlZdaLlu8=;
        b=UM7L/pCo02qsZrNBdmpORkVsRWPdPMdj5nAneZCy/YLFTVBYg6ZmXCcB9CKm0sNYXF
         qWMH78pSQEy9jgt0hA+lqWY+vFzLBbEDXFoOQuLYv/GsfoN2yLy50rv++14zTBXOGsll
         v4lE8mdPB3x6FrL4kLRQqp8g/rrF90ZYRLeCAhz0a/CctSuIE9+nuGaUqPh9dVXmgnhW
         k4hewYw2HjhxiJ5qu9s9pkIuWj6Az61eNSUD1a5ZZ7QT+Db1QpN0G3NLTUfZE9iOkc7t
         SGIhYT/maFzH8xb6oLlhWIMh+OlXPGIIWHDwDLh9cFmB3EtddLKH4voYWxdtsiVssFUM
         knwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185657; x=1736790457;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+OIAvhGznZ4LhzgR7qEdmgYN2V+vMWzwyMlZdaLlu8=;
        b=o9BOnCWR8rhq+IA1h0FWnIPryawq17eRsbsRYoHKLYQVzsHb17HfX2x9PGdFVB4ZKq
         nR+PRV4pQpG8dwRjzAI6JCZAqxeFQ5fK1RG4GO+4H5OTFRQv9Uv//8/tkFvBKSCsfxKd
         cRBeL1rVL3pmao8CpQbgG0oDapUpM8SntkdkNqeaK4EHcSiaTcnpvLTF3KxfmLnMYzyu
         Cv5QgO5ET2Fc2tt8IADVRmuYGvTaHtXJO3iR8Lo4dtEw6S2rnjJXWxEoADBIysKIsLFk
         BZg3CIv9qRnptBe0sa8THM039ufrjOR80tv+58VLrByOwsfmWrRUSyWgmvdmAFrU8Tm0
         4zeA==
X-Forwarded-Encrypted: i=1; AJvYcCXLf2OmETBZBUa99kNdMaJrfBTfjZ95yQV2dA/WE0/FronuUkQhcEWBUq32jymRT+AfW+YI3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6BRduDLOPY2D1r+5t4/3pUCwutPcjHr9qHIbgzcqG7X+RCoj0
	9mDOTze5Qpg5fVmc1RuB4JpQA/v4f7wmKv+LcUF45yxqvCL+6fcMgTwUfqfefck=
X-Gm-Gg: ASbGncsKnWiUCS32aMYiYBLs0eeptalqO8XItnktLPiIAykqxc9ltBRFtvBjMf1sWg4
	QKfQIJz1Y+WHIo7xc0DFJAS1gBdEZxQqpYHamx3NBWZCL/ZD3tmTip1jrRiDxUdn3dqCWuPNiWn
	FESQeDMr3zHya04XlY1XHT0lX/NPFYxnHYkJnqU0OnHgtB+uXwg69+PzbUorVQts+0tTEWEPvce
	pOhoH1P63Lh3eQ6VhjBAFafn+NVT3+gzlEPT0X4IQoxCVpEZUiNQ/g3SvLN1a2xTEL/Eleax9RI
	O4J9
X-Google-Smtp-Source: AGHT+IF5QHH5dwNqH02ne6UcU8UgGBcFcqL5QVA97gSzeddMqTHh+4YCSY3Twcuawu3Fpq8gAFo5PQ==
X-Received: by 2002:a05:6e02:216b:b0:3a7:a553:72f with SMTP id e9e14a558f8ab-3c2d51501d1mr460047345ab.18.1736185657580;
        Mon, 06 Jan 2025 09:47:37 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.9])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c22176fsm9113793173.153.2025.01.06.09.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 09:47:37 -0800 (PST)
Message-ID: <92eb2691-3b40-4549-83cf-fbdd0e98bf63@sifive.com>
Date: Mon, 6 Jan 2025 11:47:35 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
To: Alexandre Ghiti <alex@ghiti.fr>, guoren@kernel.org, tjeznach@rivosinc.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, baolu.lu@linux.intel.com,
 zong.li@sifive.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20250103024616.3359159-1-guoren@kernel.org>
 <a110be11-923e-4943-8741-43b5513c9691@ghiti.fr>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <a110be11-923e-4943-8741-43b5513c9691@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2025-01-06 4:31 AM, Alexandre Ghiti wrote:
> On 03/01/2025 03:46, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> When __BITS_PER_LONG == 32, size_t is defined as unsigned int rather
> 
> 
> RISCV_IOMMU depends on 64BIT so how do you get __BITS_PER_LONG == 32?

I am guessing this is from some downstream effort to compile a 64-bit kernel
with an ILP32 ABI. However unsupported that may be, size_t is the nominal type
used in both riscv_iommu_pte_fetch() and above in iommu_iotlb_gather_add_page(),
so the change does make sense.

Regards,
Samuel

>> than unsigned long. Therefore, we should use size_t to avoid
>> type-checking errors.
>>
>> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
>> ---
>>   drivers/iommu/riscv/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index 8a05def774bd..38d381164385 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1270,7 +1270,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct
>> iommu_domain *iommu_domain,
>>                           dma_addr_t iova)
>>   {
>>       struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
>> -    unsigned long pte_size;
>> +    size_t pte_size;
>>       unsigned long *ptr;
>>         ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);

