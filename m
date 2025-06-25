Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A828643E
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841302; cv=none; b=m7ATm7DG95kGIG20k7jt43+xjBRj2Q3IDSVKAjJwyDydLzsFBk4O+CU7dm0gRl3mXaw4M2V8zZFXpzn8Gwm1ZH85TiUUobV8vFAlu7M7U7mSno2WG17PBCZJjD1MWFcRoCZs+S9v7C30eCxu1PKx9p5+mieViRD7zUKWj1Xa5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841302; c=relaxed/simple;
	bh=8CxCRl0Lj4fz10PG0ihHzNx5FOrMIdCEzi0JMM7ABYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY+/dZ6QC+9Fc03K3kzk+l2E8LGF7MXuYpnuQv/TFdaq3LVulb/AyE24q0mS3QF/C19uchZHhVYmWKsFmr7hAbQ15X2irn3IvTjZr+ACb1/gKtn87/kx/7/QEKIH/q04dqTEzVR3LCUu3EqByYMob+pAfDSpkF6q1qvQo+nU1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSpzmy7H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSpzmy7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750841301; x=1782377301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8CxCRl0Lj4fz10PG0ihHzNx5FOrMIdCEzi0JMM7ABYU=;
  b=kSpzmy7HQqSGgK3cpLdBAuotHO+jwyJDWpfPL1KMM1OMpSQ9KV1T8NGq
   +UrzUT/NC6dLqPhTlWXR2SDmu+f6iEdx8teSTVAxGyGp5EpkyvJAy4l9+
   fnmZ6yXxhJWWbEBTD92iRLZorq3H8+kg+2a/nm+PSYjGFLsxetfKqtVoA
   dxR0p/N0oF8XuGXmlndfkH0lTaiBLPa0CXyuO/NW32Ao8BTuoRWqloLUU
   WAPMobFa88wvGEP5c/h4+0T+H8Khn1asPIj6EQvftreFGNgBQQtMFnQIb
   wye+kJ17KodxppZrI9XquKjWKE6IlGBx2ns3AJEX1qwhjClcSymHGE+W7
   w==;
X-CSE-ConnectionGUID: G+8WxZ+0SJKq/Q1VIPnziQ==
X-CSE-MsgGUID: ElE+3kz2RZ2yWpKILiucdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70674670"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="70674670"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:48:20 -0700
X-CSE-ConnectionGUID: 0liW6ewcRDywxXsmdIrHnw==
X-CSE-MsgGUID: Qy7hfrfOSu+xQ0N04iDCgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156557524"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 25 Jun 2025 01:48:17 -0700
Date: Wed, 25 Jun 2025 16:40:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 1/4] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aFu2CKWt+IazDiiz@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-2-yilun.xu@linux.intel.com>
 <yq5a4iw45pyk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4iw45pyk.fsf@kernel.org>

