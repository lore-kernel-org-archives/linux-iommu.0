Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866922A4FC
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683371; cv=none; b=Puo+cNp9/t0mNEWq/5PyEu3/g6vC825ma8tM24cfRV8/T47yDYei/j7b90/NOjWGGUFfxDwBOcBj0U/LesOwjaB7qcs5qn6ilGR1fnXTFuqCyEy8Rv6ZUEmhtmeDfPAFh650Pdq5v3NkbMFnibMRvv/pWnbjj6GbZwu3A+paDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683371; c=relaxed/simple;
	bh=QkYEXlLgFiLfYsdbBUxkHnpm64IBcci0n3arrJTjZQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBiPB9gr/prDw41XyuzAVL0cKm85Zmy2xhXjSst+UMZi+V5JS3cwatF2eTJWwMxIQh8doG6/ekyiaJ2pCONhlFUn4wK0LJV3OjwgucKibQW2BvNSNy6RXhSmqDijnth00XfJ5nl7TVI2Swb/zx48bumMGxiU15pZAHHX9W8jlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HG5UFVJN; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HG5UFVJN"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50331ac1fedso48695901cf.0
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 16:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770683369; x=1771288169; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6h4j6WhKvTbDaZfOUKYNWWIjZl7N5IPl8TkLFVZwN4=;
        b=HG5UFVJNyZkOgPKs4cGrSKdhUpCkkbRySsBGXFDnXD3LKXFVEREpyecnvcLGBtyQEb
         aWYn3AwhRjVF5c/iUsE9OV3vvojfivNg+5FLeTVYvou8jFIaSK2CUsetHAMiKYzw6yTI
         vINpdOvDkAWr4I9B79AOZHAJGWU77sxoc7YfhcSF1wGbXBpb4cZfbOMTzrTqtRkR50T+
         heA6Dg7YR/tumSlWCaumk1mtV3J7/dJnC/pk/j7ju2rxAy44MOxa3IjsSSxul0TOiVoJ
         B4jE9R3MkRM46ceWu3PcuwBkznUHtZ3+zl7tksU/ewb8TIUcTIBHr4rVnwRB4Bw9TMwo
         ySJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683369; x=1771288169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6h4j6WhKvTbDaZfOUKYNWWIjZl7N5IPl8TkLFVZwN4=;
        b=O9THfQm9zEcHsYX2F3/KjDOvgT0Qga5l4tn+Ey2xZsvzgvMZyfqGlf9jpPVeh64wQq
         Z7lrvIlk5YmKbfpvpnOc2TSd4nsZTrc2tgX6C03J6lcOgym7P0jDqIZLFhHW1vfUDRdm
         uT3jB417UcWZfxfuFVi5+xZSGGsLJEUY4rF1fypQspVtBRvIvaZfrYCHN0DyjBBd4L7U
         rTpKxhwd855Qyn8h8XJBUgo5wWc80RRsdG3ihHTFbgil+N7SkbEtNhzoXDLXcrJfTxMe
         PBHwN+ZOwwMejEOM1A7fGr0aUN1w6Ol+w5wJljSjjaW1Enzl8AlDFHEAyi8W3WibdWLG
         mQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUx3jlmNmrnhuPXBaFOE0SFNrpZRo30JBk5sOqiSe2Y5XjYi5sqGqvZAtAdsovoCIQRZkLh0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn9gGt2WomE8hu/3ARxilV8INivHrtb5zh+r26VRYb4dtdrmEq
	diMXfS1yfzUzhdBvp97CKCniQKTKhseCWZBupUPoE9jJ9q3y5hgfM1HTe1KJ7FQ4vnQ=
