Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030524;
	b=Tq42BU6bzr4mUWEF/TxLTl2o0F8Hn61NigDOqIfHMBrtYPAcBWNNz+sPLk6q3kDdRYS3
	 HHD8DFXSIBD/v43cAtaIhoUtd94hoHCWa09GrotNcQCfEMY7QG76dLkGuw9ppxJBEykL8
	 NBsd9O3hygb/QqeTUAA0GSYs2cXvBg2aWSdiSCDMYaGmRHuSckIFy349q2ZysEZ/kj7Hs
	 CQPlErztIp6TDSR+wfnxt1pbmUkSkDS7yZ7//nPC3x7yuRgo1L7kIPXkFgzbOvbgAsEmo
	 gUq1Bvx+ilBTT+Sc15xBEQsuL+YBAJKr/tUHkk8HrCaaSLf9ZVWr3Pge13utxMkeqlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=svDhZvS2nvuMtlSX/aJAYIzvYs1mM+RCPAdRdKGv9lw=;
	b=k3TtxnCQScRZSo8CHFZiOMsH2aqFs2dw+wnBPssAxuecUVsRGcCuSxHgJUQIYjqleGaY
	 CnVOHqt0gacDlqPG6gAUL6I6+3exF2YLzXaovHd/19rXbV3jTpR0vGkc/438e4yOh+o8U
	 Z/gmmKlUB0+KdgBSO2Ji9BJJTIKV8+wMcEMDbixJpALHCQDjA6VasFMM9TU2QQG3T/mfi
	 xJ46WGYtSpnulgqyR3uA6FWXoczxE7O32NHJ+N97qb0CzBX/J07HvQlldRdGuHxqokaBM
	 0b6KiRaT3s4WJNwvkirqwQen1UPaLt5cIs1VIZeXbIChSLAJhJ4JkJYU5GTjf3jZtbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HMaPEjds;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35D606C41A
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 19:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B35D606C41A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HMaPEjds
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53634b8328eso13301921cf.0
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795030523; x=1795635323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=svDhZvS2nvuMtlSX/aJAYIzvYs1mM+RCPAdRdKGv9lw=;
        b=HMaPEjdst1d34xKSSi9QgwAv2oJbaNL7vefx1tABgF/L1UUjpF6PRbHsei3Uj8i81P
         rC28CaGajDRnYyuJ1q0+R/4Zwyono1tJUGFBpTmjxBR1HKXQu8NYIY/WSMWAgOCdFaJ/
         e0054edpsBlS6h9ayTGsQ7SgRB5VYInXAls2hmSCJrswSXReysBg3sZc0Jr+lTTC4dZ7
         GO4Fh9k+ct3IR7GOANFc1Du2XOjdnTcN/RhtlNW6uGMsXbpfcSDOZbJEoterYgjzPt3a
         F6b6yu+N4tUFlOdoeG8Kr4Admwo9YcGVj2G6xSuShx75EeR0U/x9atrXmJBXgG8gR72k
         XBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030523; x=1795635323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svDhZvS2nvuMtlSX/aJAYIzvYs1mM+RCPAdRdKGv9lw=;
        b=kB8S5z2rxUhOhpt7rLFlHyAtp3hefoPly0RGCIrDWnene4JEtp8ppHnHkpD+dMbuGP
         R6oZV1mD2geuaPGMQ0Rbba24gbCrZMk8oIb83dd/v6uPtvFYyI6gN6oXkkK3qP0ryyMM
         opseqbw5SPJQHYBdaEAlzR8eT4KZXHrT9G6HnIaufPQym2jBvKktO/sPzGN3btGNfH8E
         BF/6Kee5Q+utbd4KaN0QKdywQIB3ABuBlBDMam7o5Mt5qKRYMCMVM1dB4G1BGNb31LuV
         DR0jCrfZFIAXBOga8prVSi9DPFlyWIwBizJ2A0iha388NoUDzSAo7m86olwi/Rjh6mWS
         eEzA==
X-Forwarded-Encrypted: i=1; AL+hErFnDHjxIWwzlJ5rLcXF3qwxtIQBsPNrckLMBa3RmsxYGZUi2zLdFyEuyK/OO1f4jF+HZ6iRww==@lists.linux.dev
X-Gm-Message-State: APuU4Z+SjyKzLteDUTJoB82D9kusEU+JP8F2/NyZhUVJO8vEqIqQSWJi
	L3u8FiCgfKejMsz+0crfQ95nEhK8TVXFGu8G09BOrcLIdZn7tUf0FySwXfdvi+g1FVU=
X-Gm-Gg: AYBFou1tmTICr2Ej02HGF/rYaBd9N0w+piwaVodnZUpcXdde3xf0wvIlCp3H6X+6G0T
	npEboCUjbkwWUXAf330u1/EZr5CZnyb/rxvDCf9FqzjytwmtwgExqnj1jrX/LM7Z9EyVIXybrWW
	+WeDPAy3wmMlfcoaOU4acjLstF9BB9MCnSwx4xvFHN/J1uCQyPMrdthAl73HGg8oHgdaAmYzVkG
	Xb8Td8R2k+IE5Jzc6LInIprkXyura9yTTfxxsF21H+Uk7Mmeba7rfuKcIlR85zugqbPaFcFxl2f
	xZjha7AhKkNZcbYTMMN/+cZfdBkuXHgTJFiE4rdTIOJOv0Ov4anxj52ozTgRoh3fGZ1OOd8SyBs
	SJge6cn71pF/kihPwkLuvwR5Xq9VWjxNRADula76f5M8J4ffUDw2EVPGHY20YTpqEPvGbkThLKp
	XtvdDnvODMGOUnF6hCi6RbcHLa+ACVM5cPyPw/ExjqGYuZT9OA5Q0BXaqB3xVrnXxZ996U8G2+H
	kY/v9+2cS2UBxxvRRI46I22JvHsoAK18I49E07DyUsAtm986KNIXCeHlTx6pVhocHBfmmfqskXQ
	TF9aNQ==