On Wed, Jun 25, 2025 at 11:21:15AM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > Add the iommufd_object_tombstone_user() helper, which allows the caller
> > to destroy an iommufd object created by userspace.
> >
> > This is useful on some destroy paths when the kernel caller finds the
> > object should have been removed by userspace but is still alive. With
> > this helper, the caller destroys the object but leave the object ID
> > reserved (so called tombstone). The tombstone prevents repurposing the
> > object ID without awareness from the original user.
> >
> > Since this happens for abnomal userspace behavior, for simplicity, the
> > tombstoned object ID would be permanently leaked until
> > iommufd_fops_release(). I.e. the original user gets an error when
> > calling ioctl(IOMMU_DESTROY) on that ID.
> >
> > The first use case would be to ensure the iommufd_vdevice can't outlive
> > the associated iommufd_device.
> >
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_private.h | 23 +++++++++++++++++-
> >  drivers/iommu/iommufd/main.c            | 31 ++++++++++++++++++-------
> >  2 files changed, 45 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 9ccc83341f32..fbc9ef78d81f 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -187,7 +187,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
> >  			     struct iommufd_object *obj);
> >  
> >  enum {
> > -	REMOVE_WAIT_SHORTTERM = 1,
> > +	REMOVE_WAIT_SHORTTERM	= BIT(0),
> > +	REMOVE_OBJ_TOMBSTONE	= BIT(1),
> >  };
> >  int iommufd_object_remove(struct iommufd_ctx *ictx,
> >  			  struct iommufd_object *to_destroy, u32 id,
> > @@ -213,6 +214,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
> >  	WARN_ON(ret);
> >  }
> >  
> > +/*
> > + * Similar to iommufd_object_destroy_user(), except that the object ID is left
> > + * reserved/tombstoned.
> > + */
> > +static inline void iommufd_object_tombstone_user(struct iommufd_ctx *ictx,
> > +						 struct iommufd_object *obj)
> > +{
> > +	int ret;
> > +
> > +	ret = iommufd_object_remove(ictx, obj, obj->id,
> > +				    REMOVE_WAIT_SHORTTERM | REMOVE_OBJ_TOMBSTONE);
> > +
> > +	/*
> > +	 * If there is a bug and we couldn't destroy the object then we did put
> > +	 * back the caller's users refcount and will eventually try to free it
> > +	 * again during close.
> > +	 */
> > +	WARN_ON(ret);
> > +}
> > +
> >  /*
> >   * The HWPT allocated by autodomains is used in possibly many devices and
> >   * is automatically destroyed when its refcount reaches zero.
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> > index 3df468f64e7d..5fd75aba068b 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -167,7 +167,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
> >  		goto err_xa;
> >  	}
> >  
> > -	xas_store(&xas, NULL);
> > +	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
> >  	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
> >  		ictx->vfio_ioas = NULL;
> >  	xa_unlock(&ictx->objects);
> > @@ -238,6 +238,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
> >  	struct iommufd_ctx *ictx = filp->private_data;
> >  	struct iommufd_sw_msi_map *next;
> >  	struct iommufd_sw_msi_map *cur;
> > +	XA_STATE(xas, &ictx->objects, 0);
> >  	struct iommufd_object *obj;
> >  
> >  	/*
> > @@ -251,16 +252,30 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
> >  	 */
> >  	while (!xa_empty(&ictx->objects)) {
> >  		unsigned int destroyed = 0;
> > -		unsigned long index;
> >  
> > -		xa_for_each(&ictx->objects, index, obj) {
> > -			if (!refcount_dec_if_one(&obj->users))
> > -				continue;
> > +		xas_set(&xas, 0);
> > +		for (;;) {
> > +			rcu_read_lock();
> > +			obj = xas_find(&xas, ULONG_MAX);
> > +			rcu_read_unlock();
> >
> 
> What is the need for the rcu_read_lock()? 

To surpress rcu warning in xas_find().

> 
> > +
> > +			if (!obj)
> > +				break;
> > +
> > +			if (!xa_is_zero(obj)) {
> > +				if (!refcount_dec_if_one(&obj->users))
> > +					continue;
> > +
> > +				iommufd_object_ops[obj->type].destroy(obj);
> > +				kfree(obj);
> > +			}
> > +
> >  			destroyed++;
> > -			xa_erase(&ictx->objects, index);
> > -			iommufd_object_ops[obj->type].destroy(obj);
> > -			kfree(obj);
> > +			xas_lock(&xas);
> > +			xas_store(&xas, NULL);
> > +			xas_unlock(&xas);
> 
> is that xas_lock needed?. we can't run a xarray update parallel to this
> because neither iommufd ioctl not vfio cdev unbind can happen in parallel.

That's true, but also to surpress warning in xas_store().

> 
> I have this as an additonal comment added to the function in my change.
> 
> /*
>  * We don't need additional locks because the iommufd_fops_release() function is
>  * only triggered when the iommufd descriptor is released. At that point, no
>  * other iommufd-based ioctl operations can be running concurrently.
>  *
>  * The destruction of the vdevice via idevice unbind is also safe:
>  * iommufd_fops_release() can only be called after the idevice has been unbound.
>  * The idevice bind operation takes a reference to the iommufd descriptor,
>  * preventing early release.
>  */

That's good. But Jason has another suggestion that no need to clear
tombstones on fops_release(), so we don't need these changes at all.

Thanks,
Yilun

> 
> 
> >  		}
> > +
> >  		/* Bug related to users refcount */
> >  		if (WARN_ON(!destroyed))
> >  			break;
> > -- 
> > 2.25.1
> 
> -aneesh
