Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF9186284
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173734; cv=none; b=ARxdj8u8O1dtmVBrWSy8zK//BEwlbIphWFRTlERXrqY1XgoL49t0xJhpGarqaZNOSM09gKc0qOPqFuVy4D2eOSLsb7We+hmzA/jzta9VK54SLORLq5ZMJgI6rgJvi9GHu16j4EUXCrLkF6pDGZXwFYTtAe1cadP1aDCuQSAiaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173734; c=relaxed/simple;
	bh=MPdvlYF+iWz1K8Rhtff35P9jt2NBVcoETnQ/FL6EmYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8zUa6Os/XZzqZwK00YQELCP55aF51o5kSPoSx+mq/MxWUQDOXGHZX7AGX59u+ARzldmfVkfu2v9KzPjOtQO4R2eKKSEusUJ/r2iafYWr0ZXv/3I+0fBebRW49CJopx+wwd1bEQOREDI9UwV8/b1ZI3b7zaURlP+BysKn/T+jLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/dyNUKU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/dyNUKU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48569636800so83715e9.0
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774173732; x=1774778532; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I//2qfZnYblxfMX6zr8r1FNilN8mRILbWlr2/H3rAfI=;
        b=i/dyNUKUjuQFgij++vOWh3llBupEF2SjUKGhtecOos+QTjS29weiE+oGLnz1VDtmWi
         0pMIIrFgp4DBdMCqdb3rO8M1dWcIlZtyZ0Jkkw56fgiDlbNWbXr/+s0DTOqV493vPCwr
         S97uM1un0xRAT8ELOdijX0OTNXevejvWvfIhgU4nAd7PtIiK4oTJOsSQYGmQ/bIfCadk
         7Vq0LFssjXEh4uS83O7RN9VIzVHlcwdCpJBDftjYf/JfWlSriY7xnundlL4vq9FCRuGu
         /aYU62uGPbg6O+sSmQ8uP7fm4gyik9+rIA+tp9uDZFK4rK8nfB3aVaDR6PbRwjHoZlfR
         gzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774173732; x=1774778532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I//2qfZnYblxfMX6zr8r1FNilN8mRILbWlr2/H3rAfI=;
        b=LCvgY8nXpzpERJYTmMp2SR5tFWn6RhfS0QDIDD+rr3dqQVFPGKz9SeArJXJlWklUoy
         Eq6Me5vQ5n3yWMWam5QjPUTU9kilnoaL0OyGkGDheIxs5xV9/ysTV29gU8XH5L/EM/F3
         0VMppPfyJmaf3yIJqYztd3JwEEx2Vtz1kBo8h1kT7Mkc6xWeT3l40dmQqylrx/FERCGK
         WVFV3eegBksGwwJ9Gh9hkEkWqIP1czjvgjZHUNfJLW2ANNAbIBPTm01eAzgvf1kvOGaE
         HEFwzuGSt9/1jdz3QBuuYqbCnl8ig3Te3O4+4G+GHgtJmWXPkwMPbzmfW7LrQgC6p8zo
         NV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBpNxCOuZkqe4bCtJZUq9C38hxo0T4UDah222ZWFDcewaTlcJtEuI/p/z3wxZJAnYbeS6xBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2OBsGl0RqxSfjqz+zvy8P9Fg/pAfLw48w3h1bu7ZAgawaEiBL
	LXE4u8dQms8/xiHVxwWp/vu14msvxKFvs2G5rPScl2oYHunKpz+FK/5U9VGfb8y3GA==
X-Gm-Gg: ATEYQzzSpqN266k2xuT1zUR6VTq9/NWu7Y7UCK0lV0mdhnXXelzcm7pLWs8lf2PDP6J
	vjY8BLEY0qnVnQa7Yun3qx7n63dv4I/j3Vd5WR0iKhiWJDOCTyu0XkAuGV2H/cTbH1audsRQORL
	B4Kbo1AVMUaVmcUielbh/UaefCS0cFllzt7zV2uaU6CxHcjuI98jrlFl92eiTQydJYcwBDiSyTZ
	GaMoXln1ccT921pAoJ72mVV7t+vSTol++vt4ThJvatX2fD1w8cCUXdxhafZIRBTXcH+qE03uv8I
	JtI0ZEJd+CdvHg5HVd6H5WqclhljUqclliwwR61mhsooJl0apTBP+uHwDA7uXA0rzpzXCjvxrMQ
	+G2vi7UaBGMmnJH/Epj71nbaQ8ZXg3YckcAZ7aH9zZIQRnudPsWwvrwV42z7erzowIuAB3xk7hw
	kN+WLfySZBewSLN3qMA8iE3U+D/MyRSz8cQPWeBm8JF5ldk/ub0B7teebe
