Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28152EAE6
	for <iommu@lists.linux.dev>; Sat, 12 Oct 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703403; cv=none; b=OTJ/iJoFapgQMrzXPzLXZZvPv7R1JQG2f0PE3Q8DlMRGYaL1Jf0JzB39OXIOJrx1mh85C/fVmTC9qMqZQDSafTLpobPU3QePtmxM3vmb2JcW+82Fh/DrvgGdC91hyDN7E+jFXHwTRS6ohaPiTmbNDaA5lELrbISDP21eRyKyw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703403; c=relaxed/simple;
	bh=wsSaBgBTeHtBghO0cfqVgH243fy8Pa2RXxN/pZupV6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G83ulQzKR1Kwe3zlz/xO591k73WChSXHgn9LXqe8qailARvQMEzAX3jLuzEwndSt7/+001IaBg/J0rDiA0qVdhmPjPX5NSUPBNrIZMMtyuNDDe3RbF7CUljbVdMm0OlKSPhLAuzIhnjkK2aZzbT/A2RRh1bj0x+r4Up3YeiPJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N02QhS6a; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N02QhS6a"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e7e73740so71452e87.3
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728703399; x=1729308199; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlglIBEouENDM99FxQmO+xYhesFmMYXUSPi6sZycxFs=;
        b=N02QhS6asRNECwTexstGP5hiraD0Rp2+weklwYKDaDZQKbus3xfR8ytU4TRc54fzc5
         qA6UYGyjcb0q9TNCuNa+Zs9PfMjjaysLccBeA0/Wmo3z5lDUQnob2Gpux+6r+bh4F9EY
         ChteDsgolL3hd7avR5MCXnLn5aus6uzm/4bK+C6GHCqTz6yWufTePpicCVGlP7GWRnex
         bTrgjesHu4rliwLjC0cHWyCXjbK9igTsMAyinY7RyXt4yi3mCu34VvOLq+fOwGbrot0r
         Y3gz6bPTSkUBQy+8bJbeHxXEBS4vcIwvC1lFtzKB+9Rxy7Rt6ffjNGcyYdWjNsV+vS17
         eFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728703399; x=1729308199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlglIBEouENDM99FxQmO+xYhesFmMYXUSPi6sZycxFs=;
        b=G7GQyvJS8nnwLo+XkAWJLln3gNA1JE6GBpKv0WNF+WvngO9eMZXXzKt0QtY+tYCpnr
         tmXYPRuX+bAEpDw61mzT2cOJQmbAPenA/hWyuMWVWk3kkSNadthyHYSfkxZqotajqku2
         1qbloMkNzN1azyLBSKNEglgDJ7SkDXIRnn+XLp9pnnMlovPO7Yw11JBcqDdhPY0tGE48
         YqhD/FWP9P/H3CFNTMbXSF2G0U4IUA2PYVqkUnQX8h5UwOhVLGn+AzjgN/NoYNHWP8GY
         fnnIG8HpJFjhYrigIsNm9q8T8Rm1OVJ65KfJ3vLBKQfnGC/AQ3dpc08QIfwbW8z6CtXU
         QzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs5Vu6WmD8159Ul/r3sB+o8z9VRDWn48coBbs1ueIkgqD+ppVPOCdpc9eS59Iqp+QHNn1Naw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTm//BGi6+Xa3ZCGOEiosh1bJ85XEBQCaKSyWVn/ITRt7wAQUx
	e10z3PDsi/pn052R+u813HkK7GE8ae8U0bWj2ffMaMytc8j+hE4bW1joWMYvIoWU2fkCyTnBqeh
	x+BU8rpFW4xPe7XOc4iyuSmveSGs7v6tY39W9hA==
X-Google-Smtp-Source: AGHT+IHTB9MOBFF1SVeJM6RLI2586pPtKAOHvz7bsl4p80HAofGQzLo5/TLSZAoKOlZ1GlH3ENrvOlgP85K3q2XSHPI=
X-Received: by 2002:a05:6512:2201:b0:52f:1a0:b49 with SMTP id
 2adb3069b0e04-539da4e2d8bmr2268383e87.31.1728703398750; Fri, 11 Oct 2024
 20:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
In-Reply-To: <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 11:23:07 +0800
Message-ID: <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
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

On Thu, 10 Oct 2024 at 00:40, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
> a slice of physical IOMMU device passed to or shared with a user space VM.
> This slice, now a vIOMMU object, is a group of virtualization resources of
> a physical IOMMU's, such as:
>  - Security namespace for guest owned ID, e.g. guest-controlled cache tags
>  - Access to a sharable nesting parent pagetable across physical IOMMUs
>  - Virtualization of various platforms IDs, e.g. RIDs and others
>  - Delivery of paravirtualized invalidation
>  - Direct assigned invalidation queues
>  - Direct assigned interrupts
>  - Non-affiliated event reporting
>
> Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
> vIOMMU structures. And this allocation also needs a free(), so add struct
> iommufd_viommu_ops.
>
> To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
> It's suggested that a driver should embed a core-level viommu structure in
> its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
> meanwhile the driver can also implement a viommu ops:
>     struct my_driver_viommu {
>         struct iommufd_viommu core;
>         /* driver-owned properties/features */
>         ....
>     };
>
>     static const struct iommufd_viommu_ops my_driver_viommu_ops = {
>         .free = my_driver_viommu_free,
>         /* future ops for virtualization features */
>         ....
>     };
>
>     static struct iommufd_viommu my_driver_viommu_alloc(...)
>     {
>         struct my_driver_viommu *my_viommu =
>                 iommufd_viommu_alloc(ictx, my_driver_viommu, core,
>                                      my_driver_viommu_ops);
>         /* Init my_viommu and related HW feature */
>         ....
>         return &my_viommu->core;
>     }
>
>     static struct iommu_domain_ops my_driver_domain_ops = {
>         ....
>         .viommu_alloc = my_driver_viommu_alloc,
>     };
>
> To make the Kernel config work between a driver and the iommufd core, put
> the for-driver allocation helpers into a new viommu_api file building with
> CONFIG_IOMMUFD_DRIVER.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

> diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> new file mode 100644
> index 000000000000..c1731f080d6b
> --- /dev/null
> +++ b/drivers/iommu/iommufd/viommu_api.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +
> +#include "iommufd_private.h"
> +
> +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> +                                               size_t size,
> +                                               enum iommufd_object_type type)
> +{
> +       struct iommufd_object *obj;
> +       int rc;
> +
> +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> +       if (!obj)
> +               return ERR_PTR(-ENOMEM);
> +       obj->type = type;
> +       /* Starts out bias'd by 1 until it is removed from the xarray */
> +       refcount_set(&obj->shortterm_users, 1);
> +       refcount_set(&obj->users, 1);

here set refcont 1

iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
IOMMUFD_OBJ_DEVICE): refcont -> 1
refcount_inc(&idev->obj.users); refcount -> 2
will cause iommufd_device_unbind fail.

May remove refcount_inc(&idev->obj.users) in iommufd_device_bind

Thanks
