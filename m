Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38613F0ABA
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182324; cv=pass; b=Fj1rUK7MWapGMXC1UCV2xCRzYE5HI9iYQjEfA1wNGRYbOmn5WUhKrOiRiOL9LyNOhS1p/QjyYbd0P5GQJzIfrGTqY7+CVWEZKJlWx4o4sxFidsiqNo7mCHIVf45uTEfmbBl1RnuGiCMaD4jQSdCzXcsaj5uW9QUAUCqda+q3lS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182324; c=relaxed/simple;
	bh=ZzAu+fK+83nRbBr+C8zGS1c02CiUVdV0X9lIGhmfvhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaFRNwonqRaYHpWiZdKSZMo3dwjW1UW/H7vY2MfLMtFU6MJtbxL7rg00d33yhXkmO9OUqj5DE6i7hXiuXitBbdnRkx4codgAPHA/CHaXL7tdA2gZBAA2Mldol+kEDxolh3WL9lfRVlEFto/zNTTLJ+dRAhQTQ2n71ow75PZ5lpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOEfLSLS; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOEfLSLS"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbca22dbfeso1645186a34.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 02:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779182322; cv=none;
        d=google.com; s=arc-20240605;
        b=AKB9mIRKPFvN3mSlQUYnUFTiMdkpAzU+Hz919Hp5rXKv6F4oMeCdji0QdrE3Nurcty
         LoWw+P/BlCKNzzdB+09JWMhZuH/c2FwOguvsSWmjiH90+8VM7c2GG6HJwTr3GmZ2WSuV
         bCialCsprHehRKvDPJOTaVHDgz4Bdonw3fg+RWOORG2bYDsgjWlYYr+lKEUx83c2BBWD
         XQvKOsQ594E67eEGZ57foAIHg5Zm1ZLbHTkOGpf7gIw7uSLLRI/9WkCqS4/4zD4Q0/gM
         IkAZB8RkVg+vEw/34b3pJqB+kh9ngXAvkp85fECqF8PhDvBxAitACHs5F+p0Y1aDBMfU
         ZmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZzAu+fK+83nRbBr+C8zGS1c02CiUVdV0X9lIGhmfvhY=;
        fh=eM9jO/e9OOa2r1nmDhWII0zLjtWCZV/M+/nP+KTwLOw=;
        b=g8tdXdABLGF3ZY4o4KMQHP3Z6aARPnEQUq+qVJCgf1akzyRXkU3+4YmD2SZbB2lkFW
         1bMAC0AiFp3Kr8knW+wvdFV0pyMvkzaq8b+/MY6qcq2vxqgmuv4rkZO5C6LhgyjO/f2a
         PbodEKqsuSHyW8MDMqERHML6uP1r+02neVN7/eSyBllN3zLhIn12xwFXJm8t4LZ9o0/t
         9a9vQxuWhDP/jPn+MsLu7wvgOTmpnASasV2B0GhnPHpe5V9P6++A1sVDItSZ/xv9Tl4p
         3XoGAl8uAgjx/1hnygqc/XNKo661ZnD8d7YLe4vC37wlWALMVd9HZj1rTRwhQn/QG3NH
         T6RQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182322; x=1779787122; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzAu+fK+83nRbBr+C8zGS1c02CiUVdV0X9lIGhmfvhY=;
        b=fOEfLSLSSAembDqTeRk9YPgaS+cyj/Ecl5nTV2VDQfu41PvoO4ewo7UQjWdhBZq4PC
         PXr/GZAihbvVwxWf3Fk3cwOa5dBoKl1u6zjVFuhjfqUGKCI5GvUhYzvxocby4KN5qr4D
         8iaaTFHt6y2ldvbK027ctMnc/+6ioXZAaBi1Ccc7l5BgP1PWfT/YOkcl5/Mtqeof34Ll
         rYEO0qoe42EEvAyBwJcEoHZhQ94ZdspUvRWUNxx05k9xCKrjymNB7N9HxDyQOGmvpl8b
         eNCytx/9gbXo6KxDwJBcZA4xxaFfIQJE+on1PZBKiHLS49KaaW67vr6JajSAYozQEpQQ
         8Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182322; x=1779787122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzAu+fK+83nRbBr+C8zGS1c02CiUVdV0X9lIGhmfvhY=;
        b=UoPAaIaawnL8mTnRYGvjuh+eOCxZ65T7UdlPJG7oibyMPTnNhNZNWISIXaYCdRiv0R
         vKvz+xYQH7n8PK7mavEwMXlXieMNgfnwJdN4KpqxzilkRs4MBolGhv/PTtYNpwabwKqO
         nQuJQANyV/SqrQoamJanEl5coj1x3MqLqA8ay1hr6o3l34sPlOCZYlv5/79JaMmLnz/Z
         P+9NNJKps6WXbc5uqZgb2GoOPo93pYqFOdajonFm/gDU3faoju5wA6E49bfqT4ofnthj
         1EyAOJ0EusUNMyzr9PTVrznX+aTMwa9ucmbungSnPEMKpohbDN7GSFetor8srt7nYoub
         xPOw==
