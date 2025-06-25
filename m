Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E82820BA
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844791; cv=none; b=uDFtiovc5Adl5MZ9l32pAqu8zUXy4nxhIkELz5IZBARPh3NONP8eQe7wnpKov9TQOGN7SoyfOhqoizRN2PiwzP/fjCir014JA9qZ4FS0G+U3rHDPlcyI2GWRw/MJhepiyleOh9SNxYNABFNV5UM2szU4m5QY8WPToDNP9AdIefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844791; c=relaxed/simple;
	bh=VahF800RD6awzaPHIvyJkfnSmFed4yTzKvqtc6h4VSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFCmMzlMkWFW5nJBYFF42jHuzW5do8tMxyMhHKDJagJNbpjo0bRCyGAblShXU7iRAF6nVkabI5VMMjRoAT6ukUyKqzSefp/XeV6JdqCfWGkEZqIHDZG+lu2LVUBfqHUqGY61rBxpGOCVr3iVCGHFHhTarHhsGSnlgW/qIM1Jicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq9LtvWA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq9LtvWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750844789; x=1782380789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VahF800RD6awzaPHIvyJkfnSmFed4yTzKvqtc6h4VSY=;
  b=Dq9LtvWAJyv8Do22ksoIMS8pFKJgBPNfFVrCk+SAfVdaSaGdWbWOL7L5
   JPphI7ENi0Z/dRGhxeKv1v7N3s/T7IA9r80pZGWz0WYY40ot91xzfJcKe
   Y9cFF+pCjhBaeEQGre2Yq0ZRF1I2AZJU8e8u7ZVE4n80w90fap+HcFTQj
   dR2M8S87P9kQk8C8WPjo9VUPazs1CjkHEcurqZBCb57AB5cbETI1CLByr
   CWv3Br8/NW4gUH9QSvOdtYTx/9Dr4s7R7sWl9EZRYARNKAxfbMV42sxAk
   TSGD59Nd9Zcw1GVFmBDRSTEPZ16L66HP3ICzNC9C8M5KSfEuVHlDP7LMH
   Q==;
X-CSE-ConnectionGUID: j1HQfKFkS+Szu0yeVz9twQ==
X-CSE-MsgGUID: f6pv4I3jQcmNGJ9kB2dLcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52337922"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52337922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 02:46:28 -0700
X-CSE-ConnectionGUID: UA3V2zXlRkS4ZS9/NnWkrQ==
X-CSE-MsgGUID: /m4EyaggQxm2KjJxNyFJVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151681300"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 25 Jun 2025 02:46:25 -0700
Date: Wed, 25 Jun 2025 17:38:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aFvDqAGAM3RbPh8G@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <yq5a1pr85noj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a1pr85noj.fsf@kernel.org>

On Wed, Jun 25, 2025 at 12:10:28PM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so that
> > vdev can't outlive idev.
> >
> > iommufd_device(idev) represents the physical device bound to iommufd,
> > while the iommufd_vdevice(vdev) represents the virtual instance of the
> > physical device in the VM. The lifecycle of the vdev should not be
> > longer than idev. This doesn't cause real problem on existing use cases
> > cause vdev doesn't impact the physical device, only provides
> > virtualization information. But to extend vdev for Confidential
> > Computing(CC), there are needs to do secure configuration for the vdev,
> > e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
> > destroy, or the external driver(VFIO) functionality may be impact.
> >
> > Building the association between idev & vdev requires the two objects
> > pointing each other, but not referencing each other. This requires
> > proper locking. This is done by reviving some of Nicolin's patch [1].
> >
> > There are 3 cases on idev destroy:
> >
> >   1. vdev is already destroyed by userspace. No extra handling needed.
> >   2. vdev is still alive. Use iommufd_object_tombstone_user() to
> >      destroy vdev and tombstone the vdev ID.
> >   3. vdev is being destroyed by userspace. The vdev ID is already freed,
> >      but vdev destroy handler is not complete. The idev destroy handler
> >      should wait for vdev destroy completion.
> >
> > [1]: https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/
> >
> > Original-by: Nicolin Chen <nicolinc@nvidia.com>
> > Original-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> 
> This is the latest version I have. But as Jason suggested we can
> possibly switch to short term users to avoid parallel destroy returning
> EBUSY.

We can discuss in that thread, I have the same question as Kevin.

> I am using a mutex lock to block parallel vdevice destroy.

I don't find reason to add a new lock rather than reuse the
idev->igroup->lock, which is already reviewed in Nicolin's series.

