Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A5145B16
	for <iommu@lists.linux.dev>; Sat, 12 Oct 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728296; cv=none; b=lOyIbFOVIhslPDk59NU0tvCdvUkY2obknYjMBFjSICtJekD183XMCIlEa4QojmW7P+EP7bljyPsWWY3daQxaE7wcrkkZgSBP8ui4lLaUz7KnA/UkWSeiE7dX0V+equqQtNHmZ9G11ijTt2XMfkw8tBL/Mvl+38gA49j1wVPAFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728296; c=relaxed/simple;
	bh=suB/gvK3RVIdTIVj3t4mfWLPv0ww9krbFp7E65wTf2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYx21+P2UWqDCEMvNCRm3dI9b0yB4xH1STQVdtr6dBj4cNdJXuua4lRNsh8BZ6E8rutfCRR0BYidfkXnTqEyaTxVhIUS8EXB+YGQCs3cfHaLHYtdP5M5NmQO6IJmPNzAQ7VFw5Gk9RIarfTfu4oOoW/YC2qbkUxx8cp5083zo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UnTjxjDD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnTjxjDD"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so3391451e87.1
        for <iommu@lists.linux.dev>; Sat, 12 Oct 2024 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728728293; x=1729333093; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqMjcC1AHeZ0rlGgmH16x4sW7vgPdZLOnPDdmB4aH0c=;
        b=UnTjxjDDjCalTOTXYk96NR76Od3gbv5xd13rfryjILHMEE4nrBux/Q881K5JtuBai7
         s2CiXKIwIkCeGUxU3V2BCBfoRqnBmGITaeE6PUcTeeenOJxTkks1vKMAeZYtklpiUcJd
         3UDte0NdO8hmlEtMtjhYbI/HT+L+cPF1pN/tHGAvIzSRL4VqAa8mPfQSF+nUK/fkWx56
         dDkT8+VOU4wLTqr6GRK/kogyfYHM8NMrr0zz39U3mniE5BqBdTXTTCnBtagrPExL+ujd
         Q7j5b4BANjZRVCQSWvn2XmTu85w/wBfAuFdZKxnLZL4wIh45JbFMtw9o6PkDANyQKYq3
         uiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728293; x=1729333093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqMjcC1AHeZ0rlGgmH16x4sW7vgPdZLOnPDdmB4aH0c=;
        b=Lj6eYEKx4x5Ct4GFgLcuT/YnvpfdQE9/yagYFeeSdWKn+D4zKA27ixfxkCHEez11QU
         BkblxmbkIWUyXkQrPFeklHaIxDiVKHr2u0okt0IHtzhRyMYycmoXlpxCG+f2MFDbwvNR
         HkNZg2u/DsfzI9bQyOSopJK+Sf2i4xQCpA2tPmoQjzie/lI0dfXvyLG0dH8qGrOjkU4n
         i2dshac0vVELCf6gUUGjtS8ZvbJPWf358G0bwfNF3IhbLayxCjrrYy6UIPVhxJAKWNWq
         dnwMGK4gMy8+uBAUy9ZFfXVBEJ6qyr7RfGdQ8/WfLPlra9X0QPA+0R8HnRZGURIa9p7j
         LGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbq3fUb3p6WgQo+thy/nblYvlbZsw3O6ZYnmCEL5OV4zJnbT/sSBkEYd3yRCuffbqIkZD02Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdRZq4lT3xspGmD07flTVjqJDM4ITcJWeWUFJpE9s3cw4jCj+5
	J4Y7ddbNjNTcUD3et6SL71oRfWa7wJfeq/LrJ74oEv7eB46hR+zOCdmT9zmJ38VmXj0BmKY8xLN
	wOq+I7TBGl4j1rVKF3rDbUxeNsGBTjSs50yHJmQ==
X-Google-Smtp-Source: AGHT+IGKwx5nKYmIdfK4265lwZmlfRajEDE6ymLUhhDbGn/6VtvHNpCQcZb2C0Db73mm6sCx/G3nlJDjNP9fje8CkFg=
X-Received: by 2002:a05:6512:b9e:b0:52e:fa6b:e54a with SMTP id
 2adb3069b0e04-539da4d53femr2076954e87.30.1728728292983; Sat, 12 Oct 2024
 03:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com> <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
In-Reply-To: <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 18:18:01 +0800
Message-ID: <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 12:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
>
> > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > new file mode 100644
> > > index 000000000000..c1731f080d6b
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > > @@ -0,0 +1,57 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > + */
> > > +
> > > +#include "iommufd_private.h"
> > > +
> > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > +                                               size_t size,
> > > +                                               enum iommufd_object_type type)
> > > +{
> > > +       struct iommufd_object *obj;
> > > +       int rc;
> > > +
> > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > +       if (!obj)
> > > +               return ERR_PTR(-ENOMEM);
> > > +       obj->type = type;
> > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > +       refcount_set(&obj->shortterm_users, 1);
> > > +       refcount_set(&obj->users, 1);
> >
> > here set refcont 1
> >
> > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > refcount_inc(&idev->obj.users); refcount -> 2
> > will cause iommufd_device_unbind fail.
> >
> > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
>
> Hmm, why would it fail? Or is it failing on your system?

Not sure, still in check, it may only be on my platform.

it hit
iommufd_object_remove:
if (WARN_ON(obj != to_destroy))

iommufd_device_bind refcount=2
iommufd_device_attach refcount=3
//still not sure which operation inc the count?
iommufd_device_detach refcount=4

Thanks



>
> This patch doesn't change the function but only moved it..
>
> Thanks
> Nicolin
