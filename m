Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37330C629
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136769; cv=pass; b=teAj3SiW/Jb9sgSib8h5qAHs6TmQSr2MCFRwTc05WXgppdR+L1fk+EvQ1g7028Y8V2PyEyFgOTfWOg8rgDKXmWrE7x/QsYqqwuiPKjH+nqjF069IOQPRyTcECoXk68jhqpt/jt97AOHOpMyt1KlQtgUQlyFoWC7uCjr8a9Hsg10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136769; c=relaxed/simple;
	bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R83C4AYAaaEapif6uQbKmPPX9SNggIIiGjSJgv/QArDOaVYteMwcDuBnKkrkzVidgW7MAol3q/KrdDqkMo24W8RNJlIG4ZSpRNuVs1e++gXzs1wJg7UDyQM97xStlmH7O+IU61JUpfHB2MPFlSu3Ccixv9VupJa6PZz5TVCc1i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHOU964h; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHOU964h"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9841aecf72so99699266b.2
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 06:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775136766; cv=none;
        d=google.com; s=arc-20240605;
        b=OFgk91/wsZ7rLPkVFJwH8Ql0us07CKBvi3k+Mpna8PeGMjdQC4XcXIyGgcY9xcS2fD
         gtKaDHgK6ytLXO/3iWJHxeb6lpIeqjowcyA7EI9dqMSZGj8GpT5CcHnLzSO0Mxm3Yt/6
         lY6MMssr4P6fA3AeRNMKdwXGwy5/805j3ngvO08pPyCQETXEbvmrPDkxmwn4FtQnQ7bT
         g3cJcn+cKD1KVyFm6AoxET77dZ1r1OFL9wcZBmbYwctMUPJVas0WR+wyhnh2qnfr+b6E
         6S0krkf98/m+isKYsKXskPqyW2SzLIcFvuLXq7p2xl0NXmfCUOQGZVe30dERyEK8ZseR
         sIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
        fh=Np95UR4S3qnZHvSUnA2V1N2zkcTjbd6ZPNCjxCotxNc=;
        b=EaNFwFPUHaX8QobWocBqiJzslws2cqfo49e8m5o5D0/XQg1kPF4Km177phmSbgWGE6
         Hu0bUPgmPKTnhGAx+1WF7n9lwgUZ5keRvJDUXS7amkl3AZukHu2ONqJe6oy7TsLoY3s6
         cbXodQhgg+Cy+B/AA1mjRm/Cho62ww1DkSr+Cn7Gc0nhzuF6iGTqDrSSET7eNehozBqT
         NEOGJk8C4bUwohvwUJNb/W92IWGNdI3GQ5+wc0NteqfeBHmiKTbeyc//FG/Hf/m/5tEm
         t7WvV7fvSNtmF0uCaqAybxiTXk49r7YgpJ6Tb1N+Os6BN1d1Ah+cADcYQO+mF7mzNYq4
         E5iA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775136766; x=1775741566; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
        b=iHOU964hDP3F/PSsAhaclYz9w+EcpkiDNA8jvruL0mjc0/hYoer3h+X+mrjTmGAiut
         g4vIcSICQ8TPFPepUMPsMsQjedQ0+GrZd3ed4cnH9WMLWvYr5oHNvRm9ms0A3JYDGPCO
         QRs1tFf0Tb0ub7B52iY7iNmA7Qt8zFI22WNJ0ej5pvo+Gj4CxO51HwSJptRzQBIq4aQg
         LU7zyiFgg6CiAIxc8ntHZ3HJ3v1Eg8WQGhTSw4lWe/DKLdUQpaKZ40QpbjnBH54QLs0m
         9SNbt9uDseBBkLUNBy+ZUy3laRqPx3v1ZW1+EsSDsm27pJBl8nClaoSagWK04iKkq7a8
         PxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136766; x=1775741566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsx2hYjw+sV8/0qohJ1DlKPwBoo2zkp1J5PdzUN8MV4=;
        b=lIlVOgvxO3VxOVWajKlh1TkHc7cFQDwhk/o+7/93xXP4dKlzAFMOHZ42WjHO2rtbWV
         QPUV8o9942hkTVN/+NyZiIuBoO+XhfM00ODhfpX83KowLzXjH9akGYBOJAULkv8SrHoS
         5osKZ+yJkzRharsDs8Z17hn6A1MmPCmAK91zQVMdvlw3Xrp2pmnD7RdQzYrtBMbzD/fR
         /mUW25vnfUFV+uWOyVPlLl63zX81HvUxOpjvdcg/M1vzaWLY6u4UuvPsGqj3cxihXWu5
         7A2VjxPlW/yLRuEZZG4ms/vDthitWNeH89bXVegQiNfdhuLJzrx+NcTbe2b8t4NRUTW3
         L7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVtLobnRGnsyRuRHEvBZgQ4T5epNYNgmKouI/LlzcRYbZKs9x5vsNw+xe0zZTiIOOYXMo2KUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUBr+iFnxSYZRi8q1lh4FTmHbFTkvErUrK2eROYPiKo842FuGe
	L5N/FDD6n4lP8F7so5+RQ8FypfCMS50Ps0A92trs0iHWAMGa19KLuGKkRJdoTXxJDULIn5/L2PQ
	NVqWlMv19Osr9jOU74V2Q7b7JHGzaIDZSdMwlljkl9g==
