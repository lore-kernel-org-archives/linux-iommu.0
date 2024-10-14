Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AEA14F10E
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892750; cv=none; b=SF1g+u61rE+oC47HgFnI/TvL7SjmJB2py8y+hxLVGJRfJGrhDD7+bYlBRnZb5aPsrg4DyP7oMPw83PZvFecCZonaun7fFshsnIq4GeQgx2w23aZg9I8NGEZFzz4pLiJxG2s/eZyDLurFgyHiOP+LHcuhpo3jB3LB6tdZmoplmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892750; c=relaxed/simple;
	bh=oFF6VHGttnHusqmr3FN2QG++jdlGO4+8p6CDui+ULbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAuG71dn2ouvqckI9U023uazDQ+D3D4dRfrkXn4X4vYgdLhekr/XtvUITDzPMFkt0kVJ3pxEbcZZrSZEY9MByKcKoAw0zy7ybpXrWNeinJSL9NeGh7hn+CxADMwLrXV9Zsg8I0cDwHao0qFWP3aNiFQKJTWyCHGB7e1UbRMQpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eDsSokh/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDsSokh/"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1486510e87.3
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728892747; x=1729497547; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScjclWrKfNDFbBysTklj+SJ3rFHMGEWxbh3si/BH/Zk=;
        b=eDsSokh/d3w9yHQ+Us/Fae7b7TtYJrLuJEbAD91QMBckEtBLvJ7e4BD+WYuOrcA8z7
         GJ8wYDUQGMJM28lrxa44TZTAosrPEMnla8c+mtbHxc0ZSsgRCy0dCwVt3qDwFSCuSIFR
         UzIpYg0OeWg3abxELeg6DaLOLnkOVgzd15Tmlgfv7cTBQXojS7YNkeQTq30uHBain2je
         q8idhRYTYi5hdPnCxA89E+GyE9icHH9l4CBzwiXMBJlsAyPEETezh8K0ICuUDIjMAg6w
         edo7UnbDpknmMnLWr/PHns37gGChpwFX3037yF/si3xAJrqYQgTtJtWbfBiOJoXAJvdZ
         1Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892747; x=1729497547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScjclWrKfNDFbBysTklj+SJ3rFHMGEWxbh3si/BH/Zk=;
        b=AQOb0IW5Uk33fpxvw2DEbvHql937gQ6A1flxCzn7brS+g1tRm8imwiBPHGVcDsODGf
         GBdgMlwkyzoM60ZCtVkOJOUTG2Y3rOxdCxij0C4qLvLZ5L7+2zvcTEoeqLqajsDa0T1E
         EoB0sIOEKrpNOjvnEVNSWDFr5nvvoyMZhkv/6rUJwpY/AgybGim1wUy/vxCgDhtioZrW
         +eLd6JffsXgnv5kJTcuMerQDBLvVcoWmpUl0EePDysS68f8yTeYfuDUjpqL8tBc8ssNZ
         cjChq+lZPS2rjjZt9AziyxXRhIgEin9FcLWoNgn7Gn6z2S8hWqJm9cxpMxf9b1vxVmYc
         wTEw==
X-Forwarded-Encrypted: i=1; AJvYcCVBWJiP2P2zx7KFZ0YlLvOBcPUazjwMMFBUexa97XgwucTx+JHelBDEm3NZeoDp6ziGEQg6GQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbqOtdjT4YxwgVL+rsHmwONBNG2DjenMer4G2f8O8xf5DbNDAp
	JpFVYCvF61EoavXxDMPaRNx1dgyR/NQDdmFzYI4HwjWuyleKN7+vqanls4neewvO/ySlOqy1MeL
	nrcp+WWmodohkWr4bB6ssWJ8DsmKBVE/pFQLUug==
X-Google-Smtp-Source: AGHT+IEKyEtol/S+SVKZojpSYhC7ViJe62dDg31X0hlm2J4WIW4keP+c77Z9R7yIc1BX887mjL23tAglKwfPJlsZKB8=
X-Received: by 2002:a05:6512:3e21:b0:539:ebb6:7b36 with SMTP id
 2adb3069b0e04-539ebb67d8cmr1600580e87.25.1728892746567; Mon, 14 Oct 2024
 00:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
In-Reply-To: <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 14 Oct 2024 15:58:55 +0800
Message-ID: <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
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

Hi, Nico

On Sat, 12 Oct 2024 at 18:18, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Sat, 12 Oct 2024 at 12:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
> >
> > > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > > new file mode 100644
> > > > index 000000000000..c1731f080d6b
> > > > --- /dev/null
> > > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > > + */
> > > > +
> > > > +#include "iommufd_private.h"
> > > > +
> > > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > > +                                               size_t size,
> > > > +                                               enum iommufd_object_type type)
> > > > +{
> > > > +       struct iommufd_object *obj;
> > > > +       int rc;
> > > > +
> > > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > > +       if (!obj)
> > > > +               return ERR_PTR(-ENOMEM);
> > > > +       obj->type = type;
> > > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > > +       refcount_set(&obj->shortterm_users, 1);
> > > > +       refcount_set(&obj->users, 1);
> > >
> > > here set refcont 1
> > >
> > > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > > refcount_inc(&idev->obj.users); refcount -> 2
> > > will cause iommufd_device_unbind fail.
> > >
> > > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
> >
> > Hmm, why would it fail? Or is it failing on your system?
>
> Not sure, still in check, it may only be on my platform.
>
> it hit
> iommufd_object_remove:
> if (WARN_ON(obj != to_destroy))
>
> iommufd_device_bind refcount=2
> iommufd_device_attach refcount=3
> //still not sure which operation inc the count?
> iommufd_device_detach refcount=4
>

Have a question,
when should iommufd_vdevice_destroy be called, before or after
iommufd_device_unbind.

Now iommufd_vdevice_destroy (ref--) is after unbind, hits the if
(!refcount_dec_if_one(&obj->users)) check.

iommufd_device_bind
iommufd_device_attach
iommufd_vdevice_alloc_ioctl

iommufd_device_detach
iommufd_device_unbind // refcount check fail
iommufd_vdevice_destroy ref--

Thanks
