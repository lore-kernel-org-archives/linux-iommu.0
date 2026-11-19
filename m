Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100114;
	b=bDNemRgFPsYdsz6kozJP7wQbBarTf/buHSCW8o3szdfxWaXmtsQkLuNBl+LpURhFgtun
	 5cxI5dPByyR2VeIJqZbRIowzBHBMu38910FHpRBPGCFbSkGUhlMGY5pruE6j04fqAJ3OY
	 V5sbhU5EKU5d6ZYPk+mxgVh09h2g3cKl8na6e1YYkDqt1RYIMW5ccs8Jz9XQaomz7aDq0
	 pOlpJj78tcw+isQMSDwhT7TeRJXl72P1RNb3XB1xqr5i4zWqoDFYUJ/1oEE6WXQ60vbrT
	 BzqhoRJN/TgO7Vpza7aSc11HJZfhScsP8Jx6gLyvWRxaxikVEGvV60DBY34LJc6PuuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=G+3w7qcryJEhye/h2qafkqEU5e//COD+Oo6UYEV8BlY=;
	b=KzcyNDdL/NNumSNMrgrL6+DQ89qFmqrcfRK817THG4b7tznLMroJbyrkuIrs9ZAy4skj
	 coZCRnsS0PBeJSw9ndELW4aQVi0s8uYA73DNJuJOfqAFjiifefPJ1B/Kc9+f6iIO/NCCs
	 slwDKs6JgLh69BAdjrVGkLfpYG/61bA9suFO91GuXyw0IpJRPIddeY/Q8+e2R2jKWz4uA
	 ENkRtQy0ZENETJoKR97LepcFEOUukQfA7jc8OKd5f+CszI8RJK+tVS7Org/daGbEdzfaq
	 r3dw5tYXeXfRyd6W5B9+sbUz2bponuvtLWLrGC0KeZ6TyWve6a8l5vHzKs8XEkbp28Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iVIv4Dit;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A92606A325
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 14:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A92606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iVIv4Dit
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so361683566b.2
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 06:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795100112; x=1795704912; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+3w7qcryJEhye/h2qafkqEU5e//COD+Oo6UYEV8BlY=;
        b=iVIv4DitBj+0cjHC+U4AryqiFVPRjNOkXwUKbZoCtAToILsRvaqD5Sm1nfPjI4chjw
         PUQMWtkisw3uPw0kxWmxFr/nFWBffbfiGCqCP+OjPBemOK2+A3KWRMZEiGEZYjONkY5A
         P+vN9zpbMWF6CVTQZ3pBqslUI9B6VgI3Nhyew6v9xj09rl1g/7NpBHHCzA6mEb91WwAj
         VpN2CUTJTeJUi+clJ8gpmuHplt5b5eWbesXnrjltpkymLdYSDZ26SmQRNKKov3Sao8qc
         MEANMZFyBFOkxbyy+SHRSIUveyPHUVjxOcb0bkmxNOdie3K9XD4S4oK5+shQinxmEawC
         PHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100112; x=1795704912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+3w7qcryJEhye/h2qafkqEU5e//COD+Oo6UYEV8BlY=;
        b=AP7d/XjKMeikHSGZOPn3sPGDECcqAnSXzeYCAIZQVsuAsBF8Vevu1s3YXcKfulVW8G
         5cG1piH16sg9Hw2C4Pguqim652/iswiffhtV+78BpGMSv5+1VfGWqEUKH8fxloiKFGqS
         XkloSvnD6kEvLPSS29/0AyFkmGNlJ7VmGo+dXqQ7WkmZcDk0iX0jekZPBvaFHdlrM+31
         UdqTveE3SObSnwZhctB/zoutKb/iNsRjQPTrIJT/I3MCxhASu3VQYu463Y8UeEdIuKiH
         yGPzo4utEQH5Byx+6fDmH0v+OskRe+gqYfVS+NfJUKNsytFGDcX9scUfKfOWE3O6mSb6
         WePg==
X-Forwarded-Encrypted: i=1; AL+hErFCwsOHP2LZhyllRfluMDEhq9cp5Z+qdKbnBI0FxfJrVp0LEkToB5oAg1f6cMqU2nsyDvizgQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/rPCdUw4pjVV56Qbal1ONpXlpLPCUUq/RLt+gOht4u3wSp4gf0
	78fSEhm0QNAD04Advko+TaFvHp8rz+jG29P8E84WZBYApfWJCB8C2W59hVKTlHiK45E=
