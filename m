Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A3134BD
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 17:57:15 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8b2b60731so33532875ad.2
        for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689703035; x=1692295035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRD9blNIxHluSUPOIYULRJbi8uFOds7uOEZDc3kDErE=;
        b=mMpImavfY2ADOOfTsM0dULPAztPWwAkAxaN5EBRdgTONlUbuDv0bc/jnql1JEnUeOO
         bda5Tj4uvdDQ4B+NJ/gmvkMeUhOrHdA5CxK42FliEYPeTWhjOiI8i0+G+nUodHSTQx/g
         HanMLQr/dHe8w7iHPBOx35pnzrQWodjmfukbs1BbseIHXHWTRnEizqCumzGYhUaGm+dQ
         jRxPO5RqjGL1hwX87TamgliuO3lsmronneNDvHaIucdFlccgiBcVHg4FAmdI6hkUO0Ji
         3UXm13B3+3pT+2iToWzn8Ie1OvrVbaXYWR6AEsbzg//AwTK48dHUa2cpqzFIrDJGPtWZ
         5PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703035; x=1692295035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRD9blNIxHluSUPOIYULRJbi8uFOds7uOEZDc3kDErE=;
        b=i2QMPp+Uhn+kP0v/kdovqKIPMf+w3NwP/VTftEyS8OOSyt+ARo/TQt6LIxNZ1lrDyK
         eFTaDFrZxgPggWBsem39Ij8meRHa0QT2kZ8OrBjQho8pzVpqqL3RH7YEOIRehjIDPS0s
         ZIbzxOcyOUzfxngDIejXJ93R6nQMC3FyTwOEF0+qqu+WdvqDt90ivAtTqFDrFci2FaEJ
         sbjNh7auGKr8laufb8ZWxr+0J2A5WZw4cCO4uNIc7UfaCt+Fw1lRaSpTrOuf6zW0mPVu
         yy8mXdsb9E9pXVda24j/cjOzGHpUkDGbTiYtOKoZ6/JCg21YQrQ5wB+Y1g6yx8bGWzLP
         Jxzw==
X-Gm-Message-State: ABy/qLZRqjAb2g/d3cjG3D7v6tbE1wv1TpFod8IdcJU2XXL4F/MNisTy
	mtT21TqZoqAy6BEZ/AyLIWw/pg==
X-Google-Smtp-Source: APBJJlH/DFdDcamBY608z6if+lXRDqfUJnrs4w53GX7UPxfbPo+Y0+UeHJe6ZmJVTzN0SvAK3Kq8RA==
X-Received: by 2002:a17:902:e549:b0:1b8:aef2:773e with SMTP id n9-20020a170902e54900b001b8aef2773emr17009609plf.46.1689703034916;
        Tue, 18 Jul 2023 10:57:14 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001b89612dc7dsm2167740plb.142.2023.07.18.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:57:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qLowi-002aex-Bi;
	Tue, 18 Jul 2023 14:57:12 -0300
Date: Tue, 18 Jul 2023 14:57:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, ajd@linux.ibm.com, catalin.marinas@arm.com,
	fbarrat@linux.ibm.com, iommu@lists.linux.dev, jhubbard@nvidia.com,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, nicolinc@nvidia.com, npiggin@gmail.com,
	robin.murphy@arm.com, seanjc@google.com, will@kernel.org,
	x86@kernel.org, zhi.wang.linux@gmail.com
Subject: Re: [PATCH 1/4] mm_notifiers: Rename invalidate_range notifier
Message-ID: <ZLbSeO+XjSx1W795@ziepe.ca>
References: <cover.b4454f7f3d0afbfe1965e8026823cd50a42954b4.1689666760.git-series.apopple@nvidia.com>
 <c0daf0870f7220bbf815713463aff86970a5d0fa.1689666760.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0daf0870f7220bbf815713463aff86970a5d0fa.1689666760.git-series.apopple@nvidia.com>

On Tue, Jul 18, 2023 at 05:56:15PM +1000, Alistair Popple wrote:
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index b466172..48c81b9 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -456,7 +456,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  		return;
>  
>  	tlb_flush(tlb);
> -	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
> +	mmu_notifier_invalidate_secondary_tlbs(tlb->mm, tlb->start, tlb->end);
>  	__tlb_reset_range(tlb);

Does this compile? I don't see
"mmu_notifier_invalidate_secondary_tlbs" ?

Maybe we don't need to rename this function since you pretty much
remove it in the next patches?

> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 50c0dde..34c5a84 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -207,7 +207,7 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
>  	 *    spin_lock
>  	 *     seq = ++subscriptions->invalidate_seq
>  	 *    spin_unlock
> -	 *     op->invalidate_range():
> +	 *     op->invalidate_secondary_tlbs():

The later patch should delete this stuff from the comment too, we
no longer guarantee this relationship?

> @@ -560,23 +560,23 @@ mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
>  	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
>  				 srcu_read_lock_held(&srcu)) {
>  		/*
> -		 * Call invalidate_range here too to avoid the need for the
> -		 * subsystem of having to register an invalidate_range_end
> -		 * call-back when there is invalidate_range already. Usually a
> -		 * subsystem registers either invalidate_range_start()/end() or
> -		 * invalidate_range(), so this will be no additional overhead
> -		 * (besides the pointer check).
> +		 * Subsystems should register either invalidate_secondary_tlbs()
> +		 * or invalidate_range_start()/end() callbacks.
>  		 *
> -		 * We skip call to invalidate_range() if we know it is safe ie
> -		 * call site use mmu_notifier_invalidate_range_only_end() which
> -		 * is safe to do when we know that a call to invalidate_range()
> -		 * already happen under page table lock.
> +		 * We call invalidate_secondary_tlbs() here so that subsystems
> +		 * can use larger range based invalidations. In some cases
> +		 * though invalidate_secondary_tlbs() needs to be called while
> +		 * holding the page table lock. In that case call sites use
> +		 * mmu_notifier_invalidate_range_only_end() and we know it is
> +		 * safe to skip secondary TLB invalidation as it will have
> +		 * already been done.
>  		 */
> -		if (!only_end && subscription->ops->invalidate_range)
> -			subscription->ops->invalidate_range(subscription,
> -							    range->mm,
> -							    range->start,
> -							    range->end);
> +		if (!only_end && subscription->ops->invalidate_secondary_tlbs)
> +			subscription->ops->invalidate_secondary_tlbs(

More doesn't compile, and the comment has the same issue..

But I think the approach in this series looks fine, it is so much
cleaner after we remove all the cruft in patch 4, just look at the
diffstat..

Jason
