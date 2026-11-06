Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959999;
	b=b8bxMwkBleVc6w4SFujC2CqDqGf5WSPAPo2/0rV0/RxLrcczSbpCHeZ7oU0xR7UZfFcY
	 j3krJI9t7DpjphuZap3GIl4LvUIG/86K0jFYYzLb3CaLSki2mdwzLQ0pGDOwtvwHf2B3M
	 zXBRJwbbVIUxhgZLFF0eFJhQ9d7XGD3xoFzqPHRC23HDLnAqddoxc+yzx+5feOvSLcqQY
	 H04s6aIBXhMTEtMlcpSTdPVvOmtDnFiUThSStANeKiQeUPRbeDfGCQHdmCljbQIdr2c2q
	 YIxQhuS4lk5jebsBJDLglb3BqOrt5HGt9dKD4nTtY36tLiuLWEXQXKYCvJ1Vwefu1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
	b=YnJpNzhp/YA4N7oeX7t44GfpXmCWmaWDC9L6V8QX7UPP4q5zibiw3x/cSP/4Qi4DKNZM
	 ZNqS2irvExye1QeLdu5HLfyHUQW1zWziPheIlmmSwMopK/e1VaSgBg8p8IlKKFOi/8B9w
	 GnjhjYwEdF7PBIXW4o53sL4kLZJ3X/FxFZiV7J9Qy4N2jlsnx+QgiVuPs4i20SzqsRUIW
	 SO80yMyhS6hsjsNodPw52sup0I1iQQhAQ0XdSM33w6xrHuRjr+NTTfPWtziCnf/u/zrZi
	 NyGagDVIYTcQEojgZCvx12s3DtC+NvN/luRP51kcunGJ9sslhqgSDe/Uab8WbiSTpeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGqOlpUo;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E28606A332
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 10:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E28606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGqOlpUo
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490585eddfcso305881f8f.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959997; x=1794564797; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=TGqOlpUoXy9ELl1t7kQ/y5QAPOElb/qdkFTOgfTWVf9vxPYoH8VGJPMPB5ojtQSbBC
         FnDO5Uvvlx8SBrwA5PeIpdE8BmJMVyJVxVFc8P/F2ETjd3Uw6NEyifq6u37dahU7A/G3
         Pws2l/ouhkZdmvrTNCltbxm58f+7FgJSgJ3XIJxmaa8pktuHiUoQXP3UF/CDTfn/2AtX
         wxyYKpidpvVGHMSTc4HEPZygZ/sdmtDW0bdo1PAtdjyiM2eCNk7+JTnXLiEe///3JWrl
         iFle0TKS+Qge4at4NL7ZINI8gk8Bsm0NIwSDTpzClvF36Bax1KedQ1uj5ccjK509XzTa
         UKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959997; x=1794564797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=qqC6byHG79AcCMH13Pis+0N6yXGK6etolJCYjUyXXwb88msD1rMt+HDhPEDV4IqwyQ
         U43Lxv/POXPW8TbnSRq+0fOsT5OiGpv0mG9xf4Fke0vxDNhU4Teflz+qRy8SLplvTan8
         Y8IX9j7sVo4pSSs2K39b6cC3oDCMIU+qQetPQM32he/pOQGRrrrDX7Pu+K+1Ha1zrZ6c
         QDV32aMglKnJGk/sf7VocvwweGHaK8thC29kt7YPBYpTznGcX6UjpmQGu1kvfhlG8nDa
         S4JR/H5RStqf4UuaOIIMBrovTQFft9hCbuNip3DXLKAxPstR2g25MXXgXNKmMgHKVUMk
         eC1A==
X-Forwarded-Encrypted: i=1; AKwUvBwr5hoDpWbJydwVnv26uyhdE2g15YBcUU+WPi/r+Tplu7aeyIIQjmCObS8B3HqvfxNqJlQiFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+YKRj0rtdG3VxP4R+XTq73FH8MBAJKAqYPj8JFMO5AQb/20U1k
	JSs4zfteP85RbIL+S3hfvRyWy5kPbo6CnqWeDUAJIT+pDHjHCN3hj1RJ
