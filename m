Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944D1F8723
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886422; cv=none; b=X8CoCTxIX7kgpZjkQYzMsE05qph6LBR27ik/kAnzeDfkxHjBmJYfYTnZwZbD6kM0cZ1STTYRCMJBCBl8jQOUMh3wxnbMvrlESyGnrK4ckv4fIK2sUlOgpfAZVb7tVPFYZrWGvmssJj0Gvn7adwI+tzPecwV2mauUrRsLB9mQra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886422; c=relaxed/simple;
	bh=TvPe6sn2VwKv6+XCrQDIbSVH+bc8I6FtHM/fuPjgMTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaqP+T3bXrbjof4bKSQwNM/nmrGMn2+joJmebJkFSMAdLTvOj71IhzQtqeNzPDHbfN7NZU2/tbNNGumGmemX8wdy1SwyGWDX11QDQnNw9eAgJ+R8M6Hznpn9q6Z2MxDA5Qltiowet5PWMcd/iLsobOt9u0/no/CmTjbYteCn280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk1F35ko; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk1F35ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751886420; x=1783422420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TvPe6sn2VwKv6+XCrQDIbSVH+bc8I6FtHM/fuPjgMTU=;
  b=hk1F35koOAE+Ol/wA9iNnOykNCqdsPDaYS3WVGNAKGZpvNzJkpNyaWgM
   bsUWgMN98sVd2cR3jf87abn+oUykFH2KZ7LCFY09pZocPSLBkhqdrdxbk
   WtV9sqtLu8dnG32cetEBMT3SEovxeY4Vda2MrmJ5WtXEsyPe0tsCp/+4W
   9LhT9qmfortmcmBSGYMzmvl/2bHeH3NlXPvMXyhvKQN+Ch8xVC92TSEOY
   ADSQzQaL6S1IMn9G/D+sX1hmQLUpuzosCpHipzM31Kwe2htPCTcLb6Nx9
   0IZ19rplmaEoLS1mIHFqtoE4CpfpVc0QPw4Co+kkP1W/Pv7JRFknqREgc
   A==;
X-CSE-ConnectionGUID: yw9uLFHwSna4sInN43bGnw==
X-CSE-MsgGUID: 0xf2c/2IRJytGsg+cRat/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53984780"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="53984780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 04:07:00 -0700
X-CSE-ConnectionGUID: ia13fup7RQ+X/5nkMp688w==
X-CSE-MsgGUID: 33RwzANqShqF203blNLRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="186140785"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jul 2025 04:06:56 -0700
Date: Mon, 7 Jul 2025 18:58:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aGuoZUaNOgclC2uU@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
 <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
 <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250702124042.GD1051729@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702124042.GD1051729@nvidia.com>

