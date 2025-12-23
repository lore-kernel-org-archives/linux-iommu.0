Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9792139D
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766448190; cv=none; b=Q9pgOOtptpw/EgsPtqxkB/mFDf7JDqM2+RKoq7wjJphz0VZmoAVct+ufBJuKomd3BO5LAbd7N6c16s5CWJ7bLK599usDs4cLkAwyIVRmlkQbXiqXrFmMyvfTdP00NpME5o46ygnJyNLGXRrXY8QB9wN4D8fNV2x5N7LdVDdiAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766448190; c=relaxed/simple;
	bh=juAIOmILzQG+So2+STFQKwLHKHJ4nfNa2seKYSN0cmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4nHSTS597NpJTIajSWEcN5jry1OKVdW+4NhM998tbcJdopTEuG01AR7bGQX0jyhApi+B0qO/zXamZYUKj0m2Ml7t72Px9MVjXQKcHkqBOHenNf8i6T97yfeqw9gQhlkPIHKqt84RBUTJa8qM5WDrqe8zir2uSC4SksqRpmEJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQy/38H+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQy/38H+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a288811a4so50541696d6.3
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 16:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766448186; x=1767052986; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LOicgErNhTFYQEd3WH4kuv3Qzd96akWti2P2bwjKXg=;
        b=EQy/38H+fHNqxCxYWKD1spsIS9E2HSkxjURamVjRhN5QOMnczq7UaGT1zPC/oe2D9k
         4pbXQLAfbW2ET3ECf8c97pZYI436cpNLRRIgkWVbDIsS85Dgx2yr0ap8JUYVWt8d0EJc
         zX+GY0jh08+Po/u/AJJMVS23jIw3cRi+UEN5XDo1RQg9mvEjfQ9XlUnmIZsMyTZ3Wph9
         2d6jhWCqtIEERJU8lXrZUN9hsrTZT2ethYOGrM67TI2B4WR+bzP73CU8Z6CcDzuWq2V9
         a0kV6pjfpceTVFEJGzDnFrWLAwShyT2PvnmecMVuPlJGvZGTBJjENOJPNXIcwzLA/mki
         nXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766448186; x=1767052986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LOicgErNhTFYQEd3WH4kuv3Qzd96akWti2P2bwjKXg=;
        b=wsc2FdNu9XghiexUZkSR9MnXG+6v4FEope6kNGVTyabVCfNejQrChjXn0//FdrKTyk
         xdWl/9QkILo0oxJ20s0zSmqQSW8J7gHFEKLen7zHaUBZuapQUCZoiHoOYNSFrhWUpL1p
         Tjj/KbgqAyKIZwt748vRLdYUId5ibTEpgIsRqEx2H6nq5BWAu5MUANxBBqu/cQ7aIPj4
         hcz9PzRfy6v7k4kDpFUD4F+e5VLZizOWs1f/f5cm2FpXsAto/MhkChYov214ErtPBqIK
         3uECC8Amygw+DUlHvOMXDJSdjazDmBDET2zofXDRX0Gomsx2/OvtYbaO/Ul8t6d4fKnJ
         BN5g==
X-Forwarded-Encrypted: i=1; AJvYcCUWsmFU7hu36PNnEYZILznVhjzkh3pTeB9MJlcZj53VATbCmqXhFGqCPbIJR0YNz8gYQMzADg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy1W1j4u0PO2jfrLaVZpANwxls+fSRHZngsl0HdN35/euC75aQ
	pIsHgycodwkEXBAFixk+br7y80CQ8PVxAiYxU8aRfRzGTUsjjTpWRfLUb7Fzef08lhTHeZsWFmx
	79/odFzZbWSntM/ARi9RxwwY+CWHJJwE=
X-Gm-Gg: AY/fxX7fMttw6j99bTeDEIjvykyeEfArhTONPqvhnu1nKRk3D1h880mfDlZEwQIjhZa
	FwPThNC1g+C7ZVuDpdtXroXgpOeiGOmmylx1Vjv/KXPpz/h4LQVLTGbo2nr1noVcwIQeY9BipEp
	yCFc89sE2grfyhrBQ3y6/hrHL31GoORV0X4dPMdnQf2bt7Hd/WlXBB+LaQlmUZLG5PazLgpDoc0
	31lHghJdegD0pCiBJlcAxGwHHIoZ3c2tjiLXQLUGmuXAprNY9C8Zd6nggS2wTGhE0IA4A==