X-Forwarded-Encrypted: i=1; AFNElJ9yzYigA5cqnkUh+RURMKnkyE4P6lbeQuy+kCWaLSzZLZIVhmhuOXAjhnwO4Xf4kMs29NPUqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiN+WIaUDk91LK6zMyw1tWYuLC52VClw1g0YjT6M53KOZvKjS2
	6ME/OPSArrGSXEz2wcjCFM0gUYuRA5hPtzNLFZcAlOHGxGkitVpWzlcbShTNZv39/yK0oAjCIDu
	h1wwt8SsIJbkTFulVCI8xI8SOnTebqmo=
X-Gm-Gg: Acq92OEWaxNrHNktXAh2lcYLkAxBzdFb7Pa8x3M7dC3L1T0mAU8ReBv8kxnm9qer+VV
	Q7XV2wrJpEeVuMZlm6ID0qVvv8EW9Nt3seKYMLYfxpCdJxhrn3MV5v9000vbDcaz1PWa54CpuQs
	VqI9B/GPoqA+TgMTY09c5n25ZlYfypMrnZJZM/1JAJ+dWKcKtEwI8Zbzq/kjk88o91alGz0HX4L
	/Ox3l7ubSDiUpNsRs8QTF8yBkZg/UmJKk5IicMwS29nfzxGvFI50X0xwnLPrYT5ky7i8RvJDowD
	59iGQeQKoA==
X-Received: by 2002:a05:6830:7108:b0:7d7:fcac:6374 with SMTP id
 46e09a7af769-7e4ea087b22mr11547942a34.8.1779182321960; Tue, 19 May 2026
 02:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
 <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
 <20260519100606.6b3c91e3@pumpkin>
In-Reply-To: <20260519100606.6b3c91e3@pumpkin>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 May 2026 14:18:29 +0500
X-Gm-Features: AVHnY4KyUgq49USXq97_TdbRMKDSb9sdhGwJS-tK5TZf96gIYnt-uKoN1347We0
Message-ID: <CABXGCsOVTBOm72gsqEdzJd41ZMqHhvW5WPo03s+-9TBSS0k7MQ@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
To: David Laight <david.laight.linux@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, m.szyprowski@samsung.com, hch@lst.de, 
	robin.murphy@arm.com, djbw@kernel.org, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, harry@kernel.org, ming.lei@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 2:06=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> Isn't there a flag to kmalloc() that indicates the buffers will be used
> for dma and mustn't share a cache line with anything else writable.
> (Which means the size must be rounded up to a multiple of the cache
> line size.)

Not a per-call flag, but ARCH_KMALLOC_MINALIGN does it at compile
time: when set to cache-line size (as it traditionally is on
non-coherent arches), kmalloc returns cache-line-aligned buffers so
independent kmalloc allocations can't share a cacheline.

CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC (370645f41e6e) was added to allow
smaller kmalloc minimums on those arches by bouncing small unaligned
DMA mappings through SWIOTLB; this patch preserves the cacheline
tracking when that bounce path is active.

What still hits the WARN isn't independent allocations sharing a
cacheline -- those are already prevented above. It's:
- the same buffer used in multiple concurrent DMA mappings (raid1
sync, io_uring iopoll buffer reuse, dm-thin, ...)
- userspace DIO buffers, where kmalloc alignment doesn't apply

> For DMA_FROM_DEVICE it is important that the cpu doesn't dirty the cache
> lines.

Right -- that's the real corruption concern on non-coherent arches and
why the WARN keeps firing there with this patch. On coherent arches
bus snooping handles it, which is the scope of the suppression.

> This is probably worse on systems with 256 byte cache lines.

Mechanically yes, but those systems size ARCH_KMALLOC_MINALIGN to
match, so kmalloc allocations still don't overlap each other. The
remaining cases (shared buffers, DIO) are what Christoph is looking at
via the DIO-path alignment requirement.

--=20
Thanks,
Mikhail
