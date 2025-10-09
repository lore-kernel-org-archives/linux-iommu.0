Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1896282E1
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037990; cv=none; b=uX4pyZ7VYQIe7jJRfvzVE5KO3PmUBRV33KwJJfakkUuMOdubzWkcY2MQBNijwF8zmcw1GXiCy9w6eAcGBxy/LiOtuadXL2q+sF8AEj7GiGX3X4CSbiOYEqiadx1Yt1UFMFJon8gv+R+49c4QGj6XTzqkNTmDYT4Rw2nMG5+mkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037990; c=relaxed/simple;
	bh=7q2YWJYpQaCZUvR/ZTZ8el7P1YcW8PJr6NQTIwA6NmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOOtAMYLk1Iy8zGWurOuYo/+txTuuiCXHhywR3moB07p1MP9eg/pxcfUaU9X/QjN8pb4XtuO9B49ViRiBNUydIzVrmOW48yok+FrWvqZ8qJV3UjagSjSNYF2Ll8c1uGSMe17g2LnHkhhC2E4Ow3l8QxrkB3KwBGWEJiVLLJtGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oxat8xjQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxat8xjQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W2B8vT5pvQD+mfwnpX1+1iKZS8FrGv7Z2N6yCTBVfn4=;
	b=Oxat8xjQWOBkPZTCDSqayp4Kw5cjtcY702+BZnDgW4u2KwNJg+0j94Nzx0FGo62o9gP3af
	Rfwv7v18IOuZJGN0JzFGF7TQIjgZnWJ/Set471WZxapqJWUJwLcXUtMpulxa/czzyf9tCR
	f9twIRgKXG0VZBrWypqN+yK6O1ssqKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-KyalQ84oOJWUNsp2jZJEDw-1; Thu, 09 Oct 2025 15:26:26 -0400
X-MC-Unique: KyalQ84oOJWUNsp2jZJEDw-1
X-Mimecast-MFC-AGG-ID: KyalQ84oOJWUNsp2jZJEDw_1760037985
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso883500f8f.1
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 12:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037985; x=1760642785;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2B8vT5pvQD+mfwnpX1+1iKZS8FrGv7Z2N6yCTBVfn4=;
        b=be8vEmLscC3lzTSMuS/5CfrjDuREdU8z6tDuguyBXLUAj6x4YLU0DC7Z6fE9+/mEtm
         2Tc+YOByF2SVXTKH3r2dui9awzfT+ZtGnyVSyfe4j1jP1BXHOik8XD7ZP1aRzekBOTfk
         Z9wE85puJw42FUgGcbqkGCbUtN3v2mUIuE8iNSctz/OQdknu8iXO6GZZHYEBUYZV/SQN
         x/dTebcYgFi2h0dodbRJCqfajhJNMvrcJQ8vVwhJ1MSIYpKj8gQyBVgfVBGBbvvexkgD
         FGBj9QO9DHppojObdYdCLmxorawdNmpYVp3Lc8nOorGv7BeQ6uSJUwN3a1q87bzmeZaO
         hQlA==
X-Gm-Message-State: AOJu0Ywo4uA+8skAC8yi25ujA3CmyIGw47kDuZG5iVedoguYKGV2wWyR
	PraYHr1JNXG7aSKeJjhKLuuilLnZWtQQgngd1STjV3AStlqDgXjrKvU7D8nQmkR9U3iYRpqIHQd
	J3K7tq99KswaAaGMAMV2bJEn6Dnn0fzl1P0mb8zEl3vY6Rm/KixzQ8AxH
X-Gm-Gg: ASbGncvnF4Yo0EfeutoeeJiiiO04/cDerp4PtgvBm448OV3VjhW+RXTPNL+VHWMQ8JY
	3aZeLMHUDICR1XQo9ipOEUYVPhbtmv0kczaarwbOzlVF3WyRv1+IkyC+pZq25+l1qdN6KG/UXoy
	kjncUMkpxFcBfdGvyNcCvrQfaHRVoIRK1qwS/vJdiReYFwkve2H1k+Fxico3ZaoVwH/XXmRM3O9
	YJvph+E7t2bFC+B9mHt88onb6TCakKq79/1nJtpE9muUC0l1xcwp+EbPt6CWxI7MuWjAeZYfi7o
	9UITXNTgQud1iZxJLQ5H2vlmNR3pK8j3Ql459U371dS/YVDSed8mN+/gQcJH9KeQywdbj9Nsj0y
	KBdAdvkkh
X-Received: by 2002:a05:6000:1861:b0:3e7:4fda:fe0c with SMTP id ffacd0b85a97d-42666da6dd4mr5743424f8f.15.1760037985156;
        Thu, 09 Oct 2025 12:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr53Oq5rgi0BWcMZ9Fm+pXJK59Y4s0sHr9nDLiWoMs2OEe75OxVzju/Ffcx6q/sukO2F7BzA==
X-Received: by 2002:a05:6000:1861:b0:3e7:4fda:fe0c with SMTP id ffacd0b85a97d-42666da6dd4mr5743402f8f.15.1760037984752;
        Thu, 09 Oct 2025 12:26:24 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0061sm434778f8f.30.2025.10.09.12.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:26:24 -0700 (PDT)
Message-ID: <646c392c-0a3d-46f6-9d81-c007d6a736da@redhat.com>
Date: Thu, 9 Oct 2025 21:26:22 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] mm: Introduce pure page table freeing function
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-5-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250919054007.472493-5-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: drlX8CS18ta-6mg7RL9nD7bcpLRwelCGByLuCX9siCw_1760037985
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 07:40, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The pages used for ptdescs are currently freed back to the allocator
> in a single location. They will shortly be freed from a second
> location.
> 
> Create a simple helper that just frees them back to the allocator.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   include/linux/mm.h | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3db3a5ebefe..668d519edc0f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2884,6 +2884,13 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>   }
>   #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
>   
> +static inline void __pagetable_free(struct ptdesc *pt)
> +{
> +	struct page *page = ptdesc_page(pt);
> +
> +	__free_pages(page, compound_order(page));
> +}
> +
>   /**
>    * pagetable_free - Free pagetables
>    * @pt:	The page table descriptor
> @@ -2893,12 +2900,10 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>    */
>   static inline void pagetable_free(struct ptdesc *pt)
>   {
> -	struct page *page = ptdesc_page(pt);
> -
>   	if (ptdesc_test_kernel(pt))
>   		ptdesc_clear_kernel(pt);
>   
> -	__free_pages(page, compound_order(page));
> +	__pagetable_free(pt);
>   }
>   
>   #if defined(CONFIG_SPLIT_PTE_PTLOCKS)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