X-Google-Smtp-Source: AGHT+IEZZVrQZ0i2FOsWBMrA37EgStlHwxoujL9L1Fx4NStIdzIudBmVYo0v/NHWIETz9sf+Dm3aWxP2ut/+MfFNKiE=
X-Received: by 2002:ad4:414c:0:b0:880:4310:7e02 with SMTP id
 6a1803df08f44-88d81d42e4bmr152858826d6.21.1766448186339; Mon, 22 Dec 2025
 16:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251221115523.GI13030@unreal> <20251221192458.1320-1-21cnbao@gmail.com>
 <20251222084921.GA13529@unreal>
In-Reply-To: <20251222084921.GA13529@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Dec 2025 13:02:55 +1300
X-Gm-Features: AQt7F2rid0y3y0Yd9WtXER6TR3yir1jQ4ns4ZMhe7WurwhJeM4kREFYEM2znxW0
Message-ID: <CAGsJ_4yuvHNqHDi8eN-8UoY2McoXUeCMmbjFAr=jSdv8GpGKeg@mail.gmail.com>
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if
 supported by the arch
To: Leon Romanovsky <leon@kernel.org>
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org, 
	catalin.marinas@arm.com, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, maz@kernel.org, robin.murphy@arm.com, 
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com, 
	will@kernel.org, zhengtangquan@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:49=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Dec 22, 2025 at 03:24:58AM +0800, Barry Song wrote:
> > On Sun, Dec 21, 2025 at 7:55=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > [...]
> > > > +
> > >
> > > I'm wondering why you don't implement this batch=E2=80=91sync support=
 inside the
> > > arch_sync_dma_*() functions. Doing so would minimize changes to the g=
eneric
> > > kernel/dma/* code and reduce the amount of #ifdef=E2=80=91based spagh=
etti.
> > >
> >
> > There are two cases: mapping an sg list and mapping a single
> > buffer. The former can be batched with
> > arch_sync_dma_*_batch_add() and flushed via
> > arch_sync_dma_batch_flush(), while the latter requires all work to
> > be done inside arch_sync_dma_*(). Therefore,
> > arch_sync_dma_*() cannot always batch and flush.
>
> Probably in all cases you can call the _batch_ variant, followed by _flus=
h_,
> even when handling a single page. This keeps the code consistent across a=
ll
> paths. On platforms that do not support _batch_, the _flush_ operation wi=
ll be
> a NOP anyway.

We have a lot of code outside kernel/dma that also calls
arch_sync_dma_for_* such as arch/arm, arch/mips, drivers/xen,
I guess we don=E2=80=99t want to modify so many things?

for kernel/dma, we have two "single" callers only:
kernel/dma/direct.h, kernel/dma/swiotlb.c.  and they looks quite
straightforward:

static inline void dma_direct_sync_single_for_device(struct device *dev,
                dma_addr_t addr, size_t size, enum dma_data_direction dir)
{
        phys_addr_t paddr =3D dma_to_phys(dev, addr);

        swiotlb_sync_single_for_device(dev, paddr, size, dir);

        if (!dev_is_dma_coherent(dev))
                arch_sync_dma_for_device(paddr, size, dir);
}

I guess moving to arch_sync_dma_for_device_batch + flush
doesn=E2=80=99t really look much better, does it?

>
> I would also rename arch_sync_dma_batch_flush() to arch_sync_dma_flush().

Sure.

>
> You can also minimize changes in dma_direct_map_phys() too, by extending
> it's signature to provide if flush is needed or not.

Yes. I have

static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
                phys_addr_t phys, size_t size, enum dma_data_direction dir,
                unsigned long attrs, bool flush)

and two wrappers:
static inline dma_addr_t dma_direct_map_phys(struct device *dev,
                phys_addr_t phys, size_t size, enum dma_data_direction dir,
                unsigned long attrs)
{
        return __dma_direct_map_phys(dev, phys, size, dir, attrs, true);
}

static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
                phys_addr_t phys, size_t size, enum dma_data_direction dir,
                unsigned long attrs)
{
        return __dma_direct_map_phys(dev, phys, size, dir, attrs, false);
}

If you prefer exposing "flush" directly in dma_direct_map_phys()
and updating its callers with flush=3Dtrue, I think that=E2=80=99s fine.

It could be also true for dma_direct_sync_single_for_device().

>
> dma_direct_map_phys(....) -> dma_direct_map_phys(...., bool flush):
>
> static inline dma_addr_t dma_direct_map_phys(...., bool flush)
> {
>         ....
>
>         if (dma_addr !=3D DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) =
&&
>             !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
>         {
>                 arch_sync_dma_for_device(phys, size, dir);
>                 if (flush)
>                         arch_sync_dma_flush();
>         }
> }
>

Thanks
Barry
