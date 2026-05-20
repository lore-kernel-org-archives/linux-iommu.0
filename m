Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173173F86F4
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300918; cv=none; b=BTXMI/XwG4CEL7cAlrF6kAZAl4YEkQSZw22Kz7yV5EaafQOgvaNiyG4p1CtK1mVjqZKgmRDu+oQK8hZb9l1N3npsZO+L93o74/WdzyoxZvIlWP2GHpH/VhVhWrK/6d19WB2T4bh+VUs47WPygd5MiaX1roFBBf1NZJmGPg+eevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300918; c=relaxed/simple;
	bh=OS9DlG9+xP6pHRsPUNnJHBZKr4Dsc6g1NV9wQpL8+/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNgDjrWwHru4Kj7ty41kA0QeHkDJ4Od9ed8kpZ5tkrqgV9U/a07EyfrProt7Xj9USF1A0Em8OC94nSjvzVugRU6I7HMdPsRrFKwRj0GdgzC9dTeiQ4fwPeX3tpcnjjHHqsgORcimX0k5rmls9b5Vi/miX7p5mh5qKzr1AeY5bRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qexsou1h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qexsou1h"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 49F8020B7167;
	Wed, 20 May 2026 11:15:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49F8020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779300908;
	bh=t6C9qOV2fZgdqqDL8oC0l2IKVRKrv5LoXHVAZJGcQd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qexsou1htpNFxAtWhpS6rO6KKktY1eOK6SG6JcIXOsx0M/UdEil/KkdpDqhBEZ87T
	 UixoMVQqFnD6/W3x4YHcfcQIzesd69xzjfxyjWWBWIbi3L1TP2tVsVCp9GJJ1C8QUp
	 o8pL1w8VBZ5Gt0tc7w1NZJuD2eloVYEGxdODcz6Q=
Date: Wed, 20 May 2026 11:15:13 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260520111513.0000188d@linux.microsoft.com>
In-Reply-To: <95235a41-f9b3-4b5b-9a34-489a9ff7eac5@intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
	<20260519214613.167e8d5b@shazbot.org>
	<95235a41-f9b3-4b5b-9a34-489a9ff7eac5@intel.com>
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

