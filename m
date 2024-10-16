Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46214A09E
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043827; cv=none; b=dC1d+UIHkLSqWVraHcq/kwYYpJTiX6BmbkIaBJ5FXIDel9aQ7nK8vLnpS/6fIV8G6HQZ1NjXjLcskg+iCzCsY4q89y9iWjhE4VGcSucGsD7lOInX8lXFB3BUTbcH0bVUj35QMWF/yLkRMsBLxI6x7Ny/xfZwY3lC/YJRbYtfL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043827; c=relaxed/simple;
	bh=6btI4iopsKLLKW9bPf4SycRrF9fzH3XxNtDWeivhWT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Akw3vqwImuufXJvipIsZK2cyUijZioHOxUnjg+oKPNVkq+IRqCG/q2qs2h+/KoBcNMxjC3Nat5hktNm+3C1e3rj9pqFGgbkWZ5kvRo7bz/tbH8ZI5zsjEojA085Pu7iICVZciXAbd9UOOJQrJ/2ni0LhBlinIOe+XVlksS4aG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mxCc++sR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxCc++sR"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so3487564e87.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729043823; x=1729648623; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FelR6GsDdJRo+uFPqIYovXFoQ6VzTQQEO/rkc9OHfQ=;
        b=mxCc++sRcirU/rq/kNxDlR6NJm5NLMah/2Aie7+I9Vt9hT33osWNpcEdZWjZggq2R7
         tCMwiWG7EqIyO2ppIC3yMecS4LGtytXzLt1E21cWuNG+LgcrFwX18YA0weuqTzf6OkBW
         OzzGAvLBqxcoBBXy+739xetrnNXbRt+FNm/ujjzcfG5UIJpThiCbfoiPuM858YGRdnO3
         3KZEqMxPD2XTeNA2y9NUEXPJZ1U1/XeWWXHH3neb5VsTCRxV6IJE/DSooUyppzHwfuf/
         bi29y1P0gJlKdYT3+dTHYH2Bc/auUIx6zRQbKY5fN4jeoRNq0xe/XvTTslY6uP3E69h8
         eTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729043823; x=1729648623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FelR6GsDdJRo+uFPqIYovXFoQ6VzTQQEO/rkc9OHfQ=;
        b=HOFkF+DSIgJjUcrSfO9nTrbSOrIQoHwMJSUNkwN7/rfmRUzTkdjlEAH1qfey0X/9gw
         2mhTdqxVIqFJKnKN/PzePC9bLK9ceroK908sb4gi3+ptw1lNM3q86CXKWQu7k2vyER7L
         fE5L2t7AmtaDlSPrGY4MKV/ieEQG6d54OALFTtP7yLiUNahCiOD3jHRKcnukBbVq1Fdr
         UedowNc0PddTG2RS9MjMmM2J9MD6Wk+FmMRKb3p8t3bBQaCoE+OyOXdwL9mYWM5kefxP
         EdXleLn4Gl2P0j7inNbkzVv9Pr1umLijqe95eYVDHsTl1rcphmTmg6C361uM3AHynVbI
         6Mqg==
X-Forwarded-Encrypted: i=1; AJvYcCXWkLZMRZfWTBo2126z+dv36n1GccZI77L1s8KSrNlhbBFWsrXclbe5JI2EWIlOnUrLe2DqUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym+rv1blqhsnBCebN3ZuqdiQjepvOaDcSHbmQCH2qAIXGyrB3n
	Hm/PCQf6MK1AUTayykvFRREP25NzknUAUWsbXYfDuGDzaQaTEkp5ql82OU64e6Cjhjih0Zv/VmO
	0NlpEka3TTFt0iWqwtyexFnm9AKKq7/5Q0ou6wQ==
X-Google-Smtp-Source: AGHT+IGHNJy6WCLVvS1v7p2xUs8DBaNAGSH314OUXrO/87SH8h3u7zNrDy2Yj2k60G+29EMeHRdokeLA3B/2m0BY1IA=
X-Received: by 2002:a05:6512:3a91:b0:539:a353:279c with SMTP id
 2adb3069b0e04-53a03f2d542mr1721990e87.28.1729043822707; Tue, 15 Oct 2024
 18:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
 <Zw08z9TOFL57z07O@Asurada-Nvidia> <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
 <Zw3M/h1KYe9MjcZK@Asurada-Nvidia> <Zw64C7bQicoAmAM3@Asurada-Nvidia>
In-Reply-To: <Zw64C7bQicoAmAM3@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 09:56:51 +0800
Message-ID: <CABQgh9Fea006HPwVTAuxk7KGh-7-YbjRhoUttVo_iACjAbr0CQ@mail.gmail.com>
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

On Wed, 16 Oct 2024 at 02:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Mon, Oct 14, 2024 at 07:01:40PM -0700, Nicolin Chen wrote:
> > On Tue, Oct 15, 2024 at 09:15:01AM +0800, Zhangfei Gao wrote:
> >
> > > > > iommufd_device_bind
> > > > > iommufd_device_attach
> > > > > iommufd_vdevice_alloc_ioctl
> > > > >
> > > > > iommufd_device_detach
> > > > > iommufd_device_unbind // refcount check fail
> > > > > iommufd_vdevice_destroy ref--
> > > >
> > > > Things should be symmetric. As you suspected, vdevice should be
> > > > destroyed before iommufd_device_detach.
> > >
> > > I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
> > > this issue?
> > > In checking whether close fd before unbind?
> >
> > Oops, my bad. I will provide a fix.
>
> This should fix the problem:
>
> ---------------------------------------------------------------------
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5fd3dd420290..13100cfea29d 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -277,6 +277,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
>   */
>  void iommufd_device_unbind(struct iommufd_device *idev)
>  {
> +       mutex_lock(&idev->igroup->lock);
> +       /* idev->vdev object should be destroyed prior, yet just in case.. */
> +       if (idev->vdev)
> +               iommufd_object_remove(idev->ictx, NULL, idev->vdev->obj.id, 0);
> +       mutex_unlock(&idev->igroup->lock);
>         iommufd_object_destroy_user(idev->ictx, &idev->obj);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> ---------------------------------------------------------------------

Not yet
[  574.162112] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000004
[  574.261102] pc : iommufd_object_remove+0x7c/0x278
[  574.265795] lr : iommufd_device_unbind+0x44/0x98
in check

Thanks

>
> Thanks
> Nicolin
