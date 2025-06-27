Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781392EB5B9
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041734; cv=none; b=h9RCoOkyBucLoNdQmEFtPWK7SfWrige4rAeCbMTOT/2s6vW5jgLNanS/v4mCxFhxlNHDH04vE5s3pNEWkSbhAvxXCdn8wtsmBsMLLIzeQihtVKEO+xJpk4XkA1v1jDyaM379vM6aPT6LTEc4Z3N4R+w0JfIiKS5sQjpMZk6lAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041734; c=relaxed/simple;
	bh=ckwNK5l6kNEQi0dMFT1BhLSPph3IS47PHdxbRsKbg2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8xnllTPiivBBg5bRWAz7d+aa84Lr/eSvhbLolt80GI+e7rviQXfCvrdAjvAhnuUzw1or8ssxiEW5w+Rzr6pSqdJCOx5kfQY8QZk/sNGPwEAqhZWWAO25uTNQRLoKZvr9KPYOT9vNVM8peLDdunhPMXYgXzLl+G0qWNVv2R/ddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLwpXCGl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLwpXCGl"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fafdd322d3so95536d6.3
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751041731; x=1751646531; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwe6yBI0hTTSV4QKO/x65G0lF6NWazoC/YzcyBgyfJc=;
        b=aLwpXCGlOBo6MfNZHF2fjfaVYTsQpHrd+wAcCm3nomHB0lY4EEU6zYfu0+JYcESsZw
         hB2U72Wf3IugPBOtNOLV3gxtUkaze1fpFu5l7PUymhZI4Elc+Ak/sOHiBB5NL39fX9VS
         xw2HXkg7+fG5B6FRVfZy0lDtMiGdvjHItnfwFfVHOVrVyYjlwrMLJwGnUUp5X5xfao0W
         ytvLx+C1udRXPZu9mvPU+s18Ax+mgsF/Qxn17SDLHtJsTMpDoZcJbhds4uX/qAjNm2Hn
         ZFx8TcGxUdkwVnUvo/GCIn98/Pw4Er9Q9jKb/G9a1swBBXFTNkUWhtJfL6uyZYFcRUGh
         FEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041731; x=1751646531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwe6yBI0hTTSV4QKO/x65G0lF6NWazoC/YzcyBgyfJc=;
        b=q5uOOxZzWlK1PBLh5l5LQXnR2ydFFVacvrx9R3L8rrAD0jMFnrOl+T/5WZ0ptBZMSA
         uqrj0oUucOCKwKKDyCC4bbgGngBLNYV8PRTN+EPsBxIbFM4M6PlEIDkAqvPMgaHXEMWn
         zni6bXVOQkmu52P5QnlzFPx6XpXN+zYU7LpNElsmJrLhlQ/6zrUVW2tkK7F9BBu3UhjG
         Ll5g/EI5d8PRGpXczfN9ZDj/ns8Y938X8zIxs0s4/fMNMUgRFQ1uRNNVEzu1z6pG/Ol4
         5NUqgM7uvU0ivI8mubUkuHCBLfoBi+IqfNcaecIPMkiVLd1qnnl6MoTcUkcxSwgjhnFC
         Wk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7GNSgn9j7ydg2KCjhNPP815taST5SwlWw/BPrewEMIKvH81TjdE5yHliOxglBMFF36uqQ6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0TXyHb8Ou7PqP/NIqfjyb+sbtl2YyQYjf/w1ZdljVxs+DWQwH
	2vusVkIE26kadM9h2j+e/SxFg9n8IKgO9pO9vLaBfEBSh7+PwANNUUYpiIt38T/u7t6K3SqHFI/
	iBER0e4ojdX6GC4GYhtHpvGDV/RdiGnSEY2GE+LpP
