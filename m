Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC81A0B06
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556245; cv=none; b=lqhbXC2nrnwclIaFVJluTdnqcwYVUh+G7YrOZYVW/adJRcyXkzIJq/WzB1AhRi9kW8VdTwgN6SsBbgubjQsmK0r/Cy+iS40m/Y+ApjeRALAczfVmlwftWQi0GDssyjbqDz7XRw7Bj8DOTT9lLzAN2wRyJQkPp4FOdh2jSOdE9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556245; c=relaxed/simple;
	bh=W3mjOn/yF2UHDYZ5e+nh25q/TqVulPe8iYhtDSb0T1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4+s8y2MsChRqj0yA6GhokNjsp18qGpAA2bHDjXiHcI/Pqe6vgvXLywtAoNxVPFwbIX2rAslG2Ts5l+ZeW4LBnJ7Eu9AFWKIfMsRvvsLJp4rYAWDbfAwFCzIBWtF/Jy8v7TpYn6LBBdYsDNO1CWQxq1Xt1DQjO06sBS+2ZU+Vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMpceV5q; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMpceV5q"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39f526fd19bso3814175ab.1
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725556243; x=1726161043; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TugYWWTmfA5+0ZqiY0zoD9lJrHPCBxbgSyyl1t8wKjk=;
        b=YMpceV5qSQiOorVJnG3h1n2t6WwMGGlY2COJ1M9YZuEmzKg6Pe0cZy/jcu66JYad+5
         moG1bnazmS9d4a9DvoGuJ0wDkgLp/znXcBL/0FFSR3qL63/JoYzvoxJdd7GCLjBa3/Oi
         1dkNI4z5R5sEHFCayvFjxSmkR2imboF97A+7ZCO0dGKVmk8O/6kIdBDIL32PR7Hi1smx
         EObS/I03DILgD2WaiSQC5sVT11FUWCzgOWlZUb44n32/ioTRvmSseklBIoAuFo4Oh9gN
         pRGjdEXiqDzvfC8vyTahoVrJKkTClcjD1mcfei/XEqtHrQKiGpdy90N+6LVDzzFmFfEm
         th1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725556243; x=1726161043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TugYWWTmfA5+0ZqiY0zoD9lJrHPCBxbgSyyl1t8wKjk=;
        b=W999gcLN8thIGrIXoopZpyb1R+AxoWOAxKQJD5UZ5jUTjUc+vD0TvS5HtnXCquelon
         mmm+07RhQQNEpj5eMqvld70b2u2AUqWpr9GJBR0+f3poMZOw6w0L4veYMEhoovlzPVtq
         SSeaxh04Is/Fb+sJefr87nHao3qASLLRXYr7pnICzfU1oHKC+oQXSG9GSr6t6KbEYsAn
         WCnBizaG2AfTX3WLnwfzBDgogBLTHrw7BhMcyDVc4e+4yYPeiru0q0KTy7ym4jqX5RnH
         G/mW7ijOvBR7GYVJp45nJkwg1EP21kAYA/ZB+zLaQmfgJ1Zkdsrn7xyCH/ogG4gjRnDv
         MkWg==
X-Forwarded-Encrypted: i=1; AJvYcCWJod4QDT/GWYBb9qhf3jnT5gt9cmikG0lRSulHtQz9iSGhHltFCYIpzY0iH1Au1bKPu7pPYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY2Y1fqkFK+M1h1k+K2Ie7Ky5PNYbDnoJeoezMmo7p0Nwwi6fB
	KB5gjtTAg7zQOHKz5mu6VJ3+ayexPHWhfWRQ84zC89ASDyHL5/co2StFeIoaRaj/J8iIwShoNU8
	fCKYohnuqiXItRDRrdu8DGwtNdReeQ677
X-Google-Smtp-Source: AGHT+IH5kHkyh4TQY9qQMpV4jTCKCy2lyxsS5qWD7hz50R2gl4bk5tUOxy/O9US635pYUshC6lF6+mLFwVVPNAM4HVQ=
X-Received: by 2002:a05:6e02:148e:b0:3a0:4d72:7f5e with SMTP id
 e9e14a558f8ab-3a04d7282c9mr15898065ab.7.1725556243238; Thu, 05 Sep 2024
 10:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240905124956.84932-1-robdclark@gmail.com> <20240905155330.GA15246@willie-the-truck>
 <53f13813-a515-475a-836d-0b6017a117eb@arm.com> <CAF6AEGs3aRXbnnhD84GBbz9wJmyNR=dA3hbGuMLcM22Vs8CU_g@mail.gmail.com>
