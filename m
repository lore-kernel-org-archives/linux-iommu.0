Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D4194C61
	for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739619354; cv=none; b=LxvUspbx5svlGKLd4UtbzJEwP232dCU0rT0gbgShmUwa2mCzNNLWTQcKUokwXxtkUieyG0Wwad/COMd6FothHXrb1V0LJ/7y7JPa76DK9lVbRFUBzxHk/ReIi2O8hxjNDS7YeAvUt6o60PUgde2XFQwSllzrMgxIam9d7iFtFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739619354; c=relaxed/simple;
	bh=Ci0+XLq+d9rZIvFoN72FJTBWdzTfmnvxyaM9qpi7TnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpeYmbbawJb0f2k37e76i6d2XQ/8wwnu4bRug/Jha88qeCu7C1Jj6H+x+ISl6sDLy1BO4n/yPVgvBz6zevrxyhoppkNahtolFMyvp/Zg30lwAy1woWihezopLQGniI/8W3ETemNGPXITxwyWjSnfR92v/1MAjy3h2oVxwrwuxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+WxMxaF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+WxMxaF"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso29698951fa.1
        for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739619350; x=1740224150; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GWKV3bPvJoEC6CwCkO5EJJnYQ2m33vdhaH2jkHmFW3k=;
        b=Z+WxMxaFX2HA5T0pk9zvppC/wEJXFvhPugmR+qjYjPztuwCi/3ZCQ1Hx5N4YyUUC6q
         W+TXshXz9tguBsBVtOAp+55tfRCaI0yvcAPBNegEGcOUDdeAkyI93rAHff3kMjF9fiU2
         VTZRXx+sVOTFuHaEq7VsDzKT+4TxttzNPWs6MInJR1yDpFx2K4+ED+gJVr+BhAvFPieN
         HcBxqMBNyipOPhJmtFZbt17hOREgaryG+8FjojdW9Xfh+oIX816hXL/IKIRWMcXX4n6y
         k2KwnfCkgEs5fPNTw4aweaQwiYlF/paoEWuc0cYfQ4f0YS31A7ednEmD9rcLjxLgfWqW
         fk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739619350; x=1740224150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWKV3bPvJoEC6CwCkO5EJJnYQ2m33vdhaH2jkHmFW3k=;
        b=UcZeXgI1VsdzhdhaXP5lo5K3I9SGh2LlS0BCK6g0HQ8qzNRACZO3d8TGCLGr/6nH5o
         DpvCquA/AuncAQcPyotIB+/ppwrrCjLjbrxzQlDh3ho7wFmPQ/Y0/k8/1aRoPpFkcxXS
         FPI9kmK8SWfQ5KRuqgH5NTAVCUlWM5Dmx4QVah0aQx7tdKWgi+I3jaq2j4NgJU4GQ9f9
         enBxZdbtbJsA1cZL2YawWJM43bgy2cB5a78fiLLQFwA/sjn7JDQ+OoNfGF/j1NPovSUv
         Y0SKri/2k/nh5YuZu+Iz2JOZF6ICMImSq4VXTcEGsfXHb5xLBblGjREWiYaLY+kOae8u
         OuRw==
X-Forwarded-Encrypted: i=1; AJvYcCXV5gaIm384oekl/jgHM5vnk0xIdqeybZd3EvuXzy9JVSGFk4yzEz/WmihXYLjWNaQ0yR/emA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxieitWzmu+f0W8hXkWl87uC3UuLr6H/77YZHUBKyWZrztl2/W+
	gt4eER+z7Otn/EddU0lG0FhMDwnL4l2h6md8CXBRZVIG8tGZoAexpYQpJdxcjpE0ZYfw6phYCKW
	E7081Zy8z+TuIcmszDcwOw0CuQnmYq7MSD2J9fA==
X-Gm-Gg: ASbGncu1cveAWyQQSwsbe3Tjm8VrWOJOjLR0pRQeTxmU5mHo95BRimOPzXA6STYrJaB
	SemyGbbC/I8dV4lNko+LUYjWqEt5XkJexjjuDFseEIJa+I9QnNO3Olcd9wGLbjCNGAVrC1/xKnB
	GsAw==
X-Google-Smtp-Source: AGHT+IHwSYAZC5CwjRpFYyBiSqR0sK1FpBP8Yk5w2sAiYtZY0gHXngaY4LcBKuFQd7HHYoA0EWP5G/v7vRNNBL7KWXo=
X-Received: by 2002:a05:6512:ba6:b0:545:f4b:ed66 with SMTP id
 2adb3069b0e04-5452fe56d7emr909583e87.21.1739619350484; Sat, 15 Feb 2025
 03:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca> <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
In-Reply-To: <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 15 Feb 2025 19:35:39 +0800
X-Gm-Features: AWEUYZlvK8a7ONBBadH8VVaSYChy_w4QHfiKgPqrTgWgJopiUVoF2zbjBT2p1uA
Message-ID: <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 18:09, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2/15/25 16:11, Zhangfei Gao wrote:
> > It does not relate to multi devices, one device also happens when user
> > page fault triggers.
> >
> > iopf_queue_remove_device is called.
> > rcu_assign_pointer(param->fault_param, NULL);
> >
> > call trace
> > [  304.961312] Call trace:
> > [  304.961314]  show_stack+0x20/0x38 (C)
> > [  304.961319]  dump_stack_lvl+0xc0/0xd0
> > [  304.961324]  dump_stack+0x18/0x28
> > [  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
> > [  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
> > [  304.961336]  arm_smmu_attach_commit+0x64/0x100
> > [  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
> > [  304.961340]  __iommu_attach_device+0x2c/0x110
> > [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> > [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> > [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> > [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> > [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> > [  304.961355]  iommufd_device_change_pt+0x270/0x688
> > [  304.961357]  iommufd_device_replace+0x20/0x38
> > [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> > [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> > [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> >
> >
> > When page fault triggers:
> >
> > [ 1016.383578] ------------[ cut here ]-----------
> > [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> > drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
>
> It's likely that iopf_queue_add_device() was not called for this device.

iopf_queue_add_device is called, but quickly iopf_queue_remove_device
is called during guest bootup.
Then fault_param is set to NULL.

arm_smmu_attach_commit
arm_smmu_remove_master_domain
// newly added in the first patch
       if (master_domain) {
                  if (master_domain->using_iopf)
                          arm_smmu_disable_iopf(master); ->
iopf_queue_remove_device
                  kfree(master_domain);
          }

As a comparison, without this patchset, only iopf_queue_add_device is
called, not call iopf_queue_remove_device

Thanks
