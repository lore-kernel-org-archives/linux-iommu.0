Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DC5338D
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936747; cv=none; b=MKudwHdNkKlH9WVxSEoZFXC8E+3iXfyVG4hBcdbI/DggE7uQmu2XhnYX/KuOQKyDewkWLQ/jXkaKT1ACWvGdk+LreycP6BxScZwfA6TBgrA4vXoSe6JYs8w60sNA/TQBPvmdgXgx2PHaG6lQxmKQf4MBTSamaSEYe2nwNdYra60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936747; c=relaxed/simple;
	bh=gUXKw1i0YN9NY2dtrWNeoIPxxbMcJyh+p5TcR5AoOVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWiSoqMBOUwTmxj/464PrzhFrGJSBpESebXDTRtGC1OxOzp38B7ewYJjlGe/B/63oe7GrBGJMQdlYGLE1aqynfTkekV5Laxfle9/T5xhYq/j2Yu1AvkaB4prNUFVYNzETfVNtszTlFyYOI44/8Ol8VeJWW6swIu/OYbwpAR4YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ygsmojhv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygsmojhv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f5484a37so1683830e87.3
        for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 00:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708936744; x=1709541544; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hNqFxveNN+H8aecbcycKBg8umKGdeV5MQ1apVnlx4RI=;
        b=Ygsmojhvh2LPn/MFOJqmN6+HcHd12DY1VYxwUAsZbJGvkwKyHd62HPOviGylb8wf1h
         TpzOYS/q1stpbWVty4IexQ0C2/545DjehFsJRFAq99AXULwANU9QIYnsGL2jM2j1O0lO
         Ve0S+vjj7kweKGfIqldNSfDOxEGNEHO0LEkBpDGXk0jp8ir9sePmDz7Ie03wlrcYni4Z
         QC1GYVQu/VGTX5ICWSfwCY9LIgHH9ysopWQ6XmBJJRbznKz7KDMtUcVFY8uyt1TTPQ9E
         TDLYkStW7+YcBohw9kge3uJfU8VkuZMYLbIDkOu/xMo4TLwKTmjoJpWZOM7ZP7od2exb
         qQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936744; x=1709541544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNqFxveNN+H8aecbcycKBg8umKGdeV5MQ1apVnlx4RI=;
        b=klsz6LXD2ZAMmlVzUwebpRUxLHX3htI0bPjuKuP/CktfIDZOpi8tQZotl9H/fg4iUR
         z3L+h+5/43i3Rs9GfvwSdWDO3/ZFb1jo/vgpEP6o/lDhwk03THmWJWHAkXXgA+oLWcVp
         XYmtnsTC/1+8dFO1r1Yb/NTCex5A48FPB1+O+PjbLMoBzNj0Ic8sMSYw8g9VOFOetMvh
         FSk4Q3Sc2eQplwdDPRIZxSJ33Wj4CAxjX+Z5ONfeXox8CSLuW8p5cvnNLzje+iYH//9/
         jHBWS19SmLpt+IxQyry757Bd+hQ4apuXKJMw8R0lbH8hMtXAvsnIfZAMHZzLO6JBpXlv
         kLuQ==
X-Gm-Message-State: AOJu0YynIDxP/vTs8EY3XUlfmwfEvNUc2HZZTpuQMx9ZeqZLw+XAMx8o
	RvrgqFhMeBU2WJCCqTi33b1h9Y1QpRt43+aXYFg8Mlf2NxZVQEfTMUWPYthObWKVM255tWTaIAQ
	+Zo3qhAiT8lf9+3bMbyBVTFvf+qawzBc9EXs1zg==
X-Google-Smtp-Source: AGHT+IHmHML7b3qoLecL20ShS0D8jjCvIbIUmDFgiUBztrjnO3WCKr1Ny1OWrIJBV2jCyp7Pq0IrbY/1iBrV5batGF0=
X-Received: by 2002:a05:6512:239d:b0:512:f17f:2b30 with SMTP id
 c29-20020a056512239d00b00512f17f2b30mr4528397lfv.59.1708936744085; Mon, 26
 Feb 2024 00:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-9455fc497a6f+3b4-iommu_sva_sharing_jgg@nvidia.com>
