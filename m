Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F3347B4
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350722; cv=none; b=lcT/zPBDfJ5JL4ZAkxHaWUB4p9oemn6ps4l4MIIx9kexX6Pk5owJS+5grcDB56bsM/X4lbQgT50LITT8VXzXsFwOS1OVRRtF/wi0eQU+CoKzXjZ4pviDhs1vACNmWiXNK7h8igmHHjX9WmPiKqy6RcodPGTYkSzp2SVjc9j2XJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350722; c=relaxed/simple;
	bh=KO247AiQV8c2pseFxgnYXGMOhGeTSBAsbO133igegH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN5JZ2N+5fB9jUb1yLgwN6VD9IBZd2kx2nd1OHReu8UwkWrQuXxxznLfr7SZFG+q6OzVjmzkQvKLDDGwlHxXBN0MC5M++LTujE5GOI/cxWf2Vnne3WEbdsNWwmRuJij5hIpPvr7+++HtRDozCOFnS9TnmXJ16pQbqmQuCoM9g0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlD8TrGd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlD8TrGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727350719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pTjCahG2AyWm4ZcFyWyzFLJtSNVwihw07EnaJAUIhZk=;
	b=QlD8TrGdafmnLk0W46UGFwSNX6rXE1xRI/Nc2IO2/v1FG8sdUCxh8Zbdr4fFNOjj+6HyL9
	DNQX8RxVvkCQMIrHWHinFR0mZFh/QW9e97lgWe6KTGtV+tzsjOqMGFfSa6Tmap3xguoTVL
	AmJHgpdsSerEO+5juOnQ2cIkke8gVjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-zteU9SkVPX6LiFLTBmFH_w-1; Thu, 26 Sep 2024 07:38:37 -0400
X-MC-Unique: zteU9SkVPX6LiFLTBmFH_w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb857fc7dso6257075e9.0
        for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 04:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350716; x=1727955516;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTjCahG2AyWm4ZcFyWyzFLJtSNVwihw07EnaJAUIhZk=;
        b=VvjDWbPq2SizC0F6oakPp4yEP9vNl/5JLS6OsuQHNuYX6I4O3gsaJ9ubED2ogk/4vs
         BCKUMIPb3rGZe0jaZXUh/9zu5BPu5e27Ax3pWYAyDZRBqh/zOqNlI7BDSHZKL7oJw8mR
         D+prKKnjwdxb1STE/yDdKmmiczEOUpSNJc/Q9JIWomFiY5WkNpseeEUCdWLBN5Lieeel
         HB9Dnr8Qft8J2C6DR82969xRcuabongwGDfiPqImnTol5sakY/sos97Sl/+mJcZOW8a+
         xLWiYjWDvIIP99JWSVGQpppJhslBPXu/z3j6OnynPb3Xl9FiB+jvDB3Fxcx7MYPlPePk
         pK1g==
X-Forwarded-Encrypted: i=1; AJvYcCVf3/k3me2sLr+p9h1/Tq+NqzZvfthoItU7InqNViFq1M1Cs1y5kff8DH7r2vXeJAw1PVYf0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnohDsFGBzL6sUqofNr2bMQv0lgnrxhgs70y6veVfUUPcQAQUJ
	XsgXCTd6XKaUxwGkDYCCI9OGxnMdjUAgBSC0sU/gw09ceFavQm8hLyK3HDJlEl9HzkIVJieNuya
	9Dq4SQXKeBMj/ZdJwWBAxuqKJtO+GT9GB0PKUT6BR0ylzn0pIDEnX
X-Received: by 2002:a05:600c:1c82:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-42e9610de39mr46959965e9.14.1727350716518;
        Thu, 26 Sep 2024 04:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx4Fh9q5EF8rlWaSwvCVtHUGDAyzV3eyPXxM4ooR4qW/NVfLGxfKRAe29C3CFlaSZSO9L1/g==
X-Received: by 2002:a05:600c:1c82:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-42e9610de39mr46959725e9.14.1727350716109;
        Thu, 26 Sep 2024 04:38:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902560cfsm77226145e9.0.2024.09.26.04.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 04:38:35 -0700 (PDT)
Message-ID: <0e8a9f2f-5c22-46a9-929a-f986c3f5e476@redhat.com>
Date: Thu, 26 Sep 2024 13:38:34 +0200
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
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
 <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
 <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
 <ca95e882-46a5-4510-a0a4-2c12a01b1f9f@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ca95e882-46a5-4510-a0a4-2c12a01b1f9f@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> reference fiddling is skipped.
>>
>> Please point me in mm/gup.c at that handling.
>>
>> IIRC is_zero_folio() does *not* include the huge zero page.
>>
>> Yes, we should likely be special-casing the huge zeropage in mm/gup.c, but it's not that easy because PINs can outlive MMs ... so *not* grabbing a reference could currently be harmful.
>>
>> But that has do be changed consistently, not with doing things here different compared to other gup.c functions.
> 

Sorry for the late reply, conferences ...

> folios_put() -> folios_put_refs() -> is_huge_zero_folio()

unpin_user_folio() -> gup_put_folio() will do

1) atomic_sub(refs, &folio->_pincount);
2) folio_put_refs(folio, refs);


What you cite above is for releasing huge folios that are mapped into 
user space.

> 
> I will run some tests with huge zero folios to verify the ref and pin
> counts behave correctly.

Whatever is pinned is supposed to be released via the unpin interface. 
We have to be consistent there, so this patch would be wrong (likely you 
never get the huge zero folio).

> 
>>>>>> +        return;
>>>>>> +    atomic_add(npin - 1, &folio->_refcount);
>>>>>> +    atomic_add(npin - 1, &folio->_pincount);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(repin_folio_unhugely);
>>>>
>>>> Can we ... find a better name? For example, it's "large" folio not "huge"...
>>>>
>>>> And repin is really misleading. We are simply adding more pins to an already pinned one ...
>>>
>>> Jason suggests a better name in the other thread.
>>
>> I would prefer something that simply adds more pins to an already pinned folio. Much easier to get.
> 
> How about folio_add_pins()?

Something like that, but more importantly, via which interface did we 
obtain the pins? That will make a difference and should be documented.

-- 
Cheers,

David / dhildenb

