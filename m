Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A33258CEF
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037940; cv=none; b=IkiLQk36lwqRC7a1HWJmvbLmCYri/AGpGs2MFcGaPuksNoqBvEMucn0DJRv1Q5SheYsQCmtFUqJjLWxlGF79lWfPmXjr3papQIIofdbf/QqvAgXFjNm5fDOnOchnYMIAHDiWLFlFGB2D7Tf3tKv+Ue4up7evRvPnq/I5j1UgvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037940; c=relaxed/simple;
	bh=7qNngHL5ixs0/c68xTeuILnyteUmxzuW2L51oMVSF/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCJ0TNDg7M5CJE5lu1pgx9cgmzInAffqhOWERRhaecG4O2mSULb7skD86Xv0d8lPQFaTntxhzgraxteVcM58/SfLGVyzHwLs8kudwQO6iV9/v1zh+/uDOQWRo292n+kNIbzaoFX2p9/M+AE9adJDaN3dkhdqT2hXsk0eZZ+BnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwGOFNb/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwGOFNb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J56L85qILujICEJg2uEZiptIUMagBg9oSpxwF2SjTtM=;
	b=cwGOFNb/0ryJqESiEQniG0SKTKnhwtp6GO0QYTnK/56AGTqjpxLE6O6bn2qgC5GAaK+UWB
	wmucJ7rmYsskazXxKSfQ9Xy9EqaKVTX/ZbHxs1xedFsd8lt7QxmGNlXA/JdmZEzv193x4g
	FTRhykPbXDkUDijv74AcgWCS1GZB1Io=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-xFTYTQEfNmyzYOATGDdmAg-1; Thu, 09 Oct 2025 15:25:36 -0400
X-MC-Unique: xFTYTQEfNmyzYOATGDdmAg-1
X-Mimecast-MFC-AGG-ID: xFTYTQEfNmyzYOATGDdmAg_1760037936
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso1242025f8f.0
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 12:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037936; x=1760642736;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J56L85qILujICEJg2uEZiptIUMagBg9oSpxwF2SjTtM=;
        b=bz7T7wJZUiBy5rAVeRda4bCQXH+k9E0ScY70EvgzXbIoC1vGqy9e+eQn2fQnFOe16D
         Zx/IH7nlT3p30d0z2a//kXmcsJferG7SQCxO80rZt43dGd1B6wd9uAJp0iSoz+FC7LAf
         mALEQOZHJ50KLenKjZtNJwvMPygi9Soc8MHt2s00HxHFacpK4BfKP8+kjdudnWO/P+l4
         mo0MIfdeWJCKdHbFISPy/q3yG2Emu9vOH7iszL+5rBx43F9xy65lBpcdhI2jdIvCoJLH
         A7Qe7PuLu2ps2G+OR0g9g6hglKDdUVJ2/s5E+BKm3tavcGvAPaivKZWkGRZpz2hYaHqB
         bgKw==
X-Gm-Message-State: AOJu0YwOW/3nlYz8r3ZVdLeGDhcb0TE7JNMmBghgbLypqVAtwgNy0v+F
	i9QJ7/9Z2d9ZY+lvUe8+JdApbHuwt2/au6acd2Ptv4P7sxikwKBnJqYqhp7qvqLv/Jrj+DaDYrc
	SJz4AcdjW2ouciLyFMJvhObvRbpJzP240i3T/wKpqZwIkYSsdIky3FEhH
X-Gm-Gg: ASbGnctV1M4cj9QSTy/Aa8FeSt2INHcpbrKxUGaG9SqOn3N+DKkIXtQxMXapaXFHuKO
	oyvmL9s13refGRDLU7Ws5XvIvEKtH3xhEpKuKwbIazZJHgW5UvT5CZGsRELMkUw35+YKV08KfJ2
	kWfEITWOfatbxTGt50bC/9pdg2lypDizpwc0j4eCDjB8imAG2kCiMJZZtZzYWYss0MxPERB7nQW
	p9LaMS/LdqSiKi1cjAvW5JLNfuS2giAhRCxTxycpLC2nwNwWMZx7zS0uf2g3OtsqWFex4KCOXk0
	eKeEXM8Rw8SE9u+5a4+HR1GhDt4Bqii5hQuD0P5uybWGesK0bAr6wXh2DEP1xr0omLTcZFcYWmG
	VXgTKPwz0
X-Received: by 2002:a05:600c:c16e:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-46fb42ee476mr11435465e9.39.1760037935653;
        Thu, 09 Oct 2025 12:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJj0GjP35rwfopMr1VmBMpaViGUOZdOXTQQua3M5Gtjm9FcAJ1nsP6TwIVPFYuGHNQxfRy8w==
X-Received: by 2002:a05:600c:c16e:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-46fb42ee476mr11435115e9.39.1760037935176;
        Thu, 09 Oct 2025 12:25:35 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0011sm440707f8f.31.2025.10.09.12.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:25:34 -0700 (PDT)
Message-ID: <9648e990-18e0-4aed-8110-b02f4b45aa47@redhat.com>
Date: Thu, 9 Oct 2025 21:25:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] x86/mm: Use 'ptdesc' when freeing PMD pages
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
 <20250919054007.472493-4-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250919054007.472493-4-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T69HPgaIyo4fPIwUaPVa1QgBz5dgSLxW_7QT00K8TCA_1760037936
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 07:40, Lu Baolu wrote:
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
>   arch/x86/mm/pgtable.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index ddf248c3ee7d..2e5ecfdce73c 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -729,7 +729,7 @@ int pmd_clear_huge(pmd_t *pmd)
>   int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>   {
>   	pmd_t *pmd, *pmd_sv;
> -	pte_t *pte;
> +	struct ptdesc *pt;
>   	int i;
>   
>   	pmd = pud_pgtable(*pud);
> @@ -750,8 +750,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>   
>   	for (i = 0; i < PTRS_PER_PMD; i++) {
>   		if (!pmd_none(pmd_sv[i])) {
> -			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
> -			pte_free_kernel(&init_mm, pte);
> +			pt = page_ptdesc(pmd_page(pmd_sv[i]));
> +			pagetable_dtor_free(pt);

There is pmd_ptdesc() which does

	page_ptdesc(pmd_pgtable_page(pmd));

It's buried in a

	#if defined(CONFIG_SPLIT_PMD_PTLOCKS)

Can't we just make that always available so we can use it here?

-- 
Cheers

David / dhildenb

