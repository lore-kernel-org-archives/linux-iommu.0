Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC582F5A36
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292507; cv=none; b=YU6bv17msYsYlCJ+VTAWVRxlg4syQ6vgLTy+ajS6lcBpW1dQDmTsbHFWA5vz3hNwJu1zcCnZKox4JqkdOGC6mIv5r4eteO/Kkxot4MxM6Cw7nxnORaUeYa9gY6Kq4JK16u74adVk4ZBzb13DZ+PQ+qjn/Ytiuy9WkyRnJUSQiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292507; c=relaxed/simple;
	bh=X5usUAT9GcoxLrI3u58awR580PVQTyAas93BuH6o25A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMd5s+if96+ZtZiosULF8OERRAy9SoZO7o652UW0wk1HCr4M2rCjDmS/dUE/RrovlG6YLZKorTdOwQ7aKXPICN9P5IFTmN3ugEw2smoYUObyGjiD0+XBVT5WliELYfBScRJkl4BV6oDliSImNCSGeq6i6uDacbmpLTfNNSZGTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jc+6OzYQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jc+6OzYQ"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA8DE20B7167;
	Wed, 20 May 2026 08:54:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA8DE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779292495;
	bh=/H4rjNosX305gOqhdHcx5Cy2xr4fIDvLtjdEV803Mkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jc+6OzYQmSe4NmPfgVw9IG+fIWrKHqixTRnBxRgrc41fxOaYEo8Y/bhMLXX/GEqiK
	 2QS2BKUTjBAoallvzKNVl3MX6nEwlnzC557Hov4QAHlNEo6qBrSbRppjecXMT/x1Vt
	 FrgjJ4a9HR/OZhwbgxkqEiJGPm9v+rerGe/cFjY0=
Date: Wed, 20 May 2026 08:54:59 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
Message-ID: <20260520085459.000067ac@linux.microsoft.com>
In-Reply-To: <b9e3a3ef-086c-4284-94ce-8e7fafc22d85@intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
	<b9e3a3ef-086c-4284-94ce-8e7fafc22d85@intel.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yi,

