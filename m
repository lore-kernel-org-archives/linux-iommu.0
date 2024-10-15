Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1181339A0
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954916; cv=none; b=BW9FU0gQdsFnhYtooZ+GWQSlI5mzmtJ+LE21/WVQQ8PTodZUedygNU0uvFVSfopWQ5CnRaEe5j7vmq+vPbGYzJhx5BL6gGShTi2G6wyD0aNaDwjR6tYcOIBBMiU3neB17mNderl/mBavOq07lVAW32YUnXjdBmTsarpqHFxpuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954916; c=relaxed/simple;
	bh=VmIJJAlzoK1z0rLWIpaw1YVFnfXW8kC3N6Y88tJftIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnnMJkoiY2jHzQ4Alve+ydh3NrTLYDAUh/vxobyskcYwPo0ieQWnoIceAVgrc6Y8bQvWrJkAX2yEXeYUnXoDR4kw9OgVPaeqjP/jlg86sB72EXcwDGpNkCo8vID+YPM/sALV5+GVR+e5Mi6Fhk5aTYxY0aawflAHgr25K/aE9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qy3eBusA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qy3eBusA"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb51f39394so14515221fa.2
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 18:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728954913; x=1729559713; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PZfbOacTVFYAtWKdUgGZCPQ/VjhC7zekAmG2Zkwjm6E=;
        b=qy3eBusAH2M2IU52M7yyU910sX0rfOlh6bD9yrDcNfiUAZ5TLtd2ifVLOYlAAxXYrS
         7HeVFloC9HxrdRO2jQhSLJI0eJ1f9HwCZQtJmYlNmS+a8l0pJ1mUlb8IwXoMDuQPWmC3
         VMadjV2Itv8YB2XW6m+v5vxMauQoIQ5XhiRPhcM1DfnzpzyFtNhRFxNbN8SJpAFtaqWg
         Lh34VWzonqYx7ITUgytOh8vJABWpvusBgAtlr2YBjNVu03CgXR67TaB9mWNM7mytWSyB
         r2jQErl0Y+dOaPCvqIFWXlMP/sxPj1S3EIOpaTMg+Mowb4+qLSS7qJGNUp4BpApUuOFS
         SIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728954913; x=1729559713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZfbOacTVFYAtWKdUgGZCPQ/VjhC7zekAmG2Zkwjm6E=;
        b=RFLl4R8Ln5VavQ8uaIotPLXPzhPlNj+V+uX7h2hnbIIumko9ORQF4R0eSofF0J7zS+
         IWA3yg9J4CZyBju6Xz+iGlBaKZ6tcqUoc9cLoK9aZBcno169xaTmtnZIoQ6WYWaV94NF
         Mt5mndWv169arE7V9jMLc3/rbXXunkKeIgtDcH7RDK062grQiM1hb2h6lmSXpc+HLuW6
         Z/TfNWHYApP/NqKvW0PhHvtC1mgg4x5rd9Xjb2eRV/tckprIsFZ/SRP6Y7yw3Y2H7wGP
         PKhjU6OqXVsKTL9Uoji1DsZw6Yk/rY3EzGesVAbhzi7XQmlmmRB5/ReecMkrDtVlG9Ht
         yyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE/cIo377F6J2RdN77lN1gsBlxgd7tcJGb6XuoeuUn0iyk63WcKTmDgduKDfLlX4EECXwRJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5P9Cus4Mv37pnEx/Ud3rz2JH7Cy6yDeJ0vBT/gyhkJU/1SIMF
	iSp4AlHtgom1ZbXGPM7XfW2ijd5KDC8W138l5niEOdNjxBUi78zriNXeQsDK8PqoTNMYafMYcv9
	z/AuGnNuGGxQNzHgE4cg83+6H9TLg7fOmh8861Q==
X-Google-Smtp-Source: AGHT+IE+8vWuurPXcwjc4Qb36S9I2cqdLnqLWwDuqQ3mOIsAgMhAPNpNGg8vFkE/8QuW7+Qc2RZTy2+kJ/FG39bJ7V8=
X-Received: by 2002:a05:6512:1315:b0:52c:d819:517e with SMTP id
 2adb3069b0e04-539da4cd040mr6582201e87.30.1728954912628; Mon, 14 Oct 2024
 18:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com> <Zw08z9TOFL57z07O@Asurada-Nvidia>
In-Reply-To: <Zw08z9TOFL57z07O@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 15 Oct 2024 09:15:01 +0800
Message-ID: <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
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

On Mon, 14 Oct 2024 at 23:46, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Mon, Oct 14, 2024 at 03:58:55PM +0800, Zhangfei Gao wrote:
>
> > > > > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > > > > +                                               size_t size,
> > > > > > +                                               enum iommufd_object_type type)
> > > > > > +{
> > > > > > +       struct iommufd_object *obj;
> > > > > > +       int rc;
> > > > > > +
> > > > > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > > > > +       if (!obj)
> > > > > > +               return ERR_PTR(-ENOMEM);
> > > > > > +       obj->type = type;
> > > > > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > > > > +       refcount_set(&obj->shortterm_users, 1);
> > > > > > +       refcount_set(&obj->users, 1);
> > > > >
> > > > > here set refcont 1
> > > > >
> > > > > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > > > > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > > > > refcount_inc(&idev->obj.users); refcount -> 2
> > > > > will cause iommufd_device_unbind fail.
> > > > >
> > > > > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
> > > >
> > > > Hmm, why would it fail? Or is it failing on your system?
> > >
> > > Not sure, still in check, it may only be on my platform.
> > >
> > > it hit
> > > iommufd_object_remove:
> > > if (WARN_ON(obj != to_destroy))
> > >
> > > iommufd_device_bind refcount=2
> > > iommufd_device_attach refcount=3
> > > //still not sure which operation inc the count?
> > > iommufd_device_detach refcount=4
> > >
> >
> > Have a question,
> > when should iommufd_vdevice_destroy be called, before or after
> > iommufd_device_unbind.
>
> Before.
>
> > Now iommufd_vdevice_destroy (ref--) is after unbind, hits the if
> > (!refcount_dec_if_one(&obj->users)) check.
>
> Hmm, where do we have an iommufd_vdevice_destroy after unbind?

Looks like it is called by close fd?
[ 2480.909319]  iommufd_vdevice_destroy+0xdc/0x168
[ 2480.909324]  iommufd_fops_release+0xa4/0x140
[ 2480.909328]  __fput+0xd0/0x2e0
[ 2480.909331]  ____fput+0x1c/0x30
[ 2480.909333]  task_work_run+0x78/0xe0
[ 2480.909337]  do_exit+0x2fc/0xa50
[ 2480.909340]  do_group_exit+0x3c/0xa0
[ 2480.909344]  get_signal+0x96c/0x978
[ 2480.909346]  do_signal+0x94/0x3a8
[ 2480.909348]  do_notify_resume+0x100/0x190

>
> > iommufd_device_bind
> > iommufd_device_attach
> > iommufd_vdevice_alloc_ioctl
> >
> > iommufd_device_detach
> > iommufd_device_unbind // refcount check fail
> > iommufd_vdevice_destroy ref--
>
> Things should be symmetric. As you suspected, vdevice should be
> destroyed before iommufd_device_detach.

I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
this issue?
In checking whether close fd before unbind?

>
> A vdev is an object on top of a vIOMMU obj and an idev obj, so
> it takes a refcount from each of them. That's why idev couldn't
> unbind.

Thanks

>
> Thanks
> Nicolin
