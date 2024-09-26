Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B717753
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355496; cv=none; b=MYUxd3UqdPGcORW7AxKtfNCYlqlaT88z9jgaOReoIUEtkPUrc7XtKTgu4l5OKhNAISwjdSanahD94TYj8bicyhaompw7umnReSweooY/ljDwn/Mf7QHkNU9To6PawdeDQZT/d71ev1bMGyPOb/nDd4KQCOeS0NMgDuJ1vSOZO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355496; c=relaxed/simple;
	bh=wK/SGpUXU+7mz8rDobxIRw/i6TeahI7B2kdiEvCA6qs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UkY/xYMWNo6kHXK3aCNzrmH0hhfGsucFwjOJmk1GcVocOzEv1EzRL5CHuNXLJjeEx84TGG3u303WqxqA36Iw7lYw9lUtVhjiUZimB+nA8+vWnqdDxUa+KqdTienWZe17zKT6tIdO6JyvZ0ZsafE4bukfGgzr2ECyszgnYkAruP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POLFBV+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POLFBV+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727355493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dBhH7BEffqYew0a0qy+WrB9ksqzmVcoADZs7pD+b9rc=;
	b=POLFBV+umWw/lJ+Rq27uhQk6uGUCoI7A+XAOb0ny/WW+1n7rrwjI5yUGBP9+C49u7oOS2b
	vIGyhTDnmI4SPHMjRql2oTmlDmnTZ0a14v9UE/mGTKD8oUGhlESZEkGTQeB3AovNPuZ+7X
	bmK9O+gPuxJsb9uTe2xG0dOjR3A6++w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-TeugIJ-UNiOaBcXNP6Ueog-1; Thu, 26 Sep 2024 08:58:12 -0400
X-MC-Unique: TeugIJ-UNiOaBcXNP6Ueog-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3780c8d689bso418267f8f.2
        for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 05:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355491; x=1727960291;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBhH7BEffqYew0a0qy+WrB9ksqzmVcoADZs7pD+b9rc=;
        b=K1AAJX7PnroIbDHaUwTnlMsCEqWnRh4LRIQTRi7FpDX3F0k7n/YHi1JCdaQk5vDuYf
         vSabXkWKSvIxqsXgi4K/CGZ4SEBKgmPZl/t5qVZlFprSBFIg0pGbOgypvYPIH7oHTg86
         SkDBiSzwANkpvqlLwOcF5r+r49Q+Kvqv5SswfS4oVaKkTK/q1Qb6EiYco8jyHeG/wTk3
         yD4GFVhAADjqTqWFUjHpZOqDCndR4TPkUnDZcOoh0DkMvKuu4JD7Lijjfv/eaLJqoMbD
         NJcYfI2HUWB3wX5vHQu8kaCxUzaX2rJUUKENrv5zItdH4Mzpdbm3ByaugI1/hNGM89+A
         KcdA==
X-Forwarded-Encrypted: i=1; AJvYcCU2xVPjM/kyGMRhgWZtfKkW+rQQSMEuX8UJKeyw4STRQTef271ThzlBn27OdKL/QEPGEevkbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3frb0PpGjQ+1dt6jlljrs3eO/GKIgP7mwFcl9DyqqJXGNAiTp
	0dcBvbpTd1qP5MoxJ66e61pgUL/0i9CJMm9jYAywm/zD0OWJx+enMArQDyPjQ2Mh5DbFXvn8jrP
	VSJdsd8HkVhtGh6MgUuuuPJHbLvminZ/HyumaojxpyF2zCoXmveKa
X-Received: by 2002:a5d:5e04:0:b0:37c:c5da:eaf7 with SMTP id ffacd0b85a97d-37cc5daeb42mr3185988f8f.31.1727355491317;
        Thu, 26 Sep 2024 05:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbdUKM1K/LwWJ8k5Jj9ZXE4ZcT9C6+A5fFifjMRdgk2Ha9BYREXpX43Akhn0JVShvkZBDlgw==
X-Received: by 2002:a5d:5e04:0:b0:37c:c5da:eaf7 with SMTP id ffacd0b85a97d-37cc5daeb42mr3185971f8f.31.1727355490871;
        Thu, 26 Sep 2024 05:58:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1ea2sm6455232f8f.37.2024.09.26.05.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 05:58:10 -0700 (PDT)
Message-ID: <f3f7d803-92af-4e22-afca-cb91f402a846@redhat.com>
Date: Thu, 26 Sep 2024 14:58:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
From: David Hildenbrand <david@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
 <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
 <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
 <Zu14fVDpw1RWYevL@nvidia.com>
 <27f8ff84-76cf-40ee-b391-e226218e5600@redhat.com>
 <20240926114000.GW9417@nvidia.com>
 <950cf384-03f4-466a-ac10-61c02dd2dc48@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <950cf384-03f4-466a-ac10-61c02dd2dc48@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.24 14:57, David Hildenbrand wrote:
> On 26.09.24 13:40, Jason Gunthorpe wrote:
>> On Thu, Sep 26, 2024 at 01:32:09PM +0200, David Hildenbrand wrote:
>>> On 20.09.24 15:28, Jason Gunthorpe wrote:
>>>> On Thu, Sep 19, 2024 at 10:11:38AM +0200, David Hildenbrand wrote:
>>>>
>>>>>>> And repin is really misleading. We are simply adding more pins to an already pinned one ...
>>>>>>
>>>>>> Jason suggests a better name in the other thread.
>>>>>
>>>>> I would prefer something that simply adds more pins to an already pinned
>>>>> folio. Much easier to get.
>>>>
>>>> Yes, but also nobody should ever want to do that operation, it should
>>>> always be part of some kind of "splitting" sort of behavior..
>>>
>>> I remember patches from Dave Howells that needed that for O_DIRECT handling.
>>> Never say never ;)
>>
>> Wouldn't O_DIRECT be the same splitting thing?
> 
> No, I recall the implementation had to duplicate pins, not split.
> 
>>
>>> Adding is much more intuitive than splitting ... just like we add references
>>> when splitting a THP, using folio_ref_add().
>>
>> Well, sure, it just seems harder to document so people can use it
>> properly.
> 
> As soon as we have large GUP 

s/GUP/PUD/

-- 
Cheers,

David / dhildenb