In-Reply-To: <CAF6AEGs3aRXbnnhD84GBbz9wJmyNR=dA3hbGuMLcM22Vs8CU_g@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 5 Sep 2024 10:10:31 -0700
Message-ID: <CAF6AEGsqdxO4+kaz6jOLBS_syjEkZg-7Veqh3j-o=RiGNcBH8A@mail.gmail.com>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Optimise non-coherent unmap"
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Ashish Mhetre <amhetre@nvidia.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:00=E2=80=AFAM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Thu, Sep 5, 2024 at 9:27=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
> >
> > On 05/09/2024 4:53 pm, Will Deacon wrote:
> > > Hi Rob,
> > >
> > > On Thu, Sep 05, 2024 at 05:49:56AM -0700, Rob Clark wrote:
> > >> From: Rob Clark <robdclark@chromium.org>
> > >>
> > >> This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.
> > >>
> > >> It was causing gpu smmu faults on x1e80100.
> > >>
> > >> I _think_ what is causing this is the change in ordering of
> > >> __arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
> > >> memory) and io_pgtable_tlb_flush_walk().  I'm not entirely sure how
> > >> this patch is supposed to work correctly in the face of other
> > >> concurrent translations (to buffers unrelated to the one being
> > >> unmapped(), because after the io_pgtable_tlb_flush_walk() we can hav=
e
> > >> stale data read back into the tlb.
> > >>
> > >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >> ---
> > >>   drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++----------------=
-
> > >>   1 file changed, 14 insertions(+), 17 deletions(-)
> > >
> > > Please can you try the diff below, instead?
> >
> > Given that the GPU driver's .tlb_add_page is a no-op, I can't see this
> > making a difference. In fact, given that msm_iommu_pagetable_unmap()
> > still does a brute-force iommu_flush_iotlb_all() after io-pgtable
> > returns, and in fact only recently made .tlb_flush_walk start doing
> > anything either for the sake of the map path, I'm now really wondering
> > how this patch has had any effect at all... :/
>
> Yeah..  and unfortunately the TBU code only supports two devices so
> far, so I can't easily repro with TBU enabled atm.  Hmm..
> __arm_lpae_unmap() is also called in the ->map() path, although not
> sure how that changes things.

Ok, an update.. after a reboot, still with this patch reverted, I once
again see faults.  So I guess that vindicates the original patch, and
leaves me still searching..

fwiw, fault info from the gpu devcore:

-------------
fault-info:
  - ttbr0=3D0000000919306000
  - iova=3D0000000100c17000
  - dir=3DWRITE
  - type=3DUNKNOWN
  - source=3DCP
pgtable-fault-info:
  - ttbr0: 000000090ca40000
  - asid: 0
  - ptes: 000000095db47003 000000095db48003 0000000914c8f003 00000008fd7f0f=
47
-------------

the 'ptes' part shows the table walk, which looks ok to me..

BR,
-R

> BR,
> -R
>
> > >
> > > Will
> > >
> > > --->8
> > >
> > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtabl=
e-arm.c
> > > index 0e67f1721a3d..0a32e9499e2c 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -672,7 +672,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io=
_pgtable *data,
> > >                  /* Clear the remaining entries */
> > >                  __arm_lpae_clear_pte(ptep, &iop->cfg, i);
> > >
> > > -               if (gather && !iommu_iotlb_gather_queued(gather))
> > > +               if (!iommu_iotlb_gather_queued(gather))
> >
> > Note that this would reintroduce the latent issue which was present
> > originally, wherein iommu_iotlb_gather_queued(NULL) is false, but if we
> > actually allow a NULL gather to be passed to io_pgtable_tlb_add_page()
> > it may end up being dereferenced (e.g. in arm-smmu-v3).
> >
> > Thanks,
> > Robin.
> >
> > >                          for (int j =3D 0; j < i; j++)
> > >                                  io_pgtable_tlb_add_page(iop, gather,=
 iova + j * size, size);
> > >
