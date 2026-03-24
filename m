Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6C3A3E6F
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377150; cv=pass; b=slECvGLKIskCy1iL+8JmgUlWiHnafDp3y93FQ0dOS9b7YFY6HMyLPvBtfCiFA0oDpldkmgreK1Bt1JybcvOWomy5uefDtKR+zr/C6OFqQW9vx2SJISn3Gd5lZszH2WodxTIewpMgUpxYzE+kO3YQtH2E6V9EKXbH5KK2gvjaCcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377150; c=relaxed/simple;
	bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRKBTI4AUPHVxOK4L4yRXKl2EE5A2sxBO89CPQwdETB5T3P0m+CtAuksJniRSOxJVLbQBYB+H6e8rWRjldtLOc1jiYj7FJ7ExYiZJYppYmtjcNSpbyIxdsyapFo5i/D6k0ABzJ71TiUz+FKJnz2JLvXcg3aM1Xs9K58r22o6uqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojdPX08b; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojdPX08b"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b6c45781aso87951cf.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 11:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377148; cv=none;
        d=google.com; s=arc-20240605;
        b=imZzbuKufKM6KDFi0jarwcPggDFdm0MiJIm1itgL5xOhLti6xjmA5zG7vGG6iTq52h
         vODL5xYLRU3mTRKTqbACJfD/M7Z3Y1xNpkeOa5BYE/oqrMyEgac6rhAuQptGnh3HbwK1
         zw0kiNPKVvh7i0564tX4RS1SSsqnhv29tuwdEnmO0oj5XjSU+hnX1ez150PQlGau3q2y
         BjC53OpyvDR4c3T58C1FK2HyPgRo8bWoMi1eHqEQsQuHTwxD7rSicWFcTMXYgE1bxIia
         TAvkFktkL2LpSVWLjB8K1FQb/IGPgpazIofk9DO7mIeMomByLIWqcjaY6LzZz4FJk1fB
         JMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
        fh=lCurwwT5wvQkCq2OjJhi8Jzs5jiVC7m3XdjN+CWGss8=;
        b=W3d6k1Dm7m9k9gsyI8/COuNwUIkzmJqcQbCdmXpgNn4b8Akk6Aj32v75Q8+6mcTHnj
         FtjaX6tlPXPXujDLICvJRqB6FRLt5H9nVltqlO50XfxofTyZmcP8OA5ezSe1Ej0s4Ivg
         nxBulRJV3cHQ4vWD2n+BeBvtvUsGSs6QqJeXydWGok21dQf0MlFRbVOwB0FaLO/LiAyE
         8fm0oUgeSCvjl4UHtuiPLQzCfV9I6Z7b29v7bU6eUs0nkRrkN5IjmC2t+TuetGg2Fn+d
         gng0BVUxtgZ0WUh6rrSYFl9ZZo9837XmqT7epqlM6OtkhcTpaI0g5XK1/k38gcv+B0ZA
         XnqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774377148; x=1774981948; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
        b=ojdPX08beXR96hNkwnFnQ2MMVb1dqzh5JK+NRHax00dA81SEYR358z1ws+fE1Yog9Y
         bQVjdFvol+Lr8zCaIKI8TFZwLrfFel/hNzdW2gg+f6aex7mkwsCb3ZMPPDqxehd3yBbU
         rJDIdlB0+Uwqm/Oo4h7RB+WEgZTFXDsuP1lBat48KHBv711+i8eq9Xz4Fbo6aot1A/nf
         m0cfHoAYKKy3XzKgEUmul0LajhN2lRWNcs3UCd2zl2IxUrkZhr60koNBUO8gHwZVFdJ6
         VrQLgCr9FVCoFNsHCiRsTg3MMbPQityCKusCXmCv1ynRFmjRdZg6HSRgrej+Hbna2GQB
         59Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377148; x=1774981948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capQ/2P6O0wzFj3JGECHvmPV76dOzNCALYeUIxrihD8=;
        b=BIn8vvezCsWAuwFSPjxHUwwo+J97rdvd1jmK9Kw9HXzAW08AvNQncSeUDVnsOxKcm6
         JOHDYBU+qrG3Xy8qcQZog+LXcxsS4Zrl4zG89kA0MmwHBzfOqY/1+HNuc5QrZ8FE79zq
         BcNH4xFrtMUaOJ1IKv+RTodd966//xf+Nt/DsUh40LTAJwTrDOu3dRWACNxr2xNSo3Ti
         ZKUlm4GNKmA1tQndj5QJjWTOSIDqHatQ2h6QdJ/WrEJ/sVmz47hSQVllo4G5J23l2xch
         F6e3iOLF6GZWDbF9Dltyrs1vreux5ycY04aUYGA6DHyhPmEYKs4QAAY1NaWSXR2ZifyO
         3u1g==
