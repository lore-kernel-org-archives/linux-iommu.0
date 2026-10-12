Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEC3E7BD5
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816349; cv=pass; b=aW9251r8ormC+hC1lfZ3w7a+vhhVPVK8UN5N38nY2lm/d6FgTOTCu2UPOZHdXF32BtImIHddmowIMlnFjNCfVZNmLNP/7b2iWkSMdR5694zduXeJr4Sli+mPLb10u4AQ5HLzgbfLadiikzgNtfQecNxrK2ux+KeiaMhhRJWg9Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816349; c=relaxed/simple;
	bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRMO6sm+xKd7dQKdVtGz0M0uthWEWBpKJnEdiDncm1fnQtTS5cdEd92UvpI3tzdwRZi+kmelF2iq23E6C19ACMfwTpRoCkdivv0c7um036THcBRLitkTCGKaer8Gu5F/g3QFwTBAnRDBVQuwsPhWG+wRNYnM1NX3vnc/9PM3dE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8RwqdnT; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8RwqdnT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so69555ad.1
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 07:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816348; cv=none;
        d=google.com; s=arc-20260327;
        b=cQj1Zo1EgeXPKOG8o9ZKHK7RtsnEoG+fVDo29kaf/JxYONKEQNYYbLgbS8vplizhQc
         1u97JDgtwIWhOz4I34MWwlH3Pkp9glqlvqueeuR2IAIJuvybo9gmF/1XI3G+CtJpqTr6
         aXfEBRI2zG0Tmgnc80N98ckRCHtxQAUkIK+tskfAxN0e8h3edSkkqeSkM6IWvk6n2UG2
         iegsqq10phJSbduximrFgAO1gVNwxcRv9f0iwxaItj2u15AcGHuTzfr0mGMk4JTKEu4P
         14n/Kuxo24EVskSxEyH3bYiH/1ykbPi9Xbhm65+rOkLuoJvBhSIVr+X9VCQNsbg8aoiP
         qm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
        fh=y+rI4WBOW403bZQZOE3NMquQy++kkpDJrGRm0zd9K0Q=;
        b=URfRAdFdaG/m4dXToc5fMODO6aop9lcOvaLRvo0sllHvErZLaXnIDDZFEQsVn5+s2Z
         Gg/k7rkoKJ9nRbiWEs932oFzAOaSLtT9sx1I9pZd/Rm6FBpzznAmUt5I6EXcmyUz0yer
         GUalmFgN/pGok/Gqx0Hks2f2OR/mWnRF3e6NLto/t6BnGMqJlXLx7CzSrh/zM8I3pkyo
         hvFfYT1LD/JrLYptx5BMtZBD5kss4M3L1FEb7JpQ8IWHsBCOIPoiKDnCmzfDyx1EjkvO
         myXane1so6Ivx/64FqVFsztV0/HvYNL+pSgr/ceuuXjcKS3t+5tZvsZf2IuMh6Wd36Nu
         FF2A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791816348; x=1792421148; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
        b=H8RwqdnTsfxvlFIu4bL6y2XzWHC9CMjoB5xbijUz+5dT/bsSWUhr2Xqf0/ZcHXD0Et
         fadxnXrCr3tpHbDBKxKunD+WlHmFpS/tC1rNeMfQ2tyQQlTRPFhMTg8EHgddqI1AXiHv
         /eysLyW/8+y818+h5ImIgUMIBb6mVDz3V6Ia9CYAyBMBJ/PG2PQ4VXL5x4eg2rGdQMyb
         Cn0kD/hCFhDJhoBklbUYP3QeBXKXc4LOGgU+RX0IkGLwOB+e2Rv7+qkORDyjckBGnCie
         xCLh3tOdXyudZn/VwuQ1IjVUlxtVenjaBw8g0PBjxoc/GZzOvRWymerS046Dg0a2Vf4j
         qf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816348; x=1792421148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
        b=MmrlWnf16MQ0eFbNtWcNXWLDjl5BlZGvBKauPNg48irOhWf7VA8t4ocBS9I+4Al5c9
         BkC92qvBJf5+/2Pjn7cxgBmHysWU0rJbU5EpwWmjuaQymJOgxOeYRcODBbITt7H89Bip
         d4oY5WS9QptxReg4FJZdGhAQVQKVT3/atUj39M352BUxpaC5BaG6ZUWbS5TpGbhmUiuU
         F840BzXhLWqjFWSR0IT9ztwVodb4vHXqZ9FZOEGSm5RRdJVW7fOfiLevLYO5BD72xJUD
         8DWtPNX/5KUpJdnboGpdnLk2GIrdbxvl++QfTu4/siPCeTy9075pQfovGwL8hcUMbGf6
         RonA==
