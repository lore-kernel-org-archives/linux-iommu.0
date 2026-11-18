Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035989;
	b=kjU/oacthnVrDmYQ73cuXE592a2v/7TqH1pGlzK8WwL1xwXJZ+yndb4Ea1aSewwiUYWt
	 et0n44hiAI2pIVZ+vo+GUeefl2SGpGCjEBssesaofZ6C5iLj8znfhayah2rsVDkwbcBG1
	 poWTUjv7UNQY9SLpnNZZ9ktaqwK2Pi3iUZH4r6R9/VN+CuvcF3U07g/3010ZdRfqpgq2a
	 zfKzqdJ2dn23hbzbSbCSvw5Mdtchc3SnLKfXeslcazVzeJSK7V38dVo/v9hx9DbZ4U9FD
	 rb34G96Ipy/GB4mhutgSPGSk7neCwmWZsQxe67IZcyEAplrjY/9/ADGMo359HvUiFzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=pZ3JtacZcjsrcECbYipQCJ4gvP+CBNK95VHZ3UWM6ww=;
	b=Nk6m8tEFIx5UmAZDSo+2/YB7cdTWgzmUyJL+UcOReg5uTe/wAt1+1E6nxbNdyrr++vvM
	 Yk9fFXEPcBz8vQbMaf2tY7nwed0UrhH7tndIPxJ+ogVZL/lRjdAFV5E1DNW5uimjLYG4G
	 R2Zcn/oElpvHQ4c5bAJNd7sGZphi4snqKFofpxERsTw5GPPRoMYkxAFAe8ur7eJFwuYOd
	 Si35CS491zRCirKQzIl9NZgBASJMwtXCgbLGBM3JCiBUZk/35LVQXU3WWaavfBLSTrPKu
	 LM6Qkd9mdqaj1dfOgbLUEANBcfQgJPwECZm4/M5epu5gpN0xHo0GzRox6oTUTHhAz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SDeNQrCR;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BC606A32F
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 21:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564BC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SDeNQrCR
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-949680e6d83so151719385a.3
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795035988; x=1795640788; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZ3JtacZcjsrcECbYipQCJ4gvP+CBNK95VHZ3UWM6ww=;
        b=SDeNQrCRna9AR1VBjeQJYkkWxa+pmn5iKdupNKJHm6DdWeUW4FXqvbJalHujSMUyZU
         6IMVdXy6NG5y9qpdchzEefMWcV98Ctmt8oXVFiR38kNdwKvChW0C8I70q12DvXZ36rEB
         PkECHjemMww104SXFvX2M3E5gPb4548Kr80xxAWW6dwwIjzEk3bEqIZ9Uwx2F1UWYNpU
         nwtgCnuGMv3ovXe881UvLxEjKWJcAgxQ0L9NCtOtw7VyUZMsB6kBAceftR3dBTZ4KIYB
         eqYudpF5GcuqehBXRRrKJ41a68ocKT7EDmM43eSd0vzfKc8WnWBdpwcUdFooxo+KyBi7
         bPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035988; x=1795640788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pZ3JtacZcjsrcECbYipQCJ4gvP+CBNK95VHZ3UWM6ww=;
        b=0R2saKOGIv/dCN4XALdvw0vpSLgXIHvaw02VpTxQmghhOSlHqU8+8WreWkXjfwWZSp
         a1KX1lStpdFtrWOlxBFuSkALOUIXlPBk1J8HUbU1O74G0tJP11w7+0IiA+e/lW3KSNSE
         VQuGKgFiCfSM8dc/eQ+n21t+mOuDrQyWZFtPf8sI3m/aTJxwT3B4NZYHoQlTZgFM//tN
         kYZWjLQTQoRYGenA5+83b3YntH0fe83SJI7fNE9w9xnMEIeGznJpklPNP7Oo/CJmPjQt
         lVFzalwwCez4zS5OUs7GTgz7TUAv0GysEVxt0FHxaTYaBrGjLV1HldTuxdnwLeg1d28w
         x/FA==
X-Forwarded-Encrypted: i=1; AL+hErGnUyGOpbYLbCc2v9VWMZzfrMKebYT8JVb2ySW/d3xK6jP48UzRiO6Uu0bS1DS1SXsnfR0D1Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/ua8wnOECrCjxL6V5QppODXaF0kC68H/ep/3SUdu4YZ6FcH0o
	PHrL6wq44FMwKaqxCtUNioTuly0nFeQ62J86LUxSFUPWLScZtRW9yWNibH86RV23YL0=
