Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B823939BC
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184679; cv=pass; b=ByLGnv12V+h+BfigtJAKAAioidFF/MIQ56ySGforCff7TicL09kqv+eFbqt09F8gJkFeavuFjYEmx+7j3vzo4PgjnpCgxFZNr6xLxgHtYs69wIU8OaL9pmMQJgBcZweW8iUDKICabwwwd26zCBrOkKl5GxcipdQsJda1kuPfd/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184679; c=relaxed/simple;
	bh=XExa3juJ/r3Q8jwhbRHkFWW8qX+OTXzVm9QQ16e2AbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ursZYIb7Fvmpz2vsehIyPzWZws+0w8DP5dOSmj5tRY+xpOf+K1MB+QkPBH2/SdYeCdX/IdZG+7UMA3Owa0fUSgz8Awigx6mS6LGPapIrnTjzkEA5UDEOTtyMz9VGYdsOhQBXlDnv4E/y7WIa0VA7E7IJXLWp97JsOAPbGiwpAlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npY+IcrC; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npY+IcrC"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dca5f64e86so2914231a34.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 02:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779184677; cv=none;
        d=google.com; s=arc-20240605;
        b=JYMpiw9x2Wt6GMB1BhKwUXo7+JGtvRQyCE7rHu+aAxsc3y/arDB1Peuohlp+95wkw8
         sTM6YlyvLiQwg8oAfniBzm4l9+iZY40o0LiG2hPBGM4Jd4PQjyC5o8LaWhBiRZLmhTj4
         NopLy9UqGf2DctuAp1uTOFE//Es0CPoCBwlFbeZdpq0Y3UF7b+OZrAZhllOWOgho+8ly
         nR02R1IR73PvLE20ljxAA0d9uBDX9P9MReAZOTvCDRaIjvf8kMh1tW72Leq6jFWkpPyX
         KM2czriFCIJ4XXMzrBFgJuqp7MmiA/89LdgI5Ko+MyVKtM3j+U9EopzHeIOhlFpecaA9
         HqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XExa3juJ/r3Q8jwhbRHkFWW8qX+OTXzVm9QQ16e2AbE=;
        fh=kMpk9r/yisFfVGG/0bH2pRZB5ztL9pvhg+qKfRycGK0=;
        b=JOOw/fCYB7Kw7a9rz0o1pWbYkphndqxaB6tlr3NN93QkBko/ARBmBen6mE8TguHSBH
         MpwyTIjNL+Vkor0CyCoNGE6gqzGqkPaYihknMDf67dwuW0kweVLnH+KLiTAYNkx/p4bQ
         IeQ6hoH/qQfQKvkDIpi3U7Z2ln2YoJSc9PH+a1a05XiX87EAgop3vy4xKluVKSXSsQcj
         /EVwStZkIbAbHI0t05vMybR3H77IgJ4gH+XJJimQ+wyOhQiKjZ+Quz1mG7jNMwfqRzp9
         aEsiGq0ynx3PsT3qMARZkmIIZb4uIXRvpmLs6kV/LpEHkobTjMUEWIy9WaNH2+Qmw3ef
         5ajA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779184677; x=1779789477; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XExa3juJ/r3Q8jwhbRHkFWW8qX+OTXzVm9QQ16e2AbE=;
        b=npY+IcrCBYrzOux1KkM+V+s5pW7DB6qdGRfs1J1yqtGEU8rSem00seOQjha0KOfBj4
         DjC+pGc85GLBLSEuOxptaPU0k6+knqKjcIOb6OJgtA3kw10OnP9i1eAuxKuAZ4ZxZhE8
         i0rVHP+ExE4wKmWfxgiIybDWt0t1LaZUjlJi7OSKxNx+zypPF67/Vywd47cbpZ5Ci4Gx
         49xdL01t+TnBxr7OM/y/c2sJQNtux3tOswvRS1PaNCoQf1l2UH62wU0Ki9Ppt7RqvIZe
         euWno6D0WKlXVmktj+erPJQniYv0xs+kw36GTjeCZ9sI5Tw2LW1j1XvGDSXeLTWyiH+V
         gZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184677; x=1779789477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XExa3juJ/r3Q8jwhbRHkFWW8qX+OTXzVm9QQ16e2AbE=;
        b=QDCDuTG0fhIVJyaTSkbQKRnoeboDYwnn/u+l5G8Q5+BG+IUqYoXpKZsrsxQPLaFzR+
         L1kgOdUwDCPb/CGSPZ9JQsnXTGmD2g+PtBH4g+403CjLI5rhidqe6MZzgPhTrFLINmid
         rWpGFeQpcxqtE5Il0LA1kYgnW5wymmniwXgepi/Bp4e+w+ubIF5gbZ/3Toj8Wdjxo0FY
         PLk0qmW90MxVlmbrcY5zsqrwdyn0shvEjv4Vkx+AJCNLBSbPhMZAdgYfxho0VIe5ZXAw
         2RavnmGDrl4yCUjToFQoJFXDfdPFp4saQw5s63mzeZKpEtsd+xUGCdtnfPO+vVbO9VWV
         jBCg==
