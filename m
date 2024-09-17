Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5236101EE
	for <iommu@lists.linux.dev>; Tue, 17 Sep 2024 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575955; cv=none; b=VbuoIcvt7rS0Qe3Dp1bSN9iQ9/WyOAZhd01Vrpr+6nba3ywpSGxbNteFxR2uKX61371qePYqHyxvlhhLw3U6whfg8EZ129rtLupqrKV1Onrz0foLxLiHA7EFG4yisfQ6KubfTn/Vk2eM02pIBZTBGDMlm/ffVVf30POu/rA67Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575955; c=relaxed/simple;
	bh=yY2dxR8BSG1V8OGFHIZn5B7trO9Yq2NU5Brjb66rwOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOFUitaSN5W1312+vcfX3RZXgHtyrY/p6ibfBya6Bpe7LNUKY35PkEy2YaOf7kv0/8k54hLQcPEaamkEZrVvUx5DcMIQiZS9SkarnplF02F9gPZcILKvqNquBHPDENAzR90b5mtw9YWQ8iqq0oR/iHwosr+tJ6ceCwYL9NkZmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGVidGF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGVidGF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726575952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g7RW432WcKwi2uZ8Cpks6dREw3apdK08/a3VMqbNmew=;
	b=AGVidGF4RgDQQthk6LD0iafYyXAcgA/Aisw20qu7nTTlb3+H6S4Zk0ESI51sFhz8wUhVTR
	P6PfnsgwPCG73HYfukGr+M7B3ja6pfziN3/1fnteIbD+S5z1udj2wUlPnXSO6Nc4fJHMO7
	zw6GwHoSAIJa1x3oqlckD0M5pMm1C5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-bEV_ZSg0Oyy-QYaNG1iVmQ-1; Tue, 17 Sep 2024 08:25:51 -0400
X-MC-Unique: bEV_ZSg0Oyy-QYaNG1iVmQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3756212a589so2949049f8f.2
        for <iommu@lists.linux.dev>; Tue, 17 Sep 2024 05:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726575950; x=1727180750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7RW432WcKwi2uZ8Cpks6dREw3apdK08/a3VMqbNmew=;
        b=u19wbG1JEbdUFZe9z2CSrs8OzAEyAqVPnlNumYVMwy9LKhnu7I17I8YCk2x7PYiXix
         iAjAQJAAmpRfEEmv2NktBGkfQ/5kehGmlRxgHmKXa9CZ+4jZZEhq4pSxOb0o5LV0r/P6
         z/wL1KbGEbxcKfCAqTnWhgkU7jNC9IulFGUtIn1uQnpFssbeG0rTrM5RGUGvGs5/O4ot
         UfgoSpLrNPKYSccbiUgwjH1YSC02d9IS7skY3g1RSDqXUUiaRWl5oEyeKzwN0P7P+l+p
         53QCJ7HE3jLVPq0fBMiaRrPsU5VARsx4L5Wn3Gfe7Lxx4wwbtg4N5z1zuMkOMNStr4Si
         x/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX7xKrQjW0ddqVsPXpvH0Wc8d9AGAWihrPoKBGpfhFWBjfEME48rWtA0168FKrOaCBe/Bv8Tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRd/o5l7ZN3x5hiNwoYD0ECuG1FgBmSiN8o37aLq4qztRsf7/F
	CFDAsQo7jK4fsXAnWwW7SAiR0NsKfLbvgcBFyLIeojgfITpIW9YuDYOt/Er7gTkucNbOZT0bdIF
	WmQDQjfzBcjKzSAhoZntLpRtrj2Q+SqC8DtAyvNhdGNLJXweLOW4y
X-Received: by 2002:a05:6000:b82:b0:377:4aa2:3af8 with SMTP id ffacd0b85a97d-378d61e251dmr13600291f8f.13.1726575950110;
        Tue, 17 Sep 2024 05:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5kMHOcK4YO6Cph8QhPbbjh+3Uie5RgEI+EFZ7giOEVJBPnKFUDpsQwzbqwQH1UTnAFfpq9g==
X-Received: by 2002:a05:6000:b82:b0:377:4aa2:3af8 with SMTP id ffacd0b85a97d-378d61e251dmr13600273f8f.13.1726575949624;
        Tue, 17 Sep 2024 05:25:49 -0700 (PDT)
Received: from [192.168.55.136] (078132105044.public.t-mobile.at. [78.132.105.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4cf7sm9393827f8f.11.2024.09.17.05.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 05:25:49 -0700 (PDT)
Message-ID: <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
Date: Tue, 17 Sep 2024 14:25:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
To: Steven Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.09.24 15:19, Steven Sistare wrote:
> cc'ing linux-mm for review of this one patch of the series.
> 
> This proposes a new KAPI function repin_folio_unhugely(), for use in this
> patch of the iommu_ioas_map_file series:
> 
>     iommufd: IOMMU_IOAS_MAP_FILE implementation
>     https://lore.kernel.org/linux-iommu/1726319158-283074-7-git-send-email-steven.sistare@oracle.com
> 
> - Steve
> 
> On 9/14/2024 9:05 AM, Steve Sistare wrote:
>> Export a function that repins a huge-page folio at small-page granularity.
>> This allows any range of small pages within the folio to be unpinned later.
>> For example, pages pinned via memfd_pin_folios and modified by
>> repin_folio_unhugely could be unpinned via unpin_user_page(s).
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>    include/linux/mm.h |  1 +
>>    mm/gup.c           | 18 ++++++++++++++++++
>>    2 files changed, 19 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1470736..ba8344f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2514,6 +2514,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>>    long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>    		      struct folio **folios, unsigned int max_folios,
>>    		      pgoff_t *offset);
>> +void repin_folio_unhugely(struct folio *folio, unsigned long npin);
>>    
>>    int get_user_pages_fast(unsigned long start, int nr_pages,
>>    			unsigned int gup_flags, struct page **pages);
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 947881ff..f8f3f2a 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>    	return ret;
>>    }
>>    EXPORT_SYMBOL_GPL(memfd_pin_folios);
>> +
>> +/**
>> + * repin_folio_unhugely() - repin a folio at small page granularity
>> + * @folio: the folio to repin
>> + * @npin:  the number of pages pinned in the folio
>> + *
>> + * Given a huge page folio that is already pinned, and the number of small

s/huge page folio/large folio/

>> + * pages that are pinned in it, adjust the pincount to reflect small-page
>> + * granularity.  Each small page can later be unpinned individually.
>> + */
>> +void repin_folio_unhugely(struct folio *folio, unsigned long npin)
>> +{
>> +	if (!folio_test_large(folio) || is_huge_zero_folio(folio) || npin == 1)

Why not the huge zero folio? That looks very odd here.

>> +		return;
>> +	atomic_add(npin - 1, &folio->_refcount);
>> +	atomic_add(npin - 1, &folio->_pincount);
>> +}
>> +EXPORT_SYMBOL_GPL(repin_folio_unhugely);

Can we ... find a better name? For example, it's "large" folio not "huge"...

And repin is really misleading. We are simply adding more pins to an 
already pinned one ...

-- 
Cheers,

David / dhildenb

