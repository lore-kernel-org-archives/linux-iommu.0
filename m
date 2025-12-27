Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A03A1E63
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766868739; cv=none; b=H9ofDobHIGYsN8xICgL6knwfl0Rir4dQ8EVq2p0TycvgsAUw01Af7Y/2HQOpjVVGGGnQrSjtOgA74kRmyI+3eiLghCrfVe981/EdVWrZyU3ab5Iv9PXOptQ4UFL5IGwx/pFdsZF+KiFnR+AU+/g5jGtbjTV2ft3dCi3zMab84og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766868739; c=relaxed/simple;
	bh=OcltOJpGBk2gLNwRaYWSTLeCl0pcmkC9VhazmmmBqcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGOjpqK+tA19YNibNZRHoSxo7yPWwlyUdjjE4b9negSZ5PArg+ds4UIUGKTv0nk/vzIfvAsreh0oy8cV/o2hq/CZtQ4HrfnKq8daKjlTrhtm1U1AIOVuPmwHe9BsUel9GF72Go7pY9kA230WsS8a2eriy77kjIqjUIM4+9C2Wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUpOEqky; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUpOEqky"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88ffcb14e11so34350106d6.0
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 12:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766868737; x=1767473537; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COlE5Xveygh67jucjDOeVZnfTHNWpMeqgQJOQuwR0lI=;
        b=OUpOEqkyYmQAL4pDfAy//sWAJwZ5bR0eiWIvGGMii3MR4iOlnZvIXte4WhJUkXTCmN
         l+sjAUC6GLU8JjXUI0PK4Sl0W4VplnVcbniykgLTlLHoYnF5dz4LmNaOq9NEkFaUCzO+
         ff23EXdknAyZUTsA1BOHCmYfj4QYVMXTck0h2J8mADSAKMrhlyjZZw4R7vLhLB/gsULo
         ozckQrL4ARM5zGovLOsl37MhdtKeOQazWf/rCN1INstcJMJKKNx6fLVToajkbEthIrgD
         BteIWE+g8wLT7AjlZNoIkJHRUHO7bLBE/Ox1v4RqMcuFtAGAJCfa8BkAmguLVYL56IKI
         sB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766868737; x=1767473537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COlE5Xveygh67jucjDOeVZnfTHNWpMeqgQJOQuwR0lI=;
        b=o/i5tzJpQ+jCYkfqeYgVvbUzHxDqCOgKEPs+XWDNZWai/d3UfhqjK1sOwZjYts2TAL
         T+EWoEkKA0+Wlw81hFqGLqOKEDlIMNg4zsp691UPj27RZMAH1mM14stx9IZgt0JdOt0O
         EbGwaJNprRzuD2OKukh8LzIz9dIE5LuMcuEDGFJhZc7AMkiNqjjyflBga74uvzWW7qvr
         GxYeGrW/Qss3CGEvPnuR77uKeq4VU9rD8OaR/if4ILDfEFdnIkwveJ4QvXf5DCwbHd5g
         uOjF3i0R+9Jm4kqIfv4DpIhi5vquF5wfSXL1Chcn5b+q/ercLviX3JNYmyRCqDjUWhXc
         oc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWiWWWx9HEt2W+yMjCyMOuVESpABMY8YgcbZ5ePud5SKkBOB3gVOAaAzMpz6+yq7dWGFqUFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMWUu2f/wadAfoN0zCaK5v38iK3U6Ec3YTg6dTjCCif7TNhP5u
	vrcdhHt0CioJ5PmkBaOv5qO2gPftwPu1dZgK4mdIHk/i+z65OPDBrXNJ0jMerZS3EaU5LbhXhjk
	L7y+ACf5Z4F6wKchk3g7ZBWjoPfuvISljaw/x
X-Gm-Gg: AY/fxX7d6cY2BOa+01EGIVP3Xdgrp5oPQpUAat/EMN/xZkCApaEsjR35NldztW6NctQ
	eiBGG+zRtFASUVhisimSwuVv5D7pkqkOpx/okfuemGYl4jcUFUD+bKYHf0wdAs3wwNwUfcUxZFY
	hzyrqvr3+2tPIuF83jY3gkfHeXFmunBKRDSyUmmgVNKkB8BzQxZXNdoKfTXCqhjTKc2EwrvtZOl
	02s7D9jjKC8x8HipiUGVZCWe8ltbnAewy52OmPaa4VaQx9EGn51245SamhSsShikAyYJw==
X-Google-Smtp-Source: AGHT+IFWlfYgq6fvhPnudIMznElnMp57SUfWPdf1Abz4VW1qQ4SuUkwafpWDnswUCDqMkbSt41dCGCuIrkeU0fQZTZ4=
X-Received: by 2002:a05:6214:3a8a:b0:88f:cd09:9431 with SMTP id
 6a1803df08f44-88fcd0995d8mr271616716d6.41.1766868737130; Sat, 27 Dec 2025
 12:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-6-21cnbao@gmail.com>
 <20251227200933.GO11869@unreal>
In-Reply-To: <20251227200933.GO11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 28 Dec 2025 09:52:05 +1300
X-Gm-Features: AQt7F2q5TMmxm7Qs_CjJBcT-WAtF0589kk4jJXu2nxeg2qZ04GIbkJZVDuQBxso
Message-ID: <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for dma_direct_sync_sg_for_*
To: Leon Romanovsky <leon@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	will@kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 9:09=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
> > From: Barry Song <baohua@kernel.org>
> >
> > Instead of performing a flush per SG entry, issue all cache
> > operations first and then flush once. This ultimately benefits
> > __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
> >
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > Signed-off-by: Barry Song <baohua@kernel.org>
> > ---
> >  kernel/dma/direct.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
>
> <...>
>
> > -             if (!dev_is_dma_coherent(dev)) {
> > +             if (!dev_is_dma_coherent(dev))
> >                       arch_sync_dma_for_device(paddr, sg->length,
> >                                       dir);
> > -                     arch_sync_dma_flush();
> > -             }
> >       }
> > +     if (!dev_is_dma_coherent(dev))
> > +             arch_sync_dma_flush();
>
> This patch should be squashed into the previous one. You introduced
> arch_sync_dma_flush() there, and now you are placing it elsewhere.

Hi Leon,

The previous patch replaces all arch_sync_dma_for_* calls with
arch_sync_dma_for_* plus arch_sync_dma_flush(), without any
functional change. The subsequent patches then implement the
actual batching. I feel this is a better approach for reviewing
each change independently. Otherwise, the previous patch would
be too large.

Thanks
Barry
