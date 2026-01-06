Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32536349B0B
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728871; cv=none; b=MPJyrGLNFqHBf10rdUrCXCqfh8cm9K46iBjE9JnUR+Y9ioH6Z7VpICSc4Rk9/07bG9SmUJk7+iqbK/ZDj5+GrFpnW+YGw6u+SVH8bfufsD6y3POVkEdZlIyhAmfaDAYi5KvTMd5hz2Tdt6joWzye2TxZ8MAX9mdFSIdznA9zivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728871; c=relaxed/simple;
	bh=2pLJ18qRuOCCyou+qdGCaNQHyGf5EUOI8pFnKOnWRN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecm70e7mXo/ArmM1UufL1MIOzQQ7EORqaNDgg7HKdu/HJwPVJ6DoXZCXyEgR5rJN35n0vR1vNssZCBJ/4C93TVgpfkUsCgjNul8ZjZshTZkSDwG8s7W0z/OdFuzZkc4QN8Gv3U6emYSmV8+/58asfz2gGX+M8QD21Q1LmSr3qMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0K8Xmi7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0K8Xmi7"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a35a00502so11362776d6.0
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767728868; x=1768333668; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pntXy9Hj0WqvRGVZav4oj27VTA9+7WcxJK6ERgbcGK8=;
        b=L0K8Xmi7hAbhljjspO2jG6p08nu5PntGWdsJEagNFp/uqZUAxECr2QFjANH3DStJtt
         CFXRAS/JSseGH1Nqnht9UUgtAanjOgs6+sTelVFpWwaQ+eE+PrmHmp+HkmxuBGMr41fm
         trBZXg/TjH1q+T2KKiFcU8nmPphTlxp4BjSEEgRCfEyXljhDQyg71f4x3cd7hDGqL2Jd
         S+5woCMBvo4SFim6/fpu0Te/nvoxF+QO5hnX/ZR6kuoTyTrsUq4QsQ7Rr5+NQocOJ2HR
         hwQsjg4Pz1CNJ5zbI+kW14RR/R/j9hp/2XuQ0E9Qu4ruh6KOb+NQYWr2x9BB77IZZr66
         qrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728868; x=1768333668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pntXy9Hj0WqvRGVZav4oj27VTA9+7WcxJK6ERgbcGK8=;
        b=mV80XK846WpMhbJdvhB/xugmbpsFl2LyH4qs3L1gxOGM04DqQfmAFJgyz8KenMxAil
         0WL5G2c/TV1pUBAfqf/3tAIvMyBsQm1OfhstvjAFxygt/AUYo1EOXZpiHTxxJjlu3ISM
         gH86+vHnXac5o/IxibD0bQl6BErZxPJC3oS0JmprLEtdzoyaheATyTSFspQmreargJmg
         Awe2Tu9N1tlbRPkRwmQCZmBR3h6VAvcYSRnjQ/BS1CC1Mi+b/yJERpRJj8YDfRREDTDN
         nMpJTDGfMpsuat3rKJMVI174qM0JEuQw/IKWIWQaYg3ARgUV7S9teZpwZlZA2bl86bSK
         kOUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmNYchEzo/2srgqC3tabLH2nb93C7ZlnR+haWIM65OXgmN3TEfzhuXpDgDkpsxU8xwI+sZGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy38v65cBRsshzBijf8eLCG7TJU3kUAAUehVrLtuVsMWgA1GTsw
	Lrt9EMMynMbivJPQtsmYKYICFjPfxo0Oe7FZ2xANKkFWrzlkUYZCKTXu9cSCAtf/0rUCpB8cBqX
	0PrTiAvunfRornPvC4vp7cTB2zQ5wRwQ=
X-Gm-Gg: AY/fxX6J+pnKW/3YJaa+atu8+zK6ua+Bs4anlo5ZeFGVwYSY/FHSG3rrNUOhUgig5xh
	wwsUvRmUM41FOhhjYqj/FRRt+re4QEcDnk4OMex1GO7qW8OvyERDB769pUGN/eolXuH0xDXueCM
	E4+oib0tAhui0sn4QsX+l6fFSL5B4Xpt/f5a4oid19W7lK2DXp8UsbQeCktH39vrSGihJc37vkI
	B410Zqr8cqeRNCu8yMFcXGZiZp4/kj0kJFJgnEMQ29RDKQTddCHbD+x3D9tKFMJiN7Mtg==
X-Google-Smtp-Source: AGHT+IEsDozTTuOpHzQH0xjAygijM9mAO6rgCGg7RgPz/1lUD4/ZMIEqkH9QqpKy9eDQlYCqtEtPfalOfqOAQTgTldI=
X-Received: by 2002:a05:6214:622:b0:890:5973:a567 with SMTP id
 6a1803df08f44-890841e56d5mr1480896d6.12.1767728867862; Tue, 06 Jan 2026
 11:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-6-21cnbao@gmail.com>
 <20251227200933.GO11869@unreal> <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>
 <20251228145041.GS11869@unreal> <CAGsJ_4yex5MKQkGtFr2zUcg4h0PtsFs2QVcE_NSfiyOn4qBzhQ@mail.gmail.com>
 <de876e61-42c5-414d-b439-2f9196c6c128@arm.com>