X-Received: by 2002:a05:600c:6990:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-48703433ea4mr1665715e9.2.1774173731564;
        Sun, 22 Mar 2026 03:02:11 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm20013069f8f.20.2026.03.22.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 03:02:10 -0700 (PDT)
Date: Sun, 22 Mar 2026 10:02:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 06/11] vfio: Introduce and set noiommu flag on
 vfio_device
Message-ID: <ab--H_55HJ20n_KC@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-7-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-7-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:32AM -0700, Jacob Pan wrote:
> When a VFIO device is added to a noiommu group, set the noiommu flag on
> the vfio_device structure to indicate that the device operates in
> noiommu mode.
> 
> Also update function signatures to pass vfio_device instead of device,
> which has the direct access to the noiommu flag.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/vfio/group.c | 21 +++++++++++----------
>  include/linux/vfio.h |  1 +
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 98f2a4f2ebff..6f98c57de9e0 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -588,7 +588,7 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
>  	return ret;
>  }
>  
> -static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
> +static struct vfio_group *vfio_noiommu_group_alloc(struct vfio_device *vdev,
>  		enum vfio_group_type type)
>  {
>  	struct iommu_group *iommu_group;
> @@ -610,7 +610,7 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	ret = iommu_group_set_name(iommu_group, "vfio-noiommu");
>  	if (ret)
>  		goto out_put_group;
> -	ret = iommu_group_add_device(iommu_group, dev);
> +	ret = iommu_group_add_device(iommu_group, vdev->dev);
>  	if (ret)
>  		goto out_put_group;
>  
> @@ -625,7 +625,7 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	return group;
>  
>  out_remove_device:
> -	iommu_group_remove_device(dev);
> +	iommu_group_remove_device(vdev->dev);
>  out_put_group:
>  	iommu_group_put(iommu_group);
>  	return ERR_PTR(ret);
> @@ -646,23 +646,24 @@ static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
>  	return false;
>  }
>  
> -static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
> +static struct vfio_group *vfio_group_find_or_alloc(struct vfio_device *vdev)
>  {
>  	struct iommu_group *iommu_group;
>  	struct vfio_group *group;
>  
> -	iommu_group = iommu_group_get(dev);
> +	iommu_group = iommu_group_get(vdev->dev);
>  	if (!iommu_group && vfio_noiommu) {
> +		vdev->noiommu = 1;
>  		/*
>  		 * With noiommu enabled, create an IOMMU group for devices that
>  		 * don't already have one, implying no IOMMU hardware/driver
>  		 * exists.  Taint the kernel because we're about to give a DMA
>  		 * capable device to a user without IOMMU protection.
>  		 */
> -		group = vfio_noiommu_group_alloc(dev, VFIO_NO_IOMMU);
> +		group = vfio_noiommu_group_alloc(vdev, VFIO_NO_IOMMU);
>  		if (!IS_ERR(group)) {
>  			add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> -			dev_warn(dev, "Adding kernel taint for vfio-noiommu group on device\n");
> +			dev_warn(vdev->dev, "Adding kernel taint for vfio-noiommu group on device\n");
>  		}
>  		return group;
>  	}
> @@ -673,7 +674,7 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
>  	mutex_lock(&vfio.group_lock);
>  	group = vfio_group_find_from_iommu(iommu_group);
>  	if (group) {
> -		if (WARN_ON(vfio_group_has_device(group, dev)))
> +		if (WARN_ON(vfio_group_has_device(group, vdev->dev)))
>  			group = ERR_PTR(-EINVAL);
>  		else
>  			refcount_inc(&group->drivers);
> @@ -693,9 +694,9 @@ int vfio_device_set_group(struct vfio_device *device,
>  	struct vfio_group *group;
>  
>  	if (type == VFIO_IOMMU)
> -		group = vfio_group_find_or_alloc(device->dev);
> +		group = vfio_group_find_or_alloc(device);
>  	else
> -		group = vfio_noiommu_group_alloc(device->dev, type);
> +		group = vfio_noiommu_group_alloc(device, type);
>  
>  	if (IS_ERR(group))
>  		return PTR_ERR(group);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e90859956514..844d14839f96 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -72,6 +72,7 @@ struct vfio_device {
>  	u8 iommufd_attached:1;
>  #endif
>  	u8 cdev_opened:1;
> +	u8 noiommu:1;
>  #ifdef CONFIG_DEBUG_FS
>  	/*
>  	 * debug_root is a static property of the vfio_device
> -- 
> 2.34.1
> 
