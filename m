Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5087261A
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232106; cv=none; b=mxgOyxyl4cTgD4Cd61RUmPQsX3SQdvfjGIp7ITgXvihGH5/cM0QlgjY3LadloHN2VdVSGqQQCU/M1ErWWj/6N18Tq603zj1kZQj/BSS8wn2w0/N09aTz74RsCUKy5X/Ux5VmcyGv92q7bUmmoVNUderBtZq2NPnwqJIalqRUfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232106; c=relaxed/simple;
	bh=DhLAY5LO0/YfI0VhfhrLmhY7xiirkeGZQW0pYY3E/ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZUaYoMc1C1QjgILwSvHvfRLVP2plhJym4USUF2MPzpfR4jKoG8ousnInglQS4VHKUiMPWUXcLYHCbnW/SC3NlwcHgQyEKnZq/bSxWulFMC96xM84vWCxjlDA/AhjiXp/VTmhULxSvJBnp2VBy1KDMmpZIZqGZ4J+rnLeGuXaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijMhEjHI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijMhEjHI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so61305e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773232103; x=1773836903; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z2mPFpxlHPadjopfqDbZ+cCX20y11ulYzb87JTfKSeg=;
        b=ijMhEjHIGAMChT+sHOXnbSWErwA5jp4Tn4wTIgujX9lE8VWYnMYwIoSazVr/dGlyhq
         HMoVW2OgdrbSH/s9QPROLTBve4aeImXyAUl2h6qMrng6aImoMaAHnnbLmEgtU9BqJyoT
         7wDVGJZ/fsBL7fPqW/FC6zey5sglG53VX7qraax9Qwrhx/3PTRJEOBbPVQkke1xrHQrP
         PwXo0F+RaICDzzTZsCnActPluCGpnV5QGoluHWToGEAQ5T1BqaKhH8PXhY94v6BLUoT2
         SExVvUOpQd//CZXE5C2KOCEKGqFrEmnaBxsRF8yy9rWnQN+inN4YImdZKdS+WoOb81Yu
         AHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232103; x=1773836903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2mPFpxlHPadjopfqDbZ+cCX20y11ulYzb87JTfKSeg=;
        b=IEFz35q4Pha5jYSHs7F1cKYmuNlIV+stB5YEyYCMrE7spMS41UMxsB553EVX3U9fcx
         g2sMIp3Mx9xaKxP853/6Tib149cSoBu+p0J7Jeqq556eIYKpio/mWC/q5uszD7LLFC3H
         FXmbYMPAicQjJJrkFU32txAKjYe6fHs5HyepmU/1r0RZc0122cJyf1gB3G8kHURYFidg
         D+nLXcJuyafyRwuY6Q44XQKhCO0ipViPOZWpUJnXG3/s2KyAqj40SdNU5zl6t8ovY8Jl
         kwFCOJdVQJKFNg2CxqDtrv5vgH5igFV2GytSQEpR44y2QWtaDwQOOS+c5ibE5xlyuuBb
         8BWQ==
X-Gm-Message-State: AOJu0Yx6WMQ9x5/3Fog4Y7dtnnl58BdV6MhWBhu6eql+TmIDfTuxspOP
	ne8ggSWCBVlYOIog7GAAZVpXhtX3ALuKZ9+aOfQ7OILJJpEB3MJaff5+2btdsqlT1g==
X-Gm-Gg: ATEYQzzsbp+k9WfIwHhfYQxJQJDWcbl+frM16T0NVS8ZV6PY11v/Bj0rcR0YpMwixDu
	IViebTyrjl1STYlW+R2FMzoK5GSmOain84VO+5jE5OZcOS2wftbRiCIbEbfJ+M0p3goSQeSYRQm
	lRSWL2Fl72uIVegaKWZpkgZ54QTuaUyR41nOMCMy6fMFkc+vCoPdg50ypKRDQ1rRHfjkRUYDC3t
	4ZdqboIwAgkudE+umIE6hMD67jcImANVNntu30cuZgVuBWpVbrlPwBxZdoekyDfjP4OuqzS3iXa
	qNhKwUaasopO7uOLjFheCWQg9iHGSzEFFJF5MkCSrSJPf3U3s76Bl+yoL3o4V77koKryigMO/vZ
	+PpUWT/4vokz9t9KiCcBwsKM99Y/FTRIde3ljxLTjBDTEV0mDkzB0qKY7jnkFamLFIvjn3mO7MA
	Ut2YYTk3xQqw6ZsyrVQxgGDUFTpLaMzHtbM1/0+h2bJ+Xwlkv+PwfF8Kd1UiLmCvmvtw8=
X-Received: by 2002:a05:600c:64cc:b0:477:86fd:fb48 with SMTP id 5b1f17b1804b1-4854b0be077mr706795e9.9.1773232103179;
        Wed, 11 Mar 2026 05:28:23 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm47492435e9.14.2026.03.11.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:28:22 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:28:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com
Subject: Re: [RFC PATCH 2/2] dma-mapping: Use the correct phys_to_dma() for
 DMA_RESTRICTED_POOL
Message-ID: <abFf4vZdAT1urjbX@google.com>
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-3-smostafa@google.com>
 <abAXsK6XE6119g09@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abAXsK6XE6119g09@arm.com>

On Tue, Mar 10, 2026 at 01:08:00PM +0000, Catalin Marinas wrote:
> On Thu, Mar 05, 2026 at 05:03:35PM +0000, Mostafa Saleh wrote:
> > As restricted dma pools are always decrypted, in swiotlb.c it uses
> > phys_to_dma_unencrypted() for address conversion.
> > 
> > However, in DMA-direct, calls to phys_to_dma_direct() with
> > force_dma_unencrypted() returning false, will fallback to
> > phys_to_dma() which is inconsistent for memory allocated from
> > restricted dma pools.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 27d804f0473f..1a402bb956d9 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
> >  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> >  		phys_addr_t phys)
> >  {
> > -	if (force_dma_unencrypted(dev))
> > +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
> >  		return phys_to_dma_unencrypted(dev, phys);
> >  	return phys_to_dma(dev, phys);
> >  }
> 
> I couldn't fully get my head around the DMA API but I think all the
> pools and bounce buffers are decrypted and protected guests (or realms
> for Arm CCA) should always return true for force_dma_unencrypted(). If
> that's the case, the above change wouldn't be necessary. I can see that
> arm64 only does this for CCA and not pKVM guests.
> 

Yes, that’s the problem, pKVM relies on SWIOTLB to use decrypted
buffers and not force_dma_unencrypted() in DMA-direct.
So, at the moment pKVM guests actually call:
- phys_to_dma_unencrypted(): From swiotlb code
- phys_to_dma(): From Direct-DMA code

Which is in-consistent, but only works as the pKVM memory encryption/
decryption is in-place, so there is no address conversion.

I was looking into setting force_dma_unencrypted() to true for pKVM,
which then resulted in the bug of double-decryption I am trying to solve
with patch-1.

I think the main problem is that SWIOTLB(restricted DMA) decrypts stuff
unconditionally, so we have to treat is_swiotlb_for_alloc() the same way as
force_dma_unencrypted().
That is what these 2 patches do, otherwise we teach SWIOTLB code about
force_dma_unencrypted().

Thanks,
Mostafa


> Device assignment is another story that requires reworking those DMA
> pools to support encrypted buffers.


> 
> -- 
> Catalin
