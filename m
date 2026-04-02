Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D02358369
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106423; cv=pass; b=s7r+z1M0uzzXijrBFVjBfRkUkPAj8KglNqq8nUo+7n+J+QIDt5enulTGMGWek+bf9zL/wNOv7i5ujVLSXa3V9NHg04vhyCd7UYJZR1Kv8CG32/AzIx+LsNB0my/HWs0U/7LRcVXtRKtdXRaS6ue7GhOpr1UXGEhEVAal0ji6HH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106423; c=relaxed/simple;
	bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gya0U8cl65HU5NWXQ5yh1sESLU/lZLV1Jep2BolkSrUj4i8h4INA/NfWYEDjGMYzCKEJG9GtopbhBgOMwuseA++5xzsF6HLDpFTus7R8zyjglut61FTfNC6dJZW6WnxjhoFNZBEl49aRJwXYq7PfBX7x+/LXELLHgswsiBc96r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qBpfiNqa; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBpfiNqa"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so76084466b.2
        for <iommu@lists.linux.dev>; Wed, 01 Apr 2026 22:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775106420; cv=none;
        d=google.com; s=arc-20240605;
        b=Qa7m3BfTvJH18N1wFiLjAmgJYwljHGxf7YO1l8QpaY/HI7JBfTjD84QwaIAnrsKOIq
         LWYymuLS+1uXQPncffC50WXdLy6Hdin7Zbv3zTyWLEDATd/hfR34txeKtcWcP308Y7RA
         8u3YKbtmGlIATXvXmXyOLKE+Ri03PYSaBA9iZi78D7kQzY4yqDuFaTOYWLZB+fYOH/nN
         oD+I0bpWoMfq9pBOEMo0rV4wyaUV8fHBEDveKz1haOvbhhvRZVSOY9bYZ/WH+SdxO833
         1YIAVNlMrbt1vs6YZeuztKYoo/uThIrOcZb3FSnOBIhMCXiUfw62ABS3m+L+JKUCMXKd
         qbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
        fh=inPN+Q9fviIvK0h6GcQ8gU67fv++r8cC4tr5wfUnwD4=;
        b=UNBUJQvlVt4IZWiFPZZrH+7Ja1Bd4PCq0uPnjWHLwwKm1r9t6nV+j83nBFirgHRNZg
         fykziNoEtl6j7XJCEg68sO615i+hmNhyDw5MSiS7qxbr11MCMGXRWOu80TtmvMvOth1q
         j+00kvBygZHuOHprstPIIyg8gD7MC004fBTk+Ubz1jt+jXA0nWHqhAD3ac2P0q2DngZF
         2d3vD6lUYLIT+bzqiemZAK+n93FAAQWGs1lDuqXXsWoCEqaq43irbcco+8UwsBHmEFto
         rKmDPje0h4oS/u4xE1wG7MJZZ653+tjRyq/bWOmY46KqmADVQ3TXqeL2kIkqrZeEzMJW
         jdaQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775106420; x=1775711220; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
        b=qBpfiNqa3cBJlfGu37Zvtrfga0Y48Lm4sRhMk/aKQJyD8nrx/mJYmI0PQrBSj+OALk
         fMNOc4HIHGSSzLzBcs4KPtAlzK18kgl1seKJCegaMF0HRUytcQuiXHhzaYESmu1L2PVr
         MeBiqZ4LURw5iQBjHXwssiJDdHt73KdEe/CUzka2+65RTLeew9Bm1AK8LvW7UiRSucfS
         RbtL5lJJVcUIRTJZjwSX3ayHZv3O+ueH7YKwIaZsE8ltMWmxkCVUPwCch30Qjbgu2ac2
         Y/sYceO2TvuIUTGbnz0am0OTMGigtzNiSkgQix6YbobC2K/diBKSzFlZm68Yhmw031xg
         m1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106420; x=1775711220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qf3x6hVmCFdUqtHFD5VJaVdwz6bPu+MVKVWepeQR03o=;
        b=FikFHiFG5AEUXgteRg+uPMROJ5HZxXhwUYY8SX9jPxn8zvPaXvriYd1N6HQf2QZZzu
         InEDUQ3S89uNaZvt7zI27NPUIG05ANRWwc39ovhqDwVz9/Pt4P2eVM7h83ASu+C3Zp07
         hGIKPIRe9tTj2VmVuFQ+EA3TAo+xIc8v4VAJ9ZQa6n9eTeUzN1g4qFdH9wcVTJ3Bj70x
         pUe6JfV/f8XhOYVFQMHJ+fpb/MJNdt4CnyLKSR55mX1y+BeXCFHu/5/K24qe/ialbkyY
         JkbmA1A3y2QzGt6h/oGwjKRkIbgHlh3mUxL7lrzoD8LWbEKUQo221XH+Swu0+Q0fhrqM
         68Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXL3QzjqXr5I0v5UbjLMVOnbRV9NCJTam7fQ+LH3/X7ML3YHhgFtkSZR6grOR+tLx24D4KEQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhLaSFuoe5RrA3uBqOAc02V/e7+uAv8zS1/kb+DW6FlNzSuUKV
	uLu1G7dEXp9vYIIBQrC/4Phz1uLqZugyO7sXawnk+/wNQEhKFYV3V6oU8nWmOGRax36xn37vWRK
	9iB0OonrB99jbXW8ppUF5oG9T9ARZ33WHURVTHSP4UA==