X-Forwarded-Encrypted: i=1; AJvYcCV/X9W0UxOrrPKNBc7P8MQFByM7J4bMcQp5k73RUh4qurXMxOB9E/kdgvDiC/z0X5zqXUKSmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0/uL2jVWky3Fm1JLn5vHyLGDPJENFtQtLoPOz8YdPttpnF5Kt
	EWwGQJTUsTQV7C8O9AIqkYzrkb1GZeo4DwCGSbKOkbfCv2qSN173Bpbs6Rgg6mk/sKjuRh+4pzo
	FIGNADQ33q8Kssusw8kfs385n2xuxc6COPgVQEFxH
X-Gm-Gg: ATEYQzzxha+N9YH94sJPM+1wcXTuyCfnaipDVoErj49jznw3NVILnOE6z35XUF8yV2Z
	Fohe/kF9nz7TCgnwbnwkYmv3U8IFYuL1iAn5/qxKQBblrx+nLpvsrw42b3Kh85DG6M4sqvMf1GK
	s9QQTmvHfC3KxurhYEh0H0ht1gn2fliw3X4qjbX+ULTyzDhfUZUQ/U0VIYiY2dTyAKkLT6rg3XM
	yF84QOdQhqDjQtoBj/H2Pv/D2g2smRVz3JSNAG/C0N54WGzZhVHdEzVIf/j4sRgB71FD0cYacHz
	+AAKacIFP/yw9kM6jWJsi6WQqSW0TnP1UW4HJfY=
X-Received: by 2002:a05:622a:a94a:20b0:509:14f0:bff2 with SMTP id
 d75a77b69052e-50b8221e273mr1541411cf.12.1774377147169; Tue, 24 Mar 2026
 11:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us> <ablV_f_l7wD2m63E@google.com>
 <20260324120057.GC8437@ziepe.ca> <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
 <20260324122416.GD8437@ziepe.ca> <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
 <20260324175717.GE8437@ziepe.ca>
In-Reply-To: <20260324175717.GE8437@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 24 Mar 2026 18:32:16 +0000
X-Gm-Features: AQROBzDqJGwLGVWhhqLuGOrSUtCUROoHSgJZU7HhysiSVnX9qJjxIyI0nzG2rDw
Message-ID: <CAFgf54pB1pikjtx588khBAXDg4vHne+tJL6gBqF64buX0K93mQ@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 5:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Mar 24, 2026 at 05:36:23PM +0000, Mostafa Saleh wrote:
> > But it's not about drivers in that case, it's about many places
> > (SWIOTLB and DMA-direct) calling set_memory_decrypted() without clear
> > ownership so in some cases they step on each other's toes, and I don't
> > think that will get simpler with yet another caller in this series
>
> I don't understand how this can be, ownership is clear. SWIOTLB owns
> the buffer, dma alloc coherent owns the buffer, user owns the
> buffer. There should be no other cases, and they don't step on each
> other unless the APIs are being used wrong.
>

Logically, that's the case, but the DMA-direct code currently loses
this information and assumes it can encrypt/decrypt any memory even
the SWIOTLB one.
That's what I am fixing in my series. When I respin, I can try to
introduce some more helpers around that to make it easier to integrate
new cases.

Thanks,
Mostafa

> > I am fine with the API design you mentioned, but I believe that it
> > needs clear documentation specifying who is responsible for
> > decryption. The code should provide wrappers checking for these cases
> > instead of having is_swiotlb_for_alloc() and force_dma_unencrypted()
> > everywhere in DMA-direct.
>
> Redoingt how dma-api works internally is some other project... It
> would be nice if swiotlb would sort of recursively DMA map using the
> new flag instead of open coding it but that is pretty minor.
>
> Jason
