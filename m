Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458A37F33C
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675609; cv=none; b=t28F7ffxLmrfEga2wDmQQ7Df8lo8Sxxt3/EpntwcFWMJxm4AsFoyjnqXq6aXkHDVUYMGrbIQfBM8/B1987q/sY3ISPECYPpHe1PrF5R0ixmNu3bf+5NGytTJPML6MSOWJxRNpjoI4+UVuvpDpLCJdPFWTknj04mvnXUQWE0PwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675609; c=relaxed/simple;
	bh=B0G9v6BhBY4Fuj6Zio2PzdtQEPK77b2tYVyr2I4VYEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9JeBYjrCfHZjq3En+xjZDirVwUNPoHnAQldySYEgFVod9RDKZDfkKDiaA3bIedzitKWK0HSgTJc9xphUPnxS3+8jFl/X/ERRsGaAAg9YR7jjIJW8Q5EHb5eaMa813/0PBUdKIteexeImfOyuzlk71IKimzPWDKO8Yhdahfx0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9ivUXIo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9ivUXIo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso67505e9.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787675604; x=1788280404; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SkuHlshzOD+AxFcfYa+qONyS5a/GbEXwYVTwh7Zfzc8=;
        b=s9ivUXIonynx2mGvSKgvmM/Sj9b1AWJhVusuV6j9WvVgq+dWLo0NS9pHI6ojlb5bPp
         8Na82NpkPnI01yACTJTQpg1w+KJacs/8fj6kF+tphfnpgAH5ayBX0p/kPri0myIwZjhy
         WT/CX1Nd33i9sRpJhOyZ64vLInuggeTALq5pOAyBtcJej9PKQy3aVVB5HhFh2ETJBb9M
         sEFnYzqo01utZLnquZ5lqsIMgFPXSdNUGqitvfNUVAwgz/H4i0hpIJ95ox1Ta0XUitj2
         RRBhBpYvZ4qb7IKwdlHt/2L7Kb/9ecw2QlUWJVjRWQgFlENJYP9I5BBQqX2z9Oip1pAw
         m+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675604; x=1788280404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SkuHlshzOD+AxFcfYa+qONyS5a/GbEXwYVTwh7Zfzc8=;
        b=qTN24xDhl/RyMOPbC1JK7oHZSBv2bLqn88myl4geT0DK2/c0yIrOvoStT9Iey2rtft
         +aYCr1Oxc5xfTtvKzPesS3n5wkwUophFIKKIKwGKf62nKJ5ciyf5rp0cC75F5MmdsqY5
         vIrr0JsKEsO+9CKM9hvNPcvnSLJuYgQqZSw3ytwUulQdUO5VKo9JSAzh7z8MdU1wEqE1
         ia6CKoADBVeB1PsAE0lk82tEO16nOcOD2pUnjZT+dnaB97SSoFa4Tscb9nCOAGGZO4F+
         TchBgw09zXc37jiFxqqIAmpGMNcRda/85pqQoVE5iYNtdNxbR69yEp09JlePfLc8TUTP
         6R7g==
X-Forwarded-Encrypted: i=1; AHgh+RoRRrJmy8w64m3qqOGNTKZSpDCy965fLogp7JvAVh4VTowyzU2c1C/JjJ7Pt/CtxhpKOlwzzQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nwBhqfPio2mHLpQbqRNorRRR6ngPN7wIZw6Z1iBdHkiKlzQT4b
	01iUeRizsPeFLEN7NTH/0sM86g9PIArfqjmqO8HUaaEvfwos8rM90kFAwwdIMfxtwQ==
X-Gm-Gg: AR+sD120nYSRje0oeH6vzkav7WPnplYjYJM2j17Y8W8YvHJdkxuEq655XbVji+Ieskb
	N++6OLy9F8leIBlU4GZehte81eDtLQFqSbhaii+9MavZYlYBRklpfRjCr2QIhsxx8ZIUfHtoccE
	VRM/229uEBFTuyJBS/fvSOTrltvvhx9QqHy/j45pI+tJK6D3AY9TkFt/F7mSdiWEvqN3OmSND/Y
	wXVxZJSU9ceLkJL0zNujcdulU3QZoarpxd659TjF1DGedEgvEJSidaGPrN2UFO3No8urSASs55m
	jygEKofgIf6X4M6XkSNoLRR+SoXhdWzzSYkPrhdwQrW5T8PTpCJ92S08N4iUdvEFidlhShry6v4
	JSLueS3yVjtTjJ0axpJ63xii3y67+qv4dGeTiRu//3oYKDUA21d9fhbC3t+En199JMvpkkaiOc0
	h6HZbhGBz1JJYeVN//RTsVreYUdA66G+THU/b+2S7hqsOI/W7n+MV0Sy0V9rKtOY/4jY76hgpvg
	xSzOhZ6PPrKA8fuQatzIyw56h3gng==
