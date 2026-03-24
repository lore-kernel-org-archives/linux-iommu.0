Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C313F076E
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373797; cv=pass; b=ieGb/MPwDlFLZKjKExtbk+v44rKd82MbuNWVc0Hc0axwfu8XcwnQaL99uszg2ll3342LeKp/Ej1kKbfDseqyXlIugwtEkrS79uTnE6LTpD3NHMQV8Zzq4SGwqpXWVli+RArxYo1WOcMSe37wSevrfxIMg5Na5XSy/16SpHB1KWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373797; c=relaxed/simple;
	bh=QKH3FIlHUJB8Q1byrwVmEses+K6AxcmCpK6mo9PTNmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Okj0d0uzW+ZRfjK0rcOcpuccAB5kcapJwqiKcfAxSjebTaRyiWUfKBwNc56X/KjZb7oL25MFMQzDtNf4SrB+YbbcxDMg99qldUPj24C/YcNtgBp22TkxQ3uQgaDWPb2W4+v51m5lcMyA76V4dnQ2BkwcOBbOZZX7qbPxWJxLkiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYjK2GX+; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYjK2GX+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509069a7a7fso42021cf.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 10:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774373795; cv=none;
        d=google.com; s=arc-20240605;
        b=Ab5kDjl8Owq/KXw8h/9iQGuXrTQUtk+pf8w7jDztKKN67wW9qkWBN68ZXbFBHjSybp
         PrwIRp9HqU5j3rParFgMyoIcjEqTNdYcIQgMgwuEwqMLoCDzU3JzSqsqViqwzY9JTOXW
         kIxU+REimy9pbyYkgxYo05jBMutP5i+3sGl4GV9tmiAhzzyk4v6FeCld+Z6HWwNASBRU
         kbQnYlwOD0NxLOyfTo6vPmhpMqqC+jyD2FmqtbwGwynxbNMmFB+esA/ku8XqnpbPhC8U
         86hTFHhjTkXvtNa9LNmMjKctwIktxFh8CE3ffDtQL26UBB1UKuosbmdba1LHX544xw38
         nMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T7cRZZnHlvElmV5E4d+ARimoSvXKMR3JQuoEi7NRgdM=;
        fh=mEdY8+7svGb9tpK2hVffkU8x/k3DV7/0FPFjOQq7YRI=;
        b=demvvWg5RAvBai/LYUET8kd/ulXTC6Q/ws+Dr/PPNpGNzcZqrgMIrm/tZ142ZHYFVR
         cj3sQywljJITzf6D/daz8hAL6lEzVxizei07RfkX+iBRufWt2kmEV+jR8fUEAwpMMqk/
         hy03FHgPH7XZvPI+dscW07T/RnFVoX8e6/dzCwYi9kI69+6iQc3i1p45oxcIpkYuy4Re
         Ieo1hfQg1DvQmkhJ0XLLb2WVY8VMxS1PtWzCingp0Z+UNhHuaWAy7N6OseStGP3ORA+L
         oG1GjQbrrrr7qOWGhkFjz0hoNlWLZGUp0ySE47mNXhEVhhWqRBInWBxlR9NVSKozjGLO
         M/SQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774373795; x=1774978595; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7cRZZnHlvElmV5E4d+ARimoSvXKMR3JQuoEi7NRgdM=;
        b=GYjK2GX+LXIlRx4zjtv6IPyBkm6DbjHr1Aevwm/sUV7EEtg7fhxginGiR99OFAc16G
         9TqmWvj/6CupkmMmjXQwlLfmE23b001Kwyftn2d8n8TE/c/uSZFX3UZya9YHSt5EGHcm
         YnwVIbn4GNZUjWXQoORVw1eHMQIkLdZ8Dxge6C1p1+Xe+plLrcj2QQrz3VJgBk/Tus4y
         U5boXrsm64PAwKNv/QfIL1NHgunXroI6J5BOuzjGewO85jG2cuUWjz1FpekpezlaWbeP
         Tafh0Y6bJ+cK/OWuwVcQxzEIjFFeZ94Ju0iTxDOpuLqbf+EQMGP1Csw7xSjrbKdNHLaD
         feSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373795; x=1774978595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7cRZZnHlvElmV5E4d+ARimoSvXKMR3JQuoEi7NRgdM=;
        b=QM3Sy66JQT86btjCjKPHLzpxEVYKCFN9KtuuRPwRWxos2/jw18MU6adArM4/whzMtX
         D9CXFDLewWHh/x1NwO7HVRZyCBsHYItrqLe70hoP8GBoKffBjsMoUvall8fneFffZVXT
         QtU+586WbltKUPZqF008fsINEh98kC6oACbluM1Gy2ZX/hyzS/a/TyIRSRHmFTn5paZ4
         dOBDRn5ugUzfc841AlRK9CFiT2Pz1qiOYKd0ory6OTkgyliuuJ+qmiZcvR0QMB0Fqujc
         ouRHE6Ky2Gy+2ZjWR0j58M/b3zZbxNdLyfzgeFtcCWCM9bn+UrrbSMrg3MEIC2T2X/tA
         z8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXEXAtYl/oJlND8KBTG7rxgt5FvMTYYZWgaiqhNqcuxNC/iI7EkPKYYO60M14z4TKANEkIWOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvRIoeP2m3ihk2Xw3OoBA3Jvv0qP0vZI0pqA+56FivENZAoeSh
	qHuJp3NmwQkUoUUXpSE16VoKyK8kWDr+gQhGSOLcmv5WAC+WPJ3v7vePywloCmXKp5ICB2xzcwu
	ofpCA9ep+ZQOGUaxMf73IAkf0DDdlBmVxeR5uXGk3