X-Gm-Gg: ASbGncsN7tMp1YOE07yWjdU1LE5VuGkbir3BkgmZBtgPe7ErSNb9zAsK++c3UUIFXns
	MblYBEvmrtw5Vg5mBmFMLsfvSc/bIOEvEqDdYG9XGss8Y7onmSesJ4zF1CfMx6sVczdrJcYgE6O
	o+MerFolnL1m9NyBIQeor8E2ITltVKcUydtPdj/DIRITZti1qB6jYtmIiRxVWFDNpo8f5WumVJ1
	w==
X-Google-Smtp-Source: AGHT+IEaFjJbudXPZvs4+gz+Ul1aN+IO1A0S+wtT0rUBrPe4/pZbkYPC1YJ6B1u6KB5gj2C6Oj3GAR3BNtAmvLY3bsQ=
X-Received: by 2002:ad4:5c6b:0:b0:6fb:33f7:5f34 with SMTP id
 6a1803df08f44-70002ee7d52mr61421106d6.43.1751041731049; Fri, 27 Jun 2025
 09:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1750854543.git.leon@kernel.org> <cabe5b75fe1201baa6ecd209546c1f0913fc02ef.1750854543.git.leon@kernel.org>
 <CAG_fn=XWP-rpV-D2nV-a3wMbzqLn2T-43tyGnoS2AhVGU8oZMw@mail.gmail.com> <20250626184504.GK17401@unreal>
In-Reply-To: <20250626184504.GK17401@unreal>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 27 Jun 2025 18:28:14 +0200
X-Gm-Features: Ac12FXzk502TgF39Kdk9rDaSo7SztNg9o8ROEHR27kqxNaOw7yX3TSWKD6zOmLM
Message-ID: <CAG_fn=WeK8q2g0bRna+fFx+ks4HbfoG3Tnw8PpSdmfdH=3+S=A@mail.gmail.com>
Subject: Re: [PATCH 5/8] kmsan: convert kmsan_handle_dma to use physical addresses
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	iommu@lists.linux.dev, virtualization@lists.linux.dev, 
	kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Jun 26, 2025 at 07:43:06PM +0200, Alexander Potapenko wrote:
> > On Wed, Jun 25, 2025 at 3:19=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Alexander Potapenko <glider@google.com>

> >
> > Hi Leon,
> >
> > >
> > > Convert the KMSAN DMA handling function from page-based to physical
> > > address-based interface.
> > >
> > > The refactoring renames kmsan_handle_dma() parameters from accepting
> > > (struct page *page, size_t offset, size_t size) to (phys_addr_t phys,
> > > size_t size).
> >
> > Could you please elaborate a bit why this is needed? Are you fixing
> > some particular issue?
>
> It is soft of the fix and improvement at the same time.
> Improvement:
> It allows direct call to kmsan_handle_dma() without need
> to convert from phys_addr_t to struct page for newly introduced
> dma_map_phys() routine.
>
> Fix:
> It prevents us from executing kmsan for addresses that don't have struct =
page
> (for example PCI_P2PDMA_MAP_THRU_HOST_BRIDGE pages), which we are doing
> with original code.
>
> dma_map_sg_attrs()
>  -> __dma_map_sg_attrs()
>   -> dma_direct_map_sg()
>    -> PCI_P2PDMA_MAP_THRU_HOST_BRIDGE and nents > 0
>     -> kmsan_handle_dma_sg();
>      -> kmsan_handle_dma(g_page(item) <---- this is "fake" page.
>
> We are trying to build DMA API that doesn't require struct pages.

Thanks for clarifying that!

> > KMSAN only works on 64-bit systems, do we actually have highmem on any =
of these?
>
> I don't know, but the original code had this check:
>   344         if (PageHighMem(page))
>   345                 return;
>
> Thanks

Ouch, I overlooked that, sorry!

I spent a while trying to understand where this code originated from,
and found the following discussion:
https://lore.kernel.org/all/20200327170647.GA22758@lst.de/

It's still unclear to me whether we actually need this check, because
with my config it doesn't produce any code.
But I think this shouldn't be blocking your patch, I'd rather make a
follow-up fix.