X-Forwarded-Encrypted: i=1; AFNElJ9DjBRxOdUvFGkzpZnxiHsk3iXNGIGU+SIpw2dXG9BtjvcfTx44hCCur70H7ZY3XCGT/3cklg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAusDuEtq/1gIWMja+4WNKr3UzryI66IXgYOeF90ckNeI0KJy6
	o3oz4WqXW2dkrEdWtoYxFD2VASUM5hcs1c+lDTXuWrnFC8uYmRco8S8NuI5pGdPl6wCNoTlc8kz
	rmKgP3KYDVdfxdKtHqLrwy/Ou8zN7/rrbdrcNjH4CUgwwZhE=
X-Gm-Gg: Acq92OGpGzLdZGvmpiNiGdKcZ4mxqgI0PxsNbf4M077d555J/anQBpoDHSlg7ZviPOa
	M9p1OLJknoelWWYZiQcXkXOjdv9camG2p2gxlX9xPqrxLu8fN5WlO9bJ9y2AIjMpYsnn3dt1SHB
	n2yVTYB4PGVKj2YuyRZGZXB1Pvwq6714PEMZgIB4809+krP5jHqUAe9EuhXQEk2Bus2L7iOWrY9
	Dq23KD5aeBfKr5A0uhi1RYRi1V+X5e/xJsJZt/tjXe7yL1wiIwwDFyssgq1qPKJer4cm10VMfqk
	bPF4Q+1OyQ==
X-Received: by 2002:a05:6830:660a:b0:7e1:e832:c8a2 with SMTP id
 46e09a7af769-7e4f2b9ff34mr11925086a34.19.1779184677166; Tue, 19 May 2026
 02:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
 <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
 <20260518125330.GT33515@unreal> <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com>
 <20260519071758.GB10037@lst.de> <CABXGCsNg6NUefejbqGBpH1iff9H6mJ-3Zamb0A54ay1zrfuJeQ@mail.gmail.com>
 <20260519092819.GA20292@lst.de>
In-Reply-To: <20260519092819.GA20292@lst.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 May 2026 14:57:45 +0500
X-Gm-Features: AVHnY4Km3uCXjN2omks4sUyYswpvDCGPZ68NRYKODxaUk0NuM-jOEhOz4Wrj9CM
Message-ID: <CABXGCsMRDHJDRidJEr6DeZ5aXNLDm5oHK-D453r9UKkoRv6AAg@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	djbw@kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 2:28=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> This work is upstream, IIRC it got merged around 6.18 or 6.19.

I went through Keith's v6.18/v6.19 series -- the block-size alignment
infrastructure is there (20a0e6276edb and surrounding), but I didn't
find a commit that actually wires cache-line alignment as the
requirement for non-coherent DIO (no dma_get_cache_alignment() or
L1_CACHE_BYTES references under block/ or drivers/nvme/ in that
range). If that enforcement is still future work building on Keith's
infrastructure, it's orthogonal to this patch's coherent-arch
suppression.

--=20
Thanks,
Mikhail
