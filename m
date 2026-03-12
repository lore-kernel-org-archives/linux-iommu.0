Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001A38CFEA
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306225; cv=none; b=n/L5yAwn1BcksR6ZJCIm/vBr3PqS+yJUB9Td6Zv/AYXT2bjHk8oOCsIh8XMC2FHmhsKlzTgcE9HprpVPIXJMD4hn2PK9cjV6I0ptRvZ1iBspHUkzwhFZMvbisHj7Xgh4DQ4wjtgRGKufZwTdgpZA+MXEVUaxcJAxeTt/WquYoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306225; c=relaxed/simple;
	bh=LdyzC1pgxXTGxkwgodIu0tKumfCfu9AUZ2hCUMAE1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTqsfJP/hv3K1zM3LkXEFPXMnM7dRMGtcx7UX/fEWpfG2VQXaNrwnPDep4NFAw1Uy6xLEwO0QFov+5SD0E2VvpVAaooigyiMpQOq7QlWGWpQawyCPgRFW2eDyyGz7E6dkBuQcv27dEDVg+Iw1m3ammdQ5xJvVWGU8D4oisCR/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nxPsMFMj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nxPsMFMj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so871805f8f.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773306220; x=1773911020; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFPtayDDhz8Xf/M05gyckNDjnYEg9BLk1Cs40ltYFF0=;
        b=nxPsMFMjRLnKvTT8oQsJACDG5lAw+6DqZ//Tic2bfQ952yq2HaC5bVuie7NYbOhXaE
         ySxszGL9qojHGT5yXZen149vHGnNuST7ioIOCNpySh0buyTI4QJaBlBAZpQW183NzgeX
         0ivWIqXyqt1kYJ+p3liGQi8QC204OLIsJfeF0n9BHV69CApafYohIHEdhLffIeqXGnp2
         1UTo0uh6d+Ns05TsuHA2gwo9SLjohbgsFjToI6vlakZ2f/MzOCNPLayqdjzdxHK7syu3
         4VCmlry+n+332tVqNIfhoxNOYYldD/xwxmL1dVNGXDc2L82Pb8IJrM5lgkYUvD+NmWxA
         gcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773306220; x=1773911020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFPtayDDhz8Xf/M05gyckNDjnYEg9BLk1Cs40ltYFF0=;
        b=krVENYuidDOMUwK102TlEqcFzePSK/nR843a11MWIxEbJbT9CtfWK0e72Ma4017S5J
         5HRQ4MFjlLcCISV0Z/cICGP/YDHuileumoTHQPI9y1ZsXgyCghOUDc5fClF29ytJ9REO
         5dTgpwjX12G61koxpq9ByFitTKc8Bl+/XJebGw8fbyKAvTzw/lfmsQPV4MlisB123/kI
         hDbkD8TzTYcjvugYctiyf88jgs6UJHoM3zNkZ9kyK/uC8rAnQKODghqLAbThjBRNt3Gi
         32QGrTxOYnI9bpbqx0XviK4YSTxmQDFQnNQHluHE3pO7Pp3M8eYUV9BaPOAEwAgi/whE
         R09Q==
X-Forwarded-Encrypted: i=1; AJvYcCXggCbiFpQJrgBG3dxcSEPb05FkdO1O+gQUsYQvmcQfrMBNG0SS2m9aU5L+9xlxbbzqXZnpmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXyHXnCe7YrrqipQtb4VT2/NZt+Rht09Ntvv9j9qjudbl76slX
	3CCCZhPvfocHuINXBC9X7/4HDCcr3/qpft2+XGytThdEQlUNUgxjE571w3/4huUWARw=
X-Gm-Gg: ATEYQzybiHI/CfO2tka6ZjtMw0ZBSABzeRIfCAt/6HqpJW9mRPcDzBY2bzIcqbBRuHY
	kYakfXRTURQxRhqo/Zh/66ibC5rkygimRukaVzjpY5ONQyU/nL7DVhKh8MlG2HQM+bbhXm3Y3al
	GvFulebHuRC49jjzEeEOY6m7zz/oVLMyqf8/HdjS7ythZpAJ+ZIdkdoO2XTQMsbmm7FVQsWAA3F
	8ZKzYMN06pK0CeVBcpD2ldiI2WStfuRJGs/XiMmeuQmk8pXIbej9udjm8xtyLKi6gMG1LNwXRRi
	S5l/I5caUd7gGkq/yptFNGbbU88hjFve4UTiKmHvHw7xJ8h4xFrWYWJORp2W/Dosyrk3sfqeXED
	wU2SXKd7H2KQbG/sJDw+pwjUjXAJm58Zfnk/o/gRAPrWcpFPW/IQcYxU7hAI7WTp1KCe/dOK8UB
	iQw3jUHF2keaw7MYOjwJczjYgl51OXW78=
X-Received: by 2002:a05:6000:24c4:b0:439:b3ff:9abb with SMTP id ffacd0b85a97d-439f8224fc0mr10284840f8f.57.1773306220321;
        Thu, 12 Mar 2026 02:03:40 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm6366764f8f.4.2026.03.12.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 02:03:39 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:03:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, 
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <pmfxzgtazwa7fwz4mx53htdg4jjifwyq3gyzwklc45affy3xrp@57hxan4pqnkx>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
 <20260309131530.GJ1687929@ziepe.ca>
 <20260309140233.GW12611@unreal>
 <20260309151857.GO1687929@ziepe.ca>
 <phry3e2dtgxzxdqvrnqfuskangp4al64f2auithwme5kwkgepe@7qtftrhgv4l7>
 <20260312003408.GA1469476@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312003408.GA1469476@ziepe.ca>

Thu, Mar 12, 2026 at 01:34:08AM +0100, jgg@ziepe.ca wrote:
>On Mon, Mar 09, 2026 at 06:51:21PM +0100, Jiri Pirko wrote:
>> Mon, Mar 09, 2026 at 04:18:57PM +0100, jgg@ziepe.ca wrote:
>> >On Mon, Mar 09, 2026 at 04:02:33PM +0200, Leon Romanovsky wrote:
>> >> On Mon, Mar 09, 2026 at 10:15:30AM -0300, Jason Gunthorpe wrote:
>> >> > On Sun, Mar 08, 2026 at 12:19:48PM +0200, Leon Romanovsky wrote:
>> >> > 
>> >> > > > +/*
>> >> > > > + * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
>> >> > > > + * (shared) for confidential computing guests. The caller must have
>> >> > > > + * called set_memory_decrypted(). A struct page is required.
>> >> > > > + */
>> >> > > > +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
>> >> > > 
>> >> > > While adding the new attribute is fine, I would expect additional checks in
>> >> > > dma_map_phys() to ensure the attribute cannot be misused. For example,
>> >> > > WARN_ON(attrs & (DMA_ATTR_CC_DECRYPTED | DMA_ATTR_MMIO)), along with a check
>> >> > > that we are taking the direct path only.
>> >> > 
>> >> > DECRYPYED and MMIO is something that needs to work, VFIO (inside a
>> >> > TVM) should be using that combination.
>> >> 
>> >> So this sentence "A struct page is required" from the comment above is
>> >> not accurate.
>> >
>> >It would be clearer to say "Unless DMA_ATTR_MMIO is provided a struct
>> >page is required"
>> >
>> >We need to audit if that works properly, IIRC it does, but I don't
>> >remember.. Jiri?
>> 
>> How can you do set_memory_decrypted if you don't have page/folio ?
>
>Alot of device MMIO is decrypted by nature and can't be encrypted, so
>you'd have to use both flags. eg in VFIO we'd want to do this.

Why both flags? Why MMIO flag is not enough? You still want to hit
"if (attrs & DMA_ATTR_MMIO) {" path, don't you?

I mean, CC_DECRYPTED says the memory to be mapped was explicitly
decrypted before the call. MMIO was not explicitly decrypted, it is
decrypted by definition. For me that does not fit the CC_DECRYPTED
semantics.

What am I missing?
