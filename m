Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C2C2ED
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279197; cv=none; b=IotXbHtXVPFxPxuRWBoeIzkTasBodyjXY6ubiJJFm0mtsb0r6rilQgjLWZpLl1Te8S4jWSQ5cFXPVQx22k46vmt5II533t/2JQmUr7oiRhMPowWwtqhsBmpk7870Paow6zi537yH9pCdDFmHwXbeAyV7pxD4fsTyX4i9Gz2nEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279197; c=relaxed/simple;
	bh=xwX3FrShlsU2ZVlrICD/J+sXBJpXcixYuE8iS1XPi3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuDhLlHn+NjGs+XZ+IGxalsib/zLnc+tMYwhYOTkprspMjk5JJ5Ops+gy1/Gvkk5Mk4g+AHE4kmhrisypccd319Z8DOFRXzl8MBTlE9RmzzMSUtisYcxDrLoQwnnPuPQYScviOW7buS1X20KdNL2zJaOmkC6lI+rysLR7NoDtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiTUuaez; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiTUuaez"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61af74a010aso10824697b3.0
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715279194; x=1715883994; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwX3FrShlsU2ZVlrICD/J+sXBJpXcixYuE8iS1XPi3A=;
        b=kiTUuaez8IaB34e7Wls0R5UlLtqZ5HKclNce0TTSCxcsRey/W/w5wxo53PNMu1f3yr
         tPW+4nbJWjPnEsnoE738J9DRHYvtv5i2KqXJ2yIm21LXRuTBAW8Z5+IXTtozlI4gm0Im
         SyRFxPms4z5z9/lTOixyvX3DVYUhkPkMZPPslKcIN1WboVlCVvjzEm9i2pAlSHOJIV3F
         gWcFtXYawi2huBqiUzvq7SieG8S/QnHZu3lZZeogbOJrVYtBGx41gv9Q7OVMavQMV4OI
         CulEsabs5OaTQMCKDVSJ+uRdWyELZMpETK4jg6aUUPAcAwtHZrV2Vkpll1r3gMphVfr1
         LvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279194; x=1715883994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwX3FrShlsU2ZVlrICD/J+sXBJpXcixYuE8iS1XPi3A=;
        b=RzH6CYVMkl+sgYRYp2jWKHT7HNdBOlJ0scbq0C48Mwmii7GZSf3WnE1iL1nLBt/4uE
         x1P4mFG99I24l7ko2ptqL7OsodPNKz0yWl6JE7vtddvRUV1tn+Z/3UHx2S/a4aDwuWb2
         00+vFvcnhDC0lFxGNvz3cdCcH7belFdGaYuVFTstjOdWCV2/UXUTX6mRgKJMUFcIwN6I
         uADFG11+v9e8xN9zJcieY3hC2hUvO5cV5i1YKP7oWWtAux3bNia4Cg9hlzkHa6YpF4F9
         a92ku98N3+d0FW/d/Ov0PDB01Y5P6U+01YD0Msyjds3zsmytUs02ASkgLVocGRO3Zs8e
         KExw==
X-Forwarded-Encrypted: i=1; AJvYcCUFZ2jIIh1YHkpzhGAa3J9tVHOblFENl25whkI3nE841Zh97A1YHKRDv1SpakmZQvFZWQ6m8KCQK2DgTxyOH7RyeaATrnI=
X-Gm-Message-State: AOJu0Yx4fBsHjbPzh7EFLNDTCxWnZd+lhML34fPFh1ICHQbC2/qqTRBn
	m1AUhmrJwU3DlMGeY1gYSn4Uj+jffocGp1Kki9+unUKr2iWjvMU7nrxNYXncwb3QGGsRRz7WZ3w
	u+d9ArM6awS4hvaCyqA0sSWjdUxBTfXK7c4/b
X-Google-Smtp-Source: AGHT+IEiZ1AeAFP07cQfFLqCtp+USGarpkp9LhLIX8R6emdm/gHL5dC+45h2LERG7LJDGyUSxdi3GUC42AecvGl5Q4w=
X-Received: by 2002:a5b:c07:0:b0:de4:5c94:f58f with SMTP id
 3f1490d57ef6-dee4f2ce881mr370778276.15.1715279194343; Thu, 09 May 2024
 11:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <20240508113353.GA31529@lst.de> <1be83f24-15bd-43a4-b310-f62c720cf064@arm.com>
In-Reply-To: <1be83f24-15bd-43a4-b310-f62c720cf064@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 9 May 2024 11:26:22 -0700
Message-ID: <CABdmKX0E97V+MGs-SZOqxA1EU4NmmP4ZyVeoskGMLD6=qYcSDg@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, isaacmanjarres@google.com, 
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:55=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 08/05/2024 12:33 pm, Christoph Hellwig wrote:
> > On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
> >> On Mon, May 6, 2024 at 10:43???PM Christoph Hellwig <hch@lst.de> wrote=
:
> >>>
> >>> On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> >>>>> You should not check, you simply must handle it by doing the proper
> >>>>> DMA API based ownership management.
> >>>>
> >>>> That doesn't really work for uncached buffers.
> >>>
> >>> What uncached buffers?
> >>
> >> For example these ones:
> >> https://android.googlesource.com/kernel/common/+/refs/heads/android-ma=
inline/drivers/dma-buf/heaps/system_heap.c#141
> >
> > Whatever that code is doing is probably not upstream because it's too
> > broken to live.
>
> Indeed, at a glance it appears to be trying to reinvent
> dma_alloc_noncontiguous(). What's not immediately obvious is whether
> it's particular about allocations being DMA-contiguous; if not then I
> think it comes down to the same thing as vb2-dma-sg and the ideas we
> were tossing around for that[1].

This heap isn't too picky about the memory being contiguous, but there
is an attempt to allocate high order pages if possible to reduce the
number of translation entries. These page orders are one thing vendors
sometimes change for the hardware they have.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/dma-buf/heaps/system_heap.c#n48

I think one problem there'd be attempting to use
dma_alloc_noncontiguous for dmabuf exporters is that memory is
typically (always?) allocated when the buffer is exported, and there
won't be any device attachments at that time.


> Thanks,
> Robin.
>
> [1]
> https://lore.kernel.org/linux-media/20231228074645.765yytb2a7hvz7ti@chrom=
ium.org/