X-Received: by 2002:a05:600c:a31c:b0:499:7da3:dd0c with SMTP id 5b1f17b1804b1-499d867c424mr1003585e9.0.1787675603950;
        Tue, 25 Aug 2026 09:33:23 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc960f24sm217945e9.3.2026.08.25.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:33:23 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:33:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Luigi Rizzo <lrizzo@google.com>, Jakub Kicinski <kuba@kernel.org>,
	rizzo.unipi@gmail.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, willemb@google.com, kuniyu@google.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <ao3DzzFIVPdtL7MX@google.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
 <ajEuUZMgS_NRmDcp@google.com>
 <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>

On Mon, Aug 24, 2026 at 10:59:21AM +0200, Dragos Tatulea wrote:
> 
> 
> On 16.06.26 13:06, Mostafa Saleh wrote:
> > On Tue, Jun 16, 2026 at 02:33:52AM +0200, Luigi Rizzo wrote:
> >> On Tue, Jun 16, 2026 at 2:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >>>
> >>> On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> >>>> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> >>>> especially with greedy senders, this has a high chance of happening in
> >>>> the softirq handler for tx network interrupts, creating a significant
> >>>> performance bottleneck.
> >>>
> >>> What's the use case? I associate swiotlb with debug / testing mostly,
> >>> so it'd be useful for people like me to explain why you care.
> >>
> >> Ah sorry, I forgot to mention.
> >> swiotlb is used in guest kernels for confidential computing VMs.
> >> Ordinary memory pages are encrypted and the host or devices
> >> have no way to decrypt them, so the kernel must use
> >> unencrypted bounce buffers to exchange data with I/O devices.
> > 
> > I started looking into the same problem recently, to reduce the
> > bouncing in protected KVM (pKVM) confidential guests.
> > My first attempt was to update dma_direct_map_phys() to skip
> > bouncing and do inline memory decryption (for pKVM that is a hypercall
> > which updates the stage-2 page tables), however, that was really slow
> > compared to the memcpy in bouncing even for massive pages.
> > My conclusion was similar that we need to solve this at construction
> > by making this memory allocated from a pre-decrypted pool (which
> > does not have to be part of the SWIOTLB)
> > My initial idea was to teach some of the kernel subsystems (SKB,
> > BLK, SLAB) about "CoCo allocators" that allocate decrypted memory,
> > as this is not a net specific problem.
> > 
> An example of this is Jiri's system_cc_shared heap which is a dma-buf
> heap with decrypted memory for userspace.
> 
> > I am still looking into this, I was planning to bring this up in the
> > upcoming LPC.
> > I will give this patch a try. However, I believe that we need a more
> > generalised concept for CoCo pre-decrypted allocators in the kernel.
> > 
> There is a talk at LPC in the networking track about this [2]. This is
> exactly the type of discussion that I was hoping to have there.

I see, thanks for point that. I plan to be in LPC, so I will aim to
attend this talk.

> 
> Besides the issues mentioned in this thread we've also found that a lot
> of overhead can come only from swiotlb allocations when running many queues.
> 
> I will add information about this series in my talk. Hopefully I will also
> have time to add some numbers for comparison.

I had a quick look, I am not sure how that will shape at the end, but I
think we need a general solution beyond NICs. For example in pKVM the
bouncing is used with virtio devices, so doing this per-driver won't
really work and is not possible in some scenarios where memory is
allocated from the core kernel and then passed to the driver.
So, I was thinking the kernel relying on
CC_ATTR_MEM_ENCRYPT/force_dma_unencrypted() could detect that and
allocate pre-shared memory for those cases.

Thanks,
Mostafa

> 
> Sorry for the late reply but I spotted this thread only now by
> accident.
> 
> [1] https://lore.kernel.org/all/20260325192352.437608-3-jiri@resnulli.us/
> [2] https://lpc.events/event/20/contributions/2464
> 
> Thanks,
> Dragos
