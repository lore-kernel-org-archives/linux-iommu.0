Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8E2FB969
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173263; cv=none; b=o0A6NqUVW4u1td4hZIuJ/MhbKPJmurgiAUU+jICALZsd1DDXmx3FOkuxwIylMkFzco/VX34wWjKXwwKWycDP8J+4N3Gh+H1Z0comLJ8BK9kvJRc6K6slIwpFh05jpiYhJnj1XFdI/6br1tFZx7re2htFLCIVdT9vPrbit+Gle1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173263; c=relaxed/simple;
	bh=2ar4c6Lj8CNPRZM8HVxJ+mjx+aDWyCibvzzSz+YSDsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujb8sJsCiWy9ZPfjshrRgaV9dIzz2LGzZnNpRYtwAVAIcbfm+xoJNE83Yad3bASUAi/GgnqlqC8XzrbIccd7+pRY0vrjrECyT/ML+gApyjgbLgGwquLP+m9+op70X07f+GaJ3YTqp7cYKRcUSLSkcnky1tMMauSjaEw1HhVIHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyKmcwu/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyKmcwu/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48569636800so83335e9.0
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774173260; x=1774778060; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFn8q+Ecl+Vj0twYEF8cAFpxrHeBHSySBtqzdkfKigY=;
        b=GyKmcwu/2Jjmj88l9hMH2Qykuy2/xDYzfTsVa0+lISAwvOkDSTV3rtHh7RnHwAt42G
         Q4DI7rfmB7PtGl5oh5k4GvduRykcqCH9ffCn1e/U8Uf4So2NRkg4L5FaxtPIhphlwu5F
         zxjyET3hTnErQ/uZwBq6WfsdmwA+w0g6P09laFVz5YBDIrD/B+H/7cf20Cr2n5TsO7vM
         yPK6pmaOese4P97W+3VDrdP5+GkTdKATOS4G36qjDEX3+jLKH+Vx4FcVeqdTjqKwGX7X
         9NZpTm6dE6YCIaz6xBDKf8h0gZEhe7E6N+W4Cgm/+Gk58RyA6azRDcDBTTl4Ttr2V7/y
         VbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774173260; x=1774778060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFn8q+Ecl+Vj0twYEF8cAFpxrHeBHSySBtqzdkfKigY=;
        b=rHqIZRRFehx9tPcDeG3oRGyMBqvssjHBuoDR17yTSVAwunPBqRw5AQOxp+tWi7BcQi
         3ktWQxb5VGLzm8jeOC+wpieJJTMm2iqKmspg/OaCs0qdNm1IXxqITz7kGSVWZ7dljV9p
         oYcm7GG5bg0u2yjLyH+V36CHi8DnGyoybr03huLyaGqDHo+QzR2wknrKoubh0JyXDZhz
         TxMv9YxidvHBvYx3KuIb8U2T3vpUWHtq4oSXDPkdW8db3VbnmbA1Rc1wfLskVrH9ty3R
         Db06ANCUaFXNPpxBc8/jhqqCtt3kF4MBdS+LHoQUQ2AnbczOHq+fYwX2hZYc93Hk8NSt
         VmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn8Ci5mDmHSst0dObC7Ccqqwne9kwDTX4MKg7d4NoKZVJCTi2+8CYGLkC+uMRGbm/UIn/WUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxqRBOjHJCy1RmchSl188LXoI/JsaKFok12WISC/x3b+RtE1x3
	tbfktuzF0Wvjf5MdkPUPXNXSBNduYtyslFc3T4IUdSQsWW+TwdEy3ds9xTa1qb2/0w==