On Wed, 20 May 2026 15:20:26 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 5/20/26 11:46, Alex Williamson wrote:
> > On Mon, 11 May 2026 11:41:12 -0700
> > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> >   
> >> Now that devices under noiommu mode can bind with IOMMUFD and
> >> perform IOAS operations, lift restrictions on cdev from VFIO side.
> >>
> >> Remove the vfio_device_is_group_noiommu() early returns in
> >> vfio_df_iommufd_bind() and vfio_df_iommufd_unbind() so that both
> >> group and cdev noiommu devices go through the standard iommufd bind
> >> path. This is safe because iommufd_device_bind() now handles
> >> noiommu devices via its own iommufd_device_is_noiommu() check.
> >>
> >> Add CAP_SYS_RAWIO checks for cdev open and bind under noiommu to
> >> maintain security parity with the group noiommu path.
> >>
> >> No IOMMU cdevs are explicitly named with noiommu prefix. e.g.
> >>
> >>      /dev/vfio/
> >>      |-- devices
> >>      |   `-- noiommu-vfio0
> >>      `-- vfio
> >>
> >> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> >> ---
> >> v5:
> >>     - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
> >>       and its dependencies
> >>     - Add comment to explain vfio_noiommu conditional definition
> >> (Alex)
> >>     - Removed early return for group noiommu in bind/unbind
> >>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
> >>     - Update unsafe_noiommu Kconfig help text (Kevin)
> >>     - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> >> v4:
> >>     - Remove early return in iommufd_bind for noiommu (Alex)
> >> v3:
> >>     - Consolidate into fewer patches
> >> v2:
> >>     - removed unnecessary device->noiommu set in
> >>       iommufd_vfio_compat_ioas_get_id()
> >> ---
> >>   drivers/vfio/Kconfig       |  3 +--
> >>   drivers/vfio/device_cdev.c | 10 ++++++++++
> >>   drivers/vfio/iommufd.c     |  7 -------
> >>   drivers/vfio/vfio.h        | 22 ++++++++++++++--------
> >>   drivers/vfio/vfio_main.c   | 25 ++++++++++++++++++++-----
> >>   include/linux/vfio.h       |  1 +
> >>   6 files changed, 46 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> >> index b1b1633412a9..b1a260b6054c 100644
> >> --- a/drivers/vfio/Kconfig
> >> +++ b/drivers/vfio/Kconfig
> >> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
> >>   	  The VFIO device cdev is another way for userspace to
> >> get device access. Userspace gets device fd by opening device cdev
> >> under /dev/vfio/devices/vfioX, and then bind the device fd with an
> >> iommufd
> >> -	  to set up secure DMA context for device access.  This
> >> interface does
> >> -	  not support noiommu.
> >> +	  to set up secure DMA context for device access.
> >>   
> >>   	  If you don't know what to do here, say N.
> >>   
> >> diff --git a/drivers/vfio/device_cdev.c
> >> b/drivers/vfio/device_cdev.c index 54abf312cf04..46a808244398
> >> 100644 --- a/drivers/vfio/device_cdev.c
> >> +++ b/drivers/vfio/device_cdev.c
> >> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode
> >> *inode, struct file *filep) struct vfio_device_file *df;
> >>   	int ret;
> >>   
> >> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> >> +		return -EPERM;
> >> +
> >>   	/* Paired with the put in vfio_device_fops_release() */
> >>   	if (!vfio_device_try_get_registration(device))
> >>   		return -ENODEV;
> >> @@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct
> >> vfio_device_file *df, if (df->group)
> >>   		return -EINVAL;
> >>   
> >> +	/*
> >> +	 * CAP_SYS_RAWIO is already checked at cdev open, recheck
> >> here
> >> +	 * in case the fd was passed to a less privileged process.
> >> +	 */
> >> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> >> +		return -EPERM;
> >> +
> >>   	ret = vfio_device_block_group(device);
> >>   	if (ret)
> >>   		return ret;
> >> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> >> index 39079ab27f92..bc80056c74d3 100644
> >> --- a/drivers/vfio/iommufd.c
> >> +++ b/drivers/vfio/iommufd.c
> >> @@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct
> >> vfio_device_file *df) 
> >>   	lockdep_assert_held(&vdev->dev_set->lock);
> >>   
> >> -	/* Returns 0 to permit device opening under noiommu mode
> >> */
> >> -	if (vfio_device_is_group_noiommu(vdev))
> >> -		return 0;
> >> -
> >>   	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> >>   }
> >>   
> >> @@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct
> >> vfio_device_file *df) 
> >>   	lockdep_assert_held(&vdev->dev_set->lock);
> >>   
> >> -	if (vfio_device_is_group_noiommu(vdev))
> >> -		return;
> >> -
> >>   	if (vdev->ops->unbind_iommufd)
> >>   		vdev->ops->unbind_iommufd(vdev);
> >>   }
> >> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> >> index 602623cacfc0..ac79b1a2fce9 100644
> >> --- a/drivers/vfio/vfio.h
> >> +++ b/drivers/vfio/vfio.h
> >> @@ -36,7 +36,7 @@ vfio_allocate_device_file(struct vfio_device
> >> *device); 
> >>   extern const struct file_operations vfio_device_fops;
> >>   
> >> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
> >> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) ||
> >> IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)  
> > 
> > Have you considered what happens when these are y/n or n/y?
> > 
> > I think in the former case we can create cdev devices for
> > group-noiommu devices that are not labeled noiommu, skip the
> > CAP_SYS_RAWIO test, but will fail to bind.  In the latter case, I
> > think we fail to setup an iommufd_device and unbind will segfault.
> > 
> > We really don't need to support independently setting GROUP vs CDEV
> > NOIOMMU, the suggestion was to try to get NOIOMMU from depending on
> > VFIO_GROUP.  We can do that other ways though and I think we can do
> > it without the rename in patch 1 that will inevitably result in
> > some lost config options for NOIOMMU on upgrade.
> > 
> > The Kconfig may get messy, perhaps something like:
> > 
> > config VFIO_NOIOMMU
> > 	bool "VFIO No-IOMMU support"
> > 	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
> > 	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > IOMMUFD_VFIO_CONTAINER depends on !VFIO_DEVICE_CDEV ||
> > !GENERIC_ATOMIC64 select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
> > 
> > Sorry if the previous suggestion sent us astray, but the subtleties
> > of independent support look tricky.  Thanks,  
> 
> this also looks better to me. Less kconfigs. :)
> 
agreed, let me give it a try in v6.

> just one nit: current VFIO_NOIOMMU only depends on VFIO_GROUP, maybe a
> separate patch to extend it depends on 'VFIO_GROUP && (VFIO_CONTAINER
> || IOMMUFD_VFIO_CONTAINER)' first, then add the cdev path noiommu
> dependency.

I had this below in patch 1/9. will do in a separate patch.
Thanks,

Jacob

--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -60,9 +60,9 @@ config VFIO_IOMMU_SPAPR_TCE
 	default VFIO
 endif
 
-config VFIO_NOIOMMU
-	bool "VFIO No-IOMMU support"
-	depends on VFIO_GROUP
+config VFIO_GROUP_NOIOMMU
+	bool "VFIO group No-IOMMU support"
+	depends on VFIO_GROUP && (VFIO_CONTAINER ||
IOMMUFD_VFIO_CONTAINER) help