On Wed, Jul 02, 2025 at 09:40:42AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 02, 2025 at 09:13:50AM +0000, Tian, Kevin wrote:
> > > > Yes, you can't touch idev inside the destroy function at all, under
> > > > any version. idev is only valid if you have a refcount on vdev.
> > > >
> > > > But why are you touching this lock? Arrange things so abort doesn't
> > > > touch the idev??
> > > 
> > > idev has a pointer idev->vdev to track the vdev's lifecycle.
> > > idev->igroup->lock protects the pointer. At the end of
> > > iommufd_vdevice_destroy() this pointer should be NULLed so that idev
> > > knows vdev is really destroyed.
> 
> Well, that is destroy, not abort, but OK, there is an issue with
> destroy.
> 
> > but comparing to that I'd prefer to the original wait approach...
> 
> Okay, but lets try to keep the wait hidden inside the refcounting..
> 
> The issue here is we don't hold a refcount on idev while working with
> idev. Let's fix that and then things should work properly?
> 
> Maybe something like this:
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 4e781aa9fc6329..9174fa7c972b80 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -178,12 +178,20 @@ static void iommufd_device_remove_vdev(struct iommufd_device *idev)
>  	mutex_unlock(&idev->igroup->lock);
>  }
>  
> +void iommufd_device_pre_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_device *idev =
> +		container_of(obj, struct iommufd_device, obj);
> +
> +	/* Release the short term users on this */
> +	iommufd_device_remove_vdev(idev);
> +}
> +
>  void iommufd_device_destroy(struct iommufd_object *obj)
>  {
>  	struct iommufd_device *idev =
>  		container_of(obj, struct iommufd_device, obj);
>  
> -	iommufd_device_remove_vdev(idev);
>  	iommu_device_release_dma_owner(idev->dev);
>  	iommufd_put_group(idev->igroup);
>  	if (!iommufd_selftest_is_mock_dev(idev->dev))
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index b2e8e106c16158..387c630fdabfbd 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -151,6 +151,9 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
>  	if (refcount_dec_and_test(&to_destroy->shortterm_users))
>  		return 0;
>  
> +	if (iommufd_object_ops[to_destroy->type].pre_destroy)
> +		iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
> +
>  	if (wait_event_timeout(ictx->destroy_wait,
>  			       refcount_read(&to_destroy->shortterm_users) ==i 0,

I still see concerns here. The pre_destroy() and wait_event is before the
idev's users count decreasing to 0, which means a new user could get in.
The worse thing is the new user could hold the shortterm_users until
pre_destroy(), but there isn't a second pre_destroy()...

I think extending the life of shortterm_users at runtime makes things
complex. My idea is keep the original definition of shortterm_users at
runtime, only repurpose it as a wait completion after users refcount == 0.
I.e. idev increase its own shortterm_users, waiting for vdev to decrease
it.

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9876bf70980a..49b787bc0688 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -147,8 +147,15 @@ static void iommufd_device_remove_vdev(struct iommufd_device *idev)
                goto out_unlock;

        vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
-       if (IS_ERR(vdev))
+       if (IS_ERR(vdev)) {
+               /*
+               * vdev is removed from xarray by userspace, but is not
+               * destroyed. We should wait for vdev real destruction before
+               * idev destruction.
+               */
+               iommufd_object_destroy_wait_prepare(&idev->obj);
                goto out_unlock;
+       }

        /* Should never happen */
        if (WARN_ON(vdev != idev->vdev)) {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 08f3c66366ea..6620006df8d1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -180,6 +180,47 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
                wake_up_interruptible_all(&ictx->destroy_wait);
 }

+/*
+ * The iommufd_object_destroy_wait_xx() are used to synchronize the last minute
+ * destructions of interrelated objects. E.g. the vdev's destroy() should
+ * always be called before idev's destroy().
+ *
+ * iommufd_object_destroy_wait_prepare() should only be called by
+ * later-destroyer in its pre_destroy() ops, where the users & shortterm_users
+ * refcounts are all zeroed. I.e. no new user is possible. Use "users == 0 &&
+ * shortterm_users == 1" as the "destroy wait" state, as this combination
+ * is not used in runtime usecase and it also prevents new users.
+ *
+ * The later-destroyer should use their own locking to ensure the
+ * first-destroyer still exists when calling this function.
+ */
+static inline void
+iommufd_object_destroy_wait_prepare(struct iommufd_object *to_destroy)
+{
+       if (WARN_ON(refcount_read(&to_destroy->users) != 0 ||
+                   refcount_read(&to_destroy->shortterm_users) != 0))
+               return;
+
+       refcount_set(&to_destroy->shortterm_users, 1);
+}
+
+/*
+ * iommufd_object_destroy_wait_complete() should be called by first-destroyer
+ * in its destroy() ops. The first-destroyer should not access the
+ * later-destroyer after calling this function.
+ */
+static inline void
+iommufd_object_destroy_wait_complete(struct iommufd_ctx *ictx,
+                                    struct iommufd_object *to_destroy)
+{
+       if (refcount_read(&to_destroy->users) != 0 ||
+           refcount_read(&to_destroy->shortterm_users) != 1)
+               return;
+
+       refcount_dec(&to_destroy->shortterm_users);
+       wake_up_interruptible_all(&ictx->destroy_wait);
+}
+
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
                                      struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index fbccfbd8fb03..148218293f55 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -96,15 +96,37 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
        return obj;
 }

+static int iommufd_object_pre_destroy_wait(struct iommufd_ctx *ictx,
+                                          struct iommufd_object *to_destroy)
+{
+       if (!iommufd_object_ops[to_destroy->type].pre_destroy)
+               return 0;
+
+       /*
+        * pre_destroy() may put the object in destroy wait state (users == 0
+        * && shortterm_users == 1). Another thread completes the waiting by
+        * decreasing the shortterm_users back to 0. The helpers
+        * iommufd_object_destroy_wait_prepare() and
+        * iommufd_object_destroy_wait_complete() should be used for this
+        * purpose.
+        */
+       iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
+       if (wait_event_timeout(ictx->destroy_wait,
+                              refcount_read(&to_destroy->shortterm_users) ==
+                                       0,
+                              msecs_to_jiffies(60000)))
+               return 0;
+
+       pr_crit("Time out waiting for iommufd object to become free\n");
+       return -EBUSY;
+}
+
 static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
                                             struct iommufd_object *to_destroy)
 {
        if (refcount_dec_and_test(&to_destroy->shortterm_users))
                return 0;

-       if (iommufd_object_ops[to_destroy->type].pre_destroy)
-               iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
-
        if (wait_event_timeout(ictx->destroy_wait,
                                refcount_read(&to_destroy->shortterm_users) ==
                                        0,
@@ -184,6 +206,10 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
                ret = iommufd_object_dec_wait_shortterm(ictx, obj);
                if (WARN_ON(ret))
                        return ret;
+       } else {
+               ret = iommufd_object_pre_destroy_wait(ictx, obj);
+               if (WARN_ON(ret))
+                       return ret;
        }

        iommufd_object_ops[obj->type].destroy(obj);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index d49e8f0c8bb3..a7feefd5e472 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -103,11 +103,12 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 {
        struct iommufd_vdevice *vdev =
                container_of(obj, struct iommufd_vdevice, obj);
+       struct iommufd_device *idev = vdev->idev;

-       mutex_lock(&vdev->idev->igroup->lock);
+       mutex_lock(&idev->igroup->lock);
        iommufd_vdevice_abort(obj);
-       mutex_unlock(&vdev->idev->igroup->lock);
-       iommufd_put_object(vdev->viommu->ictx, &vdev->idev->obj);
+       mutex_unlock(&idev->igroup->lock);
+       iommufd_object_destroy_wait_complete(idev->ictx, &idev->obj);
 }

 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -185,8 +186,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 out_unlock_igroup:
        mutex_unlock(&idev->igroup->lock);
 out_put_idev:
-       if (rc)
-               iommufd_put_object(ucmd->ictx, &idev->obj);
+       iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
        iommufd_put_object(ucmd->ictx, &viommu->obj);
        return rc;
