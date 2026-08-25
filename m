Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E234D384
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684495; cv=none; b=oumn2H5RF4UHZMdxOwo85ynGsW3feD5P+FV3UxOLt4xe6sgffFiVBbvZBHgPBzZ7IW2Q7q29ZTASehso0xk5QlN4zn7KJE8XFren9imprEdAMT4TEfnUYnnZBdwMEB+jw0jet+4LCjXmNPN2mFKZrLKhN8haWR4SkdXySMSVQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684495; c=relaxed/simple;
	bh=1HYlp9SU3y2irlcmJtmjwqIySSPAL8PKJ/yum36jfnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1J49G/tlBwUsBC19nqjcQ/KSyB7lpPvdyIquI+gK7Vx3+A+cz/eB9hf2dLmuz2bhosxn8G2NBz137w8xXBuHDE9G2nTAIDu8Bn/a/rC2uK9lFVQQTjcqmgygQPkSiWvaTzZublMLXGGjQ+58g08OjeFYyrYqHO8jZ6+Ja+gEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aU1IsrNa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aU1IsrNa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso24815ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684493; x=1788289293; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ceytE3N4NhL3+U5+JSuY4KQs+S6VrDSuw0Kxq2SL/M=;
        b=aU1IsrNaAqq+5QcvDOCIAdn8Qs2E6PhwOSU6N7IqQTtYE3D+TrTrIFc62I6zwiNNVp
         uxvEnpHhizhGdXPhYzXBZsjFxIge9UkEws7FZB8UfzKBMNtA1vE1tDE5tWABgh+jYLuZ
         SZiRaq2fw/LZHBmwBsgktrHDOC5uKvNnNxpZP1TURtMHyW4wxeoiC9WmU5ViZkjD2txG
         ozPQkxORX2MnCjSlu+cAo5wIMv6OtRC7U7DEEabUWGlFsDjY7zvVAdjWy/u8kpkxhRIa
         SQ2f7XmkrWY3zvi28QoaX14NEBDB6eKrqgt2krMYtg3iRnp79QHDh1VZiiTV5y7Va0bL
         zp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684493; x=1788289293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ceytE3N4NhL3+U5+JSuY4KQs+S6VrDSuw0Kxq2SL/M=;
        b=OLh6EL76ebyPQOya6x04zhR2bSKs+n2//rfIxyKNgF2BguEG++vDOKt0cj8sLmabqR
         qZa7mHHLsElfr0wzrE0LIH73ahgTfWH/xr5TmlMVpRKhiepZrkt0thWIGfDIxzmasUcL
         l6/e6kMLBfw7iYf0729pHkNBN3POVfJPckL0V4u0zUFeA/u42DDpvVlJqWmWUIQu8jhO
         wd+4qHraOH3TSABHLjGvAUc365+e8LGfYgy75P51q/pO+KY1dW1+7KgGgYAsLbAj2vaP
         6weOk8+8xhthvRFW5SWb0VHLags3FO13jXHzB5g2sNLjRvJP5Mqbkie81k7d51qd0nd5
         9W2A==
X-Forwarded-Encrypted: i=1; AHgh+RpEAUvoQCzv/35zl6mlSCt2mzcwxan63NigH2X/PajWOiwFr2n5zDW5JMmSZ0gBwJznn9EbiA==@lists.linux.dev
X-Gm-Message-State: AFuF++lZCCOZUCxTV43AbphOkxCwvx6Ld63HiZV7aox9u7JVpN2t37ou
	EzqvOnKmihMPZKcywo0wyKfj6mlav3rm0yb3hLihnFit7NX4Xke/SdMiLa7L06dH6Q==
X-Gm-Gg: AR+sD12hdYuGGH0goAubJwAiwVhEKznEullo2Y92g9ZUZ6kJitILCQ44BnNvxYOWW7O
	eucEmBN0iMvoNXBq8+deF6ERufR11S3+UPXYSQiMqwW9ar9E+AiusZIj/6qEB988GTeZ7zU6R9i
	s2HjI2kAqwxbQg3Nry4iVAaXnyDL+7O7FdmdUaaVf/OahOKgQ+M0sLA0nf/0lrZXTGVzHFZA7j7
	ENKHnniTFnJlyiGTNPFdlpfYK1B6Vf/o5UgTLx1lwGDhn/fo1D1+TNm6YU3lgDdGNehxqRisKsm
	FBVM74kc3ppC54xb3chrTgOKnMhYBjx00rsUzvfzDHJp1bFFklOQ+TNOsWN277NRUsP1uYatlrB
	atkehax+KkEyjZDMCv29GzX950CiXSYA6ofKK+yp/Yvzefo+A+KY5VXb8dpReB1C69hJoReQ3M3
	SNzk1f9oiHbVm4AkwWY2xOtUi8m7BdggHMPqaVfNl50vXqwTB3ZXVJK9WlJe2VfzH3vIFDIFYEp
	wXJFAKH/bxAU9zB/zBKA1ieqD8KQc8rP2zN
X-Received: by 2002:a17:903:3c2e:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2d707a53b4cmr775485ad.1.1787684492584;
        Tue, 25 Aug 2026 12:01:32 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a5a55esm789611a91.16.2026.08.25.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:01:32 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:01:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 01/12] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <ao3mhkgmCJhWVo9r@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-2-praan@google.com>
 <178767577112.3356902.15076197547390630060.b4-review@b4>
 <ao3SYLiFAQnsfJGb@google.com>
 <ao3jXWVF0qcnVFp1@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao3jXWVF0qcnVFp1@nvidia.com>

On Tue, Aug 25, 2026 at 11:47:57AM -0700, Nicolin Chen wrote:
> On Tue, Aug 25, 2026 at 05:35:28PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 84 lines skipped ... ]
> > > > +	/* Setup interrupt handlers */
> > > > +	ret = arm_smmu_setup_irqs(smmu);
> > > > +	if (ret) {
> > > > +		dev_err(smmu->dev, "failed to setup irqs\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > 
> > > The sashiko remark makes sense to me, we should not enable interrupts
> > > until everything has been initialized and things are ready to go. So
> > > this is better done after the device reset call, which is the thing
> > > that is setting up the queue pointers in HW..
> > > 
> > > I'm not sure what to make of the MSI register ordering around kdump
> > > comment.. Nicolin?
> > > 
> > 
> > Ack. I agree with Sashiko's remarks, we'd need to call this within
> > device_reset right before the SMMU is enabled (same place as today).
> > I factored this out to avoid setting up irq handlers multiple times
> > across a suspend / resume cycle (for e.g. we can't request_irq multiple
> > times for the same irq). Otherwise, we'd have to de-register IRQ
> > handlers in the suspend callback. Maybe we could do this ONCE based on 
> > some smmu->inited bool?
> 
> Yea, setting MSI while IRQ and CMDQ are enabled might be an issue.
> 
> FWIW, my kdump series disables EVTQ and PRIQ, so the concern would
> only apply to GERROR.
> 

Hmm, I guess I'll move it into the reset handler with some smmu->inited?
The other thing could be somehow masking all interrupts till we *really* 
enable the SMMU. 

Which one sounds better to you? Any preference? 
(Will / Jason / Mostafa / Daniel?)

Thanks,
Praan
