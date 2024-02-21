Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731743AAB
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532246; cv=none; b=O5jA3/2bYlIhbEVehu64/8Wo1UB3k75J90gV8B0hkyUzgsx64WA5vo8Bs/VMREhZkwxnJ0P+dcK/gXK4UXrf7AOCuBG6ssZUNarQezKXOPwrj731/HnraavwVrNZwQL8rwCqax1AJrlpKQOjyVPT3vSCmWtHGXuz6y2GlDyIUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532246; c=relaxed/simple;
	bh=I1meVWt4Ajaq/+XCxI26UXI001r+bq752Odfv/pfMpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiA1phUndXJzX/fYGoBKhd07wDLJcp58GE9ZN2GKdbQYOjlqCTSdUb3UpRjLX916dAkYP1G4rPnaUylHcWCFjqriIE3cINGTu2EKCPqvrY1a/fS1ve/Nsfs1XeAS4SKADG8gVlBYZB4b6IHEJWnKshK22oCfe0oj8WPGJS6CiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPyFRagM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPyFRagM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so89990671fa.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708532242; x=1709137042; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSRdTUORIP3JPrt7kN1tEQGw0K12XfL4OvvkueI/BL4=;
        b=IPyFRagMmP7jwxxu8ykAV/DvlWWuKe0FwSATdRvoC8ggBwx19QK6+MrEeLwO1y/u2I
         +eIMIoG5rKfw+g53pY9nxCFUR4i2crcsxRny+rl+K7CGdU2j6L3F62tY7NTFx0advR1x
         p5aXnJjwwmalb1vBtYiMglZ71E9Uq8r8QMyVn6ZXjsGHLtZFWY3yDl7veRUEJJAcBCwh
         cJYEJ+vyONzs3urB4HRYzax6jyIaqSWdpPCCR9Heq95Pb9Jqi9/wKOnnr0AzZZAGek/z
         wzczSEZ8jQqeHIPV3DxztL37Nh0t1DtDNWzXbvYoe0gsrPCtMKU2lZ4BYOuZ1J+wyU2c
         VzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532242; x=1709137042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSRdTUORIP3JPrt7kN1tEQGw0K12XfL4OvvkueI/BL4=;
        b=pir0VExtq1PdtIwquTxadjQFaGcDgY6t4c+i98ynOwm4ldbe5D4e6Jt6J/ogjUbC9O
         1W+kQ6AegQdbpXKHRD082z+a9w7plDnEe18JAQNlscqnX5oVjhTXJQwE3K+G2WbxIIUO
         FeieQh0mUR5hYruaT2CVYjmJ9Ss7A1O8BZViaITEScWBPCQF3ul+qeiP7H7KiHpubxEV
         OivCP/MYK5Aq6OTD2y0EmLaemTxeafiHJUTVZc3bhnba28mFy4rpTr4cS7YqMIuZ03tn
         4Xxpr39/YBmYzbUN5iu6cyp2dT3W6RODUrjVDhxlA5neLLHmAvuEJOFLT2/s/XB0IHnL
         fusg==
X-Forwarded-Encrypted: i=1; AJvYcCWhcNDKmK3otzJmHn/g6GpaTdUJfz+z7FHdhtrP2t4vuwqFsPy5hvv2FPPKmTMmy2WpIl8sBWlEECNX29Db1rZBmilsBBI=
X-Gm-Message-State: AOJu0YxMK1QatbB8NcVsSvtVX2H4zl0J8ObVx1BPlKNdztiQlBtEB9gC
	NeyR1sbxXWsw9lQq+BSp9a/P2ET+P87vsX1vTMfhpKTmet6CYyAl50OlbgG+dAaGyu7gO9kfmSM
	TV7F5B0x6nRNbYhFd1gDFQjWOUBp1I5hCsx+0LA==
X-Google-Smtp-Source: AGHT+IEAPcKs9cACBOi8r1qIxX65sNThq1I+8at14ElsSzJt2HeQxDAK+upl9KCdTVvkGPrjF+VdX67GjanquSArscg=
X-Received: by 2002:a2e:9f44:0:b0:2d2:2e1d:651b with SMTP id
 v4-20020a2e9f44000000b002d22e1d651bmr7799978ljk.29.1708532242159; Wed, 21 Feb
 2024 08:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221110658.529-1-zhangfei.gao@linaro.org> <20240221131725.GR13330@nvidia.com>
