Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BA3FBEC2
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070494; cv=none; b=i8/IoUu3uQqtZGLHB+vuMwXKD5Ra5OfPm4znWclFeUMobYDkJgtXF5UNrwRswoGfqco5pgVou0Exjwcdljtuyi6nB2jPzFPooseQnP/fCvaAuDFB4fQe48bSrVXUpGf2JgJCTpkpSfqRreJStmtoklDz8DPjAZXPL6+yb3G3kDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070494; c=relaxed/simple;
	bh=0wbebf2HPx9TeEtYpz9WSEST6/aBh9LpgQNb5KW7e/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8atfP91gN9aD9+ytk2jhzwr+ngAe/Tz16Vk7GxuOKLzstaw8TpJYPa/swAPDciHnhTDz68hjZzsOXziH9wfIedsqVDS0s6alF4zOyJhP40TKhwWDrEyutrYtG3Q6iNnq3XpkfM5Z8GPPGEeoX71P0weVd/ESv9HHBeMiUqTykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OjxSeNwF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OjxSeNwF"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8e0a768331cso934184885a.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777070489; x=1777675289; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nigELrq2iU48oxK96NCIrHW0Yy445jx+Cu1pez2xaU=;
        b=OjxSeNwFo0kWJdLQhzSnzh3kgMKwHwquo+A8dMKkuuHM0ScMLkZVb+uR7Q12fQvnU0
         2effG3dw2ubctTcdBR4m2pjRtd/GiddncrzNBd+72tXL/Bslxgo8MCuyR6lFoX7wGJ9G
         m5h3piA7jbfQak/uCn1aK7WK/jznWxjZf7I5zRevs4YRrgNbKCId+baszssV8sbGs86h
         moR0AxHAknuZsyXv4GH5xAJZmbu6y4AzV4vI+7VmhmEqCQ/PfsqT1GkYLY7enLTlseYn
         jmQHcxEvbXyHD5rF18AbE6Ic7CSJfDMDwsKlvjZC7UpfMqJZr42yEIvAzzqXoza0xHYw
         ktWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777070489; x=1777675289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nigELrq2iU48oxK96NCIrHW0Yy445jx+Cu1pez2xaU=;
        b=YrLI6eHoMatNM4DoIhSVAyrk8bDEKEZxm0nGpDVvIfNyC4JDKIsUFrtGfopDuKM82e
         KDHHlMVEd/Xd2du+q9MJmROhtbDG2El1OTuVf/1yqdmzAChy6OA++xSZQyvxLbpf5Zde
         9bKAHBxkej/NSTRBMXd5YxoWxCK87iVakyS+PZzQyCuexkUqWL3eQ2x22JOszBxegJYH
         KYBJiE+Si0Dtv6cphaZQMX5/T2n9cXfecj65xml6HVZ7ZcB4DOv59dvOYRiblV1v/q55
         1mUgTxf9EfxXYWp4m5oalr3ZrJytJLCv316PGQKe15lqxlGf1eLf4KTgqla1l395iC/X
         5wNQ==
X-Gm-Message-State: AOJu0YwExcbYcD1IQv0opsDvUF0IekcBFTREh4TwPDXlk57lSOzfpo7P
	D4XNkoZpy3xTVp/dYAt+8zneZGSToE1b16BAt6j91qmnUSbBNMHZGvTQnXJ4b0hbXXE=
