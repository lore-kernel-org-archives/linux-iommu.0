Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020517597
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708575135; cv=none; b=iqSAy2RHjJnVuIr78/lqYtSwZKszcI6/YuUkSzXLPQq9Eunckb36SgQKX/Gcpn1i/v4jnAjkYf4JTAAC5NWcc+SrSCw0jbd3ATrRcDOzpCcNbKEkbD09VmXngabVdNDvv5MjIbL3hMqMV9tk7+KIUtP8ZZD6vlvynyW05GwRdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708575135; c=relaxed/simple;
	bh=Vu/f/rZT1RWUCIPuLYOEVeQTHZVSDQpnAARYghsCAB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHDLAFQqYori88w5/ePv1Pu9uDQ4wRTnnrTJ4LVAX73+U4gNxr6aQzUqLmcfqc7dmB/xzOCSIw7aiBzBCgCMMiMC5BsIov8dvcrUdRQwJVnIbL313KoD2F9pi3GHjNHiuHePMnR9jqGO5PFMCuga3qdeIMspQKVW4YOoXWOMEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qdcq72ti; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qdcq72ti"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d208be133bso81902661fa.2
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 20:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708575132; x=1709179932; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pLbMdXfqeNQGrSTR+lBgPID7T5y9s5oLe74DwSX22JM=;
        b=Qdcq72ti3DTAr/8VO9Oaj2k73OKdJ5VwQtdkGcIjk3MmTnJ7vdNxw5nE4FBzXEI6ok
         3M9OZanHxwtmnsnVaol87B8mHDo0HyB/Q7ktDDFgrqPM+rsdBZigG39TSc3YP5w/bGfr
         jaQyseJo5YbqbQmr+BNMuoCruuDgGgtfE3bLPAdgEN2AMdGmIzNjarWCA0HW5al6OuA2
         ptfBaliVsY1l+JsMtHRTjumL+j4BJlgQRXPbXXi3wqffGyu6CUY5qiZqp83BkbdEpp9Y
         X+qYQs+Ssc8PUubvlL4kWJoJB73m3JJRbSZxr8asTjPOmBojoulYrsiJRkX5rwnNqxvz
         FIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708575132; x=1709179932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLbMdXfqeNQGrSTR+lBgPID7T5y9s5oLe74DwSX22JM=;
        b=Z+8DCIbcsgtcXmTIwQ4sydMQrl2v8bDyIPdjVMyyI5BvGaJLRoaIa4GPXNb+rWx8uX
         coX3dsnFEeWvxjE/2mitFoV20oAh5dQBI2/E9ps16zBRJgQOLIibgHDGR/ZLTZJAb3/N
         6KP2p1pbLf2+DZqRzPjT4CLoX1vstIBKJbZ/zzGnFJNku/7uBkuVYTOF3zRiU4D97L0v
         k7DhY4k1kTeUoZYfmKwyeZzP5n1sj4t09l85/B8hy+TYKXB62OAizrrXpuyrgr184b2z
         RUz2vRZ2rmcbPuAvzN9z7nfip3dtXcL5xCBEzOblSmYm+0s+6PZGxpY8TK1PkdHgkoLD
         Z3+g==
X-Forwarded-Encrypted: i=1; AJvYcCU1rk/fHkZkC/cRE1hFqUsOdk5sYcTNZgN1SYTgym42xEzJP3dPAffoinc02mufFpHzMYlUJ9wqVzem7bafuxgoPWvPuXE=
X-Gm-Message-State: AOJu0YzpFVPYGK/0eBW33+KzHxvefXkBJhR0KUxEfs2T6K2En2rwxpQk
	PCwS3cs8lkwa8o09jOvJdPbm+meF45o1lqPV0ZS4lGS1b+8ArcyavjTL4GGSakXHyoPRtd3ZID6
	x0oCCfNBOuhblGVGNsUXeHrxG+e2i9UHf41YQDw==
X-Google-Smtp-Source: AGHT+IHAMoyEL/VKTxvWkJITVlh+9tUKrNIKjNd6Rne2m4uJOagL+re0ibXespCN1AK8TgJOdoioC2ZuY5dXzU5ehEo=
X-Received: by 2002:a2e:9bc2:0:b0:2d2:3c72:516d with SMTP id
 w2-20020a2e9bc2000000b002d23c72516dmr6807924ljj.1.1708575132001; Wed, 21 Feb
 2024 20:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221110658.529-1-zhangfei.gao@linaro.org> <20240221131725.GR13330@nvidia.com>
 <CABQgh9Ha6C=Ej7Z2Md3v5Q6iXPKHsz+yQ2G_-oOaotVuVi8Hmg@mail.gmail.com>
In-Reply-To: <CABQgh9Ha6C=Ej7Z2Md3v5Q6iXPKHsz+yQ2G_-oOaotVuVi8Hmg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 22 Feb 2024 12:11:59 +0800
Message-ID: <CABQgh9Gp5QaG8-KUOGa=S4i_tAt25Zo=tMFx_DbY-mw+OS17_g@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Fix iommu_sva_bind_device to the same domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, baolu.lu@linux.intel.com, 
	"Zhang, Tina" <tina.zhang@intel.com>, kevin.tian@intel.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 00:17, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Wed, 21 Feb 2024 at 21:17, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 11:06:58AM +0000, Zhangfei Gao wrote:
> > > The accelerator device can provide multi-queue and bind to
> > > the same domain in multi-thread for better performance,
> > > and domain refcount takes care of it.
> > >
> > > 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > > removes the possibility, so fix it
> > >
> > > Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > ---
> > > v2: Instead of checking ret == -EBUSY,
> > >     change iommu_attach_device_pasid return value from -EBUSY to 0
> > >     when pasid entry is found, and refcount++ when return
> > >
> > >  drivers/iommu/iommu-sva.c | 2 +-
> > >  drivers/iommu/iommu.c     | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > > index c3fc9201d0be..20b232c7675d 100644
> > > --- a/drivers/iommu/iommu-sva.c
> > > +++ b/drivers/iommu/iommu-sva.c
> > > @@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> > >       struct device *dev = handle->dev;
> > >
> > >       mutex_lock(&iommu_sva_lock);
> > > -     iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> > >       if (--domain->users == 0) {
> > > +             iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> > >               list_del(&domain->next);
> > >               iommu_domain_free(domain);
> > >       }
> >
> > The users refcount is not to provide for sharing of the same PASID it
> > is to provide for sharing the domain across devices. This change would
> > break that because we loose the 'dev' that needs to be detached in a
> > multi-device case if we don't immediately call detach_device_pasid
> > here.
> >
> > You'd need to build something much more complicated here to allow
> > PASID sharing.
> >
> > I wonder if this case is common enough to warrant the core code to get
> > involved. I suppose maybe, does idxd have the same problem? It can
> > only open it's cdev once because of this - that doesn't seem like what
> > the code intends for a non-wq_dedicated?
> >
> > More like this:
>
> Hi, Jason
>
> Only added two lines change, and tested ok.
> The different with before is same handle is returned, and the handle
> itself has refcount.
> While before different handle is returned,
> Not think about any issue now, I think it is OK.
>
> Could you send the patch, will add tested-by then.

Or would you mind I send the patch on behalf of you?

The limitation breaks our existing system :(

https://github.com/Linaro/linux-kernel-uadk/commit/4c48330faf727303e3127c9ee6fbf56d885b4297

Thanks

>
> >
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c3fc9201d0be97..aec11e5cde6b0e 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -41,6 +41,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
> >         }
> >         iommu_mm->pasid = pasid;
> >         INIT_LIST_HEAD(&iommu_mm->sva_domains);
> > +       INIT_LIST_HEAD(&iommu_mm->sva_handles);
> >         /*
> >          * Make sure the write to mm->iommu_mm is not reordered in front of
> >          * initialization to iommu_mm fields. If it does, readers may see a
> > @@ -82,6 +83,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> >                 goto out_unlock;
> >         }
> >
> > +       list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
> > +               if (handle->dev == dev && handle->domain->mm == mm) {
> > +                       refcount_inc(&handle->users);
>
> mutex_unlock(&iommu_sva_lock);
>
>
> > +                       return handle;
> > +               }
> > +       }
> > +
> >         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> >         if (!handle) {
> >                 ret = -ENOMEM;
> > @@ -109,6 +117,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> >                 goto out_free_domain;
> >         domain->users = 1;
>
>  refcount_set(&handle->users, 1);
>
>
> >         list_add(&domain->next, &mm->iommu_mm->sva_domains);
> > +       list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
> >
> >  out:
> >         mutex_unlock(&iommu_sva_lock);
> > @@ -141,6 +150,12 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> >         struct device *dev = handle->dev;
> >
> >         mutex_lock(&iommu_sva_lock);
> > +       if (!refcount_dec_and_test(&handle->users)) {
> > +               mutex_unlock(&iommu_sva_lock);
> > +               return;
> > +       }
> > +       list_del(&handle->handle_item);
> > +
> >         iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> >         if (--domain->users == 0) {
> >                 list_del(&domain->next);
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 1ea2a820e1eb03..5e27cb3a3be99b 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -892,11 +892,14 @@ struct iommu_fwspec {
> >  struct iommu_sva {
> >         struct device                   *dev;
> >         struct iommu_domain             *domain;
> > +       struct list_head                handle_item;
> > +       refcount_t                      users;
> >  };
> >
> >  struct iommu_mm_data {
> >         u32                     pasid;
> >         struct list_head        sva_domains;
> > +       struct list_head        sva_handles;
> >  };
> >
> >  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>
> Thanks
