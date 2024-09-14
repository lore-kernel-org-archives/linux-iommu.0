Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAED539A
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293466; cv=none; b=k3qpHtAdKu1UaqeZYQXg1pQsha5n1yokXaJD8GKp7qzJS75Gvy8SKt0+9g9ATKhiH5eVOZSHKX98cj8IgmbJpRwY8Aakrci8ocrzafiLbMo8MjAnk6uIajhF5X3TRK2LKEUll57h05Pt/rrM1cJmeqg03b5RyEc6jfk6cI3BgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293466; c=relaxed/simple;
	bh=yrxyEG+7h1OUZv+xEB0fzKoqpnFZveTpJbp5Nli51Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9DlvD7DeXV2pfrqYEgXpqiTgRP/E41E1ExTaGFASjwwoIuqwLUavaLnUkpfpQsvm1QErVpDoGJfBgEHjLNRSk+sQcG6oiV66kUEj4NiJJ2Qf2OkhU4w6zbbuUpemGW6sHp1gijhExG/xgcsVynjT+Vhv0hB0BrDayEr6OVks28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L7J2gq5E; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L7J2gq5E"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d13b83511so332449466b.2
        for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726293463; x=1726898263; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj7BI1d/P05L4yR+fUrwV54+pcNt/eQNbd1AyE1f2W0=;
        b=L7J2gq5EwCBNSAliE8pXfjbHFM5ny117SZ0yOcjlIJnuZ17uWkhrtnhQCDKEGzsGml
         ymPvzy+aI33GyEuD60rMzA7muFGOOLsWM/FfmWca41zsPT79hOahSokwpKaalGNH+DLF
         UBvP8ywsldajS7pxovy3KhfcZmYI37TieCzrybnTcdZtuXc9FT7grWV4icEVS9/aK0hJ
         hwIv6nuxDgoCekIYSP8w5nPYZgSduJqlwE2NMgVnv3DPDrz+Tl7rOI4DgVoG/Wz3e/pk
         oajeachnZ46ZCZFG+K2/AeWNu9/JX6nlh3mchuMwoJxILv5eH/BJelsVlhbxaRbdzxhG
         lUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726293463; x=1726898263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj7BI1d/P05L4yR+fUrwV54+pcNt/eQNbd1AyE1f2W0=;
        b=Z5yS5/P10KjNXNX+DtOWECldAcioatOo/uKlReNcuLxFc7Y3A+h8dNCkIgiIrhys/r
         +Gm9pU8/kon1CfGspgLJTWNiZe2zYMkl5+NbCVkYK33cI6eRln0cUiTOnkITnnO0jT42
         z3F/OTGF1R4C7XxmQc/aDKzbblCCpbTVzj6SlJC4LLxR5kZa3/nVUJ0PZW82YjEug3Zs
         cXWZkqW8+sKFSQLZ70WuMeO8iFc6Bq0vSLmFHfzYDYIDwjk0sbGaJAwO5toOC3mZRNDc
         jMPVOoHk3xKNrngA1U4VFvRPb0VVwuXiev9fLAOaA0EoXGpWJlL4ZtwelbhHLPMAVcSE
         I5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCViKYy2SQxduUYiCbdBB1DqKIv4Re26agRDNbz380Pe30PFzm9aqjNUY+pnkAPpmIVh+dvpUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ4foNvfldleFhpnY06pqojhMNEJK4UHeIx2/Qdz38StTH6G1Y
	ol75RkzloNa+QuW6fddKVVZ8igmSdB8yDAjbUeL0aemaMy3zW+juwiVSP+Wh4Fvda+bbIC8z7Vk
	ZGw==
X-Google-Smtp-Source: AGHT+IHQRdOpdMJ4Y1cJj+samNp4BzlrRh+uCRWFfdK6L+8JVEJRsNx51Bj2WAtb1ztXOUZFBjsz3w==
X-Received: by 2002:a17:907:94d4:b0:a90:34e8:780f with SMTP id a640c23a62f3a-a9034e87ae4mr673589866b.63.1726293462430;
        Fri, 13 Sep 2024 22:57:42 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966ccsm37044366b.45.2024.09.13.22.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 22:57:42 -0700 (PDT)
Message-ID: <e5a05e0a-ce58-4779-ae7e-c3803af82d3a@suse.com>
Date: Sat, 14 Sep 2024 07:57:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: add alignment check for dma buffers
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240913145655.10076-1-jgross@suse.com>
 <a0b0dec5-03c1-4b69-aa0e-65771251d859@suse.com>
 <alpine.DEB.2.22.394.2409131728420.1417852@ubuntu-linux-20-04-desktop>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <alpine.DEB.2.22.394.2409131728420.1417852@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.09.2024 02:38, Stefano Stabellini wrote:
> On Fri, 13 Sep 2024, Jan Beulich wrote:
>> On 13.09.2024 16:56, Juergen Gross wrote:
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>>>  {
>>>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>>>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
>>> +	unsigned int order = get_order(size);
>>>  
>>>  	next_bfn = pfn_to_bfn(xen_pfn);
>>>  
>>> +	/* If buffer is physically aligned, ensure DMA alignment. */
>>> +	if (IS_ALIGNED(p, 1UL << (order + PAGE_SHIFT)) &&
>>
>> Why this check? xen_swiotlb_alloc_coherent() guarantees it, while
>> xen_swiotlb_free_coherent() only checks properties of the original
>> allocation. And for xen_swiotlb_map_page() this looks actively
>> wrong to me, in case that function was called with offset non-zero.
> 
> I understand xen_swiotlb_alloc_coherent and xen_swiotlb_free_coherent
> not needing the check, but I think we might need the check for
> xen_swiotlb_map_page. At that point, I would keep the check for all
> callers.

Whereas I would be inclined to suggest to put it in the one place it's
needed, not the least to avoid the abuse of the function (going just
from its name).

> Unless there is another way to detect whether the mapping needs
> alignment specifically for map_page?
> 
> For the offset, in theory if the device needs alignment, the offset
> should be zero? If the offset is not zero, then there should be no
> alignment requirement. The way Juergen wrote the check, we would take
> the fast path if offset != zero, which makes sense to me.

Hmm, right.

Jan
