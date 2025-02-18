Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E428FD
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739859241; cv=none; b=ukC6qJ/8L++w5aNgBup1PiEYzNPUCLy3hZ593KRIw/kKjJIW9t1c0OREmegeWfH7xMV6snZgMJklD5U0tv2P1Zjy/xkQ/spT5FokQpHv0C9JpdsqAhl/j7EHClQ+d/5gkN2LgXg7Q2TPoK+u+9/+2R2DOBvdJNbCvSj4uNf/GEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739859241; c=relaxed/simple;
	bh=hVcy4H2IEVB+XHFMWtYRRE56ZgToGhgyvhsDwymurh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDDvdV3pfbUMNvY+Nu8vj8X8e0wyGE2u1Uk4my/hiBw1bbJEYtKBI0fCkaZBSpGyoiwxW7uyk5QtkTntNUb5Zu9WFD4Wbo7XLHDJJ2npxonsUtHZeRW2rNp4kbrkj6xbqXvfxkP3JSurXBP78PUz/hSKkRARdKnLRFFnE2PDa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1sKSYPf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1sKSYPf"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1976718e87.2
        for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 22:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739859238; x=1740464038; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEc4icc+V5ZPPfKvc/Cq3TepJhiS7Md9sMuuln31gC4=;
        b=C1sKSYPfNzkEbjoHzKKjNZeSa+pRgbN4l5kuLHKfUa4tjdoyBn70QC8kT+fpG1MbKo
         ChY4ghIH3Msdbxd0PR3NjJu8D+KgACFvxN6xUIBg1pGgiccJxlanre/b4V/jVYRyw0fP
         tz5YjxnvoJ9cZ/3Mw4Y2WzE1MbgIs4gUMmgdBtxRC4Dxitnu79bpo1dEW1zg7kZMQhmV
         pitPDla/RDUZtcud9fAFkCIjIHDKF3/DTsrgk+BFx7PXu6OuQPG4BbOvw+kpOADk2X4V
         6e+JDNhP36PO9dCJYYHCasoM0sQw7v1qTaSYxi0UT/DdDkBu8X7LQRxJozGqrgp3Jvr6
         bh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739859238; x=1740464038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEc4icc+V5ZPPfKvc/Cq3TepJhiS7Md9sMuuln31gC4=;
        b=w0JDe2+LfroqW2j7agzwdoDAzdwc82XnBAfc7c0o1D6y7Z+gD0pGu/ExNBc/IFhmGB
         MdW6MdNm85sfzBA57jDYx07NVdlwMMAU0VILYFKb44fvbMNE1S+g0nWb2GzG+dwzCD6d
         7yIKsojWa5t9EOz31IYoByWjd8+cw4lCHoJ91dEI8lD5lEteGDcGY19JwLSJzfxwryFU
         2tiWad6LR8RPsQd47uq0boLQBxzO29Eupn/DAcOnsg7gc0W43HJFef8TWM3bRuKho+Sh
         0gfDJDHfI+AG6XzPmianeSgdPq7g+PvpHv+rWW4y24RTyIVwaFgI8HzAGXsLDYkjtkTj
         W2LA==
X-Forwarded-Encrypted: i=1; AJvYcCU/JPubnmObDfSsyA4fzcPeN+t7lbWjyenHWDMhd3obTn176MZ53Z46Hlk9P8QsKqTmBc7n5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLnwdeAxaWUaB6uLOC7rDB5exV/9wzG9mPcWYdK9EVl6mTwVbX
	jY6x9OBh7G/gqt75CKHa2hIgv8VtS0JAhcFnYL3lya+5yo7Tvy0hbwvgQj8d7gfn9wtVs3GHG7X
	51fKe3QP8CAftABvUw/m/efYPhECAsyi9ayrTQA==
X-Gm-Gg: ASbGncsvEI4CdELcmUBzUraGzges3lYaspdA0AaNvpHpqpFDPQiyO0qinfnz2gfnt+X
	XYdsXv7OSldJaYQI9VgJ8PB2F3YcZTDA1CXGw5Kc7VG0mTmjxJvt8DEHm7U/2zosAI7lztf8Xf4
	Y8rA==
X-Google-Smtp-Source: AGHT+IGBnxV3A4fhFUnb/sWJwgjsPIGI3fMQv4R99e7iyC/siM8fZi3MPJJb3XWXEOOrUXjgAuq2qG6TbZLfomOye2s=
X-Received: by 2002:a05:6512:238a:b0:544:fd8:7911 with SMTP id
 2adb3069b0e04-5452fe5809dmr4413315e87.21.1739859237942; Mon, 17 Feb 2025
 22:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca> <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com> <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
In-Reply-To: <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 18 Feb 2025 14:13:46 +0800
X-Gm-Features: AWEUYZl1Rez6pOagZuYfJjoOHu3GPR0mT83Dre02yBKbeel0GOt3_-q28p2n_SQ
Message-ID: <CABQgh9H8KOr9M6pBgtC=zT_buuc+qWZc8345Qd8sZVqsLmiFNw@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 11:00, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2/15/25 19:35, Zhangfei Gao wrote:
> > On Sat, 15 Feb 2025 at 18:09, Baolu Lu<baolu.lu@linux.intel.com> wrote:
> >> On 2/15/25 16:11, Zhangfei Gao wrote:
> >>> It does not relate to multi devices, one device also happens when user
> >>> page fault triggers.
> >>>
> >>> iopf_queue_remove_device is called.
> >>> rcu_assign_pointer(param->fault_param, NULL);
> >>>
> >>> call trace
> >>> [  304.961312] Call trace:
> >>> [  304.961314]  show_stack+0x20/0x38 (C)
> >>> [  304.961319]  dump_stack_lvl+0xc0/0xd0
> >>> [  304.961324]  dump_stack+0x18/0x28
> >>> [  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
> >>> [  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
> >>> [  304.961336]  arm_smmu_attach_commit+0x64/0x100
> >>> [  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
> >>> [  304.961340]  __iommu_attach_device+0x2c/0x110
> >>> [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> >>> [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> >>> [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> >>> [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> >>> [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> >>> [  304.961355]  iommufd_device_change_pt+0x270/0x688
> >>> [  304.961357]  iommufd_device_replace+0x20/0x38
> >>> [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> >>> [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> >>> [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> >>>
> >>>
> >>> When page fault triggers:
> >>>
> >>> [ 1016.383578] ------------[ cut here ]-----------
> >>> [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> >>> drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
> >> It's likely that iopf_queue_add_device() was not called for this device.
> > iopf_queue_add_device is called, but quickly iopf_queue_remove_device
> > is called during guest bootup.
> > Then fault_param is set to NULL.
> >
> > arm_smmu_attach_commit
> > arm_smmu_remove_master_domain
> > // newly added in the first patch
> >         if (master_domain) {
> >                    if (master_domain->using_iopf)
>
> It seems the above check is incorrect. We only need to disable iopf when
> an iopf-capable domain is about to be removed. Will the following
> additional change make any difference?
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 28e67a9e3861..9b9ef738d070 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2822,7 +2822,7 @@ static void arm_smmu_remove_master_domain(struct
> arm_smmu_master *master,
>          spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>
>          if (master_domain) {
> -               if (master_domain->using_iopf)
> +               if (domain->iopf_handler)
>                          arm_smmu_disable_iopf(master);
>                  kfree(master_domain);
>          }

Yes, good idea, using this can solve the issue.

Thanks
