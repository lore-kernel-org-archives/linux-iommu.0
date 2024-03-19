Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA62225DA
	for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870869; cv=none; b=PoH2/8GZGJeVBH1+QSutN7TNS2yrZySAUm1xfLLlCBywpKvRFB2ce8GWtD+scXO6/m3kEd0kPRZDQB2wNKC+vcygsAz6UjHHOLS+NMPbcU7VD3G58FlkKJRAl4FvbHaaW93giOyIf+HjPSyDFVicX/bc5eSKNFiyTS+iTFLnA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870869; c=relaxed/simple;
	bh=B9HuiwQg7X+0lbII8qyF6ES+SfD7F1pHs2MmLusxi84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrL0y4HtgAzYw7r0p5JD5bYUy13ZjhwadNgSUoUlDrR0PvsG6IZ+klJN30GexSRajuwv23kbV9kcuwSn73mcJLOaZLiF12Kph3+Y4qdZJ3L5Q7DduI7e8IXcHbM3ZWBHt6iLg81SNtuAq9UUEt0eHDjFOTurIadSzG7jUvT5k00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pFKv6MFx; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pFKv6MFx"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22200c78d4fso2467863fac.1
        for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710870866; x=1711475666; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9HuiwQg7X+0lbII8qyF6ES+SfD7F1pHs2MmLusxi84=;
        b=pFKv6MFxPN0uotImiAqtz/f6JCRu0AiJNC/U5woGwE4s+3DtWCAl95erBX6hhdJXUs
         kl4a7yR1+9bv/cYkpDbsOgeLMnnCfaCIBZRLZpUc+9aNfur5KkmQOb9WHHJCHT/Couni
         q7s9ZSho4G3At+YpeykGsaXFpl0n/+wghsDfCxO+2EvKMAUBhnVYLzypQthcvFwPH7qT
         isNQsBMocPjE3xr9w6aLFMaIXHeStE1v906N7L1cY57rXbrKpwV7klMRHivJypwi6/we
         2wU8JjsBKWFfBR0Z+5vkJQIHbo6NxEO+Js2+RuWEzETEcwh/MuTTUwqqtJAR+5nguXnY
         Z2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870866; x=1711475666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9HuiwQg7X+0lbII8qyF6ES+SfD7F1pHs2MmLusxi84=;
        b=AnL6fJjUTNCUCFsNc7nQZ4KQ+s+73yYTPfSrSgMG73eaRzZLi/orp2ArHXXy5k5Rtc
         DN0OG9ZFATZhdn2tN9VGRRlloSnvsneX1eMWYvjVyoeDBMFdJI1WNAkOaLI6BsCk4WCe
         P2XIGp/vhy2TiAZ7CIgHsa+YJQdNGlHHNYswNy6FCwq9Lsbi1tVGxLpGXPgJV+T1Gypr
         cSY1mQiJyRr6BL8a8vPgeS2zi7h2wxqiE3ms2QmlXH2LPiasPWPXXB3RV/UJVlBYod7j
         0M9Ikp0qH0UOZgq/VTRZskZ5Mw2hIlxnCn4TG4sTpTe6qx2/ixtMysPCSaj2+RHJUBPm
         nTHg==
X-Forwarded-Encrypted: i=1; AJvYcCXTPxFDVXGtjXj+QUapQxfC1NHT0ZXxLmPH53BfIF28YUX1ZJrb0AQzRY9OYvlKbn3dlbOJNN1+NDNhrIGsdGne33zH+zo=
X-Gm-Message-State: AOJu0YxXCLJ6RBabC7GORJpsPIpK5nBWsN7FAggEJZuydPoOM6NSqKLt
	jRhLkAJIfkE5zYw4m3BcB6UFXnv1cu7bZ747Qo86T9edVGjZYxzzPxOg0Fua93w=
X-Google-Smtp-Source: AGHT+IEd8KsCy6GqIl+1n0Sol2b9f0f/25EaZRJ80XDCZoyr9TJbEhweqbC03Izk0lN9FbayxSp4fw==
X-Received: by 2002:a05:6870:524f:b0:221:bf42:cf76 with SMTP id o15-20020a056870524f00b00221bf42cf76mr16367906oai.10.1710870866557;
        Tue, 19 Mar 2024 10:54:26 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b00477716fcbb8sm2429986jab.40.2024.03.19.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmdbD-001kiW-EG;
	Tue, 19 Mar 2024 14:50:07 -0300
Date: Tue, 19 Mar 2024 14:50:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Tyler Hicks <code@tyhicks.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <20240319175007.GC66976@ziepe.ca>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319154756.GB2901@willie-the-truck>

On Tue, Mar 19, 2024 at 03:47:56PM +0000, Will Deacon wrote:

> Right, it's hard to win if DMA-active devices weren't quiesced properly
> by the outgoing kernel. Either the SMMU was left in abort (leading to the
> problems you list above) or the SMMU is left in bypass (leading to possible
> data corruption). Which is better?

For whatever reason (and I really don't like this design) alot of work
was done on x86 so that device continues to work as-was right up until
the crash kernel does the first DMA operation. Including having the
crash kernel non disruptively inherit and retain the IOMMU
configuration. (eg see translation_pre_enabled() stuff in intel
driver)

I think the idea was that the crash kernel driver will recover control
of the device prior to trying to do DMA. Devices without a driver or
devices that are not operated by the crash kernel just keep going as
they were.

In general practice this is unworkable as some devices can't be
recovered without doing DMA in the first place creating a catch-22.

So now lots of devices use their shutdown handler to quiet the device
before handing over to the crash kernel.

I think this emerged as some 'small work' to try and make crash
kernels functional at all. Implementing every shutdown handler would
be pretty hard, but many (?) devices seem to work OK if the crash
kernel drivers runs for a bit before destroying their DMA setup. We
don't trigger weird platform crashes or anything due to failing DMA
operations either.

Now we have all kinds of infrastructure and deployed crash kernels
that have this assumption baked in. :( It sure would be nice to not
spread this full complexity to ARM.

If the original kernel could signal to the crash kernel that specific
devices are quieted and then the crash kernel could simply ignore
unquieted devices and set the IOMMU to abort them and don't allow any
crash drivers to attach. (or maybe FLR them?) If someone wants a
device to be usuable in the crash kernel then the original kernel
needs to implement the shutdown handler.

Regardless, I think if your goal is to support crash kernels then you
have to do at least a bit of the x86 'keep the iommu unchanged'. The
iommu shutdown should do less like x86 does and the iommu startup
should detect the special case and try to atomic switch to the new STE
table that aborts unquieted devices.

Booting a non-crash OS is a different matter and in that case you
really want every bit of HW put back to a clean "just booted" state,
and arguably it can't work unless the original kernel implements all
the shutdown handlers... I don't know if x86 kexec actually support
this, it looks like it only works on Linux OS and things like the
Linux iommu driver have code to support the crash focused hand over
even in non crash cases.

Jason