In-Reply-To: <20240221131725.GR13330@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 22 Feb 2024 00:17:10 +0800
Message-ID: <CABQgh9Ha6C=Ej7Z2Md3v5Q6iXPKHsz+yQ2G_-oOaotVuVi8Hmg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Fix iommu_sva_bind_device to the same domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, baolu.lu@linux.intel.com, 
	"Zhang, Tina" <tina.zhang@intel.com>, kevin.tian@intel.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 21:17, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Feb 21, 2024 at 11:06:58AM +0000, Zhangfei Gao wrote:
> > The accelerator device can provide multi-queue and bind to
> > the same domain in multi-thread for better performance,
> > and domain refcount takes care of it.
> >
> > 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > removes the possibility, so fix it
> >
> > Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> > v2: Instead of checking ret == -EBUSY,
> >     change iommu_attach_device_pasid return value from -EBUSY to 0
> >     when pasid entry is found, and refcount++ when return
> >
> >  drivers/iommu/iommu-sva.c | 2 +-
> >  drivers/iommu/iommu.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c3fc9201d0be..20b232c7675d 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> >       struct device *dev = handle->dev;
> >
> >       mutex_lock(&iommu_sva_lock);
> > -     iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> >       if (--domain->users == 0) {
> > +             iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> >               list_del(&domain->next);
> >               iommu_domain_free(domain);
> >       }
>
> The users refcount is not to provide for sharing of the same PASID it
> is to provide for sharing the domain across devices. This change would
> break that because we loose the 'dev' that needs to be detached in a
> multi-device case if we don't immediately call detach_device_pasid
> here.
>
> You'd need to build something much more complicated here to allow
> PASID sharing.
>
> I wonder if this case is common enough to warrant the core code to get
> involved. I suppose maybe, does idxd have the same problem? It can
> only open it's cdev once because of this - that doesn't seem like what
> the code intends for a non-wq_dedicated?
>
> More like this:

Hi, Jason

Only added two lines change, and tested ok.
The different with before is same handle is returned, and the handle
itself has refcount.
While before different handle is returned,
Not think about any issue now, I think it is OK.

Could you send the patch, will add tested-by then.

>
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c3fc9201d0be97..aec11e5cde6b0e 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -41,6 +41,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>         }
>         iommu_mm->pasid = pasid;
>         INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +       INIT_LIST_HEAD(&iommu_mm->sva_handles);
>         /*
>          * Make sure the write to mm->iommu_mm is not reordered in front of
>          * initialization to iommu_mm fields. If it does, readers may see a
> @@ -82,6 +83,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>                 goto out_unlock;
>         }
>
> +       list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
> +               if (handle->dev == dev && handle->domain->mm == mm) {
> +                       refcount_inc(&handle->users);

mutex_unlock(&iommu_sva_lock);


> +                       return handle;
> +               }
> +       }
> +
>         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>         if (!handle) {
>                 ret = -ENOMEM;
> @@ -109,6 +117,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>                 goto out_free_domain;
>         domain->users = 1;

 refcount_set(&handle->users, 1);


>         list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +       list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
>
>  out:
>         mutex_unlock(&iommu_sva_lock);
> @@ -141,6 +150,12 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>         struct device *dev = handle->dev;
>
>         mutex_lock(&iommu_sva_lock);
> +       if (!refcount_dec_and_test(&handle->users)) {
> +               mutex_unlock(&iommu_sva_lock);
> +               return;
> +       }
> +       list_del(&handle->handle_item);
> +
>         iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>         if (--domain->users == 0) {
>                 list_del(&domain->next);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1ea2a820e1eb03..5e27cb3a3be99b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -892,11 +892,14 @@ struct iommu_fwspec {
>  struct iommu_sva {
>         struct device                   *dev;
>         struct iommu_domain             *domain;
> +       struct list_head                handle_item;
> +       refcount_t                      users;
>  };
>
>  struct iommu_mm_data {
>         u32                     pasid;
>         struct list_head        sva_domains;
> +       struct list_head        sva_handles;
>  };
>
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,

Thanks
