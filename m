Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D322067
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073219; cv=none; b=rOSsTMzfO3p/5Uo3t6BdoBY2mt0jo+WnAL0DWI1xA7tXVWJwZhIUT8pLQsEM2ZG2XS7gf5m1WwYA8jVqPHgp2K+GjQGWGG9eSRINdMjfnPQ5Xi1irKWKXY8xOgcFIDaYQxj9DGRQP8jWPh3fy+MyVpJjZpzC7l97qYTQKAeLbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073219; c=relaxed/simple;
	bh=Y36gZNAGtZ6EswUYrjmdXaKuVNGvLPZ+BaG/Kte/lsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC97khBaXqXFMbkj07P+ECnHJX41oHn8Kc//OV4jpumDW6IV4ajJ1OMIHnhpc/xJuy4wq0XdxMaOJk4X7D1kt5k1+B8GVkr8LYxfVYm8G+kJT+/CbqKLqVAgOj7TZtfRErsTVo295et6vRbfI+BwRo7hQxTyx/3uGbCxkABqsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjOvPOfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjOvPOfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728073216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fOR382Uq6BdZtcEM+a/S6p3TMaL7eIlFaKTePlFuJkQ=;
	b=BjOvPOfeSSqJmDIpWM/sXgPsps81SHifHXkBkDsvdHeNyls905F7G+XCciB1iTm2xo2bYQ
	LEhUpMf71t7YgrD6+6JKA8iMMG0g9dtam3dPJBUHolbu7gtQJZBKLp/cZcpIvxji/p8pAk
	bqjnw2OBy6ye9OTgvHPjDtC2yWqvtn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-FDvUl92qPVmnEsWPZ0nq6A-1; Fri, 04 Oct 2024 16:20:15 -0400
X-MC-Unique: FDvUl92qPVmnEsWPZ0nq6A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cdeac2da6so18933085e9.2
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 13:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728073214; x=1728678014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOR382Uq6BdZtcEM+a/S6p3TMaL7eIlFaKTePlFuJkQ=;
        b=uP9q6pmBNUJwF7EBAUxvpS69xb88MTmdzOfYBSdan2OkZnysOIOsrzhTj11cCWJ9gp
         /iOfpwX9OKhVPHQK8lmTcJLlvTrFLzGnOIhc9J2K8ZWS8ay+bvqm2KQafVomYdjIQndW
         2ciO0jXWTX0mD/uh0yOICYtFi8yoJZM6xuN+dSHRhS0ZdI3RI5yNPGWDNmvMHU0vVFo7
         cL/s3hTIzUNIh5dqDT9XID9E+S8c5kGBPBHaHVp7GK6KHRTYUvog0PV1XNTvzRT5yaeX
         NcS0dr2zDURQ+2yvPlJKSAGy0TwSY9VH/e/QArHBWnuhIHTDGUsPfQPs9gN9boeM8WGZ
         Da4g==
X-Forwarded-Encrypted: i=1; AJvYcCVpTO1svWw/fRj6OAVMdtPTQkMaa2gadsckjK+jzCH7ybHtjrFwcB40CA0JFZjAZeQVFNmDLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFYWSez9mBWGUt6mq6e4qWhiSTBtUTY8IRpMj+jd+K+0gso6sF
	e0Iw8zTS8wemCiY1tudBEI7SlsmzCBq5JFuUNMbJ4UkxUgZl2lS+q9/+t15MBP2P2sCUlH5sYi/
	9BQe0uPPmganUpepq08UUFXm5mSB/ljmNdTFtYTU8AVXHY1tjilZI
X-Received: by 2002:a05:600c:46c6:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42f85ab7cbbmr32880145e9.16.1728073213926;
        Fri, 04 Oct 2024 13:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKY01Jqf5vMSvhz0hWepxFWHrjCcGKicALLDDeFZ+aMFgp8pKRXNH5dJg+4oKHY1ezYNFQ5Q==
X-Received: by 2002:a05:600c:46c6:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42f85ab7cbbmr32880035e9.16.1728073213560;
        Fri, 04 Oct 2024 13:20:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:d00:a1ab:bff4:268f:d7c5? (p200300cbc7140d00a1abbff4268fd7c5.dip0.t-ipconnect.de. [2003:cb:c714:d00:a1ab:bff4:268f:d7c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec61ecsm5178755e9.29.2024.10.04.13.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 13:20:13 -0700 (PDT)
Message-ID: <804766d3-da43-4860-beeb-8e9b9ffe81fd@redhat.com>
Date: Fri, 4 Oct 2024 22:20:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/9] mm/gup: folio_add_pins
To: Steven Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-2-git-send-email-steven.sistare@oracle.com>
 <53b4b083-f238-432f-a59c-61d20d03511f@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <53b4b083-f238-432f-a59c-61d20d03511f@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.10.24 20:52, Steven Sistare wrote:
> cc mm folks.
> 
> On 10/4/2024 2:48 PM, Steve Sistare wrote:
>> Export a function that adds pins to an already-pinned huge-page folio.
>> This allows any range of small pages within the folio to be unpinned later.
>> For example, pages pinned via memfd_pin_folios and modified by
>> folio_add_pins could be unpinned via unpin_user_page(s).
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>    include/linux/mm.h |  1 +
>>    mm/gup.c           | 24 ++++++++++++++++++++++++
>>    2 files changed, 25 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 13bff7c..70d5293 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2521,6 +2521,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>>    long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>    		      struct folio **folios, unsigned int max_folios,
>>    		      pgoff_t *offset);
>> +int folio_add_pins(struct folio *folio, unsigned int pins);
>>    
>>    int get_user_pages_fast(unsigned long start, int nr_pages,
>>    			unsigned int gup_flags, struct page **pages);
>> diff --git a/mm/gup.c b/mm/gup.c
>> index fcd602b..11c5f27 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -3733,3 +3733,27 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>>    	return ret;
>>    }
>>    EXPORT_SYMBOL_GPL(memfd_pin_folios);
>> +
>> +/**
>> + * folio_add_pins() - add pins to an already-pinned folio
>> + * @folio: the folio to add more pins to
>> + * @pins: number of pins to add
>> + *
>> + * Try to add more pins to an already-pinned folio. The semantics
>> + * of the pin (e.g., FOLL_WRITE) follow any existing pin and cannot
>> + * be changed.
>> + *
>> + * This function is helpful when having obtained a pin on a large folio
>> + * using memfd_pin_folios(), but wanting to logically unpin parts
>> + * (e.g., individual pages) of the folio later, for example, using
>> + * unpin_user_page_range_dirty_lock().
>> + *
>> + * This is not the right interface to initially pin a folio.
>> + */
>> +int folio_add_pins(struct folio *folio, unsigned int pins)
>> +{
>> +	VM_WARN_ON_ONCE(!folio_maybe_dma_pinned(folio));
>> +
>> +	return try_grab_folio(folio, pins, FOLL_PIN);
>> +}
>> +EXPORT_SYMBOL_GPL(folio_add_pins);
> 


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

