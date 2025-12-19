Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779011FCFEF
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766124763; cv=none; b=thnDVKZcjcxHPb4VgyTCBLJm0hVvPTHnQJ3tkDfklBxL2N4ECgCW4TRcgmQ1C+ISsVQ888gaN7qBcHW2eSKLXx1oN+Zf760MvBALmUSIZnRNQ2pCg/G9TSYH6msJ5Mqe7iMsja9KzEig9SyVTY3UZrnpHKaAw76DcUWXbKnmx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766124763; c=relaxed/simple;
	bh=GOqw5DZzZuhpet+14BvBgY+LzFXjgd4BbbuvhnIbrOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6uhbwBGCH2I1TnaAb7p7Wd97Kqd2Vtb54IJq8GiWQM6HlEvJQmZU5WLDHDT0Qus1TNAD9tVgBJ/prjfs4g13SvG3RYcLa7oHqLkRfBUOnWcjvWgXiQkiMVfXswM3ivmkVU8ZXI9rG3/hvekvQzWbOjT1MJKAGrjtj0qSc2fjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arQB2Krv; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arQB2Krv"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f64ae67dbso374783241.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 22:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766124760; x=1766729560; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Seqw1pj+s32EzkTxSRr1lPFhSWcfs+qzm8EZKw7fxvk=;
        b=arQB2Krvu7o/tyHmKkghLWRCoWkFHoRaMTdV181h91fraxL3stlUGjnzzHe27UzEbg
         ylVg2cJM37cprWEGTnB21HxtQcu2F6PomKThG0KXKjByD9U8Xi9WszNXHXWrTfsQr1yi
         MeTtf1Amh7NwwtxxwDqHzQbCNZLel0BzSzMsu0ajbPBOgH8qlnkE3TziMJ8A3rDlGpfH
         IuKzHbLIOGcvMIHhbpcfM4C7EZ0jIXxrgvkkIzy33qpuOV57KxY7fFsiaZ1EE4k6KOyK
         1+/xPkS7PdLsQ2DlRUGwHYmWw1LsWkMFp0RE12BcLUOFBpc1RTRZkTCWp4MX7NI/cxMx
         vyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766124760; x=1766729560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Seqw1pj+s32EzkTxSRr1lPFhSWcfs+qzm8EZKw7fxvk=;
        b=QTGT8OjkA4v9I/W+e0xIL1NlvasFut6+tn57m3KnzmkUm6aAPVjxxkLecaW+XHJtZX
         jqZA3vHWTITqnEJePmmBSCVfSjLZMDFVGyafvEGcUNM+ptfqe+8ppH9/wsPO3h50bRB0
         iquSm8WM5RSrnHjknvb2gnlKmEPElM8ITZMYZ+59rqepugS7nsgw8Db+yQIxgUcLMjXQ
         b/o1ZJESylOMvZiJcIVn5P4HB/8LJFoQXjGEcpXS8baqSciYx1Kwj7pI/LP9nSdPMFM3
         E27aAUqkrtaj6YsYpgjl48uWs+azkqZUwIpeiulBVO4M+HbBfeXDTj8WtrmtDFYJSPFs
         Fuuw==
X-Forwarded-Encrypted: i=1; AJvYcCVVKR9FP4mX8ONcWss6YTmfv+zQU7c8eLxkMWTVebkNMcLRT7x6ipIrZ2l/9XrM5wU9nYNQjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx34MptgwsvKwf8STHkyRCRX2of25eYwqOERC6HM2VcUGvX8i5X
	2pdl9BS78Xg/oty32NJFmmy4ju9PWsDlNbvop/Ucu3OMJ7xp573dRmb+cWWfx81yinHNC5sa04u
	jsLYWW3BFEPcsS0ZPoOaVvoE4AtP/zok=
X-Gm-Gg: AY/fxX62Cem6jHvxPPAcE4LtsGGKWDXmsm1O2C5i1F+7Taik6pcTPZ8lbHp1T5AaL09
	abAA7E8HkVlkPSWiEFiLx4Dt4GE7ouFUhKLtsuP836H3HIqYYX5/x1KxI8F3O9j+OEjwve3pfbx
	1DB1U8DULKB6jXelse5FtzPfz7QWRlTMDiJph4IQ/qplwddAIlbAUHP5OKYFGY1P7OW5tisk7sC
	xUg7z+ci+2E3z23+gxiAmiiXetN17WYol26gWrvFbDLY5I06YpXkwkLQlxR56MXOzGAHQ==
