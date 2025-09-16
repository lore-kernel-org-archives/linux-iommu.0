Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2633EB10
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031462; cv=none; b=Sk1Junjzc3c9dgTEP/zrLA2fV1mrJLyKoIpGeUtrckLfzI3fQ4yZeYGi/SABuktIxi0JCZyWwCEHN/rHmTUJF4KPJXptOZfg/Sl7JVmmSRirM7kG5xJRZBqMXrJsPmSfvj1i/e9l2egKq0fayJFRRcfE0A3hyTNDDEvssVsYDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031462; c=relaxed/simple;
	bh=Mj2uch2k7gnXMgjun6OnhPHWnFGJa3Fum6oHaYqsUBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHmNQPDj3FieTXFcl2PEnDC4NHFB9Z2o1dQhPz9haSzPT47+LxdnZfqf1tOnL6u8j2w1KRzOfj7AULGsRUixmRr6mb9C+eKmU5KrJEDFoSDWlyxT4wtmOh2ZIyaAu2wm4KhHSb40wCGRv8iI8rKH4lEREQTZPJfcBrPxvPNjlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aRkvhlu6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRkvhlu6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f30011eceso56245e9.1
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758031458; x=1758636258; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2KMOMO3XHmFOxVaDXop6w1+ZPJDKNJK8AZpmO1KEadE=;
        b=aRkvhlu6VcUW3WDqY2tq4yaJCgGCt+02DaVn6AsrKDN62Jf4XGRSKCH+NZxG3agLH5
         X45W9q/elgFWCzdSPsMo4AYP1CPwRpVZ88E2i1uEGmsmlbPdY+NgbCAtYF7dvGxP0+Wj
         UnSHUnFm5KleNV2l8FwK1HMnPu9NIKYfuaWbWHvyjwyByQNXqAcOpKOCYQza8Bs5CUJS
         PzvYgOrl8wXaDhjbJM/C6FaLZ8aQqQv8DYXVFbvwHUz9aOvc+zl3kpxJ3mIx6T/uiqtR
         Mz2eK4GZVYNzjJWQKtHUeSNykervsA+Xb50hw3HQybmf+c5Oz10v68UN0iU7KIuHiHg8
         Vd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031458; x=1758636258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KMOMO3XHmFOxVaDXop6w1+ZPJDKNJK8AZpmO1KEadE=;
        b=a/hNmeVjNo9vMfWb28AczxvsTrZw2t9u86VN7EOB46MGCFl9+iuZX2YMJ5dDG76Pjb
         HTQxNW0J5UtgPBRVW0IDyX3dR+PCvLBEDhLaXg2rMdTeGTQrYSJrVHWRc0224lRN/LVc
         mhkm7cjkXdC5l1Q0EhKECM1wv0EvaDxjRxMzjLj21hI4IWmpLgFr7m69YSg/UmOKRR+d
         nXit79o4IxvEUbt60ZYD0tYffaM1wJqrLgW54ypgmMtokyqkKbFDMOv9g2WmnFoContC
         wdpjNZ1z7UcAtaVletoDmOYXPIeBJpLAgNbIdGTl1ANtA0yPtBdX6FrEh6q3RwDxCitt
         PljA==
X-Forwarded-Encrypted: i=1; AJvYcCWXRgk8CYDMmTlF3IPWI89/R1zsiR3TiNthFE9HWNuurbdU6MEJiJNOBoW8hWHf6R+1vMNcyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3u8XlWUWKLeB0F7yd9EDjIfJESuuL62xtYaoe3S2aaH3D4aHp
	8fgTk+19TLS9iMCl5dMB/VV52E3nyqGEe9+a09vtX4nV12+kmktuPnnrH7llBnitNw==
X-Gm-Gg: ASbGncs3GVuYjJqImqbY0NkvnOR3Slt4LDviVJTw8gX8j3yUuzgTU9V27hYJ05tgrGC
	XOVahC2FgXMgo1i4qW92Uls5VjwvoXcgkUuLVtg45FPeLDPMEF3H+5sxrSQKh41Bx7Eq++0vBar
	y5kEldBRRefXS5bdYNvQsXnJ0tLAP/mw2VuuHBhJnbf6fnEOxQQswAw0gtU9y6Ca4rdZk84tLyR
	F7FuqoxpaCe15Xl8j+gD7obpVZTj5uYVSvM1Niu0erT7pBAPpXn1PiA1SyNH3gnQhJprzSnV6XU
	K5rUloMvFwQplVN+sSxxLYOVBPJWgwyyUihRgkps9QcsuunRSRd/Ksc4fQFyQ80xy8L9rlTwWwW
	9OAbfF0ildnfws6CWxSv9pd5Dn2g3baD8mqLufBAcuASmqWgW18l05qetIwYUzqT8WMzAqg==
X-Google-Smtp-Source: AGHT+IHnm9FwdHAPOXF/eEjid/iWJ/+0RKN/ZPnistvH7jALBPjgIBevgkp2XifrX2DSJ35JmAkJcQ==
X-Received: by 2002:a05:600c:a10d:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-4601d6b4da8mr561855e9.2.1758031458150;
        Tue, 16 Sep 2025 07:04:18 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372aea2sm233815705e9.7.2025.09.16.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:04:17 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:04:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 03/28] KVM: arm64: pkvm: Add pkvm_time_get()
Message-ID: <aMluXZfrvg_-fhMN@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-4-smostafa@google.com>
 <aMA2ugNakqrA1Pg0@willie-the-truck>
 <86frcvd3hb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86frcvd3hb.wl-maz@kernel.org>

On Tue, Sep 09, 2025 at 04:56:16PM +0100, Marc Zyngier wrote:
> On Tue, 09 Sep 2025 15:16:26 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Tue, Aug 19, 2025 at 09:51:31PM +0000, Mostafa Saleh wrote:
> > > Add a function to return time in us.
> > > 
> > > This can be used from IOMMU drivers while waiting for conditions as
> > > for SMMUv3 TLB invalidation waiting for sync.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  2 ++
> > >  arch/arm64/kvm/hyp/nvhe/setup.c        |  4 ++++
> > >  arch/arm64/kvm/hyp/nvhe/timer-sr.c     | 33 ++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> 
> [...]
> 
> > > +#define SEC_TO_US 1000000
> > > +
> > > +int pkvm_timer_init(void)
> > > +{
> > > +	timer_freq = read_sysreg(cntfrq_el0);
> > > +	/*
> > > +	 * TODO: The highest privileged level is supposed to initialize this
> > > +	 * register. But on some systems (which?), this information is only
> > > +	 * contained in the device-tree, so we'll need to find it out some other
> > > +	 * way.
> > > +	 */
> > > +	if (!timer_freq || timer_freq < SEC_TO_US)
> > > +		return -ENODEV;
> > > +	return 0;
> > > +}
> > 
> > Right, I think the frequency should be provided by the host once the arch
> > timer driver has probed successfully. Relying on CNTFRQ isn't viable imo.
> 
> We can always patch the value in, à la kimage_voffset. But it really
> begs the question: who is their right mind doesn't set CNTFRQ_EL0 to
> something sensible? Why should we care about supporting such
> contraption?
> 
> I'd be happy to simply disable KVM when CNTFRQ_EL0 is misprogrammed,
> or that the device tree provides a clock frequency. Because there is
> no good way to support a guest in that case.
> 

I can make "arch_timer_rate" available to the hypervisor, but I'd rather
just to fail in that case as Marc suggested to avoid complexity (and due
to the lack HW on my end to test this) even if we check this only for
protected mode.

Thanks,
Mostafa

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