X-Gm-Gg: ATEYQzwvS34mM9exSaMd/tjsYRMcUI/lvY+LSOhRIc7lB2BLx7ruBqX2ON3ZI0NP73e
	vXa3pEchagpZK25PytfcP73No5559nrPvfRYWpM8oq19P0o0VY+dEPm7F3kBcT/ZM46jHAlxcmi
	HTT9jr6xuFjRGS+JjOe7DA99tkEDpa9sFV5UTdQPvZizqDdPQ0k+IqAy98VKuknekAW0bWZretR
	RyGU66T7JotkG/vaJDSLJCNq54qoxmc9HgZH2n1RFSnvy7YEGAV/mp8XOtqud3YBY1m5TmbZZW8
	ieA+Ljv4291cr/uxQ8f6IF9ProV+bEWan4V2Vuo=
X-Received: by 2002:a17:906:f185:b0:b97:4e42:23ef with SMTP id
 a640c23a62f3a-b9c138f8b82mr248056566b.16.1775106419953; Wed, 01 Apr 2026
 22:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260331100026eucas1p19bdc2aaca4c9a48c6f6ac8fec71478d8@eucas1p1.samsung.com>
 <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org> <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com>
In-Reply-To: <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 2 Apr 2026 10:36:48 +0530
X-Gm-Features: AQROBzCJbHUqpXNhrktgFRPzZ2TP3XLnRpMznWDVTmhDI0Xxoe_pLYi4105Frnw
Message-ID: <CAO_48GEFQE_FJjuq1UqP=DC6LJE8jjE3C+4FdAyB4uEZDsnFJw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] dma-buf: heaps: Turn heaps into modules
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Maxime Ripard <mripard@kernel.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Maxime,

On Tue, 31 Mar 2026 at 18:24, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> On 31.03.2026 12:00, Maxime Ripard wrote:
> > The recent introduction of heaps in the optee driver [1] made possible
> > the creation of heaps as modules.
> >
> > It's generally a good idea if possible, including for the already
> > existing system and CMA heaps.
> >
> > The system one is pretty trivial, the CMA one is a bit more involved,
> > especially since we have a call from kernel/dma/contiguous.c to the CMA
> > heap code. This was solved by turning the logic around and making the
> > CMA heap call into the contiguous DMA code.
> >
> > Let me know what you think,
> > Maxime
> >
> > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wikl=
ander@linaro.org/
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>

Thank you for this patch series; now that it is needed by more folks,
I think we can merge this.

Marek, I'll coordinate with you on this - thank you!

Best,
Sumit.


>
>
> Applied again patches 1-5 to my dma-mapping-for-next branch. I hope this =
time it
>
> won't cause new problems in linux-next.
>
>
> Here is a stable branch to apply remaining dma-buf heaps patches:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git=
/log/?h=3Ddma-contig-for-7.1-modules-prep-v4
>

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


--
Thanks and regards,

Sumit Semwal (he / him)
Senior Tech Lead - Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed
