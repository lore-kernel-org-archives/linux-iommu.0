Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBB18E03F
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433823; cv=none; b=RVacqpJ0JnwF301zszN1Y515VMqce2ca5PCsRyGLLei+uDXhR8l8iV1/C7j9kuxxgjNde4tf4PhzRDlzLEj8nzlszj+oPZVwdnUZtn2+i6w2HiE1jzhKsw28bL5TKSpKhFR1bCs10bGtMI0I+5/XzAODBg9bJF7mluRKazWawdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433823; c=relaxed/simple;
	bh=TDmWT5YnHW8yIQcSnVwkjxI1/quD6m7l3+e5yWHnZZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzA1ebyXdL3fj5U2E4mJN2FsWe6GwKm+yeK6tb5tReEpj2PHglFL0KGgHIbGNJPMmQ2p+wWjPtY2zkpskWw4zt5OGDOQ/Z1M+IKzDjKcMkV2RBbZ5JiYu5oU7+3QmdKNbqGOyJ14YuPXGa7vN+pSmHbyf259/3QuivOv9EuI10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs3d65Pm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs3d65Pm"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so3653702a12.0
        for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433819; x=1725038619; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igaQ+cq5DGxYKGyVENdg674ni4YlsPPzIF+5a4ikTl4=;
        b=Zs3d65PmchTt2txzfcoHXhn/dwgCotc/Xd5E3G+mrlpjJAn58GiE4tJ6XzrdIxIRec
         SBxPussKj9OOGcbGAYVrQjkgfROAK08SFAqeO6SeZM/iGNuuc/pj0LbId/iHSeVmjiqt
         q+lG7HruB4FKyVsARhwaM9QKIIbT5UDfmF75+UXVuZ5Dw8hBB3yX5BvFXTG+H+k3Wtre
         HjqIiYg/uBHEQgqAZ8JXY+whvKmBBk3qkBH2A5I1piBDayNjscdQZNlY5ULlnZZFd2l8
         OkV7+p2YByANtey5l7kyXcfECacenO1Qn/Cno/JlUEM4xhojR1rzymb8IkI3A6QldqfZ
         GNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433819; x=1725038619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igaQ+cq5DGxYKGyVENdg674ni4YlsPPzIF+5a4ikTl4=;
        b=pVucmpq6grqrLjDFgrNUOc+7O3MgAs1oTUfgrMBzzlbx6xxdtEj/UfoA+bwrdVbwr2
         ftpEpboOuCVsOzClUAyljoXnbQqs9j9m0YBn/yCGbOas3wyi3f9hIksHR9i6amWuadK9
         4WVYeEc7b/m+lQ74+CoLjSefyXSM6nllD/lag+tAw//P2PWOpX7dMlpPrlNhuBHyiGXW
         rT5wYcNcjui64m4NFs8hk5GjBnsddNbU6rDbWk6x4baAfMpcTb0psF9OYJRRqYFilrWe
         jPccI6e8OvQkW7gWeBPcsXFO3PLa4awzl0OkJ9LzhcrnOh1IAaRqHop6n/LXG7DECLKM
         poIQ==
X-Gm-Message-State: AOJu0YzTz+Z0aBqo5aQ8x/t8N5HM6GAzm4yVN+Ybt7DnbkBk1JnJxSsx
	lWeiIDP9zS9gIniW6iOz/eTJdjZATlRWGBooCUndokiv0+igCiqMeMKny0NA9ZYYlM0c8sdB85H
	vqePWfbCY5kUPL5DgceomAxxpK4c=
X-Google-Smtp-Source: AGHT+IEvKoYswWA+Kv16z62fxTPQiFoASnuCbE+YY/d9Vq/hDJvvJimzLBjRmNdz9Z390iTh/rA9GLCllZDWraUA9ZU=
X-Received: by 2002:a05:6402:35ce:b0:5c0:8ff8:d7da with SMTP id
 4fb4d7f45d1cf-5c08ff8d8d6mr1124508a12.12.1724433818375; Fri, 23 Aug 2024
 10:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820171652.145673-1-robdclark@gmail.com> <20240820171652.145673-2-robdclark@gmail.com>
 <20240823160929.GA851@willie-the-truck>
In-Reply-To: <20240823160929.GA851@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 23 Aug 2024 10:23:25 -0700
Message-ID: <CAF6AEGtkwjs4XLEBpo2O7W+UgbdxGoMAsYd+3Cr_qY88ofpMjQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] iommu/io-pgtable-arm: Make pgtable walker more generic
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Mostafa Saleh <smostafa@google.com>, 
	Rob Clark <robdclark@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:09=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 20, 2024 at 10:16:44AM -0700, Rob Clark wrote:
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index f5d9fd1f45bf..b4bc358740e0 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -747,33 +747,31 @@ static phys_addr_t arm_lpae_iova_to_phys(struct i=
o_pgtable_ops *ops,
> >  }
> >
> >  struct io_pgtable_walk_data {
> > -     struct iommu_dirty_bitmap       *dirty;
> > +     void                            *data;
> > +     int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
> > +                  arm_lpae_iopte pte, size_t size);
> >       unsigned long                   flags;
> >       u64                             addr;
> >       const u64                       end;
> >  };
> >
> > -static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *dat=
a,
> > -                                    struct io_pgtable_walk_data *walk_=
data,
> > -                                    arm_lpae_iopte *ptep,
> > -                                    int lvl);
> > +static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
> > +                              struct io_pgtable_walk_data *walk_data,
> > +                              arm_lpae_iopte *ptep,
> > +                              int lvl);
> >
> > -static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
> > -                               struct io_pgtable_walk_data *walk_data,
> > -                               arm_lpae_iopte *ptep, int lvl)
> > +static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
> > +                         struct io_pgtable_walk_data *walk_data,
> > +                         arm_lpae_iopte *ptep, int lvl)
> >  {
> >       struct io_pgtable *iop =3D &data->iop;
> >       arm_lpae_iopte pte =3D READ_ONCE(*ptep);
> >
> >       if (iopte_leaf(pte, lvl, iop->fmt)) {
> >               size_t size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> > -
> > -             if (iopte_writeable_dirty(pte)) {
> > -                     iommu_dirty_bitmap_record(walk_data->dirty,
> > -                                               walk_data->addr, size);
> > -                     if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
> > -                             iopte_set_writeable_clean(ptep);
> > -             }
> > +             int ret =3D walk_data->visit(walk_data, lvl, pte, size);
> > +             if (ret)
> > +                     return ret;
> >               walk_data->addr +=3D size;
> >               return 0;
> >       }
> > @@ -782,13 +780,13 @@ static int io_pgtable_visit_dirty(struct arm_lpae=
_io_pgtable *data,
> >               return -EINVAL;
> >
> >       ptep =3D iopte_deref(pte, data);
> > -     return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1=
);
> > +     return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
> >  }
> >
> > -static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *dat=
a,
> > -                                    struct io_pgtable_walk_data *walk_=
data,
> > -                                    arm_lpae_iopte *ptep,
> > -                                    int lvl)
> > +static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
> > +                              struct io_pgtable_walk_data *walk_data,
> > +                              arm_lpae_iopte *ptep,
> > +                              int lvl)
> >  {
> >       u32 idx;
> >       int max_entries, ret;
> > @@ -803,7 +801,7 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_l=
pae_io_pgtable *data,
> >
> >       for (idx =3D ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
> >            (idx < max_entries) && (walk_data->addr < walk_data->end); +=
+idx) {
> > -             ret =3D io_pgtable_visit_dirty(data, walk_data, ptep + id=
x, lvl);
> > +             ret =3D io_pgtable_visit(data, walk_data, ptep + idx, lvl=
);
> >               if (ret)
> >                       return ret;
> >       }
> > @@ -811,6 +809,20 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_=
lpae_io_pgtable *data,
> >       return 0;
> >  }
> >
> > +static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl=
,
> > +                    arm_lpae_iopte pte, size_t size)
> > +{
> > +     struct iommu_dirty_bitmap *dirty =3D walk_data->data;
> > +
> > +     if (iopte_writeable_dirty(pte)) {
> > +             iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
> > +             if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
> > +                     iopte_set_writeable_clean(&pte);
>
> Are you sure that's correct? I suspect we really want to update the actua=
l
> page-table in this case, so we probably want to pass the pointer in inste=
ad
> of the pte value.

oh, right

> Will
