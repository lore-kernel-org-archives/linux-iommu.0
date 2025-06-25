Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135422097;
	Wed, 25 Jun 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750830685; cv=none; b=AP7uH+W2oJBDScZok5EptnFd+wS1WhOYceLizcosIrOta53IEOM5feTmH7u8ZuyfSa2LgBPPWiJxCdmIyoYCnCMGw8NxwWr/GIl2ih4tHJaeuXQhI5mdj0RISzfqXsdxHTsTd+CIT4F0lO3gGQRo0rxHv+TyU9xf/f2czlr0SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750830685; c=relaxed/simple;
	bh=v2jxSDzl+HanYql75B5ABYiNWBnLJ3SnpH0ZofYRNeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnpiVUHOtYh6HzwXl3SC7tKczhcXq57VmcFSZZtS4XXIXt7g5Szw5G/gWMiwKHe0KdXhgGfgzqAA6oVaeu91lI8/BVNM9FpMy13IyYYMafW6rmYCC6itOX8LpLYfiqpOxgiGG0iESTmWHbu/iBg4cIgfveC/sQuPu7Cs4ilP4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUfDiNVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUfDiNVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDABC4CEEA;
	Wed, 25 Jun 2025 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750830685;
	bh=v2jxSDzl+HanYql75B5ABYiNWBnLJ3SnpH0ZofYRNeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JUfDiNVGCOFOnD7O/08AlkobkiN9AejCTLC/rREbvxkF7qGDWgRJtQ/DjzmpZlizR
	 /ht+QoskG02ZSg+zAuAwJJ3rKLEtnego0bC3cZXGmKJHsuiTiiMBvPie5t82IxnCdd
	 UI57CIUjjbin1G9Vfltc5sOd6prnZoTKvNtDDpjPxnRjqyBrW20Bi+GO6gX/d4ZPAr
	 gcigXlaf+JOOkFa1/iNy/1n9+Do+pRrCKKwVgZmOmqZqvBBqTZXjlvFkoKDZn+Y86G
	 MoRaOg7bS+Am90PoiAXz0qC5NnISXdCn5SHN3uDIPqW4lxdZBBQYv2HZZxsNbxfkQ9
	 XavGWg9cJMopg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
	kevin.tian@intel.com, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	robin.murphy@arm.com, shuah@kernel.org, nicolinc@nvidia.com,
	aik@amd.com, dan.j.williams@intel.com, baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 1/4] iommufd: Add iommufd_object_tombstone_user() helper
In-Reply-To: <20250623094946.1714996-2-yilun.xu@linux.intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-2-yilun.xu@linux.intel.com>
Date: Wed, 25 Jun 2025 11:21:15 +0530
Message-ID: <yq5a4iw45pyk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Add the iommufd_object_tombstone_user() helper, which allows the caller
> to destroy an iommufd object created by userspace.
>
> This is useful on some destroy paths when the kernel caller finds the
> object should have been removed by userspace but is still alive. With
> this helper, the caller destroys the object but leave the object ID
> reserved (so called tombstone). The tombstone prevents repurposing the
> object ID without awareness from the original user.
>
> Since this happens for abnomal userspace behavior, for simplicity, the
> tombstoned object ID would be permanently leaked until
> iommufd_fops_release(). I.e. the original user gets an error when
> calling ioctl(IOMMU_DESTROY) on that ID.
>
> The first use case would be to ensure the iommufd_vdevice can't outlive
> the associated iommufd_device.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 23 +++++++++++++++++-
>  drivers/iommu/iommufd/main.c            | 31 ++++++++++++++++++-------
>  2 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 9ccc83341f32..fbc9ef78d81f 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -187,7 +187,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
>  			     struct iommufd_object *obj);
>  
>  enum {
> -	REMOVE_WAIT_SHORTTERM = 1,
> +	REMOVE_WAIT_SHORTTERM	= BIT(0),
> +	REMOVE_OBJ_TOMBSTONE	= BIT(1),
>  };
>  int iommufd_object_remove(struct iommufd_ctx *ictx,
>  			  struct iommufd_object *to_destroy, u32 id,
> @@ -213,6 +214,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
>  	WARN_ON(ret);
>  }
>  
> +/*
> + * Similar to iommufd_object_destroy_user(), except that the object ID is left
> + * reserved/tombstoned.
> + */
> +static inline void iommufd_object_tombstone_user(struct iommufd_ctx *ictx,
> +						 struct iommufd_object *obj)
> +{
> +	int ret;
> +
> +	ret = iommufd_object_remove(ictx, obj, obj->id,
> +				    REMOVE_WAIT_SHORTTERM | REMOVE_OBJ_TOMBSTONE);
> +
> +	/*
> +	 * If there is a bug and we couldn't destroy the object then we did put
> +	 * back the caller's users refcount and will eventually try to free it
> +	 * again during close.
> +	 */
> +	WARN_ON(ret);
> +}
> +
>  /*
>   * The HWPT allocated by autodomains is used in possibly many devices and
>   * is automatically destroyed when its refcount reaches zero.
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 3df468f64e7d..5fd75aba068b 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -167,7 +167,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
>  		goto err_xa;
>  	}
>  
> -	xas_store(&xas, NULL);
> +	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
>  	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
>  		ictx->vfio_ioas = NULL;
>  	xa_unlock(&ictx->objects);
> @@ -238,6 +238,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>  	struct iommufd_ctx *ictx = filp->private_data;
>  	struct iommufd_sw_msi_map *next;
>  	struct iommufd_sw_msi_map *cur;
> +	XA_STATE(xas, &ictx->objects, 0);
>  	struct iommufd_object *obj;
>  
>  	/*
> @@ -251,16 +252,30 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>  	 */
>  	while (!xa_empty(&ictx->objects)) {
>  		unsigned int destroyed = 0;
> -		unsigned long index;
>  
> -		xa_for_each(&ictx->objects, index, obj) {
> -			if (!refcount_dec_if_one(&obj->users))
> -				continue;
> +		xas_set(&xas, 0);
> +		for (;;) {
> +			rcu_read_lock();
> +			obj = xas_find(&xas, ULONG_MAX);
> +			rcu_read_unlock();
>

What is the need for the rcu_read_lock()? 

> +
> +			if (!obj)
> +				break;
> +
> +			if (!xa_is_zero(obj)) {
> +				if (!refcount_dec_if_one(&obj->users))
> +					continue;
> +
> +				iommufd_object_ops[obj->type].destroy(obj);
> +				kfree(obj);
> +			}
> +
>  			destroyed++;
> -			xa_erase(&ictx->objects, index);
> -			iommufd_object_ops[obj->type].destroy(obj);
> -			kfree(obj);
> +			xas_lock(&xas);
> +			xas_store(&xas, NULL);
> +			xas_unlock(&xas);

is that xas_lock needed?. we can't run a xarray update parallel to this
because neither iommufd ioctl not vfio cdev unbind can happen in parallel.

I have this as an additonal comment added to the function in my change.

/*
 * We don't need additional locks because the iommufd_fops_release() function is
 * only triggered when the iommufd descriptor is released. At that point, no
 * other iommufd-based ioctl operations can be running concurrently.
 *
 * The destruction of the vdevice via idevice unbind is also safe:
 * iommufd_fops_release() can only be called after the idevice has been unbound.
 * The idevice bind operation takes a reference to the iommufd descriptor,
 * preventing early release.
 */


>  		}
> +
>  		/* Bug related to users refcount */
>  		if (WARN_ON(!destroyed))
>  			break;
> -- 
> 2.25.1

-aneesh
