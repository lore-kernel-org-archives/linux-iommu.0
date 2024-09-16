Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56B282FD
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470100; cv=none; b=lle5j+jphcsLtn4OlIYHGMC4AxMvY4Fedg+UyWJIi20JjK8zxiCOsyPH4tskg1EQi6qX3szivvcSL38jU/Yr1fFhGYlt5CSR0Vhs9oRM23/0HoMXMizBifzs/HRgfmlLo+ZTHxY9ssAxCwww8GTBPAhN7qY21fbiCk+2yRRbWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470100; c=relaxed/simple;
	bh=HAIqkvoRzle5vIm/45KlUqIQro3cqaxEZuIn2gdLHDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzezqXI/jqWy5p3Bm0mieIyopdnuP0yj7wouVxYlPUwduPrbDVA/Jd+DhmyZpZ5OWI+QJV/Aes+BovQbomR6w3A9I0rJDyP6UxXfpNs95vGLNVvZGGaw3uhrr4Y+e+gOHyBMNN84iB/m3REYAiPJPBQynSN0Djk0D59gzYHoaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JioU7qrk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JioU7qrk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so489770866b.0
        for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726470097; x=1727074897; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFjCBoKriiG3bsVxWjcbX/7DjM3PloTt4D8ntNKj6ak=;
        b=JioU7qrkDjCeNsQtUSloJSqTgw6fyo9Y2OpFJOQ3+vnQV9SRYwuKPfs90dEJz4mslz
         AFCHRwKvS/Mg0rXjLDINhe4kj74UqoExC3NXS7rk4s5RszrpVB/LXxcIPng6oFEQglsH
         6mQVfDNFfpaq0zDZlaHUhrpIdUWyEZ2s0sZxmovUfzLr8Fcay4om+x7I+rsZYHDhztOr
         bVEJaAW3qDvf954y7/0qA4dglGsTTDt6dIaL3OCpUxcE5k3hIM3/8eA8N9VyIsf4K3j3
         AXm0Q5aOK+koDOdRI0K5A0qAao2FUuwlF/iC3cYpyWSvpM+4JNKz4DAPqddbDZdWPE+H
         x+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726470097; x=1727074897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFjCBoKriiG3bsVxWjcbX/7DjM3PloTt4D8ntNKj6ak=;
        b=nXv7bQ9Bw2JfCwKrFgztjDtH78xxm5wxrT1cGTk1bheAbToXSfqxC14iKpBE+aLdN8
         Ax7GgoxSCY2Hx8vOCntu3Eg1iFqrBUcM59h2Hd5hDa+iYIqOIdUccP0mOzMOS4A/wMRY
         wQq/Uq7UFOi8yByujrWfp+4yAh4IwkGeEoaj3bfCzklzDUmYzJOW7ibwGVpedtr6cpnk
         O45qDFxrm2rK/jg6FSp6bklExCyPHUtRyvxWz1545fqpjTxDueO6NHjh2KU834HHYz8Y
         8i9Kit85AAoB0mTbNHVi7WzrT8CG0kGSl4nHKzVx+gUsgHKB+MvnRAGb9m0elj3jYU2Z
         ly8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4TQTmxsDtuWYamofcKXugcc35ti62Dc0aKnSnpxoTg1OUa1409487fvmFhdBnSZjMlOxKpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyud6Usj0cQtbZOrgdToP/QeSGhWLCKr1h6vazHra76aMMSGvS2
	EI/GEsnS13IPEkq9vUilA0am7CNJJKShiYMssuRyAGL6JOO9m7HPIDA7K0W3Og==
X-Google-Smtp-Source: AGHT+IG2H8XqbpT8Q3ZMJfToOCB+0WLbtHpvn+Re7pOlLnWqXMfVhKg8+cfsUhl+CFlcLBPYX2i4zg==
X-Received: by 2002:a17:907:e26a:b0:a8d:6329:d8cc with SMTP id a640c23a62f3a-a902943b52fmr1392161066b.25.1726470096749;
        Mon, 16 Sep 2024 00:01:36 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061321568sm268978266b.191.2024.09.16.00.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:01:36 -0700 (PDT)
Message-ID: <c3a52494-7ced-42ec-8839-11bd18a7c3d9@suse.com>
Date: Mon, 16 Sep 2024 09:01:35 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
 <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
 <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.09.2024 08:59, Juergen Gross wrote:
> On 16.09.24 08:56, Juergen Gross wrote:
>> On 16.09.24 08:50, Jan Beulich wrote:
>>> On 16.09.2024 08:47, Juergen Gross wrote:
>>>> --- a/drivers/xen/swiotlb-xen.c
>>>> +++ b/drivers/xen/swiotlb-xen.c
>>>> @@ -78,9 +78,15 @@ static inline int 
>>>> range_straddles_page_boundary(phys_addr_t p, size_t size)
>>>>   {
>>>>       unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>>>>       unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
>>>> +    phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>>>>       next_bfn = pfn_to_bfn(xen_pfn);
>>>> +    /* If buffer is physically aligned, ensure DMA alignment. */
>>>> +    if (IS_ALIGNED(p, algn) &&
>>>> +        !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
>>>
>>> And this shift is not at risk of losing bits on Arm LPAE?
>>
>> For alignment check this just doesn't matter (assuming XEN_PAGE_SIZE is
>> smaller than 4G).
> 
> Wait, that was nonsense.

I think it was quite reasonable, as long as also algn (and hence size)
isn't absurdly large.

Jan