X-Gm-Gg: AYBFou1iJZRZHxK5yKkOTzsGwFEnJFQH2LX3AMBywhaA+tam2u0ucc2evYMro5ESfoV
	0PD+BWRLQ1oBGKM8vkugBX5q2GQ33JOwhADE7zP9VHpojqfShPv4UJ70mKQ/ExL6OHPapVgKWWR
	zizRd6U7zo8VAmvX70VLhwa01V7iwfYdMymisWRrhqey2n2nsxZEj2qUaJWChZ9vLMRVFfAE3Qq
	3l3Mkls4vayKCo2HSdrgchdlYwXfLjxTlh4qYQAZt0+xVJvRgeDDsTotqIo5FmBuc74HBmIifnZ
	Jq+9K+sYe9/UiRmuudJC8WCQqynI1GT1Kh3qM3c9KxfJ1PQ9GwD2C1r9zuqxrlpTKYSeUIB7FYc
	KYWyrULW7LjrNEeMFRJfBcxIKV+dXSwkepx890cj4KiqwMWK5OfXlClOJy6vtpWvg5Q43U+KoyX
	nEci/JNTozHPPxQpvu+Q1gDYFl21tdYEQrO6h287sGZgr28B4wVGVJwYbJnEu0BKEwLc/9cJQk8
	4aVxjwQiIoPn6xw/rx4LH4iUoCmfxIsoCiNg8sXOcPps4Wa2hoAVfrXHy2gV0K7s4u8RKdFTXuL
	UA6UrMrIDr0hrlDYGyQdjfJ+MAU=
X-Received: by 2002:a05:620a:4556:b0:93e:c12c:f121 with SMTP id af79cd13be357-9499964526bmr691694185a.77.1795035988208;
        Wed, 18 Nov 2026 13:06:28 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b8182dbsm271138185a.41.2026.11.18.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:06:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTmrK-0000000GRJU-0IJL;
	Wed, 18 Nov 2026 17:06:26 -0400
Date: Wed, 18 Nov 2026 17:06:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261118210626.GF3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <615C3DA2-4C02-4A8B-AEC4-70D498672559@collabora.com>
 <20261118193521.GD3115493@ziepe.ca>
 <457fe01cc1fbc5b6e2d7b5c9c167012b56fe86b2.camel@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <457fe01cc1fbc5b6e2d7b5c9c167012b56fe86b2.camel@collabora.com>

On Wed, Nov 18, 2026 at 02:41:32PM -0500, Nicolas Dufresne wrote:
> Jason,
> 
> Le mercredi 18 novembre 2026 à 15:35 -0400, Jason Gunthorpe a écrit :
> > > No, not OK :/ We want to use GEM shmem, which calls into the DMA API internally
> > > through drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable().
> > 
> > You cannot continue to use DMA API once you start touching a paging
> > domain directly. It is why driver_managed exist.
> 
> You are building a strong argument around something that is not what we intent
> this binding to be used for. If you had cared about the context you'd know we
> don't want to touch paging from userspace in this type of drivers. 

Go re-read Daniel's answer and perhaps you can understand my confusion:

https://lore.kernel.org/all/3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com/

If you want to

   "We plan to alloc a paging domain when a video encoder session is created. Then
    we call iommu_attach_device() before a job runs"
 
You cannot use the DMA API.

You absolutely CANNOT attach a brand new driver controlled domain, use
the DMA API to populate it, and then detach it.

Then we have the issue that the rust bindings expose iommu_map, which
cannot even be used on any non-coherent arch due to lack of cache
flushing.

Further, from a Rust binding perspective all these unsafe things I
talked about have to be blocked by the Rust compiler:
 1) You cannot attach a domain to a driver_managed_dma=false device
 2) You cannot call DMA API functions on a driver_managed_dma=true device
 3) I object to exposing iommu_get_domain_for_dev()/etc to Rust
    due to how unsafe it is, but if you were to do it then the
    returned pointer must never be used with attach or iommu_map/unmap
    functions.
 4) Since there is no cache flushing a non-coherent arch must never be
    allowed to call iommu_map(), since it is unsafe to create memory
    incoherence.

Thus, what exactly is the plan here? Do you see my concern?

Jason
