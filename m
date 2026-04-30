Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5228003A
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591880; cv=none; b=Ollv2uVvwEnfHK5frLbzearQR3rNk/usST8CTf2Wu5kxz8wcHflhOB03g0kgNN69YSlzAW8rvETWiK3gby3xXGJqFVI4kcTJNFhaDMhtDBEZ0fxkSOE8yanVj4ueuGI3SPM3bruzY/tMAVFs+2myFrsEHKFo9ezmpWWV9ngdyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591880; c=relaxed/simple;
	bh=NE5UL/Xqzrxx/TIBdq2BE08ubZku6RHBkLySUPvPNEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhGhI4ooCQeOPvfYJVNGqZtEhpWvL9hEj2pvyetxF8L4yjFwoR/FLT3fQmJGWEXBCabapf2R1TtdAuZOD1rTSSfgnCRLux42D4RttohAepyze6rcBezOSfqFVtyqH3ple3dslGt4TnBVfxGoDKtY7SP6+oEIvUR4n94f1NwOSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lTkoQtX9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lTkoQtX9"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 258ED20B7165;
	Thu, 30 Apr 2026 16:31:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 258ED20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777591878;
	bh=XDrfLFPKZJ0dcM9rnJs32YmLCDDdFUYqJKxUFBT9n6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lTkoQtX9QoRx4iGR3lRpkhw5XifiF6dfy13zd9WNzWuYmd1wGgAVco2K7k8ev+38t
	 AIQ0gksoX6FRnj/g3KIcoskkkPO48WBQVMn8TaoloX3aTBeXS+ghKao1lG9jhuZ3zF
	 mhpfOi0oQC1cXZJlCXN8ePc0reuLyYg8xOlupnBs=
Date: Thu, 30 Apr 2026 16:31:16 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 07/10] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260430163116.000049cc@linux.microsoft.com>
In-Reply-To: <20260416144915.4fe38481@shazbot.org>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-8-jacob.pan@linux.microsoft.com>
	<20260416144915.4fe38481@shazbot.org>
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

Hi Alex,

On Thu, 16 Apr 2026 14:49:15 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Tue, 14 Apr 2026 14:14:09 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > Now that devices under noiommu mode can bind with IOMMUFD and
> > perform IOAS operations, lift restrictions on cdev from VFIO side.
> > 
> > No IOMMU cdevs are explicitly named with noiommu prefix. e.g.
> > 
> >     /dev/vfio/
> >     |-- 7
> >     |-- devices
> >     |   `-- noiommu-vfio0
> >     `-- vfio  
> 
> The group interface already does this, so the "7" is not
> representative.  In fact, since the no-iommu groups are created as
> device are bound, chances are they'd be in sync for a single device,
> so this would be 'noiommu-0'.  NB. it's correctly represented in the
> subsequent patches.
> 
will fix.

> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > 
> > ---
> > v4:
> >    - Move vfio_device_has_group() related out to 5/10
> >    - Keep wait loop in vfio_unregister_group_dev (Jason)
> > v3:
> >    - Add explict dependency on !GENERIC_ATOMIC64
> > v2:
> >    - Fix build dependency on IOMMU_SUPPORT
> > ---
> >  drivers/vfio/Kconfig     |  8 ++++++--
> >  drivers/vfio/iommufd.c   |  7 -------
> >  drivers/vfio/vfio.h      |  8 +-------
> >  drivers/vfio/vfio_main.c | 20 ++++++--------------
> >  4 files changed, 13 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index ceae52fd7586..c013255bf7f1 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
> >  	  The VFIO device cdev is another way for userspace to get
> > device access. Userspace gets device fd by opening device cdev under
> >  	  /dev/vfio/devices/vfioX, and then bind the device fd
> > with an iommufd
> > -	  to set up secure DMA context for device access.  This
> > interface does
> > -	  not support noiommu.
> > +	  to set up secure DMA context for device access.
> >  
> >  	  If you don't know what to do here, say N.
> >  
> > @@ -63,6 +62,11 @@ endif
> >  config VFIO_NOIOMMU
> >  	bool "VFIO No-IOMMU support"
> >  	depends on VFIO_GROUP
> > +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires
> > cmpxchg64
> > +	select GENERIC_PT
> > +	select IOMMU_PT
> > +	select IOMMU_PT_AMDV1
> > +	depends on IOMMU_SUPPORT  
> 
> Cosmetic nit, group the depends together.
> 
will do.