X-Gm-Gg: ATEYQzwckrFeltztpNy4uXQ0gPHj7jy2X5EnIBEE1TgiRItd+e5oIknEgCa+pmui2sn
	gc9WA7Cw/XYFpnzPGi8Tlpf+GyVTjjUCTgiVW3rSkrzU19otwAHBNgpMx3GpNo4PHT0jJzNj7M4
	/hMVi2O7URPn+8I/IBcHhWVh9uAlFOoNQk0Ycgwg1Nh9DR5uAObP7juwuKu6FeIroxmEt3P/FOr
	9X+uYyQ1QhYTBl+wVttUkzQZuzeeVPD7DFz+Bjidou5s1TwJ7MBTOBUpRFWJFepFCwMDbRcD/Bo
	OevVA3VF7oGqVF+KftOFW24iZYp4PWgk6KL5paVuu2RFJPqer9yAL0bY08iuh6cCVNnOZdbnY+n
	DuJhguEuVmEz72Gl3ejqxcDDOdht8YxGIPo4lG90ESN9G+iEXvIWVE2i3H9kWAD1cnHkmoKgq+I
	9iNolVPRfNDi8M3JqRdfShew6JE3MI1onfSD5vPXKII6PUNzBG4smqE401
X-Received: by 2002:a05:600c:6990:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-48703433ea4mr1662305e9.2.1774173259851;
        Sun, 22 Mar 2026 02:54:19 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm21816121f8f.8.2026.03.22.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 02:54:19 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:54:15 +0000
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
Subject: Re: [PATCH V2 03/11] iommufd: Allow binding to a noiommu device
Message-ID: <ab-8R5Vww5Fs2Zp8@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-4-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-4-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:29AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy IOMMU group for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommufd/device.c | 113 ++++++++++++++++++++++-----------
>  1 file changed, 76 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 54d73016468f..c38d3efa3d6f 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -23,6 +23,11 @@ struct iommufd_attach {
>  	struct xarray device_array;
>  };
>  
> +static bool is_vfio_noiommu(struct iommufd_device *idev)
> +{
> +	return !device_iommu_mapped(idev->dev) || !idev->dev->iommu;

Do this need to check for CONFIG_VFIO_NOIOMMU and maybe the module
param enable_unsafe_noiommu_mode similar to the legacy implemenation?

> +}
> +
>  static void iommufd_group_release(struct kref *kref)
>  {
>  	struct iommufd_group *igroup =
> @@ -205,32 +210,17 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>  	struct iommufd_device *idev =
>  		container_of(obj, struct iommufd_device, obj);
>  
> -	iommu_device_release_dma_owner(idev->dev);
> +	if (!is_vfio_noiommu(idev))
> +		iommu_device_release_dma_owner(idev->dev);
>  	iommufd_put_group(idev->igroup);
>  	if (!iommufd_selftest_is_mock_dev(idev->dev))
>  		iommufd_ctx_put(idev->ictx);
>  }
>  
> -/**
> - * iommufd_device_bind - Bind a physical device to an iommu fd
> - * @ictx: iommufd file descriptor
> - * @dev: Pointer to a physical device struct
> - * @id: Output ID number to return to userspace for this device
> - *
> - * A successful bind establishes an ownership over the device and returns
> - * struct iommufd_device pointer, otherwise returns error pointer.
> - *
> - * A driver using this API must set driver_managed_dma and must not touch
> - * the device until this routine succeeds and establishes ownership.
> - *
> - * Binding a PCI device places the entire RID under iommufd control.
> - *
> - * The caller must undo this with iommufd_device_unbind()
> - */
> -struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +static int iommufd_bind_iommu(struct iommufd_device *idev)
>  {
> -	struct iommufd_device *idev;
> +	struct iommufd_ctx *ictx = idev->ictx;
> +	struct device *dev = idev->dev;
>  	struct iommufd_group *igroup;
>  	int rc;
>  
> @@ -239,11 +229,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	 * to restore cache coherency.
>  	 */
>  	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  
> -	igroup = iommufd_get_group(ictx, dev);
> +	igroup = iommufd_get_group(idev->ictx, dev);
>  	if (IS_ERR(igroup))
> -		return ERR_CAST(igroup);
> +		return PTR_ERR(igroup);
>  
>  	/*
>  	 * For historical compat with VFIO the insecure interrupt path is
> @@ -269,21 +259,66 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	if (rc)
>  		goto out_group_put;
>  
> +	/* igroup refcount moves into iommufd_device */
> +	idev->igroup = igroup;
> +	return 0;
> +
> +out_group_put:
> +	iommufd_put_group(igroup);
> +	return rc;
> +}
> +
> +/**
> + * iommufd_device_bind - Bind a physical device to an iommu fd
> + * @ictx: iommufd file descriptor
> + * @dev: Pointer to a physical device struct
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and returns
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touch
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *
> + * The caller must undo this with iommufd_device_unbind()
> + */
> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	int rc;
> +
>  	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);

