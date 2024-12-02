Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF91148826
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166419; cv=none; b=e7V3SPYzynNmqUjUJZO5E3TSfr9SjRhfX5N1QBc5UL+ek8tNyB6HBmw4pAEMgwiSTV7En1N61GFvZqEjRSHnmzu7R9kf4CFJ7bzAM6VvWD4Kmyhd77E1jzKBHfX6f+8k4nEGDGGyPAIcDDb/6DJ6tqS+918Zl83JR1KKZtTC9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166419; c=relaxed/simple;
	bh=HO8QEd0sP9QBQaCASZ99qJ6u6rzizC/OEzF1M7dMbo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/L3mzTHESzillAy5x9ARzcbXphpRlkfYKm9q5w42PKy9DxXVPtVvpBF57sjuqsX4Aty7F2gVofUKbDuzdutZBgj1zAgSIP+dqjLfO4YB4sp7MYgqYqlGCM/zYGLKdRtuxgMDqiHG3KbinTcpBJyUj8n00B+g3qRE7+1BG+ogJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxF39mV6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxF39mV6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0aab1aafcso27272a12.1
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733166416; x=1733771216; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCBUeYFV3fpgaA8Zw2GoHbzl3MSDJwsSgusnPSoLN4k=;
        b=IxF39mV6gA0jL2gHpCoOm6Tftf5h7f1BjJmPUIkdg30xZ9DEU/dHjHKUnouQLj0TBj
         jCK/yA+c0D+nHSHla+8MO8mdW3++mRoK5iJXlNawLYNnYJ2DRn0/827W/3raBVDZohv+
         yUM2UaO00PYHjdghgydc4fcf63u5ZJUWyO39OyinFD4nhIsuHimlLuhEu08ZwYIa5p6K
         KgB3BMa+4oEYSD/wCtB5HY5lO6fH8bR9J0BVIemLV/1LHZQpyBSh0gK+UMW/Kzjkw49L
         fAgVzzjFeMKH5EQAXH4AfOgW3Zc+qfTyHDdNEDmyVIuu5DQWyiiTRFWLN8fbqnAMiorA
         ZrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166416; x=1733771216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCBUeYFV3fpgaA8Zw2GoHbzl3MSDJwsSgusnPSoLN4k=;
        b=nbpq1aq/yoL7wQL9acn5yd1PUm9MCxeJ98yEv4QdD2/XWW7n8IrWJYEusX5HmqZuua
         98CsXH62l6KPqYNPCHMz9Cn8wwydScaRqX5nLyeyrF0NXS3N1YkYEjqf4grLmEVSLWNv
         P/tQqscKMxR5aqgN5xWFq3ZlwEuWLQuGK71bfaHYpk3GFDmRrKzaxJ+6YeLs2jj94hVR
         d4NpogyDnrq7rFx8I1oVc1enUrpP9tf1XrkCkkyrOd+jAMBcwLqbedLVWnK5DwSFdyWR
         ZEXZ3BzdwrjcOOuE366cdZropDBhaux8PrwPi2i14XvV1v7iUX8UVZ41MwFMQm9yOmmo
         35Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV217657VM3liG2LLbrjLmzsCS2UgmnQibdap5ojP63EVd1sMhEyheHSY6NOWuvbCPZ/eRSIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbJBsZhTu1ZHkWISW+Y/kP+oVJwuRCBD045NRhxfbA2pqT4DDd
	GuvJuLNU03SGGVdcRECqRZcEFg3/Io5QVPk5ngL3d9H2LAHrssAtCrSMY4KsG3ODmHlVAGyKx5Z
	BxwPQtj2rd1aGPDDp7vA/JMzeJtGe/7b/D1z9
X-Gm-Gg: ASbGncsG/980Psevmq94TnYLR0d/9l2/jxwIVjUJeJts8ahMiUPoCWDRuojU+8z58BO
	DHF9VORuPNNXafYUEGpBEVzZPx1D3Wa4Hk4GVbuFXKqQ/1C1cwt8FmofLIklobIal9g==
X-Google-Smtp-Source: AGHT+IH9j98cJW7npDpW6xfQsvGNfNPkd9QkcAkOZ8rrdyy7XAgOVooDJ8GQtMc27kWKIX+xFIqscW8kLPQx7naDkhU=
X-Received: by 2002:a05:6402:1117:b0:5d0:8752:cecd with SMTP id
 4fb4d7f45d1cf-5d098217d8cmr287064a12.3.1733166415531; Mon, 02 Dec 2024
 11:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com> <20241024162516.2005652-2-smostafa@google.com>
 <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com> <Z02kIaxP96am-P2f@google.com>
