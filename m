Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BF1C6A5
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355471; cv=none; b=rsT6bY0giSiwBw+NwDUXjaDY9unUZ+19+rnBueelldHmj47wE+FWELavjB8W+lvqkYT9fB8dyf6TkIWM/eVZBJeeGuz3n+eR4JdFqKomk8AKLqBaeaEYAZpWuvokZdbGLimxQTafi3M2dPZzv5na8aaxqvdtnLfqj20k4ibzNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355471; c=relaxed/simple;
	bh=zYEZIrEPsbgyeQAFf7uhiMNt3HkYO9kUgIIsnS5sJTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEmsERbJDqxrxTbhI5opY4KLFvmS/MIX2xlBWo6JdozOcqZrMBUdTYuU23f3mo5jAZ9ElrVOaryJXeFu7dyym7/oZ1f0Ym7jg+pq3aQDhRoMavMk4raSVr4J4Y3PrpC3fR2qMmdvyjY192GYeFcsHfTBBShYvgWbiB9ViDHViXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHDc+xHU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHDc+xHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727355468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w5aVhgojZdD2dt5T9DQtW5tsGpyubA8XkXZ34ExGK2s=;
	b=BHDc+xHU5SPyk7UTNg1DpYKiozo+bb3SlhS5hZUrsEIV3RwZWBhn0iN1Za46KKO6qRmS40
	Lz9Livq68BXZ6LlXssTh0mYqYjLV/iooWh+GOqzDzZNLhzt8lWIfvg16VI0INvGdlb9YDp
	KonYZgKwlD3A9X8J4wXgdR9aNmUPem4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-wlZS5FNQOyeWAqOdtVG_Lw-1; Thu, 26 Sep 2024 08:57:47 -0400
X-MC-Unique: wlZS5FNQOyeWAqOdtVG_Lw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb471a230so7004125e9.3
        for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 05:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355466; x=1727960266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5aVhgojZdD2dt5T9DQtW5tsGpyubA8XkXZ34ExGK2s=;
        b=AvbKyMKi8qQI+qIXumY7GSeKUYXiIxhy1UbHul439b4UEchiv+lROjyDvVoyVm7qIl
         eSgreTP4cUscsqSqC0C6CMQXujISYpdXyXrBhUNjV3TqLYQrqAyEU3Cj14SuqCq/rAQY
         sdaDdXC/lukbs+e0TYjAYksWlaJ9OIx74/xhT0QFqBRsM3UD6amn9Xj3TzP55IDBBH3y
         y1pTRxYxQ/Sem39FU5IJtLO3Lcllb+PuUZvlebI8H6cGlo5kGIdEmJ1SzTB23Fv/+5sN
         UkLY0X/GXOHEk1yL9nWfJNE7hQlr9Ro9kls1kYyxQWerY0S02iLtZmyu0u1q3uoe66fw
         fS6A==
X-Forwarded-Encrypted: i=1; AJvYcCW+8cNh2cVocwRM5H0QgNwVIlOiHfU6v4CJ2HUGDzNB4444j9bmflz1cHnvbM0UDf3mpcAazw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyakImylUXbLTnehF3Dp+MrXXhiw/utETBzxP9r7V4VqbupTIs7
	KbhpiF4zDioZ7FIWv44hXRg4VK1uezhlrgIq1pResqkqIWnm59CL5F3VxBlAcErEDYLQP7pQcD0
	gUEppdba9F/6TroMFTQ06d/c8KtPXDm/ZLU8jdb+l+DoygGjUu5CZ
X-Received: by 2002:a05:600c:3b18:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-42e960ae1b1mr53738935e9.0.1727355466330;
        Thu, 26 Sep 2024 05:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEns+h3Z/jyL/s/5q4yB6cInewHtGCCPEdYNLeLgTPkO88oUEnZ2JJwv+TTp7jHQm/GrFkX7A==
X-Received: by 2002:a05:600c:3b18:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-42e960ae1b1mr53738685e9.0.1727355465864;
        Thu, 26 Sep 2024 05:57:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36597sm46260575e9.31.2024.09.26.05.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 05:57:45 -0700 (PDT)
Message-ID: <950cf384-03f4-466a-ac10-61c02dd2dc48@redhat.com>
Date: Thu, 26 Sep 2024 14:57:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240926114000.GW9417@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.24 13:40, Jason Gunthorpe wrote:
> On Thu, Sep 26, 2024 at 01:32:09PM +0200, David Hildenbrand wrote:
>> On 20.09.24 15:28, Jason Gunthorpe wrote:
>>> On Thu, Sep 19, 2024 at 10:11:38AM +0200, David Hildenbrand wrote:
>>>
>>>>>> And repin is really misleading. We are simply adding more pins to an already pinned one ...
>>>>>
>>>>> Jason suggests a better name in the other thread.
>>>>
>>>> I would prefer something that simply adds more pins to an already pinned
>>>> folio. Much easier to get.
>>>
>>> Yes, but also nobody should ever want to do that operation, it should
>>> always be part of some kind of "splitting" sort of behavior..
>>
>> I remember patches from Dave Howells that needed that for O_DIRECT handling.
>> Never say never ;)
> 
> Wouldn't O_DIRECT be the same splitting thing?

No, I recall the implementation had to duplicate pins, not split.

> 
>> Adding is much more intuitive than splitting ... just like we add references
>> when splitting a THP, using folio_ref_add().
> 
> Well, sure, it just seems harder to document so people can use it
> properly.

As soon as we have large GUP and splitting might go to multiple PMDs, 
multiple PTEs or a mixture, just being able to add the number of pins 
you actually need might be cleaner ...

Let me have a look at the latest reincarnation of this patch.

-- 
Cheers,

David / dhildenb