X-Gm-Gg: AYBFou20twdI7+pJjxtyrdX6qUKfjtLNR8slUKtwNdfrwQksrkxD69ldpcVW2nQ3hi8
	cCsHchKy55o0CW9niM4isEBuVmasbEMSAS7BRGGgp0f/Ob8TELGF9z9LSl5rB1I9UlcxpLW0gge
	TpISPwsFnCjS8sTM/+t1Ppde+ecapT5Zkd7FJGB5ca9JO49mpm/tS9ZJReBj8BQJzwXHoWUQuPb
	Q/84PaIQq755EWgB4PUqU3Eqlmcr8jraDzLnQEQ5j7nymtTbq6xyUm0+uq0KkaYmKq6sMYgDvef
	aShF3QgMOAynzF6y7rAAICAbRHxIYGaCQGpoWVQi59w5ohV3ciL+aQKaGnz29iZRrIk140Uebb7
	LIZIdDL/fBbWwDFjryb4ts4L1lyHbrxxCXsl1nRbh9aD7GEQxbWZ34S/6J9ZT1vmDSPIZXd7GLI
	6qs55WUbm1gO4nliBlUrvfzHFzqOhIaZfu1iU0fI9fPB/kph/XmgwlPsfOXF3l09BlCinkPL13K
	mDU4UIal5301ztBSPSYEAR0BBwvV2rhqzv63AEyX1xiFbp/izbVRTtxc33BO3prEtX06SeHKzXz
	wjxqwVSFY1uiCR2bHnQlHhI=
X-Received: by 2002:a05:600c:310f:b0:4b6:bb67:bb9 with SMTP id 5b1f17b1804b1-4b6ded4a3b0mr30188925e9.29.1793959996617;
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm121341505e9.10.2026.11.06.02.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Message-ID: <4763a039-60f8-4263-8124-beb0f9ab3366@gmail.com>
Date: Fri, 6 Nov 2026 11:13:13 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm/gup: limit pagecache folio refcount when grabbing
 references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Let's replace our existing safety check by the new
> folio_ref_count_over_limit() check in fast and slow GUP before acquiring
> additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Drop the WARN_ON_ONCE(), because apparently these things can currently
> happen with large pagecache folios.
> 
> Keep the zero-refcount rejection if the refcount is 0.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2ab42fc6834e5..db9db6b2a4662 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -77,7 +77,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>  
>  retry:
>  	folio = page_folio(page);
> -	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
> +	if (unlikely(folio_ref_count_over_limit(folio)))
>  		return NULL;
>  	if (unlikely(!folio_ref_try_add(folio, refs)))
>  		return NULL;
> @@ -140,7 +140,11 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  int __must_check try_grab_folio(struct folio *folio, int refs,
>  				unsigned int flags)
>  {
> -	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> +	if ((flags & (FOLL_GET | FOLL_PIN)) &&
> +	    unlikely(folio_ref_count_over_limit(folio)))
> +		return -ENOMEM;
> +
> +	if (WARN_ON_ONCE(!folio_ref_count(folio)))
>  		return -ENOMEM;
>  
>  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
> @@ -1482,8 +1486,8 @@ static long __get_user_pages(struct mm_struct *mm,
>  				struct folio *folio = page_folio(page);
>  
>  				/*
> -				 * Since we already hold refcount on the
> -				 * large folio, this should never fail.
> +				 * Grabbing more references can fail once we
> +				 * hit folio refcount limits.
>  				 */
>  				if (try_grab_folio(folio, page_increm - 1,
>  						   gup_flags)) {

this can fail now, so shouldn't the error path below return -ENOMEM like
the first page does, instead of -EFAULT?

-- 
cheers,
jose a. p-a
