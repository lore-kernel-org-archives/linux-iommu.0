Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402E3211
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279573; cv=none; b=oG6akflFqJjodaLI3scIoHK5lqGzV+m+7rZAqkLVdxg3YMPRa0OHgHMj8sTCRU662jI8xRbrIz1ZTLnhljT5vrmFbL96bmSXaEbDL/wEtOByjraYRrx4LkN5q6EOBoZWJu6Wl8MB1qrforn1EtAF+gdcVbrDpt3JQqzpdPMPWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279573; c=relaxed/simple;
	bh=JpQJVTrL89+adP7TCtxgEVivnuWjp3XuE1s1dwjRF0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyBGMST+5VmpzWlsVGGr1JDx119phl2OfgO2HOodDQmrLW0caNsxf156HRwR43CuQ6hUGF6J42rXkfAbBs/QqtsSDpVXZyaqO1P6JBBseJvsps3M5/bMEvdX8FmXHk1olPRyl2EjuEbmDcMB8I2wNBdNbWjTN6ojnbrIj5GJ16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YN+2fWvu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YN+2fWvu"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de610800da0so1115683276.2
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715279571; x=1715884371; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K85R4aKMySjln2h5zunsCFNfpJdcOEMgD33+b72i2sA=;
        b=YN+2fWvucoPCqqeT3mctxrqzES6VSWfiU02TuQlHMdzPYcrgY7/IpGPnEl2YdQ8s4I
         H14lacQcG3hpXad3F6CImS5OtV7tnQ3v5HoMHQlmbT9HyBFlW/Ze1/3roMWGrRU2SX0u
         jcVX/mLN7C3LqVlanBD8OdWTvsbT58ItVt3JO03cbBIA3Jgw6PcUBR7xU2a6HT06l43b
         CQonxA6XF6adtU3ue5dQmBV7OtgcoEsey59m/MIaEjYoHKwgALt7CQPiiOcM8TjZWI/8
         i1vfsUvUjuldryEEwkVRVre3wa1TUm4D3m3Blkxn9G6ABWPdpImXKj/GhdFt/PXqr72R
         tT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279571; x=1715884371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K85R4aKMySjln2h5zunsCFNfpJdcOEMgD33+b72i2sA=;
        b=D5ioDPkE80fACvvSACbEOC8p3ejDS/pa6Up9hUtiW4AqzK5BGL07/x/DdZsnP4FUT1
         7DJ1RZOCX6wl6hReaB6f739+8JKMlnyXHhf8LOjmzVjUJwz7ak0QfNl07LN3pRv30fEt
         9EhVhUU1W4Izg4GgfXcr+8ghrguwJPlt6qHNNAo6XLKi+M9d060/aTiIXisEWfWtV34x
         tNQcmNyrvWAPBhxnMq+xN4si0FZtRciOvw4c3JBEil40SJCLBXQ2v1ai8c2aiUqNhaR/
         1P9IxR2pjp1y1T4HZV/JrMTRTj6vi3dE+kHXJ+LFdRML6O5qMUHty4Z73b7tOTVRzMYp
         YeYg==
X-Forwarded-Encrypted: i=1; AJvYcCWzYVZz8WTUpG6G12BSSygTLhOk/wEBJ/s72DZfjSjp9recXCTLCPul/kolaz7+P8IN/eVck798i1KVOax1oPQXKQGAYaA=
X-Gm-Message-State: AOJu0YwnuiS8bhJe7qJkSdXK0CRP459Ef79xHilC6kEGQB6Rd0BK69CD
	CzDrr/fRe+DNYVl52heMjVIwgGIUJ7vNyH1sefZVTlXfZT3cdbTL+o4LEu1+cMCSI/YXEo6lliQ
	tkWBaKqmzzzVqaRUOx/dejcjndhpMagurBRn8oLiVbn19vUgILg==
X-Google-Smtp-Source: AGHT+IGoQ2OQpf2a8CpZ5SCSZQupeF8o9KNIqCdhZ/BNEQqydxmcWTO4hvBdvCBICJBUvCrXjuuGbdZWLIdfO05cRUc=
X-Received: by 2002:a25:d0d4:0:b0:dd1:491e:bf0 with SMTP id
 3f1490d57ef6-dee4f37dbe6mr351885276.60.1715279570531; Thu, 09 May 2024
 11:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <Zju0JOx_ij1qH-34@arm.com> <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com>
 <ZjyAFE4Fk_r7KnDA@arm.com> <20240509130659.GA12345@lst.de>
In-Reply-To: <20240509130659.GA12345@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 9 May 2024 11:32:38 -0700
Message-ID: <CABdmKX0KRA3NHiEJYsq5LqtwwEdM4LaONpyukd6zgk7hHzp3Cg@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:07=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Thu, May 09, 2024 at 08:49:40AM +0100, Catalin Marinas wrote:
> > I see the swiotlb use as some internal detail of the DMA API
> > implementation that should not leak outside this framework.
>
> And that's what it is.
>
> > I think we should prevent bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed.
> > However, this is not sufficient with a proper use of the DMA API since
> > the first dma_map_*() without this attribute can still do the bouncing.
> > IMHO what we need is a DMA_ATTR_NO_BOUNCE or DMA_ATTR_SHARED that will
> > be used on the first map and potentially on subsequent calls in
> > combination with DMA_ATTR_SKIP_CPU_SYNC (though we could use the latter
> > to imply "shared"). The downside is that mapping may fail if the
> > coherent mask is too narrow.
>
> We have two big problems here that kinda interact:
>
>  1) DMA_ATTR_SKIP_CPU_SYNC is just a horrible API.  It exposes an
>     implementation detail instead of dealing with use cases.
>     The original one IIRC was to deal with networking receive
>     buffers that are often only partially filled and the networking
>     folks wanted to avoid the overhead for doing the cache operations
>     for the rest.  It kinda works for that but already gets iffy
>     when swiotlb is involved.  The other abuses of the flag just
>     went downhill form there.
>
>  2) the model of dma mapping a single chunk of memory to multiple
>     devices is not really well accounted for in the DMA API.
>
> So for two we need a memory allocator that can take the constraints
> of multiple devices into account, and probably a way to fail a
> dma-buf attach when the importer can't address the memory.
> We also then need to come up with a memory ownership / cache
> maintenance protocol that works for this use case.

Being able to fail the attach without necessarily performing any
mapping yet would be an improvement. However I think the original idea
was for dmabuf exporters to perform the constraint solving (if
possible) as attachments get added and then finally allocate however
is best when the buffer is first mapped. But as far as I know there
are no exporters that currently do this. Instead I think the problem
is currently being avoided by using custom exporters for particular
sets of usecases that are known to work on a given system. This
swiotlb + uncached example is one reason we'd want to fail the
constraint solving. The DMA API knows about the swiotlb part but not
really about the uncached part.
