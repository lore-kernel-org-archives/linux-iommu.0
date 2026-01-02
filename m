Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F23B2A0
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378173; cv=none; b=R8Xt4jrQ9UCP5HZurobt9x8jHbkBdU0in7TSWykd5BwIkcmehU1ECOO0gt/AdPk6mMfRPYTOaUeLkXJzmwIscln/K2gzZxXuApP3hi6rPyH8DDDc2YyFElXRXMCQoccKrGYhhUl4W5Qx2VwHoRsQRu3NI92pn4edBglzYrEUFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378173; c=relaxed/simple;
	bh=GdUd1J4V4UTi7y3zHeowygqgFqGp5+/iCY4ovYdkwZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1y0Wzd3N2K+yF69/5x/GsAC6yKhQdcVaytMqTTN3JVA4oI+nukkGxCwlKjCyAhpRgRgAWX630On+JV352fGMlnR/9X2pLkYF5E8OemdIgreVKFpVZf614aO6E4ziCrtoTIRhkoTHjkPqRRhjPPiTixDVKe3DvRQ2RzVlOU7jzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOv5Iajh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOv5Iajh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so2395e9.0
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 10:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767378170; x=1767982970; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5IiIOdbgFZQ8/EhuBk+duA7uZTuVxCyFjJNieGC9yzc=;
        b=gOv5IajhYUd3O9L6tjcX09+1bNJNspqjK8/L70H2u6Lr6N+OlAX+YdoBOyL+yVgoKx
         JD7l6F/7kKAvfpjkX0ld1thfOl4T4tWkN4uaFVWyCq6zX9y52RuCd311fME2zrKLx/g4
         NWpszE18hb4GcE3cnlnNOBSEpgWG0j/VKThowoiJbsbT9NWcyRkoYebvfQZY2jC/h3Wv
         oIhh1Nkvd6OwpcT9QTf57zLNlKR5KU/pigZZkW4rT/2JGUnV4p6+0o1Pn6jAd6Tmt7hV
         AtGnV7zwktQVhq18Ie8aPIL5w4h4cV7/IKq3L87Uw5OoMMr4IpKGYGp98y2qk5nbjzqx
         Byxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767378170; x=1767982970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IiIOdbgFZQ8/EhuBk+duA7uZTuVxCyFjJNieGC9yzc=;
        b=YrA2EdBnr8fQt6mhkTjIHm40WTLIVcrC4Uq+FUotoE3StZa6NQ3u0wLO5uq5yX4OiH
         4o7nAjnYffd0aHbmwoe/XoupnZSFNqFeb0X37Sc52C14bIlylvBr/qwlc6sDtV+UJKx+
         C1sE9x4tfWzLBuoZfkO2sXPAujJELdhAbqe18hXNnNjyzD6hEt/bDM6wGMBybF3OL5f0
         8xKQDE8ZD2k0oxrWOYk9GJYNO0O8FJqd+eCNu+spx9aILEos5oY6V64pJbguA45TgbE6
         xFGSEcb5XUDJVUbmUUjEEn6ayFk4n++4eAlqXPT+xxBHb8U9CRC9CBTW4DRtQ5mAh9VS
         T1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUDsRF5J9q/NskMAvjrNxX6x06VIgFmBp6FmZq1/Mqj4aEqLzWYq7bTtkZ5rVSNgzVJRCCYRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5ZEsA2ubcJO97/0uzIDPj27i+pGiarGg5hPq0ryG40fPrMoGc
	IULOYD7kZLrFqFsUXgGWJwHS7Lqn+hJuPhuWxZFYg2eeBoLVafZ3jzgAw8YtWqgVGA==