X-Received: by 2002:a05:622a:4c08:b0:55d:2dd1:48c8 with SMTP id d75a77b69052e-55d5a80a719mr59797531cf.67.1795030523112;
        Wed, 18 Nov 2026 11:35:23 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66b24f4dsm7057611cf.5.2026.11.18.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:35:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTlRB-0000000GGIL-2q4J;
	Wed, 18 Nov 2026 15:35:21 -0400
Date: Wed, 18 Nov 2026 15:35:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Detlev Casanova <detlev.casanova@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261118193521.GD3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <615C3DA2-4C02-4A8B-AEC4-70D498672559@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615C3DA2-4C02-4A8B-AEC4-70D498672559@collabora.com>

On Wed, Nov 18, 2026 at 04:11:40PM -0300, Daniel Almeida wrote:
> 
> > On 17 Nov 2026, at 17:20, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
> >> Hi Jason,
> >> 
> >>> On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>> 
> >>> On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
> >>>> This series adds a Rust abstraction for IOMMU paging domains. A driver
> >>>> can allocate a domain, attach it to its device, map pages into it, and
> >>>> install a handler for its faults.
> >>>> 
> >>>> This will be used by the upcoming rkvenc driver that my colleagues
> >>>> Detlev Casanova, Nicolas Dufresne and I are working on. More details on
> >>>> this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
> >>>> [0].
> >>>> 
> >>>> As part of the security model, each client will have its own IOMMU
> >>>> domain. This is needed as the submission model will let userspace set
> >>>> most of the encoder's registers directly, so the kernel cannot check
> >>>> every memory access that a job makes the encoder do. With a single
> >>>> domain, one client could make the encoder read or write the memory of
> >>>> another client.
> >>> 
> >>> How do you plan to get the paging domain in the first place?
> >> 
> >> We plan to alloc a paging domain when a video encoder session is created. Then
> >> we call iommu_attach_device() before a job runs, and detach back to the default
> >> domain after it finishes so the next job can attach its own session's domain.
> >> This is so each session is isolated from each other.
> > 
> > If you do that you can't use the DMA API at all in your driver as you
> > have to set 'driver_managed = true'. Is it OK? If it is why not just
> > use VFIO?
> 
> No, not OK :/ We want to use GEM shmem, which calls into the DMA API internally
> through drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable().

You cannot continue to use DMA API once you start touching a paging
domain directly. It is why driver_managed exist.

If you want to use the DMA API you need two struct devices and now you
are into DT abuse land.

So what exactly are you planning on doing

And why do you need the paging domain at all if you are using the DMA
API?

> The CPU mappings are write-combined, so the only cache maintenance is the clean
> of newly allocated pages, which dma_map_sgtable() does in
> drm_gem_shmem_get_pages_sgt(). 

Yes, this is why you should be using the DMA API, that doesn't explain
how any direct use of a paging domain will work.

> The mappings themselves are chosen by the kernel driver. We don't
> care about what the actual IOVA is. All we care about is that a
> given GEM object is mapped to a given domain, and that we have some
> IOVA representing the start of the allocation, such that we can pass
> that to the device.

Wonderful, what is the paging domain for?

> > Are you sure you shouldn't be using iommufd for this, tied into your
> > driver? It was intended for exactly this use case, to allow drivers to
> > delegate their translation to userspace. Though that doesn't relly
> > solve the questions about what it is even being attached to..
> 
> I had a cursory look at iommufd, but it seems like:
> 
> a) it requires IOMMU_CAP_CACHE_COHERENCY, which is not offered by the rk_iommu
> backing the RK3588 SoC we are currently targeting. In fact, IIUC, this does not
> seem to be possible, since the encoder is not cache coherent with the CPU?
> I.e., does iommufd expect hardware cache coherency/snooping?

*Linux* expects coherency, if you are DMAing direcly to user cachable
memory and you aren't coherent there are issues, and minimally your
driver would have to do the cache flushing.

Which we have deliberately made it so drivers cannot do to force them
to use the DMA API.

This is one of the unresolved problems if a driver tries to use a
paging domain directly.

> b) there is no way to do what I said above about GEM, i.e.: there is no
> connection between iommufd and GEM.

Right, because you started out saying you wanted userspace to control
the mapping and put user memory into it. Kernel controlled GEM
mappings is something entirely different.

> You seem to be saying that what I'm proposing here has a few pitfalls that have
> come up over the years. Perhaps we can massage iommufd to make our use case
> work? I can volunteer to do whatever work is needed, of course.

I am very confused about what you are even doing. Can you explain more
clearly please? What does you DT look like? What do your attach calls
do? How many struct devices do you have? Who is calling the DMA API?
Who is mapping the paging domain? And who handles cache flushing
issues for your incoherent architecture?

Jason
