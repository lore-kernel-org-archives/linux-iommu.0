Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137714A94
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 02:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569517; cv=none; b=XQtW9SOYGirskCRBr5Q+T1WP78RyTSbNdRezqoPBkPCtW1pE+lEk5G6S37NTwwZzxsU6SBwzTTNDlc7w8t4PYgCrIO2zVAfv9eZHlk1PhxZ3wjulOFgOyivSD11vvXRxr8p1EwPA+PLTjb73qhxWqeSkDTPsBdprDSoIKszGKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569517; c=relaxed/simple;
	bh=bol1OGOngLrnY2UX2bViq+wywxl3J7FoZal7fVc+BhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jrid9pIY8WJ1zvsr8tSNZvHkHK0w1bZZz2bt9U5SvusyKGJuKllIvThZ+y6RzZ3D5A6ReFkqUvKUrhLKpZvVYeIPwOBcsgpLKp840vs/9Rlk7oBZq4EXwI0eudq3mgkNEDrAJ9YYTO+SQzrMKP0iacybT9cROHhQzpEuT2aF26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7oLxhFv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7oLxhFv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42e2507c6e1so90021cf.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 18:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708569514; x=1709174314; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpTCkm3CX5PXc96PIxYgipMqzqlj7oekjyp+AyYtxnk=;
        b=c7oLxhFva5C0vUh5IucoWusulBiyvbE535tB505EbBbRmt791wJg+DvC/K6oPGfaDC
         0LlG0mT8ZavM2lTcI9oVUOsLk9g2sc9X+vcxmB3stbLxyIuMUjvhaFR6yuSZdxqMbUtR
         3PndjNY3wlLXXW1A05Wb6P5en0UFVtDXivoHkqgoUwK95+aEwL6+2dyEVFTyWDgQsh7j
         yuiBRAG1FvpMd/mnKSpueu/1l7Z/Hx8RSHW0/7Z46YET+CXTvPWC4UtEKnELMxvHatvF
         x2WP9kXHLy8c3fN9sDcUwi8AJfQ6AsOn1FxaE8rEDSnNcXQyRptAYm6EV9+YXkM+93g0
         44Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569514; x=1709174314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpTCkm3CX5PXc96PIxYgipMqzqlj7oekjyp+AyYtxnk=;
        b=Skq8MnCfAoooNCMzQOqPSNlYNWaJ6Oy1z944MuRJQ/Qs3wHl24iQf1HVVL8I/YCoUQ
         z6WvXAnuHLAyAnA/X8lrtRysk6rk0cpba2jmmx7QI4B7Z0SZGiekhOT1trUuPIjUsgIu
         nY3CSJWz5KPEYjQfNDQWFmLIv8NV4zuez8qPR6F6aFyR2DqJfJBTzCBN09wnk0kSmcA0
         09eyfdbL/L4fk5/77olhoEdHfiQrTpHC4elr7Uk0+WwxUgMij5+MBL/202vhcU06vqb6
         SVrYGKzgaJkpqBw+bJf4DxaEwaAv34KB73OY/9MUWfRfMHzYOvcc9FW1wic3+OY/irli
         vlPQ==
X-Gm-Message-State: AOJu0YxOGotf8Jyz1IhYLik9hNH9kjNa1RF/Qro/9+Bv4gYuj1lmPyfw
	Ks6qqGSkm2br5KsjV7bPYZlWjdsC54D8VpbptilMtut8iQvo/45oXAUPAIYTg+qrD2BPqWp/R8d
	z5MaLTOu+vvtPjw6K/5FA5JxnP7MrenHJUSXwXjQcDskECGKbz+gP
X-Google-Smtp-Source: AGHT+IFmMszaHy2M3FCsvRukDYUmIRAZKB1sYbS2/1eLvF+5wORRZDR4yENK3bsd8ThmIM108TKNw0I0wE58Gx4ulUg=
X-Received: by 2002:ac8:705:0:b0:42e:4b7c:d82d with SMTP id
 g5-20020ac80705000000b0042e4b7cd82dmr69526qth.2.1708569513868; Wed, 21 Feb
 2024 18:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v3-11978fc67151+112-smmu_cd_atomic_jgg@nvidia.com>