On Wed, 20 May 2026 15:20:06 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 5/12/26 02:41, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Allow iommufd to bind devices without an IOMMU (noiommu mode) by
> > creating a dummy IOMMU group for such devices and skipping hwpt
> > operations.
> > 
> > This enables noiommu devices to operate through the same iommufd
> > API as IOMMU- capable devices.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> > v5:
> >     - simplify logic and rename iommufd_device_is_noiommu (Kevin,
> > Yi)
> >     - use a helper iommufd_bind_noiommu instead of open coding
> > (Kevin)
> >     - move IOMMU cap check under iommufd_bind_iommu() (Yi)
> >     - reword comments for partial init (Yi)
> >     - misc minor clean up
> > v4:
> >     - Update the description of the module parameter (Alex)
> > v3:
> >     - Consolidate into fewer patches
> > ---
> >   drivers/iommu/iommufd/device.c | 148
> > ++++++++++++++++++++++++--------- 1 file changed, 109
> > insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c index d03076fcf3c2..4d75720432cc
> > 100644 --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -23,6 +23,16 @@ struct iommufd_attach {
> >   	struct xarray device_array;
> >   };
> >   
> > +/*
> > + * A noiommu device has no IOMMU driver attached regardless of
> > whether it
> > + * enters via the cdev path (no iommu_group) or the group path
> > (fake
> > + * noiommu iommu_group). In both cases dev->iommu is NULL.  
> 
> Are you trying to identify the case where both group and cdev
> interfaces coexist? In such a scenario, the group path creates a fake
> iommu group while the cdev path creates a dummy igroup. Both
> operations need to be performed, but checking iommu_group might
> interfere with the cdev noiommu path logic.
> 
> Is that why you're checking idev->dev->iommu here instead? If so,
> could you please make this rationale more explicit in the comment?
> 
> At first glance, the comment is quite confusing. It's unclear why a
> cdev-path-only helper function needs to reference the group path at
> all. The last sentence in particular seems to suggest this helper
> covers both paths, which adds to the confusion.
> 
Yes, Baolu also commented on this asking why not use
device_iommu_mapped. I will update the comment as follows:
 /*
- * A noiommu device has no IOMMU driver attached regardless of whether
it
- * enters via the cdev path (no iommu_group) or the group path (fake
- * noiommu iommu_group). In both cases dev->iommu is NULL.
+ * Detect a noiommu device for the cdev path. We check dev->iommu
rather than
+ * using device_iommu_mapped() (which checks dev->iommu_group) because
when
+ * both group and cdev interfaces coexist, the group path assigns a
fake
+ * noiommu iommu_group to the device. That would cause
device_iommu_mapped()
+ * to return true and hide the noiommu case from the cdev path.
dev->iommu is
+ * reliably NULL when no IOMMU driver is managing the device.
  */
 static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
 {

> > + */
> > +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> > +{
> > +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> > !idev->dev->iommu; +}
> > +
> >   static void iommufd_group_release(struct kref *kref)
> >   {
> >   	struct iommufd_group *igroup =
> > @@ -30,9 +40,11 @@ static void iommufd_group_release(struct kref
> > *kref) 
> >   	WARN_ON(!xa_empty(&igroup->pasid_attach));
> >   
> > -	xa_cmpxchg(&igroup->ictx->groups,
> > iommu_group_id(igroup->group), igroup,
> > -		   NULL, GFP_KERNEL);
> > -	iommu_group_put(igroup->group);
> > +	if (igroup->group) {
> > +		xa_cmpxchg(&igroup->ictx->groups,
> > iommu_group_id(igroup->group),
> > +			   igroup, NULL, GFP_KERNEL);
> > +		iommu_group_put(igroup->group);
> > +	}
> >   	mutex_destroy(&igroup->lock);
> >   	kfree(igroup);
> >   }
> > @@ -204,32 +216,19 @@ void iommufd_device_destroy(struct
> > iommufd_object *obj) struct iommufd_device *idev =
> >   		container_of(obj, struct iommufd_device, obj);
> >   
> > -	iommu_device_release_dma_owner(idev->dev);
> > +	if (!idev->igroup)
> > +		return;
> > +	if (!iommufd_device_is_noiommu(idev))
> > +		iommu_device_release_dma_owner(idev->dev);
> >   	iommufd_put_group(idev->igroup);
> >   	if (!iommufd_selftest_is_mock_dev(idev->dev))
> >   		iommufd_ctx_put(idev->ictx);
> >   }
> >   
> > -/**
> > - * iommufd_device_bind - Bind a physical device to an iommu fd
> > - * @ictx: iommufd file descriptor
> > - * @dev: Pointer to a physical device struct
> > - * @id: Output ID number to return to userspace for this device
> > - *
> > - * A successful bind establishes an ownership over the device and
> > returns
> > - * struct iommufd_device pointer, otherwise returns error pointer.
> > - *
> > - * A driver using this API must set driver_managed_dma and must
> > not touch
> > - * the device until this routine succeeds and establishes
> > ownership.
> > - *
> > - * Binding a PCI device places the entire RID under iommufd
> > control.
> > - *
> > - * The caller must undo this with iommufd_device_unbind()
> > - */
> > -struct iommufd_device *iommufd_device_bind(struct iommufd_ctx
> > *ictx,
> > -					   struct device *dev, u32
> > *id) +static int iommufd_bind_iommu(struct iommufd_device *idev)
> >   {
> > -	struct iommufd_device *idev;
> > +	struct iommufd_ctx *ictx = idev->ictx;
> > +	struct device *dev = idev->dev;
> >   	struct iommufd_group *igroup;
> >   	int rc;
> >   
> > @@ -238,11 +237,11 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx,
> >   	 * to restore cache coherency.
> >   	 */
> >   	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> > -		return ERR_PTR(-EINVAL);
> > +		return -EINVAL;
> >   
> >   	igroup = iommufd_get_group(ictx, dev);
> >   	if (IS_ERR(igroup))
> > -		return ERR_CAST(igroup);
> > +		return PTR_ERR(igroup);
> >   
> >   	/*
> >   	 * For historical compat with VFIO the insecure interrupt
> > path is @@ -268,21 +267,80 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx, if (rc)
> >   		goto out_group_put;
> >   
> > +	/* igroup refcount moves into iommufd_device */
> > +	idev->igroup = igroup;
> > +	idev->enforce_cache_coherency =
> > +		device_iommu_capable(dev,
> > IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> > +	return 0;
> > +
> > +out_group_put:
> > +	iommufd_put_group(igroup);
> > +	return rc;
> > +}
> > +
> > +/*
> > + * Noiommu devices have no real IOMMU group. Create a dummy igroup
> > so that
> > + * internal code paths that expect idev->igroup to be present
> > still work.
> > + * A NULL igroup->group distinguishes this from a real
> > IOMMU-backed group.
> > + */
> > +static int iommufd_bind_noiommu(struct iommufd_device *idev)
> > +{
> > +	struct iommufd_group *igroup;
> > +
> > +	igroup = iommufd_alloc_group(idev->ictx, NULL);
> > +	if (IS_ERR(igroup))
> > +		return PTR_ERR(igroup);
> > +	idev->igroup = igroup;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * iommufd_device_bind - Bind a physical device to an iommu fd
> > + * @ictx: iommufd file descriptor
> > + * @dev: Pointer to a physical device struct
> > + * @id: Output ID number to return to userspace for this device
> > + *
> > + * A successful bind establishes an ownership over the device and
> > returns
> > + * struct iommufd_device pointer, otherwise returns error pointer.
> > + *
> > + * A driver using this API must set driver_managed_dma and must
> > not touch
> > + * the device until this routine succeeds and establishes
> > ownership.
> > + *
> > + * Binding a PCI device places the entire RID under iommufd
> > control.
> > + *
> > + * The caller must undo this with iommufd_device_unbind()
> > + */
> > +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx
> > *ictx,
> > +					   struct device *dev, u32
> > *id) +{
> > +	struct iommufd_device *idev;
> > +	int rc;
> > +
> >   	idev = iommufd_object_alloc(ictx, idev,
> > IOMMUFD_OBJ_DEVICE);
> > -	if (IS_ERR(idev)) {
> > -		rc = PTR_ERR(idev);
> > -		goto out_release_owner;
> > -	}
> > +	if (IS_ERR(idev))
> > +		return idev;
> > +
> >   	idev->ictx = ictx;
> > +	idev->dev = dev;
> > +
> > +	if (!iommufd_device_is_noiommu(idev)) {
> > +		rc = iommufd_bind_iommu(idev);
> > +		if (rc)
> > +			goto err_out;
> > +	} else {
> > +		rc = iommufd_bind_noiommu(idev);
> > +		if (rc)
> > +			goto err_out;
> > +	}  
> 
> how about moving the 'if (rc)'out of the two branches?
> 
Sounds good!

> > +
> > +	/*
> > +	 * Take a ctx reference after bind succeeds. This must
> > happen here
> > +	 * so that iommufd_device_destroy() can handle partial
> > initialization
> > +	 */  
> 
> s/after bind succeeds/after bind_iommu/noiommu() succeeds. or more
> explicit, "idev->igroup is set." :)
> 
> Other parts LGTM, feel free to add my r-b tag after solving the above
> nits.
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
will do.
Thanks a lot!

> 
> >   	if (!iommufd_selftest_is_mock_dev(dev))
> >   		iommufd_ctx_get(ictx);
> > -	idev->dev = dev;
> > -	idev->enforce_cache_coherency =
> > -		device_iommu_capable(dev,
> > IOMMU_CAP_ENFORCE_CACHE_COHERENCY); /* The calling driver is a user
> > until iommufd_device_unbind() */ refcount_inc(&idev->obj.users);
> > -	/* igroup refcount moves into iommufd_device */
> > -	idev->igroup = igroup;
> >   
> >   	/*
> >   	 * If the caller fails after this success it must call
> > @@ -294,11 +352,14 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx, *id = idev->obj.id;
> >   	return idev;
> >   
> > -out_release_owner:
> > -	iommu_device_release_dma_owner(dev);
> > -out_group_put:
> > -	iommufd_put_group(igroup);
> > +err_out:
> > +	/*
> > +	 * iommufd_device_destroy() handles partially initialized
> > idev,
> > +	 * so iommufd_object_abort_and_destroy() is safe to call
> > here.
> > +	 */
> > +	iommufd_object_abort_and_destroy(ictx, &idev->obj);
> >   	return ERR_PTR(rc);
> > +
> >   }
> >   EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
> >   
> > @@ -512,6 +573,9 @@ static int iommufd_hwpt_attach_device(struct
> > iommufd_hw_pagetable *hwpt, struct iommufd_attach_handle *handle;
> >   	int rc;
> >   
> > +	if (iommufd_device_is_noiommu(idev))
> > +		return 0;
> > +
> >   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
> >   		return -EINVAL;
> >   
> > @@ -559,6 +623,9 @@ static void iommufd_hwpt_detach_device(struct
> > iommufd_hw_pagetable *hwpt, {
> >   	struct iommufd_attach_handle *handle;
> >   
> > +	if (iommufd_device_is_noiommu(idev))
> > +		return;
> > +
> >   	handle = iommufd_device_get_attach_handle(idev, pasid);
> >   	if (pasid == IOMMU_NO_PASID)
> >   		iommu_detach_group_handle(hwpt->domain,
> > idev->igroup->group); @@ -577,6 +644,9 @@ static int
> > iommufd_hwpt_replace_device(struct iommufd_device *idev, struct
> > iommufd_attach_handle *handle, *old_handle; int rc;
> >   
> > +	if (iommufd_device_is_noiommu(idev))
> > +		return 0;
> > +
> >   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
> >   		return -EINVAL;
> >   
> > @@ -652,7 +722,7 @@ int iommufd_hw_pagetable_attach(struct
> > iommufd_hw_pagetable *hwpt, goto err_release_devid;
> >   	}
> >   
> > -	if (attach_resv) {
> > +	if (attach_resv && !iommufd_device_is_noiommu(idev)) {
> >   		rc = iommufd_device_attach_reserved_iova(idev,
> > hwpt_paging); if (rc)
> >   			goto err_release_devid;  

