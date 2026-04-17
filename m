Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2B342C80
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438314; cv=none; b=uF/8Eq7Ec9i8oGpYDJYrh71IiKtycSMrhyRgmdqpSMOxgNEsWWZtyi2jULxN3cw2yC+ow8e+I9vjyBY/yX9fUktVw4GMqFMLAbWkPHlK2xvCDMkDjODfzcnK4hisB5YVRRK+niIGbQ99c0/uy6hzihy3QWv2VWjLEdFSQEnEPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438314; c=relaxed/simple;
	bh=AAr1o/QoQlbcIUCf4oJqM9PTg16ll7ntwVqX3qwv/hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN5dQvLWYUgs0lSsMnWfqkjQaVugSgzoZT7ho+B6gvr7NU8D/8dJo8vXhL7U0okSi6d+rh/nvo+iEs9KVcbFAUJqJMDvzlG+OhOASjPUcAgEqFPkg1vtJ0bqvOI9maXJCtwQtnTtWsTwQYk6F4Z7TVzPm0NWhLQxj69CSYpfdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DP1RG4A9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DP1RG4A9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so10545a12.0
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776438311; x=1777043111; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ZRBseVe21uq2uGwoexbh2seigkqxJq4bhrQd/ABgqY=;
        b=DP1RG4A95TbhZujaTnubX/M1EXQdggtqUrLGoZJvB76MHrk8jrUyz5yRhL1LqyPfwc
         owS6M9zRluFU9r4YBYWxLgDly3nIseAkGu+k9LYOyX4RZr+OrdNtru9JPc3/dU8z5N1Q
         bm2bTxUzGzA0Ke4ZAAE0mI7VsUt2BeAf6HqM6ZeuyQ/1TWUh43MmJ6cbBhS3xx8vVZrN
         5eLgwAxFjBngh8mLGO75vv7AJUDmLONtZhTikfb3sxZvfAHJpiIDNoad5fYWc4kSv6E/
         YnqAnJB+HwCCWcqSp9jr6CxaxXr6e9frUGxC4Rj3bxsS6xw29KOhvRO2z8CdgxCMiyCV
         2hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438311; x=1777043111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZRBseVe21uq2uGwoexbh2seigkqxJq4bhrQd/ABgqY=;
        b=dL9PaiGNMFngzgSlbEnHbfNe6GRavtB9Kq8iMxNn2KFiQR58CNC73RLqlXujTOuFMa
         ajyezdXcNga7Ijj2+4KCEPvO8YuNIe7Twq4pWGjlt2LmnQGlfikoHZNAu1ATx8wBxDir
         rMu9CIe0Whusviy7bd8r8jsrYa6QWV/eRq0MuMsgNjlfz9x2l2kNL9VGj3gbisDD3P82
         mHy5h3ihWHtx6LI4nDy0KeUa2Kiql4T/++ZStDOIFDWewqyXb0b5z+OgKxnxxli/p5Aq
         wPmY520nUSle3yFA19ExA0CBBOa8zh0X1Urk1b9KqKjjdPORi2GrU8/7mRH39JSdVamF
         p3/g==
X-Gm-Message-State: AOJu0YyvBup/xatHpqCCXsYhNBFi8ZIHUe/A/uulcEFNr1zKALxCQmt8
	7Q8b5WgebPRznPiVqfflOrmqj2Li1GxX12qBWgSg9m8v3Uw0Zz6vacGbEos2SJtpVQan+DwlSFk
	G6gc2nQ==
X-Gm-Gg: AeBDiev1O1N6YmeGzZx0sMtwxm5SDA/DIlSlkLr44BW+IVgk/L1VPnNnfPQmGSXAflM
	mOxTd6Fxpbdh0KmOMz2FwJdJm1mZp+nWSneu2QsLONa+G4EjVG1lJDi2QMDImBgry5pOF4sRUs+
	V925am+1BlXUy0CF+C7qf0qYhLBKjD3FNFrLF9dLMxJtuT5Q2PvKWwhoSP6HCxXzLd/+o6IX2XP
	U8u6SxxiS9IHfoU3poIwDPNInfZ19eUwXbyHzpNuB1bhhzZC8cFzjeaIZR0u6MQheAsmwXfSnKK
	0r+E5V4Lt8IReRFe/y0phVyPTA2LRkC+Bpj5jTOxRG7yQEZpiZTLQopkDpOvkYbD2KuIsq8GCHo
	fXEoP07oKErDBleQKERFNAAy1f193nLlSrlZ0PBahtPGALfRqNUzdT8PeRrOtStDOiJsH58tnMr
	a9WOu1OoMojzkCfqWkvfnjoHhf6Xie9Rz0hUSWlS2j4MTOG+/fKit9Ei21mKz9lXPqAOcq+VppM
	Nl+fQ==
X-Received: by 2002:a05:6402:404b:20b0:669:d537:de85 with SMTP id 4fb4d7f45d1cf-672c07d3110mr38388a12.11.1776438310384;
        Fri, 17 Apr 2026 08:05:10 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d5de13sm464445a12.26.2026.04.17.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:05:09 -0700 (PDT)
Date: Fri, 17 Apr 2026 15:05:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v3 1/5] swiotlb: Return state of memory from
 swiotlb_alloc()
Message-ID: <aeJMIel-A26QtX6s@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-2-smostafa@google.com>
 <yq5awly9ao6q.fsf@kernel.org>
 <ad_4WtW5uEZlDdLU@google.com>
 <yq5aeckf9thn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aeckf9thn.fsf@kernel.org>

On Thu, Apr 16, 2026 at 02:23:08PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Tue, Apr 14, 2026 at 02:55:33PM +0530, Aneesh Kumar K.V wrote:
> >> Mostafa Saleh <smostafa@google.com> writes:
> >> 
> >> > Make swiotlb_alloc() return the state of the allocated memory, at
> >> > the moment all the pools are decrypted but that would change soon.
> >> > In the next patches dma-direct will use the returned state to
> >> > determine whether to decrypt the memory and use the proper memory
> >> > decryption/encryption related functions.
> >> >
> >> > Also, add swiotlb_is_decrypted(), that will be used before calling
> >> > swiotlb_free() to check whether the memory needs to be encrypted
> >> > by the caller.
> >> >
> >> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> >> > ---
> >> >  include/linux/swiotlb.h | 25 +++++++++++++++++++++++--
> >> >  kernel/dma/direct.c     |  2 +-
> >> >  kernel/dma/swiotlb.c    | 23 ++++++++++++++++++++++-
> >> >  3 files changed, 46 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> >> > index 3dae0f592063..24be65494ce8 100644
> >> > --- a/include/linux/swiotlb.h
> >> > +++ b/include/linux/swiotlb.h
> >> > @@ -63,6 +63,7 @@ extern void __init swiotlb_update_mem_attributes(void);
> >> >   * @area_nslabs: Number of slots in each area.
> >> >   * @areas:	Array of memory area descriptors.
> >> >   * @slots:	Array of slot descriptors.
> >> > + * @decrypted:	Whether the pool was decrypted or left in default state.
> >> >   * @node:	Member of the IO TLB memory pool list.
> >> >   * @rcu:	RCU head for swiotlb_dyn_free().
> >> >   * @transient:  %true if transient memory pool.
> >> > @@ -77,6 +78,7 @@ struct io_tlb_pool {
> >> >  	unsigned int area_nslabs;
> >> >  	struct io_tlb_area *areas;
> >> >  	struct io_tlb_slot *slots;
> >> > +	bool decrypted;
> >> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >> >  	struct list_head node;
> >> >  	struct rcu_head rcu;
> >> > @@ -281,16 +283,31 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
> >> >
> >> 
> >> Should this be a property of struct io_tlb_mem ? 
> >
> > I envisioned that this would be mainly used by restricted-dma so in
> > that case it doesn’t seem to matter.
> > But generally, I guess it would depend on the discovery mechanism of
> > this memory property and I can imagine a memory allocator that has
> > multiple pools with different attributes. So propably it's better to
> > be per pool.
> >
> 
> If we are going to make this generic, we may not be able to look at only
> restricted-dma. Instead, we will have to consider other SWIOTLB code
> paths as well, such as swiotlb_map(), swiotlb_alloc_pool() etc. For
> example, in swiotlb_dyn_alloc(), how do we determine whether to use
> decrypted or encrypted memory? I am thinking we want to use struct
> io_tlb_mem.decrypted field to determine that
> 
> 	struct io_tlb_mem *mem =
> 		container_of(work, struct io_tlb_mem, dyn_alloc);
> 
> 	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
> 				  default_nareas, mem->phys_limit, mem->decrypted,
> 				  GFP_KERNEL);
> 
> 
> Also, for things like swiotlb_tbl_map_single(), we might want to …
> 
> 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> 
> 	/* if phys addr attribute is encrypted but the device is forcing an encrypted dma addr */
> 	if (!(attrs & DMA_ATTR_CC_DECRYPTED) && force_dma_unencrypted(dev))
> 		require_decrypted = true;
> 
> 	if (require_decrypted != mem->decrypted)
> 		return (phys_addr_t)DMA_MAPPING_ERROR;



I guess that depends on the discovery mechanism, I was thinking
restricted-dma pools can represent that from firmware as device tree
binding.

For SWIOTLB, I am not really sure how that works, as they are shared by
all devices on the system. I was thinking it remains decrypted as it is
typically used by simple devices that doesn't deal with encrypted memory
and devices that require special pools (whether decrypted or encrypted)
they would use restricted-dma.

Thanks,
Mostafa

> 
> -aneesh