In-Reply-To: <de876e61-42c5-414d-b439-2f9196c6c128@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Jan 2026 08:47:36 +1300
X-Gm-Features: AQt7F2rGhHEzeZcOruGijVOJFT9sChymTkhWX1JfhRWGcohbyfQWWuu1bqdVJW0
Message-ID: <CAGsJ_4xYqseJMFXOU39JJW4Lk2ZHXAnRJLhZdVuFLxAi=Dy5sw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for dma_direct_sync_sg_for_*
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, catalin.marinas@arm.com, m.szyprowski@samsung.com, 
	will@kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 8:12=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2026-01-06 6:41 pm, Barry Song wrote:
> > On Mon, Dec 29, 2025 at 3:50=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> >>
> >> On Sun, Dec 28, 2025 at 09:52:05AM +1300, Barry Song wrote:
> >>> On Sun, Dec 28, 2025 at 9:09=E2=80=AFAM Leon Romanovsky <leon@kernel.=
org> wrote:
> >>>>
> >>>> On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
> >>>>> From: Barry Song <baohua@kernel.org>
> >>>>>
> >>>>> Instead of performing a flush per SG entry, issue all cache
> >>>>> operations first and then flush once. This ultimately benefits
> >>>>> __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
> >>>>>
> >>>>> Cc: Leon Romanovsky <leon@kernel.org>
> >>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>>> Cc: Will Deacon <will@kernel.org>
> >>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> >>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
> >>>>> Cc: Marc Zyngier <maz@kernel.org>
> >>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> Cc: Suren Baghdasaryan <surenb@google.com>
> >>>>> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> >>>>> Signed-off-by: Barry Song <baohua@kernel.org>
> >>>>> ---
> >>>>>   kernel/dma/direct.c | 14 +++++++-------
> >>>>>   1 file changed, 7 insertions(+), 7 deletions(-)
> >>>>
> >>>> <...>
> >>>>
> >>>>> -             if (!dev_is_dma_coherent(dev)) {
> >>>>> +             if (!dev_is_dma_coherent(dev))
> >>>>>                        arch_sync_dma_for_device(paddr, sg->length,
> >>>>>                                        dir);
> >>>>> -                     arch_sync_dma_flush();
> >>>>> -             }
> >>>>>        }
> >>>>> +     if (!dev_is_dma_coherent(dev))
> >>>>> +             arch_sync_dma_flush();
> >>>>
> >>>> This patch should be squashed into the previous one. You introduced
> >>>> arch_sync_dma_flush() there, and now you are placing it elsewhere.
> >>>
> >>> Hi Leon,
> >>>
> >>> The previous patch replaces all arch_sync_dma_for_* calls with
> >>> arch_sync_dma_for_* plus arch_sync_dma_flush(), without any
> >>> functional change. The subsequent patches then implement the
> >>> actual batching. I feel this is a better approach for reviewing
> >>> each change independently. Otherwise, the previous patch would
> >>> be too large.
> >>
> >> Don't worry about it. Your patches are small enough.
> >
> > My hardware does not require a bounce buffer, but I am concerned that
> > this patch may be incorrect for systems that do require one.
> >
> > Now it is:
> >
> > void dma_direct_sync_sg_for_cpu(struct device *dev,
> >                  struct scatterlist *sgl, int nents, enum dma_data_dire=
ction dir)
> > {
> >          struct scatterlist *sg;
> >          int i;
> >
> >          for_each_sg(sgl, sg, nents, i) {
> >                  phys_addr_t paddr =3D dma_to_phys(dev, sg_dma_address(=
sg));
> >
> >                  if (!dev_is_dma_coherent(dev))
> >                          arch_sync_dma_for_cpu(paddr, sg->length, dir);
> >
> >                  swiotlb_sync_single_for_cpu(dev, paddr, sg->length, di=
r);
> >
> >                  if (dir =3D=3D DMA_FROM_DEVICE)
> >                          arch_dma_mark_clean(paddr, sg->length);
> >          }
> >
> >          if (!dev_is_dma_coherent(dev)) {
> >                  arch_sync_dma_flush();
> >                  arch_sync_dma_for_cpu_all();
> >          }
> > }
> >
> > Should we call swiotlb_sync_single_for_cpu() and
> > arch_dma_mark_clean() after the flush to ensure the CPU sees the
> > latest data and that the memcpy is correct? I mean:
>
> Yes, this and the equivalents in the later patches are broken for all
> the sync_for_cpu and unmap paths which may end up bouncing (beware some
> of them get a bit fiddly) - any cache maintenance *must* be completed
> before calling SWIOTLB. As for mark_clean, IIRC that was an IA-64 thing,
> and appears to be entirely dead now.

Thanks, Robin. Personally, I would prefer an approach like the one below=E2=
=80=94
that is, not optimizing the bounce buffer cases, as they are already slow
due to hardware limitations with memcpy, and optimizing them would make
the code quite messy.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 550a1a13148d..a4840f7e8722 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -423,8 +423,11 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
        for_each_sg(sgl, sg, nents, i) {
                phys_addr_t paddr =3D dma_to_phys(dev, sg_dma_address(sg));

-               if (!dev_is_dma_coherent(dev))
+               if (!dev_is_dma_coherent(dev)) {
                        arch_sync_dma_for_cpu(paddr, sg->length, dir);
+                       if (unlikely(dev->dma_io_tlb_mem))
+                               arch_sync_dma_flush();
+               }

                swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);

I=E2=80=99d like to check with you, Leon, and Marek on your views about thi=
s.

Thanks
Barry
