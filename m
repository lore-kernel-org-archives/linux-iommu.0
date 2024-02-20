Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6D67C4D
	for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446432; cv=none; b=pE9g8c5wY8xoHcoDnq2MAAgpdcswYDVuVxjUnsoTdHbVGW9QX4REzriJU/s1Cwq3rZoITsR1Tjpu7LZkZ/DZ7268LzGEwEN96gp4r24cgXwGgAHSTbCYhfyzStgUz14a4lX5F2OmOlj7yoxkTp1b+5CPOibXKi/+gNo1Ch1MjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446432; c=relaxed/simple;
	bh=mGTXaZNNbdb3/xwmUtLv4oUiJfbUgvqfyphMUdqUELc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6vN4oxDZOiJET497T/3RQ6zLx5ftmDTxo45rKrmefR0EHaEJ+Tz6SrdsaatmyRt6NKN4IJcFNcEn1cL5haLttVFDqRjXtBzhFw8bhLIK/OVKArzck1VeIU8Agw6bL4Gvj9g4ZftOtvPJtILnfe0yzHw1Lm2NrVJR8jKfL9SXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tsfqDdfe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsfqDdfe"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512cca90f38so460567e87.2
        for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708446428; x=1709051228; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GoTG41kI5OtRvDaPRyIcuGxljet2n6lqDoeB3uJInM=;
        b=tsfqDdfebehGjv+MaxSHa3kicU3cT9Ya31oJCJ3Pe1qiddhsCXk6RP2HBvs+adiE9M
         NTaoJ6vzE+YgE+DX2AmL/lVVaM/BsUxfwLYjSnWnxSD/PNybEhcO24coOdJL8Tg/9dYz
         sQrjcexqAKURnYGLgL8SgvjHTlg+LkTUUL/hoqBrwx8h6Rsxe67Sp3z6/6/9o6lZKgG4
         cpBqS/esg7HX/H9wP4ubwcKy355btijefjkYLFbacTd8zbZxlnJOiiQ39Xmlp4xhdIdh
         xc61FrCykpRBgHgv/j4Jn8BoJnCqawN/q31UmJpN6e+bCUY0pVy/2SF9N4bqjzVoktuw
         62pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446428; x=1709051228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GoTG41kI5OtRvDaPRyIcuGxljet2n6lqDoeB3uJInM=;
        b=CEvriJL1vNOLixVYoz5a+7n56vuv5XAuutFG8Hjofo53+LNQk2aBKbuZIOnGswBDu4
         5kDrZoUGx754E5jFYXhnzAkH7sf87oKQWOeMxmrpTA3/NjIO59/+Fd1NfY+bs43Gmsjl
         TT6i7DvQu8dzOUAFZZ70JcAbGdESicx1ubiN8VFM+simyzzFK7dUhETqc2aWrCvUBuvW
         QdM2kQ3nDoIXU53jpTb3jBegRdriCrjk0N4kN4P4/i5RDXHzV+eZIgq03SGWRXfo/kx+
         IqxpGYUjpvywVBLrya38IX84j26swv8yl2VDFpwnKbih6c7UTnRMRzy8Bridi4uS7lGX
         LEoQ==
X-Gm-Message-State: AOJu0YzlhbzsiS131zgS63GhBGeBvNR4DEoekzvwVno6G4uskyTbiOb/
	kGm0cszgPkRmr6Xht6jgafmV5XkJyhtE1AfdoJslWD/XnZr1bMgDegxhi+ZnWJXA5K1M8xABX/3
	GVuO2/DJeOy2H2MTVS/PD38lNBzc0hfMoUd0nKw==
X-Google-Smtp-Source: AGHT+IEFePdHyB4lIz2wmU3Z2bj7F0YcGOkBh0oWxNDx7e4zJcf1y7GqHGBsRQjK+NcqyJXVqdo1IBFokFWvAC+Y484=
X-Received: by 2002:ac2:4885:0:b0:512:be41:146f with SMTP id
 x5-20020ac24885000000b00512be41146fmr2514899lfc.68.1708446427913; Tue, 20 Feb
 2024 08:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com> <20231027000525.1278806-6-tina.zhang@intel.com>
In-Reply-To: <20231027000525.1278806-6-tina.zhang@intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 00:26:56 +0800
Message-ID: <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Tina

