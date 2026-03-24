Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A138C2D7
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375041; cv=none; b=Dd0NZcniI0wFzm/2XX6GEzsWNTSsVClx+JKVIBsde3uIWqdtagHFu4PcKYCmLpxA3+nZG3SBbSSPz8SkJX3SU9bIaOT5NlHE+5mdFyNksp59WADUHuD7DoYsXC+SoFFQUvkKiMYJAX+1BF6zSgA6IqfVRyab+1msoY4Lo4B0ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375041; c=relaxed/simple;
	bh=DGPmxoTTtNhn7YbNdJRS1EkbAYPcolSO8E8zMkGnzu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgP0qz7ng3Bant6HiufhaLCdUDh15gx+kd5W0+K8i5O7DcrhNtRGIWICfACROyrv0NkBIMoF6mwPYyUURl3pMENoLm3hne3d/kXUcEnUmcnOkXNSxYtkY9ZeXgFcio84zm84fPHGr3wzp+YHCmqDZquMtyOLXaMjDupCZTrWBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GWhzKchC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GWhzKchC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899ee87355dso65912396d6.1
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774375039; x=1774979839; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGPmxoTTtNhn7YbNdJRS1EkbAYPcolSO8E8zMkGnzu8=;
        b=GWhzKchCO4GHQ5HnWmYLnuMPpmJxdkYA7NyvpBZjqGKkIv1ntsB65lQIWPyj1kiF67
         YsCDpD4eXh/nBO/TB27LK+aFY7zgyvLq5QWZeXtu8WoQizGcODHWvn8PbxUwr4YjrFfy
         H/ONtaabCcm4OMs4mFbMZciWYi3Ql6FkE8nyuuHPyAAaOyixgDFFpBT+4rne9dkPPlit
         XBEqtSBop5Ej76Olszi4NlBZoDiPZHchI00qJ+EYoj/3ZtBVBzWVHYcdaxSkEHL9XIqU
         e6vcsfc4LlwjHc+61q7SupxhYL4XqgrlsgUUhAnNEqYzezCv9T8evkWtPwGet2g3UxXK
         fUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375039; x=1774979839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGPmxoTTtNhn7YbNdJRS1EkbAYPcolSO8E8zMkGnzu8=;
        b=c45nfCqVnMfqOghXKHf6mAt6VRv0k9HvC1lE04LsrB2RiCNmMZGzjoU1/4BrXnS2Zf
         G7vNrboL9QRzVrR6gn297mxAZ1WMj7520QeamHq7GsMkScziR98e1dN/VbHc7UihapAG
         nidOLx7I9Bl5mnkECM0gTBpCvwkx+4dEV2AJb0bAxOTFHRmJFdKu6AbsKCvO0Rj5r57P
         LhWP9tAe5XmNOsQKtAldt8IFdbH14KAPyx9zF5pwpABYM0w3mUBu97NBrdic03wvXK1s
         l/c1cMqzLFSemVJdDeMVNBsCVZtGpMqjhztuHy9MIzsWiQ2fewBIpAxZQcFI1C37C6M4
         RRMg==
X-Forwarded-Encrypted: i=1; AJvYcCWDTRetCE7me1j6SGp/l4aSmtPP2YER7rnOG9/15zKXEj/IIKHuKIvupxZdu5ATKbZBG4SAGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRi+YA60h3K6hl5K9YrBuNtnLY6b/bWM4y3Jepphg9vCrNJvP/
	0LA9+S7U+mkxXstQks7DLApsptVOuol2KFXieeA9pEoHGxXhaM4fvwSage1/uLYbe3M=
X-Gm-Gg: ATEYQzzh7xwWvMH3012Ciq/jiCXkFU3GCvSmPUnC/WIzNOPGXfY29o7iCJME4vH0ggB
	1ZGn7csHqFAyZlnajZYCQzWjIyZdGxb1ivroYiUq5AjzVvUzEbWeAxcRYBEhGWw21VzSieILyFy
	i2ULBtp9Xi0mOjgXfF5YQkzkmsWMUeor3uYNAPvTBytr52ic+Ll+5mXQdFSwSP8YS2MfMQYqLzW
	MafzYCs/uJMoYSalAkFtIewSeeWi/vfzeetVdXz9QocwzXKJmGdpEGDNsbG041ALs4sqIm2RmGg
	aIWW4ZLpGhOXdXWrgKFadaPb44QFPKfeqbfwEPUaau3vKTSGMruHkS3KULp4BQEnfP69/HHtRpj
	QcmDxxB4WAD8gQ1w6ERdl7qesA9D2k2s16TFI0tTtBoMRiTzgPlviTYCUojf/LhYYtXZo/PfwBA
	8ofdiWE1qooihXKWfwSCvLzGAsmCbFBz14tfzFe7rq222sEUXInXBr2rZwlNXDbtfDFo0TFw==
X-Received: by 2002:a05:6214:4293:b0:89a:125f:37dd with SMTP id 6a1803df08f44-89cc4ace974mr7595006d6.49.1774375038919;
        Tue, 24 Mar 2026 10:57:18 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85251b04sm116985626d6.17.2026.03.24.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:57:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w560D-00000000Isw-1b4r;
	Tue, 24 Mar 2026 14:57:17 -0300
Date: Tue, 24 Mar 2026 14:57:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <20260324175717.GE8437@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com>
 <20260324120057.GC8437@ziepe.ca>
 <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
 <20260324122416.GD8437@ziepe.ca>
 <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>

On Tue, Mar 24, 2026 at 05:36:23PM +0000, Mostafa Saleh wrote:
> But it's not about drivers in that case, it's about many places
> (SWIOTLB and DMA-direct) calling set_memory_decrypted() without clear
> ownership so in some cases they step on each other's toes, and I don't
> think that will get simpler with yet another caller in this series

I don't understand how this can be, ownership is clear. SWIOTLB owns
the buffer, dma alloc coherent owns the buffer, user owns the
buffer. There should be no other cases, and they don't step on each
other unless the APIs are being used wrong.

> I am fine with the API design you mentioned, but I believe that it
> needs clear documentation specifying who is responsible for
> decryption. The code should provide wrappers checking for these cases
> instead of having is_swiotlb_for_alloc() and force_dma_unencrypted()
> everywhere in DMA-direct.

Redoingt how dma-api works internally is some other project... It
would be nice if swiotlb would sort of recursively DMA map using the
new flag instead of open coding it but that is pretty minor.

Jason