[...]

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 3df468f64e7d..fd82140e6320 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -81,14 +81,16 @@ void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
>  struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
>  					  enum iommufd_object_type type)
>  {
> +	XA_STATE(xas, &ictx->objects, id);
>  	struct iommufd_object *obj;
>  
>  	if (iommufd_should_fail())
>  		return ERR_PTR(-ENOENT);
>  
>  	xa_lock(&ictx->objects);
> -	obj = xa_load(&ictx->objects, id);
> -	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
> +	obj = xas_load(&xas);
> +	if (!obj || xa_is_zero(obj) ||

xas_load() & filter out zero entries, then what's the difference from
xa_load()?

> +	    (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
>  	    !iommufd_lock_obj(obj))
>  		obj = ERR_PTR(-ENOENT);
>  	xa_unlock(&ictx->objects);

[...]

>  static int iommufd_destroy(struct iommufd_ucmd *ucmd)
>  {
> +	int ret;
>  	struct iommu_destroy *cmd = ucmd->cmd;
> +	struct iommufd_object *obj;
> +	struct iommufd_device *idev = NULL;
> +
> +	obj = iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
> +	/* Destroying vdevice requires an idevice lock */
> +	if (!IS_ERR(obj) && obj->type == IOMMUFD_OBJ_VDEVICE) {
> +		struct iommufd_vdevice *vdev =
> +			container_of(obj, struct iommufd_vdevice, obj);
> +		/*
> +		 * since vdev have an refcount on idev, this is safe.
> +		 */
> +		idev = vdev->idev;
> +		mutex_lock(&idev->lock);
> +		/* drop the additonal reference taken above */
> +		iommufd_put_object(ucmd->ictx, obj);
> +	}
> +
> +	ret = iommufd_object_remove(ucmd->ictx, NULL, cmd->id, 0);
> +	if (idev)
> +		mutex_unlock(&idev->lock);

I'm trying best not to add vdev/idev specific things to generic
code. I also don't prefer adding a idev specific lock around generic
object remove flow. That makes idev/vdev way to special. So for these
locking things, I prefer more to Nicolin's v5 and revives them.

>  
> -	return iommufd_object_remove(ucmd->ictx, NULL, cmd->id, 0);
> +	return ret;
>  }
>  

[...]

> @@ -147,10 +160,17 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	if (rc)
>  		goto out_abort;
>  	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
> -	goto out_put_idev;
> +	/* don't allow idev free without vdev free */
> +	refcount_inc(&idev->obj.users);

IIRC, it has been suggested no long term refcount to kernel created
object. Besides, you actually disallow nothing.

> +	vdev->idev = idev;
> +	/* vdev lifecycle now managed by idev */
> +	idev->vdev = vdev;
> +	goto out_put_idev_unlock;
>  
>  out_abort:
>  	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
> +out_put_idev_unlock:
> +	mutex_unlock(&idev->lock);
>  out_put_idev:
>  	iommufd_put_object(ucmd->ictx, &idev->obj);
>  out_put_viommu:
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 6328c3a05bcd..0bf4f8b7f8d2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -694,6 +694,12 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #if IS_ENABLED(CONFIG_EEH)
>  	eeh_dev_release(vdev->pdev);
>  #endif
> +
> +	/* destroy vdevice which involves tsm unbind before we disable pci disable */
> +	if (core_vdev->iommufd_device)
> +		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);

Ah.. I think all our effort to destroy vdevice on idevice destruction
is to hide the sequence details from VFIO.

> +
> +	/* tsm unbind should happen before this */
>  	vfio_pci_core_disable(vdev);

I did mention there is still issue when vdevice lifecycle problem is
solved. That VFIO for now do device disable configurations before
iommufd_device_unbind() and cause problem. But my quick idea would
be (not tested):

@@ -544,12 +544,14 @@ static void vfio_df_device_last_close(struct vfio_device_file *df)

        lockdep_assert_held(&device->dev_set->lock);

-       if (device->ops->close_device)
-               device->ops->close_device(device);
        if (iommufd)
                vfio_df_iommufd_unbind(df);
        else
                vfio_device_group_unuse_iommu(device);
+
+       if (device->ops->close_device)
+               device->ops->close_device(device);

>  
>  	mutex_lock(&vdev->igate);
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 34b6e6ca4bfa..8de3d903bfc0 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -63,6 +63,7 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
>  
>  struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
>  u32 iommufd_device_to_id(struct iommufd_device *idev);
> +void iommufd_device_tombstone_vdevice(struct iommufd_device *idev);
>  
>  struct iommufd_access_ops {
>  	u8 needs_pin_pages : 1;
