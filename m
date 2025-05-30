Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31F1DB548
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623879; cv=none; b=jRdTsIrv5yVCPQ9gQyqL28bFMtEj0oc6eVfntb9kSNboFXRpcq4qoEupruMY87KMNrKo4/CVk/6DxYFIHJ9xa8O7OVqOm6IO1hyMHdBihE0eLw4JnfJQxNbQ45qi6S365Etrw7FctahLcp+4+W6M8EnRZD7mi24fQcEzu9+GraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623879; c=relaxed/simple;
	bh=WzpkuGBzWNCZrmQqLTQZJZEAIZ/mK/45rC2BTeXU+NU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkMfqLEWyemutTPy30YywGLwy+bNxFQd8YJ8gsx2NikTEpHFU0Dq2RvhvMGmXrLBV79eLquc79ZttNsyJbHZoNyee1SteW++9CKOXsxhAFARP6X9GYSFULio7DoTQJqPcw82CdN2oK0kJIQ9RGqGuzaR+hTtBl8I6Ghl2gDgynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KJMSb/DY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KJMSb/DY"
Received: from DESKTOP-0403QTC. (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id B07D4203EE17;
	Fri, 30 May 2025 09:51:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B07D4203EE17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748623875;
	bh=WnSEKzxYTsBMIRxkfogjW91RE7zS7bkqD8PCbdmRo4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=KJMSb/DYBIOR0oZ9vYhMce3ff5+gVKa0s9soGlzpb/3a304i8n3Eag0Ie0OLZjiYP
	 T8l28Kfj8Pb1SAlV5bkVpRU2vsVzj6lQ8pXIej+NCCTk/y01vYm/D/AbR7lhY3wLgW
	 2e8XaXLJg2/3ntmx3872+Mksiit1PaTqaKVL60mE=
Date: Fri, 30 May 2025 09:51:12 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar
 Hariharan <eahariha@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250530095112.5ed4c249@DESKTOP-0403QTC.>
In-Reply-To: <20250527000511.GK61950@nvidia.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
	<20250527000511.GK61950@nvidia.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 26 May 2025 21:05:11 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, May 16, 2025 at 09:45:21AM -0700, Jacob Pan wrote:
> > For no-iommu enabled devices working under IOMMUFD VFIO compat
> > mode, the group open path does not call vfio_df_open() and the
> > open_count is 0. So calling vfio_df_close() in the group close path
> > will trigger warning in vfio_assert_device_open(device);
> > 
> > E.g. The following warning can be seen by running VFIO test.
> > https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> > CONFIG_VFIO_CONTAINER = n
> > [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by
> > user (vfio-noiommu-pc:164) Failed to get device info
> > [   29.096540] ------------[ cut here ]------------
> > [   29.096616] WARNING: CPU: 1 PID: 164 at
> > drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
> > 
> > This patch adds checks for no-iommu mode and open_count to skip
> > calling vfio_df_close.
> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/vfio/group.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)  
> 
> Sorry, this should have a fixes line:
> 
> I think it is probably
> 
> Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation
> out of vfio_iommufd_bind()")
> 
> By the look of it, since that is what started skipping the
> vfio_df_open()
> 
> But after looking at that patch I'm now doubting that this is the
> right fix.
> 
> Previously we'd still do vfio_df_device_first_open(), just the
> vfio_df_iommufd_bind() was skipped.
> 
> Now we skip all of vfio_df_device_first_open() which also means we
> skip:
> 
> 	if (!try_module_get(device->dev->driver->owner))
> 		return -ENODEV;
> 
> and
> 	if (device->ops->open_device) {
> 		ret = device->ops->open_device(device);
> 
> Which seems wrong to me?? We only want to skip the bind, we should
> still do open_device! At least that is how it was before 6086e
> 
> So.. This may not be the right fix.
> 
> Maybe more like:
Looks good to me, please disregard my patch.
Tested-by:  Jacob Pan <jacob.pan@linux.microsoft.com> 

I guess you will submit this?

> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c321d442f0da09..1b6a0e30544401 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct
> vfio_device_file *df)
>  		 * implies they expected translation to exist
>  		 */
>  		if (!capable(CAP_SYS_RAWIO) ||
> -		    vfio_iommufd_device_has_compat_ioas(device,
> df->iommufd))
> +		    vfio_iommufd_device_has_compat_ioas(device,
> df->iommufd)) { ret = -EPERM;
> -		else
> -			ret = 0;
> -		goto out_put_kvm;
> +			goto out_put_kvm;
> +		    }
>  	}
>  
>  	ret = vfio_df_open(df);
>  	if (ret)
>  		goto out_put_kvm;
>  
> -	if (df->iommufd && device->open_count == 1) {
> +	if (df->iommufd && device->open_count == 1 &&
> +	    !vfio_device_is_noiommu(device)) {
>  		ret = vfio_iommufd_compat_attach_ioas(device,
> df->iommufd); if (ret)
>  			goto out_close_device;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index c8c3a2d53f86e1..26c9c3068c77da 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file
> *df) 
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	if (vfio_device_is_noiommu(vdev))
> -		return;
> -
>  	if (vdev->ops->unbind_iommufd)
>  		vdev->ops->unbind_iommufd(vdev);
>  }
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 1fd261efc582d0..ff19ea05442e7d 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -506,17 +506,19 @@ static int vfio_df_device_first_open(struct
> vfio_device_file *df) {
>  	struct vfio_device *device = df->device;
>  	struct iommufd_ctx *iommufd = df->iommufd;
> -	int ret;
> +	int ret = 0;
>  
>  	lockdep_assert_held(&device->dev_set->lock);
>  
>  	if (!try_module_get(device->dev->driver->owner))
>  		return -ENODEV;
>  
> -	if (iommufd)
> -		ret = vfio_df_iommufd_bind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			ret = vfio_df_iommufd_bind(df);
> +	} else {
>  		ret = vfio_device_group_use_iommu(device);
> +	}
>  	if (ret)
>  		goto err_module_put;
>  
> @@ -528,10 +530,12 @@ static int vfio_df_device_first_open(struct
> vfio_device_file *df) return 0;
>  
>  err_unuse_iommu:
> -	if (iommufd)
> -		vfio_df_iommufd_unbind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			vfio_df_iommufd_unbind(df);
> +	} else {
>  		vfio_device_group_unuse_iommu(device);
> +	}
>  err_module_put:
>  	module_put(device->dev->driver->owner);
>  	return ret;
> @@ -546,10 +550,12 @@ static void vfio_df_device_last_close(struct
> vfio_device_file *df) 
>  	if (device->ops->close_device)
>  		device->ops->close_device(device);
> -	if (iommufd)
> -		vfio_df_iommufd_unbind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			vfio_df_iommufd_unbind(df);
> +	} else {
>  		vfio_device_group_unuse_iommu(device);
> +	}
>  	module_put(device->dev->driver->owner);
>  }
>  
> 
> Jason