X-Gm-Gg: AY/fxX4hQY++R8HHS9m6hK04UnWX5KiRNpiTOy7NHIhWaaZxnA/cNz0mPYE2NE3sWrP
	cyI6eMFYUyOBWtJq62nbz2IcIjIIgcNWq5VcFNqtSy6mA3n4jYpZfHGwulrS//toPspdOUUQIst
	+SLONbEQvs3xaeUvJoBfexAmXxdVBWKNXQXMvbxCTguEyF2BRGI47KjVnTADH/ZChWhFeEObBJm
	ahnsUtb/nBm7MPrTNMva3nA/cuRBMELc0rCme1FM6ygrZSqIU+Ylh3Ad6Kqxg+BLnqWL+AefQQB
	MhL0Vl8XSdawG995n1F4mnpS14OUUUMCqS15af5eOxAzTzgyQ0RdF3PfwMKDICNxufah46nQeqk
	s+jhSHYB5vUiCcKfwYjL986Xz/Yt9BJNAZvN6+IXVu2jUEimI+IAhqSb/KB20FcmQ1Tl3npbp+g
	a3bYInS8XedP+JcbhP5MLN7yX1dPXcn9k5nkIPLyj1wdt836Dyt/Ie
X-Google-Smtp-Source: AGHT+IHPa9BfjetwRVFzisbfuQDu9u4VsHiovnCoNEmzQNdcrMb63MY4lDI/VvFuE8axHy+Gopltqw==
X-Received: by 2002:a05:600c:6a90:b0:477:8282:6cca with SMTP id 5b1f17b1804b1-47d6c328fefmr5725e9.6.1767378169601;
        Fri, 02 Jan 2026 10:22:49 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm86915989f8f.4.2026.01.02.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:22:49 -0800 (PST)
Date: Fri, 2 Jan 2026 18:22:45 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <aVgM9ZNOmK6MdaNa@google.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>
 <aUQvAKjVUT1L3N7j@google.com>
 <aUQ6u+s8YbPiLC8Z@Asurada-Nvidia>
 <20251218180129.GA254720@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218180129.GA254720@nvidia.com>

On Thu, Dec 18, 2025 at 02:01:29PM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 18, 2025 at 09:32:43AM -0800, Nicolin Chen wrote:
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index 12a9669bcc83..a3b29ad20a82 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
> > > >  	 *  fault records even when MEV == 0.
> > > >  	 */
> > > >  	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> > > > +
> > > > +	/*
> > > > +	 * EATS is used to reject and control the ATS behavior of the device. If
> > > > +	 * we are changing it away from 0 then we already trust the device to
> > > > +	 * use ATS properly and we have sequenced the device's ATS enable in PCI
> > > > +	 * config space to prevent it from issuing ATS while we are changing
> > > > +	 * EATS.
> > > > +	 */
> > > 
> > > I am not sure about this one, Is it only about trusting the device?
> 
> Yes. The purpose of EATS=0 is to prevent the device from using ATS at
> all - critically including using translated TLPs eg because it is an
> untrusted device and the OS wants to prevent it from attacking the
> system with direct access to physical memory.
> 
> If the device is trusted then once we disable ATS it must stop issuing
> ATS, so the EATS=0 should never trigger a fault.
> 
> > > I’d be worried about cases where we switch domains, that means that
> > > briefly the HW observers EATS=1 while it was not intended, especially
> > > that EATS is in a different DWORD from S2TTB and CDptr. 
> 
> Well, no, it means EATS is enabled a little bit earlier or disabled a
> little bit later, it doesn't mean it was not intended.
> 
> The point is our rules for ATS say that the ATC is empty at this
> moment and the device is not permitted to do any ATS fetches because
> we won't issue any flushes.
> 
> Thus there can be no concurrent ATS traffic and we don't need to
> exactly sequence EATS with the translation.
> 
> With virtualization the hypervisor is still the exclusive owner of ATS
> and guarentees that EATS enable/disable is sequences correctly with
> ATC invalidation.

I see, thanks a lot for the explanation!
I was mainly worried about the virtualization case as the VMM can
influence ATS enable from the vSTE.
Looking at the code in arm-smmu-v3-iommufd and iommufd/device.c, it
seems ATS enable will only change at attach.
Looking into arm_smmu_attach_commit(), I see the ATC is invalidated
after the STE is installed, which means that userspace can transiently
observe the old domain ATC. I think that's fine at the moment because
when binding to a VFIO driver, it will attach to an empty domain.

Thanks,
Mostafa

> 
> > I think the last line that driver controls pci_enable/disable_ats()
> > should justify the whole thing? Are you worried about device still
> > doing ATS after pci_disable_ats()?
> 
> Exactly right, and we can't worry about that because it says the whole
> ATC coherency system is broken.
> 
> Jason
