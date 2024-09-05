Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2019CCE7
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544657; cv=none; b=oFOAxE15kVLcSdWJ2QSaOH5cEPH3fI0GeTgtgm2EMOClXEziUXkYNZ9adEHqLmySp/3DQaLKlLKU5y+0kSKUI4BNMCuakSErMVY6F4alBlCH47Xc2Y0c3PpBwJIRHFo5/anvpbsU5PVP18IGm36SQRNItbwzzrTBNC7omtWRp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544657; c=relaxed/simple;
	bh=ICoiFojqXJghEOejDRRpEkyrTboLl9TIGErwYJpH6HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2EYWoJwMlhnmvcfYynuLPCMFw4yoRfN7zu6irSOQwqA6kUUve4YIMIF6yfYjSW4H5cV/LCx4E7LUIyyD4onhEPDwvr0MfkXaLUAqRNrIvINmKhaedxuixY0eFEo/B/PGu7fkr15VXDD8hdIa0Ehl4TFYQdelMINMEZ86SeKt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E58sK6OF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E58sK6OF"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39fdd5c44d3so3188315ab.3
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725544655; x=1726149455; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc5+mSx3W5XFfGXytntTUzm4xnx4wnnrB9kh6mhBy6M=;
        b=E58sK6OFUXJLFfQoE7C0IvajHM/ljDJ+o92OXE/PyQ5nEcaY8a790fuiPi4O2rcXEL
         H4UIbNENe4xP7D6OFWKREb0wdGkoVm0qxc5w8Z2QRHwa94SfVPTtVLkeLIuYDMZuo/mi
         O4HK6WVMV8ndUJknwy6fcA4cdTT6F3IWC5kz5Rw0lrgAtobqhqmAhS5Rbnv1Mgv/ewV8
         d/XVOudz+n0ccyST9I2WFEHcwrT0H+xb40NBQwgOPSiY3WH508ynccHixcFRn+a7VNz7
         A+kzAgeOiTA/7vVNIMzCWky45tq2H8FxD2CYIP4cIsixLCnHmO8GWhc9CNOybgcvw015
         7AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725544655; x=1726149455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc5+mSx3W5XFfGXytntTUzm4xnx4wnnrB9kh6mhBy6M=;
        b=nvV9A1Osbcs4E/VYOlOzfLCSK4QcpzbvPgLAEmcrtG8C+rEQ8RO6gKxvUjfiLcyFu1
         ytqjcloUqXy5aNF9Lxf536FeIlZ7lhI0YtkFcQ/0nm/DwiIUjm+OZpJt1AJLB0ONtVzW
         8GyjcdjTzXI2jbGPMD1/HuOSx9Z3WZfHY6YtBkUZ8hU7zy509o77d2fG4y5JZgngwUNd
         dVBAy3NQ97OEDNrZ5CKqQFoVMHmXivT/hYxI5q8XC9I+k23SLYNwdDqOA2CI3o6GYql5
         P+cVIUP69HmG9GAcgrz4PIUOkMcJx9rV3wr+3jTZ4B8q9my8aEOuKT0hu8VOUYZQ566d
         EfPQ==
X-Gm-Message-State: AOJu0Yw3Qez0XGzNZV/yU4J1142AKokKV5SFbIsjg9oHQjsrwZiPbEAS
	hSVtpdOftEEO54oFq0M0k2hsx3RqFafO6dUHwJ5NOu2t98+yEF9AJmcfGhT1stYII4U4l+nRfNa
	AB4w46S1ckXXT/48uRcLvg9yhJwk=
X-Google-Smtp-Source: AGHT+IH19xIWuVYCDQUvgge4detxZmlypKKLvCBkh2uWT8rdoV0uXU1DBfLhUeWBn085IemWYq1jY9RKwCVgIwlHcUo=
X-Received: by 2002:a05:6e02:1a6d:b0:39a:ea89:22ec with SMTP id
 e9e14a558f8ab-39f4f68d785mr219239495ab.9.1725544654507; Thu, 05 Sep 2024
 06:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240905124956.84932-1-robdclark@gmail.com> <fb54ef8d-f769-47d5-8a9d-aa93f96d5c41@arm.com>