On Fri, 27 Oct 2023 at 08:06, Tina Zhang <tina.zhang@intel.com> wrote:
>
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()). However, although sva domains and their
> PASID are separate objects such that their own life cycles could be
> handled independently, an enqcmd use case may require releasing the
> PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
> will be permanently used by the mm and won't be released until the end
> of mm) and only allows to drop the PASID after the sva domains are
> released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
> increment the mm reference count and mmdrop() is invoked in
> iommu_domain_free() to decrement the mm reference count.
>
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
>
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu-sva.c | 92 +++++++++++++++++++++++----------------
>  include/linux/iommu.h     | 23 ++++++++--
>  2 files changed, 74 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 4a2f5699747f..5175e8d85247 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -12,32 +12,42 @@
>  static DEFINE_MUTEX(iommu_sva_lock);
>
>  /* Allocate a PASID for the mm within range (inclusive) */
> -static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
> +static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
>  {
> +       struct iommu_mm_data *iommu_mm;
>         ioasid_t pasid;
> -       int ret = 0;
> +
> +       lockdep_assert_held(&iommu_sva_lock);
>
>         if (!arch_pgtable_dma_compat(mm))
> -               return -EBUSY;
> +               return ERR_PTR(-EBUSY);
>
> -       mutex_lock(&iommu_sva_lock);
> +       iommu_mm = mm->iommu_mm;
>         /* Is a PASID already associated with this mm? */
> -       if (mm_valid_pasid(mm)) {
> -               if (mm->pasid >= dev->iommu->max_pasids)
> -                       ret = -EOVERFLOW;
> -               goto out;
> +       if (iommu_mm) {
> +               if (iommu_mm->pasid >= dev->iommu->max_pasids)
> +                       return ERR_PTR(-EOVERFLOW);
> +               return iommu_mm;
>         }
>
> +       iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +       if (!iommu_mm)
> +               return ERR_PTR(-ENOMEM);
> +
>         pasid = iommu_alloc_global_pasid(dev);
>         if (pasid == IOMMU_PASID_INVALID) {
> -               ret = -ENOSPC;
> -               goto out;
> +               kfree(iommu_mm);
> +               return ERR_PTR(-ENOSPC);
>         }
> -       mm->pasid = pasid;
> -       ret = 0;
> -out:
> -       mutex_unlock(&iommu_sva_lock);
> -       return ret;
> +       iommu_mm->pasid = pasid;
> +       INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +       /*
> +        * Make sure the write to mm->iommu_mm is not reordered in front of
> +        * initialization to iommu_mm fields. If it does, readers may see a
> +        * valid iommu_mm with uninitialized values.
> +        */
> +       smp_store_release(&mm->iommu_mm, iommu_mm);
> +       return iommu_mm;
>  }
>
>  /**
> @@ -58,31 +68,33 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>   */
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>  {
> +       struct iommu_mm_data *iommu_mm;
>         struct iommu_domain *domain;
>         struct iommu_sva *handle;
>         int ret;
>
> +       mutex_lock(&iommu_sva_lock);
> +
>         /* Allocate mm->pasid if necessary. */
> -       ret = iommu_sva_alloc_pasid(mm, dev);
> -       if (ret)
> -               return ERR_PTR(ret);
> +       iommu_mm = iommu_alloc_mm_data(mm, dev);
> +       if (IS_ERR(iommu_mm)) {
> +               ret = PTR_ERR(iommu_mm);
> +               goto out_unlock;
> +       }
>
>         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -       if (!handle)
> -               return ERR_PTR(-ENOMEM);
> -
> -       mutex_lock(&iommu_sva_lock);
> -       /* Search for an existing domain. */
> -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> -                                               IOMMU_DOMAIN_SVA);
> -       if (IS_ERR(domain)) {
> -               ret = PTR_ERR(domain);
> +       if (!handle) {
> +               ret = -ENOMEM;
>                 goto out_unlock;
>         }
>
> -       if (domain) {
> -               domain->users++;
> -               goto out;

Our multi bind test case broke since 6.8-rc1.
The test case can use same domain & pasid, return different handle,
6.7 simply  domain->users ++ and return.

> +       /* Search for an existing domain. */
> +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
> +               ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);

Now iommu_attach_device_pasid return BUSY since the same pasid.
And then iommu_sva_bind_device attach ret=-16

> +               if (!ret) {

Simply tried if (!ret || ret == -EBUSY)
The test passes, but report waring
WARNING: CPU: 12 PID: 2992 at drivers/iommu/iommu.c:3591
iommu_detach_device_pasid+0xa4/0xd0

Will check more tomorrow.

> +                       domain->users++;
> +                       goto out;
> +               }
>         }
>

Thanks