> Noting my previous concern about why we keep group support for
> non-container builds, what about making VFIO_GROUP_NOIOMMU and
> VFIO_CDEV_NOIOMMU?
Yes,  separate CONFIG option made it much cleaner. No need to do all
the null group checks and avoided problem caused by mutable
vfio_noiommu. I am also adding an IOMMUFD_NOIOMMU option where
CDEV_NOIOMMU depends on, just to avoid layering violation. Will be
in v5.
vfio/Kconfig
+config VFIO_CDEV_NOIOMMU
+       bool "VFIO cdev No-IOMMU support"
+       depends on VFIO_DEVICE_CDEV
+       depends on IOMMUFD_NOIOMMU
and
iommufd/Kconfig
+config IOMMUFD_NOIOMMU
+       bool "IOMMUFD no-IOMMU support"
+       depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
+       select GENERIC_PT
+       select IOMMU_PT
+       select IOMMU_PT_AMDV1


> Also, vfio no-iommu is traditionally gated on CAP_SYS_RAWIO, but those
> tests are all in the vfio group code and not replicated here for cdev,
> afaict.  That would relax the usage requirements quite significantly.
Good point, I will add CAP_SYS_RAWIO enforcement in cdev open and
iommufd bind path to be parity with the group model.

> 
> >  	help
> >  	  VFIO is built on the ability to isolate devices using
> > the IOMMU. Only with an IOMMU can userspace access to DMA capable
> > devices be diff --git a/drivers/vfio/iommufd.c
> > b/drivers/vfio/iommufd.c index a38d262c6028..26c9c3068c77 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct vfio_device_file
> > *df) 
> >  	lockdep_assert_held(&vdev->dev_set->lock);
> >  
> > -	/* Returns 0 to permit device opening under noiommu mode */
> > -	if (vfio_device_is_noiommu(vdev))
> > -		return 0;
> > -
> >  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> >  }
> >  
> > @@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct
> > vfio_device_file *df) 
> >  	lockdep_assert_held(&vdev->dev_set->lock);
> >  
> > -	if (vfio_device_is_noiommu(vdev))
> > -		return;
> > -
> >  	if (vdev->ops->unbind_iommufd)
> >  		vdev->ops->unbind_iommufd(vdev);
> >  }
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index 9e25605da564..ad9e09f6d095 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -376,19 +376,13 @@ void vfio_init_device_cdev(struct vfio_device
> > *device); 
> >  static inline int vfio_device_add(struct vfio_device *device)
> >  {
> > -	/* cdev does not support noiommu device */
> > -	if (vfio_device_is_noiommu(device))
> > -		return device_add(&device->device);
> >  	vfio_init_device_cdev(device);
> >  	return cdev_device_add(&device->cdev, &device->device);
> >  }
> >  
> >  static inline void vfio_device_del(struct vfio_device *device)
> >  {
> > -	if (vfio_device_is_noiommu(device))
> > -		device_del(&device->device);
> > -	else
> > -		cdev_device_del(&device->cdev, &device->device);
> > +	cdev_device_del(&device->cdev, &device->device);
> >  }
> >  
> >  int vfio_device_fops_cdev_open(struct inode *inode, struct file
> > *filep); diff --git a/drivers/vfio/vfio_main.c
> > b/drivers/vfio/vfio_main.c index 5d7c2d014689..3ae3d34c21cc 100644
> > --- a/drivers/vfio/vfio_main.c
> > +++ b/drivers/vfio/vfio_main.c
> > @@ -332,13 +332,15 @@ static int __vfio_register_dev(struct
> > vfio_device *device, if (!device->dev_set)
> >  		vfio_assign_device_set(device, device);
> >  
> > -	ret = dev_set_name(&device->device, "vfio%d",
> > device->index);
> > +	ret = vfio_device_set_group(device, type);
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = vfio_device_set_group(device, type);
> > +	/* Just to be safe, expose to user explicitly noiommu cdev
> > node */
> > +	ret = dev_set_name(&device->device, "%svfio%d",
> > +					   device->noiommu ?
> > "noiommu-" : "", device->index); if (ret)
> > -		return ret;
> > +		goto err_out;
> >  
> >  	/*
> >  	 * VFIO always sets IOMMU_CACHE because we offer no way
> > for userspace to @@ -359,7 +361,7 @@ static int
> > __vfio_register_dev(struct vfio_device *device,
> > refcount_set(&device->refcount, 1); 
> >  	/* noiommu device w/o container may have NULL group */
> > -	if (!vfio_device_has_group(device))
> > +	if (vfio_device_is_noiommu(device) &&
> > !vfio_device_has_group(device)) return 0;
> >  
> >  	vfio_device_group_register(device);
> > @@ -396,16 +398,6 @@ void vfio_unregister_group_dev(struct
> > vfio_device *device) bool interrupted = false;
> >  	long rc;
> >  
> > -	/*
> > -	 * For noiommu devices without a container, thus no dummy
> > group,
> > -	 * simply delete and unregister to balance refcount.
> > -	 */
> > -	if (!vfio_device_has_group(device)) {
> > -		vfio_device_del(device);
> > -		vfio_device_put_registration(device);
> > -		return;
> > -	}
> > -
> >  	/*
> >  	 * Prevent new device opened by userspace via the
> >  	 * VFIO_GROUP_GET_DEVICE_FD in the group path.  

