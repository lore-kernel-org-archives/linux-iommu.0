Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5C280334
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213700; cv=none; b=GeDKi0jkS6eR6/P7P3ptsmnAC6h9fyxrTILzmaBDPJv/gVCdL4st0ltrAoL6aJi8wCnJqnC5dPiqpT51K8s+voZF+6ZiiisnW8BGp5KAdaLQKYf+KmzBHOP0sjQ+/SEOuAAZ2C68IvRm+4ooO7RTYsADF6gy/AdYq37rrfAqM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213700; c=relaxed/simple;
	bh=96oZjGpBhsGM6T5RqD1Jhcz8DPmt/ETyRKKVXbbqnx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWgy8za4JAQwbvIE+WOfB0Abfw8M1nPomTyA4wuVsP+yPPsgE+ivJCVfBU+UO2aGOCzcnry/5X1I1+pLtt8+148j9H2flFF3dM7eyU+WA01TtvH0azVDY3e+fCF5q0AZ1bzrjihBqFU2DrDtW33d3NYrFbi82/ByxwJAKIFMsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcyAQm9N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcyAQm9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756213694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+33Ue2Cu5Y5oxJByCwLn3TsnRWViKb51w/F+XvIasfg=;
	b=DcyAQm9NeNX0gNflVUjQyILC7pOSj8BOQuPJkoc9Ws5tkI4pIyooy809jkrmo/dtSfvM0u
	hfeTmrpUGOhtQW9NHApP4OmOlmgQVVx3j5nklKh0erN9odZL3Y8P3mYu2mSgxKFENZBUi4
	RKRvrldVHpFiQsfFXa2rkx/Re4Oy2Ro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-QLHSZdeJNayK6BjWz0IwDQ-1; Tue, 26 Aug 2025 09:08:13 -0400
X-MC-Unique: QLHSZdeJNayK6BjWz0IwDQ-1
X-Mimecast-MFC-AGG-ID: QLHSZdeJNayK6BjWz0IwDQ_1756213692
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b612dbc28so13620095e9.0
        for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213692; x=1756818492;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+33Ue2Cu5Y5oxJByCwLn3TsnRWViKb51w/F+XvIasfg=;
        b=OwvUWIWkQIov0Bf6B1iza9yJhs6KaGOOWr3EFtyitOx9wDhVTInwWdKJ+lfhs3Bqd6
         3Ja4XvpNxTAypt8PpYiL3lk+r/DJgyoMUbJ+3duE4V400HCwxUmmX5Lu+Qh5oLTxRnfz
         UwNBFmH+MLS62C/DbRHfWZG27DXgklg2r7pVXEYkKobY/Ja+HEa1wme2cM5OyD+eW/aq
         z9PtOGTa51bLL+SsHrR8PObP78BuZjx5Ow8R9tKvLgIszIQNjlIYfOg+ryALVDKDvXMv
         i6Q5Qcr9YcP3ALCrrx9vsIjeuqb7yazMSGggOL4SdUJzjEdLe9FY3xnhQfZvupbpaHna
         xGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrdY/payhR0RJjVVLxog3nEb69DBN5ivNL079Iw4V1kvidKXU1WW0WnBSiTK3qYogR04+MXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPCMDj2y4cgxEHUnjIiq2yFCCXNQ10KjbQFendB8MWL34xC+6x
	MrL/+r2KnUucMSMkVB8ZjDL4oZhJw88Iv7pPtun/pIPQ7nc6k631ltReOvopbO79G/Jq8Fw7WLb
	gKgOGf04t7+Ev0Z1ThdwdKEUf1tYHm6qpticnBxmsC/CwCjjy3+2t8MLQ
X-Gm-Gg: ASbGncv/kaPCnGr8v/a445VFBbulIENrQkuHEtbER5zuHjg20dp6kszj7p3GU/Se8O+
	1zwbMox595i6D7vpHXA1p5haMniOCj01TQIrcndSfg0oYCZGh7yIhgtD6fpAYnWj02Lq4zZWIrM
	kiQ9QfI4bfdN7cchR1r8dszUENdBkWrKRoCXzpxhddrCn9WNpTJUOyIuz1yagODwXYd+5IqGNg8
	rh3ZrqFeqPYYgWIRm2W9wO+v0EpIMCf7n3JfOJ6VGtM7YJ+G8gL1Xe8Tk/qY228MQm7XWC7XUcf
	BJlcxDl1x9Cih+CVIajBy33ZVgMJ/gG1T08yNyXjZM5JYLtZ2u5z7RMJn/ol0XCe/LOYfA2SOA=
	=
X-Received: by 2002:a05:600c:19cb:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45b517d2751mr126238535e9.28.1756213691637;
        Tue, 26 Aug 2025 06:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0uVvd3bkBu8Q9HfrtdCgTiP652NIGyMgKGC7lB/H2NXiQPCgnz3LGDq701BEdJbsSh2Pm8g==
X-Received: by 2002:a05:600c:19cb:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45b517d2751mr126238015e9.28.1756213691060;
        Tue, 26 Aug 2025 06:08:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57444963sm165603375e9.3.2025.08.26.06.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:08:10 -0700 (PDT)
Message-ID: <ecc599ee-4175-4356-ab66-1d76a75f44f7@redhat.com>
Date: Tue, 26 Aug 2025 15:08:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 21/35] mm/cma: refuse handing out non-contiguous page
 ranges
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-22-david@redhat.com> <aK2QZnzS1ErHK5tP@raptor>
 <ad521f4f-47aa-4728-916f-3704bf01f770@redhat.com> <aK2wlGYvCaFQXzBm@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aK2wlGYvCaFQXzBm@raptor>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ObNDYVvsMVsfXVeFvM2BiaIaEGOmYtLzmqXV8G6_eEw_1756213692
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 15:03, Alexandru Elisei wrote:
> Hi David,
> 
> On Tue, Aug 26, 2025 at 01:04:33PM +0200, David Hildenbrand wrote:
> ..
>>> Just so I can better understand the problem being fixed, I guess you can have
>>> two consecutive pfns with non-consecutive associated struct page if you have two
>>> adjacent memory sections spanning the same physical memory region, is that
>>> correct?
>>
>> Exactly. Essentially on SPARSEMEM without SPARSEMEM_VMEMMAP it is not
>> guaranteed that
>>
>> 	pfn_to_page(pfn + 1) == pfn_to_page(pfn) + 1
>>
>> when we cross memory section boundaries.
>>
>> It can be the case for early boot memory if we allocated consecutive areas
>> from memblock when allocating the memmap (struct pages) per memory section,
>> but it's not guaranteed.
> 
> Thank you for the explanation, but I'm a bit confused by the last paragraph. I
> think what you're saying is that we can also have the reverse problem, where
> consecutive struct page * represent non-consecutive pfns, because memmap
> allocations happened to return consecutive virtual addresses, is that right?

Exactly, that's something we have to deal with elsewhere [1]. For this 
code, it's not a problem because we always allocate a contiguous PFN range.

> 
> If that's correct, I don't think that's the case for CMA, which deals out
> contiguous physical memory. Or were you just trying to explain the other side of
> the problem, and I'm just overthinking it?

The latter :)

[1] https://lkml.kernel.org/r/20250814064714.56485-2-lizhe.67@bytedance.com

-- 
Cheers

David / dhildenb