In-Reply-To: <0-v1-9455fc497a6f+3b4-iommu_sva_sharing_jgg@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 26 Feb 2024 16:38:52 +0800
Message-ID: <CABQgh9GTnT+ieqQiNFjc=CLeG0J01Rf3RdLxZatdkKJgNLqXsA@mail.gmail.com>
Subject: Re: [PATCH rc] iommu/sva: Restore SVA handle sharing
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>, 
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Tina Zhang <tina.zhang@intel.com>, Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 22:07, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Prior to commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva
> domains") the code allowed a SVA handle to be bound multiple times to the
> same (mm, device) pair. This was alluded to in the kdoc comment, but we
> had understood this to be more a remark about allowing multiple devices,
> not a literal same-driver re-opening the same SVA.
>
> It turns out uacce and idxd were both relying on the core code to handle
> reference counting for same-device same-mm scenarios. As this looks hard
> to resolve in the drivers bring it back to the core code.
>
> The new design has changed the meaning of the domain->users refcount to
> refer to the number of devices that are sharing that domain for the same
> mm. This is part of the design to lift the SVA domain de-duplication out
> of the drivers.
>
> Return the old behavior by explicitly de-duplicating the struct iommu_sva
> handle. The same (mm, device) will return the same handle pointer and the
> core code will handle tracking this. The last unbind of the handle will
> destroy it.
>
> Fixes: 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")
> Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Closes: https://lore.kernel.org/all/20240221110658.529-1-zhangfei.gao@linaro.org/
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu-sva.c | 17 +++++++++++++++++
>  include/linux/iommu.h     |  3 +++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c3fc9201d0be97..7f91c8d0064b71 100644
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
> @@ -82,6 +83,14 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>                 goto out_unlock;
>         }
>
> +       list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
> +               if (handle->dev == dev) {
> +                       refcount_inc(&handle->users);
> +                       mutex_unlock(&iommu_sva_lock);
> +                       return handle;
> +               }
> +       }
> +
>         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>         if (!handle) {
>                 ret = -ENOMEM;
> @@ -108,7 +117,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>         if (ret)
>                 goto out_free_domain;
>         domain->users = 1;
> +       refcount_set(&handle->users, 1);
>         list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +       list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
>
>  out:
>         mutex_unlock(&iommu_sva_lock);
> @@ -141,6 +152,12 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
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
>
> base-commit: 510325e5ac5f45c1180189d3bfc108c54bf64544
> --
> 2.43.2
>

Hi, Jason

I am testing on 6.8-rc6 with more test and found one issue, sorry about this.
When test openssl rsa, it will use two devices, one is sec, the other is hpre.
I found the second handle can not be shared since bind_dev directly
goto out but not add_list.

So still need a minor fix like this

    iommu/sva: Fix SVA handle sharing in multi device case


    iommu_sva_bind_device will directly goto out in multi-device
    case when found existing domain, ignoring list_add handle,
    which causes the handle to fail to be shared.

    Fixs: 65d4418c5002 (iommu/sva: Restore SVA handle sharing)
    Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 7f91c8d0064b..b1f3a864e124 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -117,11 +117,10 @@ struct iommu_sva *iommu_sva_bind_device(struct
device *dev, struct mm_struct *mm
        if (ret)
                goto out_free_domain;
        domain->users = 1;
-       refcount_set(&handle->users, 1);
        list_add(&domain->next, &mm->iommu_mm->sva_domains);
-       list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);

 out:
+       refcount_set(&handle->users, 1);
+       list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
        mutex_unlock(&iommu_sva_lock);
        handle->dev = dev;
        handle->domain = domain;

What do you think.

Thanks