In-Reply-To: <Z02kIaxP96am-P2f@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 2 Dec 2024 11:06:44 -0800
Message-ID: <CAE2F3rAj74u5cs_iVTuU+RqJRYPTceVMqww9EFwC7X03Xave5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mostafa,

On Mon, Dec 2, 2024 at 4:12=E2=80=AFAM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> Hi Daniel,
>
> On Sat, Nov 30, 2024 at 08:20:10PM -0800, Daniel Mentz wrote:
> > On Thu, Oct 24, 2024 at 9:26=E2=80=AFAM Mostafa Saleh <smostafa@google.=
com> wrote:
> > >
> > > When calculating the max number of entries in a table, Where
> > > RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
> > > an index spanning more than one concatenated table (for ex for 4K
> > > page size > 512).
> > > But then, max_entries is calculated as follows:
> > > max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
> > >
> > > This leads to a negative index in the page table, where for:
> > > - map: do nothing (no OOB) as fortunately all comparisons are signed,
> > >   but it would return a negative mapped value.
> > >
> > > - unmap: it would leak any child tables as it skips the loop over
> > >   =E2=80=9C__arm_lpae_free_pgtable=E2=80=9D
> > >
> > > This bug only happens when map/unmap is requested with a page size
> > > equals to the first level of the concatenated table (for 40 bits inpu=
t
> > > and 4K granule would be 1GB) and can be triggered from userspace with
> > > VFIO, by choosing a VM IPA in a concatenated table > 0 and using
> > > huge pages to mmap with the first level size.
> > >
> > > For example, I was able to reproduce it with the following command
> > > with mainline linux and mainline kvmtool:
> > >
> > > ./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  -=
-force-pci -c \
> > > `nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  =
/hugepages
> > >
> > > Where huge pages with 1GB would be used and using IPA in the second t=
able
> > > (512GB for 40 bits SMMU and 4K granule).
> > >
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtabl=
e-arm.c
> > > index 0e67f1721a3d..3ecbc024e440 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte=
 pte,
> > >         return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MA=
SK << 4);
> > >  }
> > >
> > > +/*
> > > + * Using an index returned from ARM_LPAE_PGD_IDX(), which can point =
to
> > > + * concatenated PGD concatenated, get the max entries of a that tabl=
e.
> >
> > I believe the macro that returns an index is called ARM_LPAE_LVL_IDX
> > not ARM_LPAE_PGD_IDX.
> >
>
> Yes, the comment is not quite accurate, although ARM_LPAE_PGD_IDX()
> calls ARM_LPAE_PGD_IDX() which is the problem.

I assume you mean the problem is that ARM_LPAE_LVL_IDX() calls into
ARM_LPAE_PGD_IDX().

I find that ARM_LPAE_PGD_IDX is a misnomer as it returns a number of
bits as opposed to an index. Something like ARM_LPAE_PGD_EXTRA_BITS
would be a more appropriate name.

>
> Thanks,
> Mostafa
>
> > > + */
> > > +static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgt=
able *data)
> > > +{
> > > +       int ptes_per_table =3D ARM_LPAE_PTES_PER_TABLE(data);
> > > +
> > > +       return ptes_per_table - (i & (ptes_per_table - 1));
> > > +}
> > > +
> > >  static bool selftest_running =3D false;
> > >
> > >  static dma_addr_t __arm_lpae_dma_addr(void *pages)
> > > @@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgta=
ble *data, unsigned long iova,
> > >
> > >         /* If we can install a leaf entry at this level, then do so *=
/
> > >         if (size =3D=3D block_size) {
> > > -               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_i=
dx_start;
> > > +               max_entries =3D arm_lpae_max_entries(map_idx_start, d=
ata);
> > >                 num_entries =3D min_t(int, pgcount, max_entries);
> > >                 ret =3D arm_lpae_init_pte(data, iova, paddr, prot, lv=
l, num_entries, ptep);
> > >                 if (!ret)
> > > @@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm=
_lpae_io_pgtable *data,
> > >
> > >         if (size =3D=3D split_sz) {
> > >                 unmap_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data)=
;
> > > -               max_entries =3D ptes_per_table - unmap_idx_start;
> > > +               max_entries =3D arm_lpae_max_entries(unmap_idx_start,=
 data);
> > >                 num_entries =3D min_t(int, pgcount, max_entries);
> > >         }
> > >
> > > @@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io=
_pgtable *data,
> > >
> > >         /* If the size matches this level, we're in the right place *=
/
> > >         if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> > > -               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - unmap=
_idx_start;
> > > +               max_entries =3D arm_lpae_max_entries(unmap_idx_start,=
 data);
> > >                 num_entries =3D min_t(int, pgcount, max_entries);
> > >
> > >                 /* Find and handle non-leaf entries */
> > > --
> > > 2.47.0.105.g07ac214952-goog
> > >
> > >
