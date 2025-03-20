Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA61B422A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509561; cv=none; b=TPQGlhNL581kHSzWE6HD19XZtJuO0XIMIHk9XLjixqfTz801sTAfUmOaRjZqWzuR3A1GNcfA11FZvTJOkl63n8eNKwwYd3mo9FlKt8jFfH0ojxhopi00FSJyfRLJwzQAOJoueybGj3NAzccDsrosLASvr8mZ7Kc+tJV1CKOYetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509561; c=relaxed/simple;
	bh=rtgfneJuGU5MepEKABOy9ED/U9xJNGCwYpR8TscSO58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMuFqCYJ6QH6IvlCvT7svfH4WZK+aji9+nh4bKUNT9FH+MeLZaNuub3uILFinxoPVLUP2iWVj3/tSWsnyoI43NMeZlmbFejdDLUl2zEAV1xtZ0f4fVG8GIwJumVbMQriUiiCBJvirmPddZy3ESbE9+mih1Cp4RRzaOsZRzbQFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Igezh+WA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Igezh+WA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe808908so22345e9.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742509558; x=1743114358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqbAwe3T4QdQaJvGcspAuta0Dd/wr2yfLGyOGxPfoCY=;
        b=Igezh+WAhljto6t2H2YWJX3nJfRdrS0xcxX/wMWv/+O385Uo2Qrllse1FH2KGfVBID
         +08ayVICvU2l46AUkDTgJyL0NGNjeD0fqs/3K5rL+Gk0GDGqJKbekgJPtI2Ph7slPKhi
         rgx2VdAqJ+cBhh7BjFKXFn+TLxbLmlkzE7Xw5VqpEqk9p4jXfdS54vvxDzRSbKWRt5QQ
         8xzhy3ISQjVFYXcmgKuh/HITgHpdHmSjyfV/PggdvvEwUyKj0NR+oYTOKZJ2FJLsknQz
         n9zD/OuvUGGsXMWF3kzwL21ZDyZ4tmwyo8a8Ei6FIsYjdwc8MqtY3yHg2ltcNtBlEUI6
         sY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742509558; x=1743114358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqbAwe3T4QdQaJvGcspAuta0Dd/wr2yfLGyOGxPfoCY=;
        b=hmPdKaV2X42tM7+LiuquUp7HYHJDYgLw2xnB3G2VYcE8GfwT4fPgebhjh0AoCiXq4X
         u9YTmsjJofxnvK6xLZEpw5OBX+wcjR6FU4iWVfTDjBPAK+nTJrH7VBPdsEON+G7ATfWm
         WXkuiYdfVHE8Lz41ULBGGO6QnEay0idKYHXgxh1gZtUXLH//a0hZbkFrLR88O7aduM2H
         Z9Ru0IHr/8E+vR2YHWXas9iTf3iJOyrwzAdXR/dX5x0In6O0CACsZvg/MxQrRwruGvTM
         2UW/4jPOWSPz+r2BdkAWW9AlznCprooSQvF3aW1MBjgftOxnCCbGMzvORXq2gGuVesmf
         7iFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE+/ZI09Q7/peMTA5QlNq6Yv1uqtPLXTgEK1Ic9qLFiA+tdb7tyyHafdYPmSQ1tKAC4OVwnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkFSaZlzrRWZIEMTnawIv85TxdANC6tfem+oYBe+nDRWqWovyv
	wcC9AapEqwbKIorZ+Ur3qU+Upp8M6veLaLz5a541PT39FmcNmZNDMUaPOUe/Jw==
X-Gm-Gg: ASbGnct7jwcGhLHmdJL5lKreVrp9ZcEqxRS+OwB4pgoFEEVB0lYTDQTA4guOE/60lHL
	7TM75uaNWEvqqlOua2g1yImlfsMxr2nOgqBPEqSsILNhT7AbHjbvLsG3k3KB/3uYuxJcy0pnASO
	MsnLvvMTpJHEwLIkEzfPzAArBIoJHqBDA7ng3ijfExZ5T0fVlo2iZwrt7udD3bMN+9oZuHsxgvw
	ZiOyGZbpC5HrnYvVvbFI2xMaXfm2VMkCREkcr0Xpd2ak3HkrhGNWhsEtrVXQeCz+A85HD9h2nip
	k1fhomAjRgkXXOlun3QEF7x06vReHVv0bF0/4OK1RWU32BSH00II6e8RmDU68sQPg2kzCeaUiHl
	Uhyax
