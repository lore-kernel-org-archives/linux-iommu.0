Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD413B595
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142352; cv=none; b=aBrNtc4i0CAGRhBZcUR4R2/VlAL6uWWzNf8rI8G6FXiWAFLhud7ql4aUy9mS3dkLSDbLGgBq263KU4FCLRut+JsFk1ukmsHemRgmuyoI4Wu9x7+Ax33Enmq9f4+TzBW0jXQgNC6ennmy1J/4amxJDsRoHjYEYYw2yfY+0M86KPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142352; c=relaxed/simple;
	bh=bcmfNZsY5jzoMPlSHya3R2EV0bnWvPrM9VHEHUhKNgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPussQkDI2Hb9I4l4CgvhxZ1wndbzn9Kp5O5hGysxWg7s/3FZPV5/OPAlp05dyFn8dSZRpb7Cy+Y30Kr8jdIzX1xvN4hTKtfBXcVesWzN46blCmmKITd5bbBLyjDagHu7ILenYM2l4zQjmwDWHiUL6rQKy0gUVlI4ZIxFcMg0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGJATSyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGJATSyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714142349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7LAbhJxCY0/OTL2dKRUHH/gZq1bMdRuFQcrvL6xeSh4=;
	b=hGJATSyP5GEgEqY7Eb9J+eU7pzRFPRvLYgaUPJL/pbcsWMFUaUhjIXreZLPLkh079JYsl0
	vfQ9loKmal7Q0dfk/IX8nyEpnw8xaUtLUw2yBRSFwVe5Dcs4DcI6QJpZfYAgvQW2T89bL0
	3e4L6XudL09iRRmHdBzjfZzkGKAMHQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-gbqLgYxsPyKDd_aCdhJ8ug-1; Fri, 26 Apr 2024 10:39:08 -0400
X-MC-Unique: gbqLgYxsPyKDd_aCdhJ8ug-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-417de456340so11381685e9.2
        for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 07:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142347; x=1714747147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LAbhJxCY0/OTL2dKRUHH/gZq1bMdRuFQcrvL6xeSh4=;
        b=Pew75gaDp0LlXGBVH18fUO+KpYzXOxpyVwDJExrlzzF2BOzscnk8xc5WgSzmIRqwj4
         Fte0kA4VHDq/MT98V9pyoJ9UvLhxTISKCj3D6UVQuqvPzNpFiXwCftTBV9b/3Akwnydf
         fuQjMQ7rmsou5RwUWiA6Gv5sy+VZn9+bc9koKHX4pkCz84hx2tDTanmX9b5WLxxFRxL/
         usAHr966tmqegDDdRPDc/4rmh4AQS8sjNYtU2sMLLBhbPJB3KBh/qace2r0p6E5g5Y8o
         myu38JhG+WYWaKomxQlZ33w1bROo+9UkT9RxzR2UQcZ6YZujXlGovgYr56v9kTtq3ZTu
         9m0A==
X-Forwarded-Encrypted: i=1; AJvYcCXya9c9XtY0dMoyOFhPTUaHA8NWRFCxzOao1y1cHMeDWUh719dWeNoIjtau982rA8YauQTRepTtGbbyFvelg2oWjyXxcoM=
X-Gm-Message-State: AOJu0YxzH3Qj4a/rZZCf5DiOOLe4EIMdqKfylUNvS50iQPIvPm/IZOUu
	NuL5ThaRrrYuaxWwRyD0ZT3+wqtebv0+RSksiIiWCqmnpIUNB5UadyeDc4+LQUWgi2KJ3d4gnDF
	tGAgxf8TMOp7Q/5CDhGUfSQNTp23wrxMe94DMVukD+tnleIWQUgLl
X-Received: by 2002:a05:600c:358f:b0:416:3f85:d49 with SMTP id p15-20020a05600c358f00b004163f850d49mr2362262wmq.18.1714142347300;
        Fri, 26 Apr 2024 07:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9PzaUmVi6q/UvBMMZv0Ud9xDfpTnl9gZMBvkcePNOUk3TFUHV7ndCSVu9IlBQ/73CMWAnrQ==
X-Received: by 2002:a05:600c:358f:b0:416:3f85:d49 with SMTP id p15-20020a05600c358f00b004163f850d49mr2362243wmq.18.1714142346813;
        Fri, 26 Apr 2024 07:39:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b004183edc31adsm34757800wmb.44.2024.04.26.07.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:39:06 -0700 (PDT)
Message-ID: <9bf62e97-dfdd-4537-8fb0-b5f293856f59@redhat.com>
Date: Fri, 26 Apr 2024 16:39:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev,
 Matthew Wilcox <willy@infradead.org>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
 <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
 <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.04.24 15:49, Pasha Tatashin wrote:
> On Fri, Apr 26, 2024 at 2:42 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.04.24 05:43, Pasha Tatashin wrote:
>>> Changelog
>>> ================================================================
>>> v2: Use mapcount instead of refcount
>>>       Synchronized with IOMMU Observability changes.
>>> ================================================================
>>>
>>> This series frees empty page tables on unmaps. It intends to be a
>>> low overhead feature.
>>>
>>> The read-writer lock is used to synchronize page table, but most of
>>> time the lock is held is reader. It is held as a writer for short
>>> period of time when unmapping a page that is bigger than the current
>>> iova request. For all other cases this lock is read-only.
>>>
>>> page->mapcount is used in order to track number of entries at each page
>>> table.
>>
>> I'm wondering if this will conflict with page_type at some point? We're
>> already converting other page table users to ptdesc. CCing Willy.
> 
> Hi David,

Hi!

> 
> This contradicts with the following comment in mm_types.h:
>   * If your page will not be mapped to userspace, you can also use the four
>   * bytes in the mapcount union, but you must call
> page_mapcount_reset()
>   * before freeing it.

I think the documentation is a bit outdated, because we now have page 
types that are: "For pages that are never mapped to userspace"

which includes

#define PG_table

(we should update that comment, because we're now also using it for 
hugetlb that can be mapped to user space, which is fine.)

Right now, using page->_mapcount would likely still be fine, as long as 
you cannot end up creating a value that would resemble a type (e.g., 
PG_offline could be bad).

But staring at users of _mapcount and page_mapcount_reset() ... you'd be 
pretty much the only user of that.

mm/zsmalloc.c calls page_mapcount_reset(), and I am not completely sure 
why ... I can see it touch page->index but not page->_mapcount.


Hopefully Willy can comment.

-- 
Cheers,

David / dhildenb