X-Gm-Gg: AeBDievGaXyJZ5zCjSNmFxBF1h2KD+bVbsKLiZYDBisZDTi+s470ZA1A8MPmgDsrgQG
	uA/QciJgCksrJq54ySHWiDSiQkFBFBOqL5J+FVwBDhDsTa6Y2oY/lLEK3phWLr4in87OHaXljxG
	oNsVqa8muDxAzv9Dngd3TCt1U92MOpoIiCcNlxb1N/IkBbxUDlPdnoOSwzVv69oR1SlZuvRfWeb
	5Z5bhqcoulBcMyAIhADR8+5n+rqDsbChCp6eMaftaoIvtPfCE3X2GY0lDJJnoLcrqspyKonCWB0
	1fuDapVuS2ahO3mfzhfltfG/ehuLW/WKW6GI6EhTrUg/eCw1Yd62UVuTZXIsVG8QILrTbQOFMpJ
	2BHIwcdzet0QUjvDwxVAecOZh0N7pzDaO7eofTCtsXU+KclveziTehk87wDxDuNAmwyR0ASOijn
	Ap0Gk3g6MEuhlOM23Wn7AJomUee4WJbvIhQiLFghNb9z4ORKxRR/BIjf1EZJrS3EFOmL8MRtwNB
	JLRgD8nAtWFtSIL
X-Received: by 2002:ac8:5a0f:0:b0:50d:a8f5:fa94 with SMTP id d75a77b69052e-50e36738adfmr435612941cf.21.1777070489381;
        Fri, 24 Apr 2026 15:41:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e5d5ecffdsm147416631cf.29.2026.04.24.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:41:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGPDD-00000004sdv-3EBS;
	Fri, 24 Apr 2026 19:41:27 -0300
Date: Fri, 24 Apr 2026 19:41:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 6/8] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260424224127.GC804026@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-7-aneesh.kumar@kernel.org>
 <20260421122924.GB3611611@ziepe.ca>
 <yq5apl3rczmj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apl3rczmj.fsf@kernel.org>

On Wed, Apr 22, 2026 at 11:20:28AM +0530, Aneesh Kumar K.V wrote:
> >> -			if (is_swiotlb_active(dev) &&
> >> -			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> >> -				return swiotlb_map(dev, phys, size, dir, attrs);
> >> +		dma_addr = phys_to_dma_encrypted(dev, phys);
> >> +	}
> >>  
> >> -			goto err_overflow;
> >> -		}
> >> +	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> >> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> >> +		if (is_swiotlb_active(dev) &&
> >> +		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> >> +			return swiotlb_map(dev, phys, size, dir, attrs);
> >> +		goto err_overflow;
> >>  	}
> >
> > Then this movement shouldn't be needed?
> 
> I am still not clear about the use of DMA_ATTR_CC_SHARED here. If the
> resulting DMA address is not dma_capable, I was expecting that we should
> fall back to swiotlb_map().

"resulting" ? From what?

The user provides an address. If the provided address is marked
DMA_ATTR_CC_SHARED, then dma_capable should succeed on a CC
system. Otherwise if !DMA_ATTR_CC_SHARED dma_capable must require T=1,
or fail if T=0.

> That was the intention behind this change.
> However, the other email thread suggests that DMA_ATTR_CC_SHARED is
> always used with swiotlb_force_bounce(). I think we should address that.
> If we do, the goal here would be to check dma_capable for both shared
> and private addresses.

The flow I think should be

 if (force swiotlb)
    then do swiotlb

 if (!dma_capable())
    then do swiotlb

 if (kmalloc_needs_bounce())
    then do swiotlb

 otherwise use the provided phys_addr directly

ie stop using force swiotlb to handle T=0, instead have dma_capable
directly check T together with DMA_ATTR_CC_SHARED.

> For private/protected addresses, swiotlb_map() will currently fail with
> DMA_MAPPING_ERROR because the default io_tlb_mem (dev->dma_io_tlb_mem)
> is decrypted by default

This is a bug in swiotlb. swiotlb must *always* returns something that
is usable by the device, or it is broken. ie the pa it picks must pass
dma_capable:

It must return a buffer that falls within the dma mask

It must return an unprotected buffer if the device is T=0

It must return a protected buffer if the device is T=1 (ie it should
not choose an unprotected buffer just because DMA_ATTR_CC_SHARED, we
might be bouncing because the device dma mask can't reach the
unprotected adress space)

So, when the device is switched to T=1 something also has to go and
fix swiotlb so it is using T=1 memory too, and there should be
defensive WARN_ONs in the swiotlb path that the memory it picked is
suitable.

Jason
