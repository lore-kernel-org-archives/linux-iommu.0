Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FA31577D
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432068; cv=none; b=LCrjFvmyK6ljnU0F8H9e/7BWbVbKFQ2SndQyLKDLmcUuV2oJi0RkSCytRGsSsaEnMH+oeAFFG3pG+iWTv0Pj6ocZj1q0deM2qHC1NXovjFK4mhBsCOT/XafYCdNCYmZ7rEjweOXKIlcHMbhm+Se8f7CSyrNFzpz8YlTB2rLkNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432068; c=relaxed/simple;
	bh=o48LDt0TSPg569fegonQldrDqlDIsfXnN64sffEnKdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwXBZjHjvtztS3pZzQP75PDzyAIHFBAsV1tWOLMT9OUMC8w1Fdc+J5+9EHeNJcihj+CIH+qEiZgI3KhYPvzfNmDcBuIM8fgYUx1pPsbnMxA1siIY6Hi1/Zb6koyG28yZ+UYX7WhIZOuhjXVXOFRlSvgn0Lp1Czk3Gcgn1JTg/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbyRS+oo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbyRS+oo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298145fe27eso66243605ad.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 18:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763432066; x=1764036866; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uG2h5hFbc8f+zsWVWelwgYAnnvEshc/EkCba1TrqhH8=;
        b=HbyRS+ooyhA8KLV3XRJBqLlTHE1JPAVLUQTUbFJK3HBohLd2sMPyYFqKrnk6qh6Z5C
         ku4NQ3tKXoz/HMdnJLLwXXI/SjfJ755lrO+xk25HkIAmDYfl26L/FKJuAcUkrStt30nf
         sX/BA898dredw5DJz9fAtgjz09vmqG8+zcA2xDo0/NrcawkVMGx3cukNL7+feL7HJQvW
         XihZ3Ecmcdz0cxthwm0vREi0O9vZ7mSTwCuaYeVY2eIB7h8LIT42JgjMdOVPY0jH5xfU
         MNqLQUt7xmopTtpKwHJcP5ZDZn8yap9CIBBrJxFhdpJrEOQNJ1HE5c90nSe/FXuv87w2
         +KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432066; x=1764036866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG2h5hFbc8f+zsWVWelwgYAnnvEshc/EkCba1TrqhH8=;
        b=i7BmpsDr9RytWn0SgpOWD9KT8Re2CEkkOcUa4mykXVXAuwpmb3NvGNC/JcwQPWRGCZ
         Yr9pZ7a9ILsDLAuintLODuR47hE/Zt8ZcZwQDMZUvgJ6oCVAAE9I1gWHU+KQ0tgVT3R5
         xSYFhYqoHm5tsA/uOJondSUt02lSqWr78p5B5ywe7+9MIWjggRpkWPtxG0ESDIAv0Pt6
         uwFzP60WJvGhPDRtP7MV9jg0WE69wtdHG3cOc6u67F/dvViOOHLkUmWlUCbtfeGY/i2r
         rQOB0hxqI7ZuSkFroU3ZacPM9CPKjuoLnDkgHuxVt+lRyVPNz8/GtIWWNH/KdE3mS7Xv
         STlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcRkTiqt2WB6Y8UgoA6dsLwqNNF8R+gq+wU+uApm6qa0kHO4cLtms5Pq6Ro49LcvmP+EXjfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE7D5p8V01v6mWHq/SjdtMNzvYgexwHw9r2NlB6hNMPJaDaNcB
	3VXNVqqv/oJymODZpm0dA59OsQPbjxRcz7OqPb7WHe9LaJUuOOZVcJq6
X-Gm-Gg: ASbGncv9B1fUzqaOitjjXgtVMDVJwdy6yjyXhEmrTjfCNncFvpnyL2GhD7hFBP+NrrK
	iktRM4QGqWfPem4H2tVK3P3LNtdMphzEmp1NFOLDmfknlJbuWuoMn1eER6hpQfFq1wjFdnkSCZb
	WJcuMQPohgspHl+uYVI5aksbnjHJkNxmV6grotUWsklTz2a8WCr86+scsTt8kGBYMhZ1WhnuaCM
	IpcDUv0GKOVTrbm2wXT5lM3xeYRbaqSxU++pKPDnUjEjoMg1B9cKCtf/dDtAiAK2WWOwDN6bYLc
	VSHFAYCseIqjEReyTRGM8pzx6kq4VGzEaeyGflCC1DwTQLPgDlG8xd2tfpC64oYp6mne2sinACy
	qFfS8zSn1jons12xIeliNnCE3fsfL9Dr6ysUBXvT21n6yJ3PKefMEW1Rhmo1jIfaXhQvTb8cvqR
	VS/ZZj2LaJp08vAUGeOGpJlYyyrgclhewXBJwtMrmIJtg=
X-Google-Smtp-Source: AGHT+IFPov549n2LzL2CKQOMPes01IHaPnK+Nr8T6G4o/JsbD9vqU64qA4wEzMsT+osaI0OWReXc8g==
X-Received: by 2002:a05:7022:b902:b0:119:e56b:c74f with SMTP id a92af1059eb24-11b411eda26mr4902917c88.20.1763432065736;
        Mon, 17 Nov 2025 18:14:25 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608861asm36771548c88.9.2025.11.17.18.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:14:25 -0800 (PST)
Date: Mon, 17 Nov 2025 18:14:22 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/8] x86/mm: Use pagetable_free()
Message-ID: <aRvWfv_fc60zUK1d@fedora>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022082635.2462433-7-baolu.lu@linux.intel.com>

On Wed, Oct 22, 2025 at 04:26:32PM +0800, Lu Baolu wrote:
> The kernel's memory management subsystem provides a dedicated interface,
> pagetable_free(), for freeing page table pages. Updates two call sites to
> use pagetable_free() instead of the lower-level __free_page() or
> free_pages(). This improves code consistency and clarity, and ensures the
> correct freeing mechanism is used.

In doing these ptdesc calls here, we're running into issues with the
concurrent work around ptdescs: Allocating frozen page tables[1] and
separately allocating ptdesc[2].

What we're seeing is attempts to cast a page that has still been
allocated by the regular page allocator to a ptdesc - which won't work
anymore.

My hunch is we want alot of the code in pat/set_memory.c to be using ptdescs
aka page table descriptors. At least all the allocations/frees for now.
Does that seem right? I'm not really familiar with this code though...

[1] https://lore.kernel.org/linux-mm/202511172257.ffd96dab-lkp@intel.com/T/#mf68f9c13f4b188eac08ae261c0172afe81a75827
[2] https://lore.kernel.org/linux-mm/20251020001652.2116669-1-willy@infradead.org/T/#md72f66473e017d6f3ce277405ad115e71898f418

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/mm/init_64.c        | 2 +-
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0e4270e20fad..3d9a5e4ccaa4 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>  		free_reserved_pages(page, nr_pages);
>  #endif
>  	} else {
> -		__free_pages(page, order);
> +		pagetable_free(page_ptdesc(page));
>  	}
>  }
>  
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 970981893c9b..fffb6ef1997d 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -429,7 +429,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  
>  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>  		list_del(&ptdesc->pt_list);
> -		__free_page(ptdesc_page(ptdesc));
> +		pagetable_free(ptdesc);
>  	}
>  }
>  
> -- 
> 2.43.0
> 