In-Reply-To: <fb54ef8d-f769-47d5-8a9d-aa93f96d5c41@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 5 Sep 2024 06:57:22 -0700
Message-ID: <CAF6AEGuv=yyVDx58iWU203BQPp-pT2SAC9yW-JMm2U+MTsGUaQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Optimise non-coherent unmap"
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Ashish Mhetre <amhetre@nvidia.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:24=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 05/09/2024 1:49 pm, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.
> >
> > It was causing gpu smmu faults on x1e80100.
> >
> > I _think_ what is causing this is the change in ordering of
> > __arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
> > memory) and io_pgtable_tlb_flush_walk().
>
> As I just commented, how do you believe the order of operations between:
>
>         __arm_lpae_clear_pte();
>         if (!iopte_leaf()) {
>                 io_pgtable_tlb_flush_walk();
>
> and:
>
>         if (!iopte_leaf()) {
>                 __arm_lpae_clear_pte();
>                 io_pgtable_tlb_flush_walk();
>
> fundamentally differs?

from my reading of the original patch, the ordering is the same for
non-leaf nodes, but not for leaf nodes

> I'm not saying there couldn't be some subtle bug in the implementation
> which we've all missed, but I still can't see an issue with the intended
> logic.
>
> >  I'm not entirely sure how
> > this patch is supposed to work correctly in the face of other
> > concurrent translations (to buffers unrelated to the one being
> > unmapped(), because after the io_pgtable_tlb_flush_walk() we can have
> > stale data read back into the tlb.
>
> Read back from where? The ex-table PTE which was already set to zero
> before tlb_flush_walk was called?
>
> And isn't the hilariously overcomplicated TBU driver supposed to be
> telling you exactly what happened here? Otherwise I'm going to continue
> to seriously question the purpose of shoehorning that upstream at all...

I guess I could try the TBU driver.  But I already had my patchset to
extract the pgtable walk for gpu devcore dump, and that is telling me
that the CPU view of the pgtable is fine.  Which I think just leaves a
tlbinv problem.  If that is the case, swapping the order of leaf node
cpu cache ops and tlbinv ops seems like the cause.  But maybe I'm
missing something.

BR,
-R

> Thanks,
> Robin.
>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++-----------------
> >   1 file changed, 14 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index 16e51528772d..85261baa3a04 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *p=
tep, int num_entries,
> >                                  sizeof(*ptep) * num_entries, DMA_TO_DE=
VICE);
> >   }
> >
> > -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtab=
le_cfg *cfg, int num_entries)
> > +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtab=
le_cfg *cfg)
> >   {
> > -     for (int i =3D 0; i < num_entries; i++)
> > -             ptep[i] =3D 0;
> >
> > -     if (!cfg->coherent_walk && num_entries)
> > -             __arm_lpae_sync_pte(ptep, num_entries, cfg);
> > +     *ptep =3D 0;
> > +
> > +     if (!cfg->coherent_walk)
> > +             __arm_lpae_sync_pte(ptep, 1, cfg);
> >   }
> >
> >   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> > @@ -653,28 +653,25 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io=
_pgtable *data,
> >               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx=
_start;
> >               num_entries =3D min_t(int, pgcount, max_entries);
> >
> > -             /* Find and handle non-leaf entries */
> > -             for (i =3D 0; i < num_entries; i++) {
> > -                     pte =3D READ_ONCE(ptep[i]);
> > +             while (i < num_entries) {
> > +                     pte =3D READ_ONCE(*ptep);
> >                       if (WARN_ON(!pte))
> >                               break;
> >
> > -                     if (!iopte_leaf(pte, lvl, iop->fmt)) {
> > -                             __arm_lpae_clear_pte(&ptep[i], &iop->cfg,=
 1);
> > +                     __arm_lpae_clear_pte(ptep, &iop->cfg);
> >
> > +                     if (!iopte_leaf(pte, lvl, iop->fmt)) {
> >                               /* Also flush any partial walks */
> >                               io_pgtable_tlb_flush_walk(iop, iova + i *=
 size, size,
> >                                                         ARM_LPAE_GRANUL=
E(data));
> >                               __arm_lpae_free_pgtable(data, lvl + 1, io=
pte_deref(pte, data));
> > +                     } else if (!iommu_iotlb_gather_queued(gather)) {
> > +                             io_pgtable_tlb_add_page(iop, gather, iova=
 + i * size, size);
> >                       }
> > -             }
> >
> > -             /* Clear the remaining entries */
> > -             __arm_lpae_clear_pte(ptep, &iop->cfg, i);
> > -
> > -             if (gather && !iommu_iotlb_gather_queued(gather))
> > -                     for (int j =3D 0; j < i; j++)
> > -                             io_pgtable_tlb_add_page(iop, gather, iova=
 + j * size, size);
> > +                     ptep++;
> > +                     i++;
> > +             }
> >
> >               return i * size;
> >       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