In-Reply-To: <0-v3-11978fc67151+112-smmu_cd_atomic_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 22 Feb 2024 10:37:56 +0800
Message-ID: <CAKHBV24y8p49cPJQhwDpRu0NYw74SjNCJo9MohwQ35NUJL92mg@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 8:27=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> If the SMMU is configured to use a two level CD table then
> arm_smmu_write_ctx_desc() allocates a CD table leaf internally using
> GFP_KERNEL. Due to recent changes this is being done under a spinlock to
> iterate over the device list - thus it will trigger a sleeping while
> atomic warning:
>
>   arm_smmu_sva_set_dev_pasid()
>     mutex_lock(&sva_lock);
>     __arm_smmu_sva_bind()
>      arm_smmu_mmu_notifier_get()
>       spin_lock_irqsave()
>       arm_smmu_write_ctx_desc()
>         arm_smmu_get_cd_ptr()
>          arm_smmu_alloc_cd_leaf_table()
>           dmam_alloc_coherent(GFP_KERNEL)
>
> This is a 64K high order allocation and really should not be done
> atomically.
>
> At the moment the rework of the SVA to follow the new API is half
> finished. Recently the CD table memory was moved from the domain to the
> master, however we have the confusing situation where the SVA code is
> wrongly using the RID domains device's list to track which CD tables the
> SVA is installed in.
>
> Remove the logic to replicate the CD across all the domain's masters
> during attach. We know which master and which CD table the PASID should b=
e
> installed in.
>
> Right now SVA only works when dma-iommu.c is in control of the RID
> translation, which means we have a single iommu_domain shared across the
> entire group and that iommu_domain is not shared outside the group.
>
> Critically this means that the iommu_group->devices list and RID's
> smmu_domain->devices list describe the same set of masters.
>
> For PCI cases the core code also insists on singleton groups so there is
> only one entry in the smmu_domain->devices list that is equal to the
> master being passed in to arm_smmu_sva_set_dev_pasid().
>
> Only non-PCI cases may have multi-device groups. However, the core code
> will repeat the calls to arm_smmu_sva_set_dev_pasid() across the entire
> iommu_group->devices list.
>
> Instead of having arm_smmu_mmu_notifier_get() indirectly loop over all th=
e
> devices in the group via the RID's smmu_domain, rely on
> __arm_smmu_sva_bind() to be called for each device in the group and
> install the repeated CD entry that way.
>
> This avoids taking the spinlock to access the devices list and permits th=
e
> arm_smmu_write_ctx_desc() to use a sleeping allocation. Leave the
> arm_smmu_mm_release() as a confusing situation, this requires tracking
> attached masters inside the SVA domain.
>
> Removing the loop allows arm_smmu_write_ctx_desc() to be called outside
> the spinlock and thus is safe to use GFP_KERNEL.
>
> Move the clearing of the CD into arm_smmu_sva_remove_dev_pasid() so that
> arm_smmu_mmu_notifier_get/put() remain paired functions.
>
> Fixes: 24503148c545 ("iommu/arm-smmu-v3: Refactor write_ctx_desc")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/4e25d161-0cf8-4050-9aa3-dfa21cd63e56@=
moroto.mountain/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 38 ++++++-------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
>
> I suggest taking these two patches as well which will further help this c=
ode:
>
> https://lore.kernel.org/linux-iommu/12-v5-cd1be8dd9c71+3fa-smmuv3_newapi_=
p1_jgg@nvidia.com/
> https://lore.kernel.org/linux-iommu/2-v4-e7091cdd9e8d+43b1-smmuv3_newapi_=
p2_jgg@nvidia.com/
>
> Michael should check it, and Nicolin or Shameer should do a quick sanity =
check
> on their SVA HW.
>
> v3:
>   - Pull arm_smmu_write_ctx_desc() up into __arm_smmu_sva_bind() and
>     arm_smmu_sva_remove_dev_pasid() to avoid the early exit in
>     arm_smmu_mmu_notifier_get()
> v2: https://lore.kernel.org/all/0-v2-7988c2682634+261-smmu_cd_atomic_jgg@=
nvidia.com/
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 05722121f00e70..4a27fbdb2d8446 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -292,10 +292,8 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *sm=
mu_domain,
>                           struct mm_struct *mm)
>  {
>         int ret;
> -       unsigned long flags;
>         struct arm_smmu_ctx_desc *cd;
>         struct arm_smmu_mmu_notifier *smmu_mn;
> -       struct arm_smmu_master *master;
>
>         list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
>                 if (smmu_mn->mn.mm =3D=3D mm) {
> @@ -325,28 +323,9 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *sm=
mu_domain,
>                 goto err_free_cd;
>         }
>
> -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -       list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> -               ret =3D arm_smmu_write_ctx_desc(master, mm_get_enqcmd_pas=
id(mm),
> -                                             cd);
> -               if (ret) {
> -                       list_for_each_entry_from_reverse(
> -                               master, &smmu_domain->devices, domain_hea=
d)
> -                               arm_smmu_write_ctx_desc(
> -                                       master, mm_get_enqcmd_pasid(mm), =
NULL);
> -                       break;
> -               }
> -       }
> -       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> -       if (ret)
> -               goto err_put_notifier;
> -
>         list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
>         return smmu_mn;
>
> -err_put_notifier:
> -       /* Frees smmu_mn */
> -       mmu_notifier_put(&smmu_mn->mn);
>  err_free_cd:
>         arm_smmu_free_shared_cd(cd);
>         return ERR_PTR(ret);
> @@ -363,9 +342,6 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu=
_mmu_notifier *smmu_mn)
>
>         list_del(&smmu_mn->list);
>
> -       arm_smmu_update_ctx_desc_devices(smmu_domain, mm_get_enqcmd_pasid=
(mm),
> -                                        NULL);
> -
>         /*
>          * If we went through clear(), we've already invalidated, and no
>          * new TLB entry can have been formed.
> @@ -381,7 +357,8 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu=
_mmu_notifier *smmu_mn)
>         arm_smmu_free_shared_cd(cd);
>  }
>
> -static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
> +static int __arm_smmu_sva_bind(struct device *dev, ioasid_t pasid,
> +                              struct mm_struct *mm)
>  {
>         int ret;
>         struct arm_smmu_bond *bond;
> @@ -404,9 +381,15 @@ static int __arm_smmu_sva_bind(struct device *dev, s=
truct mm_struct *mm)
>                 goto err_free_bond;
>         }
>
> +       ret =3D arm_smmu_write_ctx_desc(master, pasid, bond->smmu_mn->cd)=
;
> +       if (ret)
> +               goto err_put_notifier;
> +
>         list_add(&bond->list, &master->bonds);
>         return 0;
>
> +err_put_notifier:
> +       arm_smmu_mmu_notifier_put(bond->smmu_mn);
>  err_free_bond:
>         kfree(bond);
>         return ret;
> @@ -568,6 +551,9 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domai=
n *domain,
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>
>         mutex_lock(&sva_lock);
> +
> +       arm_smmu_write_ctx_desc(master, id, NULL);
> +
>         list_for_each_entry(t, &master->bonds, list) {
>                 if (t->mm =3D=3D mm) {
>                         bond =3D t;
> @@ -590,7 +576,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_do=
main *domain,
>         struct mm_struct *mm =3D domain->mm;
>
>         mutex_lock(&sva_lock);
> -       ret =3D __arm_smmu_sva_bind(dev, mm);
> +       ret =3D __arm_smmu_sva_bind(dev, id, mm);
>         mutex_unlock(&sva_lock);
>
>         return ret;
>
> base-commit: c76c50cd425e574df5a071cd7e1805d0764aabff
> --
> 2.43.2
>
Reviewed-by: Michael Shavit <mshavit@google.com>
