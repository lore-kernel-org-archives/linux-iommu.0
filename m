Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0592638BC
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275652; cv=none; b=DyAQY+TG5CaB6OwmraNp0Lvib7u/N9N+x2SnvWvv/bd72SNoi9iYE0JERyaqezJb9IhzrmOTevGwLoGg+5DrLG//TTWZttUi/qbfB560yjOeV/u4CF5lfW48Kd8/OnK7Ksosr4I8as5nMpAbYpFFHBTx3os6ufYYHBzeiuEvtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275652; c=relaxed/simple;
	bh=Jwj40ySNMYku3d2yjr55Yeih0XswBk9HBherb/fv8B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMireyKC9hF/BOoND9V2LZREFit58ZsbAXqNFzrqkOQysztrp4AIwzaiFwM+gzWRaooM9klIr1iWIwjgfoldS6DDFvyEh28V3lUv9ZfCK3albrXpQRrPP+hcY88LICI0i9tiBRBfEgLx9ZmnIqURurwgAdEqjJwedzxrfWvQSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FUbGlaxy; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FUbGlaxy"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd847b4b23so39465385a.0
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773275650; x=1773880450; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVlsIEeUlShNo2vVDcti72NQw3N4AQ0tu/N5/EFylTo=;
        b=FUbGlaxynXG4Gp7BCAjNCao7GEYi39F4fVizF5EPzZU4uWXVfG4iJILSqcKcPIRe2y
         qVfOQHD6TDFFt2QbyNlfJWbpLjXkFNgGhUiz785smFHv4kVD+gs9nhuf7PEHOahOkOM1
         ErDusHfc1E1BSzf9231kK8Q8xugQoxwDbOGn6RjVHeFA2NYgAh8OSdHwRGt+ioFm3x+j
         5JBhGL8afBUlxSTTR5HCldo4WjUA4r1u3q7WsFUMahYcJYhMmguGh4tyrYbf+qf6W06Y
         S9M4l0w3SVQt58GeAgRqMBFIZ/HYElONWfe6HKEZ+8zAwfMLOh7WjVEgviFym8EtJKws
         H9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275650; x=1773880450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVlsIEeUlShNo2vVDcti72NQw3N4AQ0tu/N5/EFylTo=;
        b=tNZ6FqetoaGxmgD4EtthgyGJ1/eybVZMrRnePaCPZWD7G9FkhA1csN8FRc+T4lFnAx
         NIsmg575XG6OuNoBDhdToQNIsFdx1NAzQVwIMpL9/vrn8/X52AmfAn8ao84VUTS/6Plg
         ey+NRSGDPAeSu7onuw0vfa75veIJsD8IaHxSPQ/traqPPruDL3op+zNCzkvw93Z87de6
         wiEopcvEyIZ2SOJm6o1QTHOr4ziNR/kywz8HpwqPxfkPss0ISeIRMXwVdhdWzLtUPtv7
         TZE4mDnb3B/uPQzzSm8VbI/FBuzmW7ESe4LY1xFIauf1ZNtYPxTqG++VIMStVSb2SKvi
         Extg==
X-Forwarded-Encrypted: i=1; AJvYcCVtsJT6jMRC8JGpII0l6T3f/nMg6VPcloS4DBk3gjFruTSpFfAyZgsIvZfBzWagcDsAwgxZ1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd93S/l+anSy7btq71GvOP937TYgvxqkI2nxcGKwQdTsFPcD4Q
	VCaSmkPYvi89MoAIp/ewvraQNQl9PbBrnh6NTkvRE/XlG7TKn/1y1XjMV0/mrcImsVM=
X-Gm-Gg: ATEYQzx3uACanJxyW8EiFwl7yJqsGhCLjy9DmtAsElgVXYKFmCju8gSO1+vXCf0cBqE
	xWAiovrFkmbdX4mYudycPuij6pxZDTIHGEAp5956lIGTkYN6fLSfOkA3S6ShAi1FYemNxGT4dT+
	Wi1ise0TTKClMA1XaK9K1cGswFDQGZJCcr3z9HBbdbjZNAwqklM35deWtNwJmf/W7z/hsJVDYpk
	em1VvND6styEgTulaE7IRVbpRwbLrX9SkhpLWrV4Ll8CsBmoTS+lHKHsfd/FxehUfc251m6z7RK
	oEAlzBKmKLWm6k8yu0qnp8+prbrRklVsnBfjYkq0BLV47Gs8yUitGBLwmWo6nkSOQPHQEcW00MZ
	gydmrgQ0YIlt8X+T3yHcCkbMzzJYg8Vyazeo88ezKBHaSxrQcxQcn9r9Nlip/6zhvu/1sIcF8pa
	1OYdmd1Ec8HvzDvVRLtFk9TxJ7OamdoTfzbRGKmqqcwmiERPk2lxQxyG+FtjWHsJIDCOJM0agWN
	kJtLe4I
X-Received: by 2002:a05:620a:298e:b0:8ca:305b:749b with SMTP id af79cd13be357-8cda1ac2072mr553438885a.60.1773275650360;
        Wed, 11 Mar 2026 17:34:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda212cac1sm263453685a.33.2026.03.11.17.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:34:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0U08-00000006Zyx-3dXg;
	Wed, 11 Mar 2026 21:34:08 -0300
Date: Wed, 11 Mar 2026 21:34:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <20260312003408.GA1469476@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
 <20260309131530.GJ1687929@ziepe.ca>
 <20260309140233.GW12611@unreal>
 <20260309151857.GO1687929@ziepe.ca>
 <phry3e2dtgxzxdqvrnqfuskangp4al64f2auithwme5kwkgepe@7qtftrhgv4l7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <phry3e2dtgxzxdqvrnqfuskangp4al64f2auithwme5kwkgepe@7qtftrhgv4l7>

On Mon, Mar 09, 2026 at 06:51:21PM +0100, Jiri Pirko wrote:
> Mon, Mar 09, 2026 at 04:18:57PM +0100, jgg@ziepe.ca wrote:
> >On Mon, Mar 09, 2026 at 04:02:33PM +0200, Leon Romanovsky wrote:
> >> On Mon, Mar 09, 2026 at 10:15:30AM -0300, Jason Gunthorpe wrote:
> >> > On Sun, Mar 08, 2026 at 12:19:48PM +0200, Leon Romanovsky wrote:
> >> > 
> >> > > > +/*
> >> > > > + * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
> >> > > > + * (shared) for confidential computing guests. The caller must have
> >> > > > + * called set_memory_decrypted(). A struct page is required.
> >> > > > + */
> >> > > > +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
> >> > > 
> >> > > While adding the new attribute is fine, I would expect additional checks in
> >> > > dma_map_phys() to ensure the attribute cannot be misused. For example,
> >> > > WARN_ON(attrs & (DMA_ATTR_CC_DECRYPTED | DMA_ATTR_MMIO)), along with a check
> >> > > that we are taking the direct path only.
> >> > 
> >> > DECRYPYED and MMIO is something that needs to work, VFIO (inside a
> >> > TVM) should be using that combination.
> >> 
> >> So this sentence "A struct page is required" from the comment above is
> >> not accurate.
> >
> >It would be clearer to say "Unless DMA_ATTR_MMIO is provided a struct
> >page is required"
> >
> >We need to audit if that works properly, IIRC it does, but I don't
> >remember.. Jiri?
> 
> How can you do set_memory_decrypted if you don't have page/folio ?

Alot of device MMIO is decrypted by nature and can't be encrypted, so
you'd have to use both flags. eg in VFIO we'd want to do this.

Jason