X-Gm-Gg: AYBFou1bXwZ59RiveEWuVtO1jThLiOhu5AihMEAYCcq/vJdA6/EAfAR/NM8wY7ppBYb
	iMdFI3nbCqr7Xddtal0QYalyV2Tvb91ypGedVJJTRSlrJEdg/lnRjPD4d3JeIohnVjj5NIQBhxg
	p72unj1BGModvqr1K873C/sTabrIQvfxKZKEnQsAH7iT+8ZqwAQokw5ojOaG7ph+mvxMpivyJq3
	bGtNlQgZRgXIpUTmJHB2d9ESxmE4i1U0wu+efPFHC3E0RZGkl4j4uOzZ6QUSSYqjtvQMJF2XgxV
	sH82l71Bx1erZ202+Zkqbbm0JGg6JRKSzIuUVdRh0n2g6gHWhrO8M1jHw2CsMOlmIuhKJVBIqGg
	fufC6Ol23H5RZA0WboYzpXHehrLRg/3EVP+oARLsiAFNiFj9DMabtrSmbdJZGgrL6XlV7prklaM
	FoxEP1JPOqPZH/qUgpG18eYaG/Ss05IiISlu6W/GvbRqchTkKLogEupj5y8u2DPesT2xNQ+xDQj
	SzXn7Q/tWmRYRdQ76JkQPSwy29Q8R5MBG+nqZmMzbX/4VIu2Jckor9zi8ws/PIRAi8Oa2Mdx/51
	3ry6rg==
X-Received: by 2002:a17:907:ea94:b0:c50:aa10:d888 with SMTP id a640c23a62f3a-c513acab9d6mr6638766b.40.1795100111790;
        Thu, 19 Nov 2026 06:55:11 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae8f70fsm2503566b.40.2026.11.19.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:55:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xU3XZ-00000000vhT-1zwc;
	Thu, 19 Nov 2026 10:55:09 -0400
Date: Thu, 19 Nov 2026 10:55:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <20261119145509.GJ3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <615C3DA2-4C02-4A8B-AEC4-70D498672559@collabora.com>
 <20261118193521.GD3115493@ziepe.ca>
 <457fe01cc1fbc5b6e2d7b5c9c167012b56fe86b2.camel@collabora.com>
 <20261118210626.GF3115493@ziepe.ca>
 <06d4eead-b765-44b9-94a8-6ec2d71d172a@arm.com>
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
In-Reply-To: <06d4eead-b765-44b9-94a8-6ec2d71d172a@arm.com>

On Thu, Nov 19, 2026 at 01:03:52PM +0000, Robin Murphy wrote:
> On 18/11/2026 9:06 pm, Jason Gunthorpe wrote:
> > On Wed, Nov 18, 2026 at 02:41:32PM -0500, Nicolas Dufresne wrote:
> > > Jason,
> > > 
> > > Le mercredi 18 novembre 2026 à 15:35 -0400, Jason Gunthorpe a écrit :
> > > > > No, not OK :/ We want to use GEM shmem, which calls into the DMA API internally
> > > > > through drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable().
> > > > 
> > > > You cannot continue to use DMA API once you start touching a paging
> > > > domain directly. It is why driver_managed exist.
> > > 
> > > You are building a strong argument around something that is not what we intent
> > > this binding to be used for. If you had cared about the context you'd know we
> > > don't want to touch paging from userspace in this type of drivers.
> > 
> > Go re-read Daniel's answer and perhaps you can understand my confusion:
> > 
> > https://lore.kernel.org/all/3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com/
> > 
> > If you want to
> > 
> >     "We plan to alloc a paging domain when a video encoder session is created. Then
> >      we call iommu_attach_device() before a job runs"
> > You cannot use the DMA API.
> > 
> > You absolutely CANNOT attach a brand new driver controlled domain, use
> > the DMA API to populate it, and then detach it.
> > 
> > Then we have the issue that the rust bindings expose iommu_map, which
> > cannot even be used on any non-coherent arch due to lack of cache
> > flushing.
> > 
> > Further, from a Rust binding perspective all these unsafe things I
> > talked about have to be blocked by the Rust compiler:
> >   1) You cannot attach a domain to a driver_managed_dma=false device
> >   2) You cannot call DMA API functions on a driver_managed_dma=true device
> >   3) I object to exposing iommu_get_domain_for_dev()/etc to Rust
> >      due to how unsafe it is, but if you were to do it then the
> >      returned pointer must never be used with attach or iommu_map/unmap
> >      functions.
> >   4) Since there is no cache flushing a non-coherent arch must never be
> >      allowed to call iommu_map(), since it is unsafe to create memory
> >      incoherence.
> > 
> > Thus, what exactly is the plan here? Do you see my concern?
> 
> Yes, your concern is a restriction that you largely made up :)
> 
> This is very much *not* driver_managed_dma, which TBH is poorly named since
> it really means either "no DMA at all and thus fine to nominally hotplug
> into live domains" or "userspace-managed DMA with no chance of ever
> inserting DMA API calls at the right points".

Now you are making things up :) When we invented driver_managed_dma it
was explicitly for the driver to take control of the domain attachment
away from the DMA API. For whatever reason the driver might have to do
that.

I wanted to convert all the places calling attach to this model but it
was too difficult with no way to test on all the embedded hardware,
but I still think that is the right thing to do.

Jason