The next code introduces new error cases, do that need to be cleaned in
that case by calling iommufd_object_abort_and_destroy()?

Thanks,
Mostafa

> -	if (IS_ERR(idev)) {
> -		rc = PTR_ERR(idev);
> -		goto out_release_owner;
> -	}
> +	if (IS_ERR(idev))
> +		return idev;
>  	idev->ictx = ictx;
> -	if (!iommufd_selftest_is_mock_dev(dev))
> -		iommufd_ctx_get(ictx);
>  	idev->dev = dev;
>  	idev->enforce_cache_coherency =
>  		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> +
> +	if (!is_vfio_noiommu(idev)) {
> +		rc = iommufd_bind_iommu(idev);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	} else {
> +		struct iommufd_group *igroup;
> +
> +		/*
> +		 * Create a dummy igroup, lots of stuff expects ths igroup to be
> +		 * present, but a NULL igroup->group is OK
> +		 */
> +		igroup = iommufd_alloc_group(ictx, NULL);
> +		if (IS_ERR(igroup))
> +			return ERR_CAST(igroup);
> +		idev->igroup = igroup;
> +	}
> +
> +	if (!iommufd_selftest_is_mock_dev(dev))
> +		iommufd_ctx_get(ictx);
>  	/* The calling driver is a user until iommufd_device_unbind() */
>  	refcount_inc(&idev->obj.users);
> -	/* igroup refcount moves into iommufd_device */
> -	idev->igroup = igroup;
>  
>  	/*
>  	 * If the caller fails after this success it must call
> @@ -295,11 +330,6 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	*id = idev->obj.id;
>  	return idev;
>  
> -out_release_owner:
> -	iommu_device_release_dma_owner(dev);
> -out_group_put:
> -	iommufd_put_group(igroup);
> -	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
>  
> @@ -513,6 +543,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>  	struct iommufd_attach_handle *handle;
>  	int rc;
>  
> +	if (is_vfio_noiommu(idev))
> +		return 0;
> +
>  	if (!iommufd_hwpt_compatible_device(hwpt, idev))
>  		return -EINVAL;
>  
> @@ -560,6 +593,9 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>  {
>  	struct iommufd_attach_handle *handle;
>  
> +	if (is_vfio_noiommu(idev))
> +		return;
> +
>  	handle = iommufd_device_get_attach_handle(idev, pasid);
>  	if (pasid == IOMMU_NO_PASID)
>  		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> @@ -578,6 +614,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>  	struct iommufd_attach_handle *handle, *old_handle;
>  	int rc;
>  
> +	if (is_vfio_noiommu(idev))
> +		return 0;
> +
>  	if (!iommufd_hwpt_compatible_device(hwpt, idev))
>  		return -EINVAL;
>  
> @@ -653,7 +692,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  		goto err_release_devid;
>  	}
>  
> -	if (attach_resv) {
> +	if (attach_resv && !is_vfio_noiommu(idev)) {
>  		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
>  		if (rc)
>  			goto err_release_devid;
> -- 
> 2.34.1
> 
