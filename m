Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC8409E1C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181571; cv=none; b=LOR+RW76WPrKRETQEHW6/C02iCQ7tbMD3bIELE6mmxrRrjpHm0S99hNwy2Rvz46NwOknb+wZEHOEOx9MP0ao1pdVQSgH7mV8Eq4Cu4jNvfxrq93ejEo+EWAyd2yUq8u7+ziIC7rR25MujQP3iPoqQsFdhup817fUiIKihW+Gebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181571; c=relaxed/simple;
	bh=MV15nxOHFor4yNcSn+17krF+1oXD5USMzBTrCNx+2tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCYOPhHsj21U3LCBJRToECyOettmif+aBnGS4FUtr1LHV0m9JrerRo+zSupRw/4+hqkzIb/59I/CJrb5AfrhiX8d6HpSmrosxMCi6Ars6YBXbAlhivoXMA7J+yc00bLRipX6EnP84kTSioCK4gUtg5sxIcE5C3zOAOYsSbjoCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqGTuJrR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqGTuJrR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b150559bso25278845e9.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779181568; x=1779786368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KzuyoCOkwbfj6tR36TDJK9gqiV5pxoB5tBNWM4bdEA=;
        b=WqGTuJrRVeGAP7YwXytOAhSfb61At5YFl2RK/RGkdRy+DZH6GOErGwDoWqhP72yPiT
         VRFUV6o2soCLsXcQnt7fp1u9fWFnLCnVxb2Hbk7l7CnZRlV1EcJV365YTZ2SleQBksJJ
         9e/WdujsId6fs7M7ecpzt94xX+N9DEjaZ5rg74T4boCsOWacu4rXie4k9B82/5cr3Nvq
         e3swvRUlOJ1jfR2RKzE/zSoZUwaCsUMFYXW7BnoLtvCE0ZDpxqJ2S70d9Oy2gFLj4gXr
         nCVfkFeLitRCIZakPBjcta2M/LU4N3KdyYbBjbv4eu41B+fS12rFgRO2hLoQJx+Ju/ot
         Ms4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779181568; x=1779786368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KzuyoCOkwbfj6tR36TDJK9gqiV5pxoB5tBNWM4bdEA=;
        b=BjKG/RVL9dYg8hqov/twL3BkFHLyLXfufwz4PK+HDSQIrHNiyCH4enMZ3Xz5MMyuKD
         sPniL8cHKFXcuw3EQaagFCVwISJlHo7eojofR2UQUt9ux0b8SMYVtXKtWXdfzpB8GBFz
         5k1oxYpbQENWANWap4nBbhq1HxW68eXYlIF1/jHavSMvuLivouezv+OAo9eAo0bAc+S3
         80vMZmfRoCAykcwmnLOuQMAlrigbRUS2KMQkjcNFkRjTa58iquJUnblbYwCGMcV39AIy
         RJ7UkLH+ydf8hwtLXn/KTwfG4dzHRxZ0WVz9JbY5zDwiQmmqddWcZDWxKRIqIrjPQ6U7
         HNWw==
X-Forwarded-Encrypted: i=1; AFNElJ/2ZsxKZzq00tE2yoQCIYrDwBqmhG3I77vD5VUWeMZDtxWsm8JH4F1FDQCkMJEJppmNm2+0Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSp0wDi6+6TCIAHiFEbI5UkB/lMXp/4tC2+LiJcMEe4/WS4ZLx
	o3wEdaquL0viyGfR8AYhsSGPZx9DmJzS342D0EtdyQKzsh/0teV5wEji