X-Gm-Gg: ATEYQzwxbWgEtfgGgSiqt+A/C2KyLxxIIKnqQf+Z5vPg3x9U9Gg5/sGuVE3Z+mWYkAd
	h8sJgszFM8tYl3/GCp+2SttFQKOZWURNM7rjcjm+J52H8tToFpV29rwXMmXdV3RseNlHTcQGBei
	XdxIPOc1bs6W7MZX17fhHtL2TcAaDDQMA8r9J3L4RBFPnrnaIGwdEbxkgYUPidrgTkq83GEPU4H
	2slwFFjjLyo2axqSAXJgmiTHqy/eb5/UUHBKAvEMYtXMpUdsVEDVASTnLWnbT7wFuKzjNsCou1X
	SqXVprqADRhcdlu1t5w53Hkx/RGez3A6IHm0PhQ=
X-Received: by 2002:ac8:5a41:0:b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50b823fa2ddmr354431cf.15.1774373794536; Tue, 24 Mar 2026
 10:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us> <ablV_f_l7wD2m63E@google.com>
 <20260324120057.GC8437@ziepe.ca> <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
 <20260324122416.GD8437@ziepe.ca>
In-Reply-To: <20260324122416.GD8437@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 24 Mar 2026 17:36:23 +0000
X-Gm-Features: AaiRm51PAsNGUjv3vtee5YHklYnd6tfPfqFJtrYrMATN4cWFgoB-kqA4e1zQENQ
Message-ID: <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, 
	ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
	suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
	john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:24=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Mar 24, 2026 at 12:14:36PM +0000, Mostafa Saleh wrote:
> > On Tue, Mar 24, 2026 at 12:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:
> > >
> > > > On the other hand, for restricted-dma, the memory decryption is dee=
p
> > > > in the DMA direct memory allocation and the DMA API callers (for ex
> > > > virtio drivers) are clueless about it and can=E2=80=99t pass any at=
trs.
> > > > My proposal was specific to restricted-dma and won=E2=80=99t work f=
or your case.
> > >
> > > How is this any different from CC?
> > >
> > > If the device cannot dma to "encrypted" memory, whatever that means
> > > for you, then the DMA API:
> > >  - Makes dma alloc coherent return "decrypted" memory, and the built
> > >    in mapping of coherent memory knows about this
> > >  - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory
> > >
> > > There is no need for something like virtio drivers to be aware of
> > > any of this.
> > >
> > > On the other hand if the driver deliberately allocates decrypted
> > > memory without using DMA API alloc coherent then it knows it did it
> > > and can pass the flag to map it.
> > >
> >
> > The problem is that the DMA API currently gets confused by this; it
> > can end up double decrypting the memory or using the wrong functions
> > as mentioned in [1]
>
> I fully belive there are bugs, but the API design is sound. If you use
> the coherent allocations from the DMA API then it knows decryption has
> happened when it generates a dma_addr_t and there should be no issue.
>
> Now, if drivers are using the DMA API wrong, like trying to double map
> coherent allocations then they are broken. I also would not be
> surprised to find cases like this.
>

But it's not about drivers in that case, it's about many places
(SWIOTLB and DMA-direct) calling set_memory_decrypted() without clear
ownership so in some cases they step on each other's toes, and I don't
think that will get simpler with yet another caller in this series

I am fine with the API design you mentioned, but I believe that it
needs clear documentation specifying who is responsible for
decryption. The code should provide wrappers checking for these cases
instead of having is_swiotlb_for_alloc() and force_dma_unencrypted()
everywhere in DMA-direct.

Thanks,
Mostafa

> Jason