X-Forwarded-Encrypted: i=1; AKwUvBwdVLn/x1EzPn/dMBueJ22V+/ccK9F7vVxqV6REvklC8jtj8LnrjVj/Y7NE1pOkIvpRdpM64A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJu/lJ9ctJFzL2MJu69+Ga1WfdsQnpJVJosKe6AhexgxwQ620qW
	XrvGfdiwFm/h0XtGzHk29NaXk334xfn8Xjbh4ltVknzWLVAfdlJ/2iSreo1Ld+DZ6PYdVNsZhX5
	ginoOc5ikwGSp4NJPDQk8oxKQNRXjdRDiaYqPI/0X
X-Gm-Gg: AYBFou1ZyKYeVeEPVjrhpMi5RhUEwFh4/3Eud3dkS2a0e1JVR1BdEWRfvJRJ+EF9pwl
	z9TsvTrwZkMwrLLx1A8P8AsXVU6HnKF6824u397F3/1Ab2Fx53f4E7eg05S61wIcCfIdORJE9rN
	YQHU8f5v48FoGlsll5cFUK73UKMVq3Xv/JOlvcgU0nrR7/3Jt6tRRJDiwajPu35o6mmbpMCLOAm
	YlubbD8XYevoy40FMA3KADOEmCeMFem3Ml6CwwFacDxaQ/C6erW7cNP67tTx7wW1JacE8fm/WaO
	KuUMLb7XBQFZqZMIiKuzVSJdxchugwa9ERCoTHsbmGtuxuxjnePU7mIB
X-Received: by 2002:a17:902:ebc6:b0:2e2:d665:6ad8 with SMTP id
 d9443c01a7336-2e87bc2190fmr6225715ad.4.1791816347416; Mon, 12 Oct 2026
 07:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
In-Reply-To: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 12 Oct 2026 16:45:11 +0200
X-Gm-Features: AclHuK-i8fHHmdGq1sG19E58z4J25P_7xaX9lSE-RrDdVmPDw1ep2a8coGIVdbw
Message-ID: <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:51=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/3/26 23:22, Luigi Rizzo wrote:
> > Here is a subsystem called DMA_PMD on which I would like feedback on
> > architecture, possible enhancements, or kernel components that could be
> > reused to avoid duplication.
>
> Here is a feedback to a subsystem called DMA_PMD ;)
>
> Why is basing this on PMDs (and embedding it in the name) the right appro=
ach?
>
> On architctures with large PMDs (512 MiB on arm64 with 64k), would we rea=
lly
> want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) that=
 might
> possibly also have TLB benefits (cont-pte)?

I had to call it something... an earlier prototype used the name IOMMU_2M,
but I didn't want to suggest that the design was limited to 2M (it is not).

Aside from the name, the _current_ prototype restricts to 2M allocations,
exactly because too large units are expensive and wasteful.

In the code, decoupling the allocation size from the PMD size is trivial.

To enjoy the reduced IOTLB pressure the architecture needs to support
IOMMU leaves with the correct size. Looks like ARM supports a
"Contiguous" hint, but I am not sure how to tell if the hint is honored
(ie the IOTLB actually uses one entry for the full contiguous range)
other than measuring.

cheers
luigi