X-Google-Smtp-Source: AGHT+IEYYJeMizIldVex1EiTO8GCb+0HbY3HsKfquI1PVS0/XxNfg4Rer0KrgtoNJIEdAArjSVJkxQ==
X-Received: by 2002:a05:600c:2296:b0:439:7fc2:c7ad with SMTP id 5b1f17b1804b1-43d515d3c19mr122805e9.7.1742509557863;
        Thu, 20 Mar 2025 15:25:57 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9f0107sm711541f8f.99.2025.03.20.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:25:57 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:25:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z9yV8KsdXnZg1Ppo@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>

On Wed, Mar 19, 2025 at 04:07:57PM +0000, Robin Murphy wrote:
> On 19/03/2025 11:57 am, Jason Gunthorpe wrote:
> > On Wed, Mar 19, 2025 at 12:42:49AM +0000, Pranjal Shrivastava wrote:
> > 
> > > 3. Invoking runtime_pm_get/put
> > > Given that most of the configuration done by arm-smmu-v3 is stored in
> > > memory, the initial idea is to focus on areas where the driver accesses
> > > the hw via exposed ops, like iommmu_ops, iommu_flush_ops, sva_ops etc.
> > 
> > This seems weird, if the SMMU is suspended doesn't it also fail DMA
> > transactions? Why would ops like flush even be called if the HW is
> > disabled?
> 
> Because once the device has finished its operation, its driver is free to
> call rpm_put() before calling dma_unmap(), so by the time that gets as far
> as TLB maintenance, the SMMU may already be asleep as well if that device
> was the only thing keeping it awake.
> 
> For direct IOMMU API users, pagetable update may be even more asynchronous
> from device activity, e.g. a GPU buffer might only be unmapped once
> userspace closes the last file handle referencing it, long after the GPU
> itself has moved on to other things.
> 
> > flush is performance path stuff, so it doesn't seem great to be adding
> > extra calls there.
> 
> That much is true - this really wants to be using pm_runtime_get_if_in_use()
> nearly everywhere such that at most it's just juggling refcounts. There's no
> point waking the SMMU up just to issue a CFGI or TLBI, if the act of doing
> so is inherently going to do a full arm_smmu_reset() and thus invalidate
> everything anyway.

AFAICT, there is no guarantees that caches are clean on system resume,
but as we do invalidate everything that should be fine, but I am not sure
how that works with distributed SMMUs where the TBU can still be powered
with some TLBs that can be invalid?

Thanks,
Mostafa
> 
> > > Instead of wrapping every exposed op with an rpm_get/put, the idea is to
> > > follow through till a logical common point (lowest common ancestor in
> > > the call hierarchies) and wrap those with the rpm_get/put calls.
> > 
> > Should the iommu core be doing this instead of hidden in drivers? It
> > seems like there might be better information there about when we
> > expect the IOMMU to be powered up and working and when it is OK to
> > have it shutdown?
> 
> On the contrary, I would say it's very much driver-level knowledge as to
> which operations need the hardware accessible or not, and trying to do it at
> the core level would inevitably end up very pessimistic and inefficient, or
> at best just horribly complex.
> 
> > And maybe in this direction we can do things like remove the
> > translation before doing a suspend so that flush ops are not a
> > problem.
> 
> Case in point: that would be a load of extra work to do, make suspend/resume
> even slower, and even then for no benefit, since map_pages/umnmap_pages can
> still be called on the unattached domain (especially a default DMA domain),
> wherein drivers may still end up trying to touch their hardware for various
> reasons in ways invisible to the core API. Easy example: consider a driver
> calling dma_alloc_coherent() to prepare a buffer *before* it wakes up its
> client device (which would then also wake up the SMMU via the device link),
> and deep within that call, arm_lpae_init_pte() ends up calling back into
> arm_smmu_tlb_inv_walk() because it's laying down a block mapping where an
> old empty table PTE happens to be...
> 
> Thanks,
> Robin.
