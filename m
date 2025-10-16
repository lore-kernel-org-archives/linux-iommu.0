Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8B2DA775
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643233; cv=none; b=pOCE+RNTHKhKHM49t3fwoBFmslwHWlEJsFsLFoCvGLqHvd6+8g7HIe7el5CK67XSgDFiah5ffVIVzBCkGPQIyaPZuSZVPtn5dVY5QQeEzvd0iRiOYJpv1n5yQrcKBNgGyDWzbQrY8Ek8rDIBTCI24kpLqNgwtLIJPOWK+sbEPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643233; c=relaxed/simple;
	bh=BbReeajioyVdpdH5EfCQ1kWml7ui1MCQlkHRH4jcTCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFQbyoDiOn0G09ZFvYciUKT+S/U/B7qoxXwgoImqCP7sPOzFh4jh2wdGI13OKFd8zcGpaNQ/vpl619As9ihmkIZPQDS/R4iJ3uEkQjLKU1Q4jmGDqkKTR9YfFlWl0zzVZ6VoiVnrHzm0a+i5138ZAw2xVORX/ZUPz9zuG9Y/bJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQ/oJbzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQ/oJbzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760643231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5k258mGUTXr57SH1nKnjEgecOQG7w002Lx/0nyjvVDw=;
	b=fQ/oJbzZYQaYgVUFoiT64t9YximNe/mHkaNh81SwoqUOdV1OQtS+xoXexGa0iWEJdX1oG3
	249e8v+YpZPWEP1+Bvfg3bFf4+1v0uLSM8DTcJz+N5RayV4Y+GYPdeIpkMvUX+fXPjyIV1
	22RWhfX/lfVbGnTBNWzWmJ05zZhK0F8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-vMxzHbG2MxuHQoN4c11D4A-1; Thu, 16 Oct 2025 15:33:47 -0400
X-MC-Unique: vMxzHbG2MxuHQoN4c11D4A-1
X-Mimecast-MFC-AGG-ID: vMxzHbG2MxuHQoN4c11D4A_1760643226
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee130237e1so702503f8f.0
        for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 12:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760643226; x=1761248026;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k258mGUTXr57SH1nKnjEgecOQG7w002Lx/0nyjvVDw=;
        b=fiZrNUCp8Ag3SkR/utuEe7d6o9VR7BQoL9f+iA5E0QpiGfRpPiYrienJQGxnBm8jVK
         AoNNgx9VTOJJBKYNPuZvGGDJpiO8wlC2hz7oNClHgZ4xi+ZJl9hA/aHjJ0TwuBxmoV+W
         2a0Dw/zqhu8CBcC5VLycKtsZSLsggNnP18KWEXVQj3T5pfwCt/LIVTpoKm5zbGukCtwT
         jDr/ybMMsrYkl3z5mc7J1RKAn9Ah3XAsDExOxyXZd9jQl5BtjVuM2/zsCmDDFBb5/Cn3
         T4BVubQzTCHKkzCz1ulb9fJc11tz/BrVd7JttDXmSHSC7qPERAfHugU7nB5dgC1bbcmB
         AXBw==
X-Gm-Message-State: AOJu0YwoLu/YCLR07WhtnO/lvnaFEWoP6ySXbCjWB1hJAwFYx16bNrJa
	ijVtl0PzF5UwrJ9ccOT7KjoiXViZXMiK8BP88gXCPSTEWUmycNjDBthvs7ODAJmwUQ7WEqLnnC7
	EZklpmo/VKZCOkqnSpuyzi35v1+NAu2oqug/4HikBLw7cPtUlpNhvmKWJ
X-Gm-Gg: ASbGncuPqSezdiksfvj3TT90syQ8Q8661c/PMRWssB0zaMAQAQUAuWt4Lwgs/lu25oG
	qsWkAnTDQVXYvXQzaTUePYyT7y5n79BqRsVzCSotFn6yJF7Ozw6A8AjZ/gB6NIAPX75in3G03QH
	ICqEGtDNfxMY1vizKKb6HARmvL2MVL888Y7ZYE3UEeQ4vbThOhQQgMf270/oGDH+1tbfX60xN81
	XA2zDCSUmzgE3RctNYvWpSYKOvYtPuKMKPhTScxPY1KsGctg6IG9ZsDP5pfGu8ASErz4HGnfn0X
	bSt+Zao1103msmKpcvVwQVk2Oy0wCDSLoY14iXHPe5SzjcLd70X7nqHVPVJ0yetgn4zwhxGuGwE
	jfLNELAwh/c3vRjEV3z/IBpO1Jd7VCgzyWoEEC8L6xAPMuheoopZ+72gW805lX4T3DNeyAdfdsn
	ygdS/s/y46AeWFlxADmdtaVmLpTO0=
X-Received: by 2002:a05:6000:25c6:b0:3ee:1294:4784 with SMTP id ffacd0b85a97d-42704db5d28mr907037f8f.37.1760643225872;
        Thu, 16 Oct 2025 12:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfcc8Stm51iYuGklKchoOX+xG5epa3pMdO3lfWEiLBnXCqovN2Px+K7w/7mGkDHX2bMpQSYw==
X-Received: by 2002:a05:6000:25c6:b0:3ee:1294:4784 with SMTP id ffacd0b85a97d-42704db5d28mr907016f8f.37.1760643225439;
        Thu, 16 Oct 2025 12:33:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc0esm36868337f8f.6.2025.10.16.12.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:33:44 -0700 (PDT)
Message-ID: <54a30819-25e2-4835-80c7-5631237b8e9a@redhat.com>
Date: Thu, 16 Oct 2025 21:33:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] x86/mm: Use 'ptdesc' when freeing PMD pages
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014130437.1090448-4-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014130437.1090448-4-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ig4ohymctwNl1-V6DRjnd_rsishhirSLooWje0_ljl4_1760643226
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 15:04, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are a billion ways to refer to a physical memory address.
> One of the x86 PMD freeing code location chooses to use a 'pte_t *' to
> point to a PMD page and then call a PTE-specific freeing function for
> it.  That's a bit wonky.
> 
> Just use a 'struct ptdesc *' instead. Its entire purpose is to refer
> to page table pages. It also means being able to remove an explicit
> cast.
> 
> Right now, pte_free_kernel() is a one-liner that calls
> pagetable_dtor_free(). Effectively, all this patch does is
> remove one superfluous __pa(__va(paddr)) conversion and then
> call pagetable_dtor_free() directly instead of through a helper.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   include/linux/mm.h    |  6 ++++--
>   arch/x86/mm/pgtable.c | 12 ++++++------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 15ce0c415d36..94e2ec6c5685 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3203,8 +3203,7 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>   	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
>   		NULL: pte_offset_kernel(pmd, address))
>   
> -#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
> -
> +#if defined(CONFIG_SPLIT_PMD_PTLOCKS) || defined(CONFIG_X86_64)

Yeah, that is weird. I'd have thought we can simply move this out of
the ifdef? The CONFIG_X86_64 stuff certainly has to go one way or the other.

As PTE tables always fit in a single page, pgtable_page(pte) is sufficient.

PMD tables can exceed a single page on some archs, so we have to find 
the first page first that we can then cast.

Can't immediately see why that causes compile issues.

>   static inline struct page *pmd_pgtable_page(pmd_t *pmd)
>   {
>   	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
> @@ -3215,6 +3214,9 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
>   {
>   	return page_ptdesc(pmd_pgtable_page(pmd));
>   }
> +#endif


-- 
Cheers

David / dhildenb