X-Gm-Gg: AZuq6aJSujCqnZtYoDxG9e2SGQXTgOfJvWUey/xDQne9qy02J3vUins7ck/u7k7Hkq4
	c9okNMPZnTFxNxYrkgsNfcubePTZkcs6u3ODixaf1FksVAY/yvFKWHOK02GHpLChBq3oV0+w7YD
	VaxHBUq681bRYYNrB09VD1t6utjSbvAAxunyW8Q0hnsUAqRshgJZ/6Hh4F5sEtHYak4jOjzboEg
	D6Yx92TxWQCK0VX7xe1rtGhkkzA9KfLZ53A8gDzUg63WxAbDFdxbhhBI7y6Ua04YALFvbk7WYS3
	aGpfe1Ni0ldbNljqV1HULSMD2o5TkUQYvgG7vN82CuZmv2r3jMJZVmrrrcOCjieqmDT5sHjipZS
	/743qwXsxzg9n458e0HJnMsCRsJHkLlNSpi716b/PNxugrltm7ACRis27zjeP3sDSpMan0HnXMy
	Yv1EU/brb+SgAgBLWOBi50mDrdseo6tZW8h4eT3n4WjuFQ5O37Oztev+HTpt0n0C0MmcPB/ij+o
	euKV1Q=
X-Received: by 2002:a05:622a:54:b0:4f3:438c:71 with SMTP id d75a77b69052e-50639889de0mr182445181cf.24.1770683368674;
        Mon, 09 Feb 2026 16:29:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a157ddsm979856985a.28.2026.02.09.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:29:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpbd9-0000000GngP-1JAF;
	Mon, 09 Feb 2026 20:29:27 -0400
Date: Mon, 9 Feb 2026 20:29:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: John Stultz <jstultz@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap
 flags
Message-ID: <20260210002927.GC943673@ziepe.ca>
References: <20260209153809.250835-1-jiri@resnulli.us>
 <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>

On Mon, Feb 09, 2026 at 12:08:03PM -0800, John Stultz wrote:
> On Mon, Feb 9, 2026 at 7:38 AM Jiri Pirko <jiri@resnulli.us> wrote:
> >
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Currently the flags, which are unused, are validated for all heaps.
> > Since the follow-up patch introduces a flag valid for only one of the
> > heaps, allow to specify the valid flags per-heap.
> 
> I'm not really in this space anymore, so take my feedback with a grain of salt.
> 
> While the heap allocate flags argument is unused, it was intended to
> be used for generic allocation flags that would apply to all or at
> least a wide majority of heaps.
> 
> It was definitely not added to allow for per-heap or heap specific
> flags (as this patch tries to utilize it). That was the mess we had
> with ION driver that we were trying to avoid.

I don't know alot about DMA heaps..

On a CC VM system the shared/private property is universal and applies
to every physical address. Not every address can dynamically change
between shared and private, but every address does have a
shared/private state.

By default userspace process generally run exclusively in private
memory and there are very few ways for userspace to even access shared
memory.

From a heaps perspective the API would be very strange, and perhaps
even security dangerous, if it is returning shared memory to userspace
without userspace knowing this is happening.

I'd advocate that the right design is for userspace to positively
signal via this flag that it wants/accepts shared memory and without
the flag shared memory should never be returned.

Even if the underyling heap only has shared memory in it (eg it is
mmio or something).

Otherwise making it implicit, perhaps based on heap name, sounds very
tricky for userspace to actually use fully securely.

Again, I don't know alot about heaps, but perhaps the missing part
here is that on a CC system all existing heaps, other than the one
using normal system pages, should be disabled for now. They can come
back once they are audited as to their shared/private state and
respect the new flag.

Another view is to ignore this affirmative handshake and just make it
implicit on something like the heap name and hope userspace lucks into
something that works for it, and doesn't accidently place, or become
tricked into placing, sensitive information into shared heap memory.

Again I know nothing about heaps, but this is a fuller picture of the
security sensitivity and what to think about with heaps and CC VM
systems.

> Now, there has been many discussions around "protected buffers" (which
> doesn't seem to map exactly to this confidental computing primitive,
> but sounds like it might be related) 

I'm not sure what protected buffers are, but this CC VM shared/private
(or encrypted/decrypted) is a core kernel property that applies to
every physical address in the CC VM.

I assume protected buffers are something more platform specific and
hidden?

> But, it seems like the use case here is still far too narrow for a top
> level allocation flag.

CC certainly is a narrow use case, but within CC I don't think it is
narrow at all..

Jason