X-Google-Smtp-Source: AGHT+IHVAIB9EXt8ze8fpRH7DuJvrst/8Jm6U+PV/YkYRLVhKzfveCY9N+lLA5aRRN4x+/psgM/S/yxWdRr7JEYae2U=
X-Received: by 2002:a05:6102:32d6:b0:5df:c1f6:be44 with SMTP id
 ada2fe7eead31-5eb1a616edfmr463311137.5.1766124759992; Thu, 18 Dec 2025
 22:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251219053658.84978-1-21cnbao@gmail.com>
In-Reply-To: <20251219053658.84978-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 19 Dec 2025 14:12:28 +0800
X-Gm-Features: AQt7F2ocTD4IJSx97glcMfCOzOn9j6QaEk9Mmx1rXjj179nhPKrWDK_ik_o0Wu0
Message-ID: <CAGsJ_4yKeUHgxRJJHiOcdaVcV1pjeHRjbybvEs5YLm=AJoe-Dw@mail.gmail.com>
Subject: Re: [PATCH 0/6] dma-mapping: arm64: support batched cache sync
To: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	will@kernel.org
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, ryan.roberts@arm.com, 
	surenb@google.com, v-songbaohua@oppo.com, zhengtangquan@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It is unclear why, but the cover letter was missed in the
initial posting, even though Gmail shows it as sent. I am
resending it here as a reply to check whether it appears on
the mailing list. Apologies for the inconvenience.

On Fri, Dec 19, 2025 at 1:37=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Many embedded ARM64 SoCs still lack hardware cache coherency support, whi=
ch
> causes DMA mapping operations to appear as hotspots in on-CPU flame graph=
s.
>
> For an SG list with *nents* entries, the current dma_map/unmap_sg() and D=
MA
> sync APIs perform cache maintenance one entry at a time. After each entry=
,
> the implementation synchronously waits for the corresponding region=E2=80=
=99s
> D-cache operations to complete. On architectures like arm64, efficiency c=
an
> be improved by issuing all entries=E2=80=99 operations first and then per=
forming a
> single batched wait for completion.
>
> Tangquan's results show that batched synchronization can reduce
> dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
> phone platform (MediaTek Dimensity 9500). The tests were performed by
> pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
> running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
> sg entries per buffer) for 200 iterations and then averaging the
> results.
>
> I also ran this patch set on an RK3588 Rock5B+ board and
> observed that millions of DMA sync operations were batched.
>
> diff with RFC:
>  * Dropped lots of #ifdef/#else/#endif according to Catalin and Marek,
>   thanks!
>  * Also add iova link/unlink batches, which is marked as RFC as i lack
>    hardware. This is suggested by Marek, thanks!
>
> RFC link:
>  https://lore.kernel.org/lkml/20251029023115.22809-1-21cnbao@gmail.com/
>
> Barry Song (6):
>   arm64: Provide dcache_by_myline_op_nosync helper
>   arm64: Provide dcache_clean_poc_nosync helper
>   arm64: Provide dcache_inval_poc_nosync helper
>   arm64: Provide arch_sync_dma_ batched helpers
>   dma-mapping: Allow batched DMA sync operations if supported by the
>     arch
>   dma-iommu: Allow DMA sync batching for IOVA link/unlink
>
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/assembler.h  | 79 +++++++++++++++++++-------
>  arch/arm64/include/asm/cacheflush.h |  2 +
>  arch/arm64/mm/cache.S               | 58 +++++++++++++++----
>  arch/arm64/mm/dma-mapping.c         | 24 ++++++++
>  drivers/iommu/dma-iommu.c           | 12 +++-
>  include/linux/dma-map-ops.h         | 22 ++++++++
>  kernel/dma/Kconfig                  |  3 +
>  kernel/dma/direct.c                 | 28 +++++++---
>  kernel/dma/direct.h                 | 86 +++++++++++++++++++++++++----
>  10 files changed, 262 insertions(+), 53 deletions(-)
>
> --
> 2.39.3 (Apple Git-146)
>