X-Gm-Gg: Acq92OFU2Rq5cLWN2t0Ll5MB4mLStN34+F149Qf1oXEVOis2fMqAcZew9a6jKTXJPJB
	/Al1/4/kH53ZsM40f5iXnSvCjFEmz6KFKlf4cPDCp413vggnQoHxswxHsVRGI7HwHV45oGcTAIv
	Yn53jXi/q+d7s07pK10T3ONJb5+d3i6T4WOwrb4dVXoWyPlbOBGtK66oaj7S9gYiSTNELIe1Wc2
	1ZcEYoifn35AdjcLIx6IUB2QkPuUKc0G5fyFmITK2O9mRBRFSPG6Mq6aboEh79+hSOeaUPBUylu
	cjrycuWmlY/5EbIq2/EsMQb9/cqp1s5Ue1B64v64Q5em7kOwSFLkXHGhZJWssijz7tvxomujgfw
	O7TxlrBV0w/1R1tN3G4YeXmlTJAAqhO0U4Zjp9Km/fzQxkEqdmEdPfUnRT6JK1HgzDj0s7BSz14
	1rt4FPsAxd03ftXx14GzdEFfvmCEQmrfWXpY19wyyKVWIHXdOklcuHUaNr53ZGVKZw
X-Received: by 2002:a05:600c:4e02:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48fe6322416mr301618735e9.18.1779181568347;
        Tue, 19 May 2026 02:06:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe74a53sm103879765e9.27.2026.05.19.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:06:07 -0700 (PDT)
Date: Tue, 19 May 2026 10:06:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, m.szyprowski@samsung.com, hch@lst.de,
 robin.murphy@arm.com, djbw@kernel.org, akpm@linux-foundation.org,
 catalin.marinas@arm.com, harry@kernel.org, ming.lei@redhat.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
Message-ID: <20260519100606.6b3c91e3@pumpkin>
In-Reply-To: <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
	<20260518121047.GR33515@unreal>
	<CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 17:23:15 +0500
Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:

> On Mon, May 18, 2026 at 5:10=E2=80=AFPM Leon Romanovsky <leon@kernel.org>=
 wrote:
> >
> > I would say this reproducer is incorrect. From what I recall, the only =
two
> > legitimate use cases for cacheline overlap are virtio and RDMA. =20
>=20
> The wild trace in the commit message is NVMe block I/O -- neither virtio
> nor RDMA:
>=20
>   add_dma_entry -> debug_dma_map_phys -> dma_map_phys ->
>   blk_dma_map_iter_start -> nvme_map_data
>=20
> The block layer submits many concurrent in-flight requests; small
> kmalloc'd buffers naturally land in the same cacheline under high IOPS,

Isn't there a flag to kmalloc() that indicates the buffers will be used
for dma and mustn't share a cache line with anything else writable.
(Which means the size must be rounded up to a multiple of the cache
line size.)
For DMA_FROM_DEVICE it is important that the cpu doesn't dirty the cache
lines.

This is probably worse on systems with 256 byte cache lines.

-- David

> which is incidental rather than intentional overlap.  Ming Lei's report
> linked in the commit message [1] enumerates additional non-virtio /
> non-RDMA cases hitting the same WARN: liburing iopoll tests, raid1,
> dm-thin and other storage utilities.
>=20
> > The first intentionally relies on it for small allocations, and the sec=
ond exports the
> > cachelines to the user space and cannot operate on non=E2=80=91coherent=
 architectures. =20
>=20
> The reproducer isn't claiming to be either of those.  It deterministically
> reaches the same state-based gate the wild NVMe trace hits
> (!is_cache_clean && overlap > 7, with direction !=3D DMA_TO_DEVICE, after
> the v2 coherent-arch / SWIOTLB-bounce suppressions are evaluated).  Since
> that gate has no subsystem-specific term, any caller -- synthetic or real
> -- reaching it with those state values triggers the same WARN.
>=20
> If the broader concern is that the block layer should opt into your
> coherency-attribute work rather than relying on debug-side suppression,
> that's a reasonable longer-term direction.  But it's additive: even with
> opt-in adoption, the WARN remains a false positive on coherent arches
> for callers that don't annotate -- which is exactly what v2 (3d48c9fd78dd)
> already established for the sibling "cacheline tracking EEXIST" err_print=
k.
>=20
> [1] https://lore.kernel.org/all/ZwxzdWmYcBK27mUs@fedora/
>=20