X-Gm-Gg: ATEYQzykx+D/p5fKXtrIOpPyXik8x0G0iugb5maIu2zzf/2dt9fG6Zq0Ma9sMxA7Erl
	QblB8SbP99qBaDT7PZtbMnwOQNOUrcJcsB3iHjtmg8dC/HwTU1rCgz7iwgQiZzsZ/6gvCrTSVPs
	IINKrSBi6T6lpQg2SG6NYt6fPPIAkIN+5McY0L2QTrxEJGMeGzjZXIbpdV9hS1I/kthR6H59OCm
	SBpTpTcx/L/lJS8UKhl5zcij2V2IWrF8LAh4XAlyykCswvWluGhsxjQn/xzZ5X7fZO25RCtGFku
	glbNZN8=
X-Received: by 2002:a17:906:4912:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9c138c110amr392586266b.18.1775136766273; Thu, 02 Apr 2026
 06:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260331100026eucas1p19bdc2aaca4c9a48c6f6ac8fec71478d8@eucas1p1.samsung.com>
 <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
 <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com> <CAO_48GEFQE_FJjuq1UqP=DC6LJE8jjE3C+4FdAyB4uEZDsnFJw@mail.gmail.com>
 <20260402-burrowing-fine-bloodhound-afcebc@houat>
In-Reply-To: <20260402-burrowing-fine-bloodhound-afcebc@houat>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 2 Apr 2026 19:02:34 +0530
X-Gm-Features: AQROBzBU7_o7IRQH6mzOKTP-KDFv7IkPoqq1yaLRTD3AfvGaKguQAkczWk5rypY
Message-ID: <CAO_48GHzMpKHQxmS9ADd_Z9G56uWOPfJ-qhNek7ubgkk_yjGDg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] dma-buf: heaps: Turn heaps into modules
To: Maxime Ripard <mripard@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Maxime,

On Thu, 2 Apr 2026 at 18:42, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Apr 02, 2026 at 10:36:48AM +0530, Sumit Semwal wrote:
> > Hello Maxime,
> >
> > On Tue, 31 Mar 2026 at 18:24, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > >
> > > On 31.03.2026 12:00, Maxime Ripard wrote:
> > > > The recent introduction of heaps in the optee driver [1] made possible
> > > > the creation of heaps as modules.
> > > >
> > > > It's generally a good idea if possible, including for the already
> > > > existing system and CMA heaps.
> > > >
> > > > The system one is pretty trivial, the CMA one is a bit more involved,
> > > > especially since we have a call from kernel/dma/contiguous.c to the CMA
> > > > heap code. This was solved by turning the logic around and making the
> > > > CMA heap call into the contiguous DMA code.
> > > >
> > > > Let me know what you think,
> > > > Maxime
> > > >
> > > > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/
> > > >
> > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> >
> > Thank you for this patch series; now that it is needed by more folks,
> > I think we can merge this.
> >
> > Marek, I'll coordinate with you on this - thank you!
>
> If Marek plans on sending it during the next merge window, maybe the
> best thing to do for us is just to wait for -rc1 and apply the rest of
> the patches. Otherwise, we can merge the branch in drm-misc.

We could do that. Are we ok to wait till -rc1?
>
> Maxime

Best,
Sumit
