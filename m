Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16E4C0433
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093481; cv=none; b=c0x+vb7h3Yb16G5adHXlmIHBbXpgajbkQKth1dTPrd7qgCuuEF5u2DVfQ5tZF4sfNXgiN4JcJKaXQfFDD5UhZ/RhLjnvnbi3ZtJH/BU/oDhlgMMnAk8RDEXsccw23WlJKYZYGajfT7powR0a7y1Z/ye1jqzgzZRKWGowXrbHbqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093481; c=relaxed/simple;
	bh=l8q3fQT1Uhf9PefZsPEXCZLfXMFVhrdJuNGVG2hZFIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fay1k4T29o6xMu7cskM+GeaX0lFFOHbYnVPqAMir/kYBQ69sQpaHxEiFPWLUgRb/u36Hetolx13JiXoWcOnbrPC1P98K6alalLqxsN7pbWDP3VsEe7gEpMjihE7H8+B/DnI/vpjg+jvlA77sjpgoBZS7EPVceak0bkLQK2zpq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YfgnQ4zI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YfgnQ4zI"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF9AF20B7165;
	Wed,  6 May 2026 11:51:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF9AF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778093476;
	bh=FqkE3AnjOC54q+/CUtG8ChoGtSX/vykzC0WVfkKDCWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YfgnQ4zIxpKyeJI5MQKPjqThOooF3HLoQpePJ5Jdc56rkuAb2eFeDec+q6fuKQ7WP
	 g8C3G6eEy9Au3NU5arPkDBzXb/+TTo9TBHDxUXxTf0EYjgb4GHj1Mh2BdXGQz594fX
	 EHF9rkax0eO47OhFlYL/qgVvhuT7KEVbOx3f98UE=
Date: Wed, 6 May 2026 11:51:16 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, <skhawaja@google.com>, <pasha.tatashin@soleen.com>,
 Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 03/10] iommufd: Allow binding to a noiommu device
Message-ID: <20260506115116.00001251@linux.microsoft.com>
In-Reply-To: <dbdd2289-8a0e-40f9-a0b5-842fd861acba@intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-4-jacob.pan@linux.microsoft.com>
	<dbdd2289-8a0e-40f9-a0b5-842fd861acba@intel.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yi,

On Tue, 28 Apr 2026 15:45:56 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 4/15/26 05:14, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> >=20
> > Allow iommufd to bind devices without an IOMMU (noiommu mode) by
> > creating a dummy IOMMU group for such devices and skipping hwpt
> > operations.
> >=20
> > This enables noiommu devices to operate through the same iommufd
> > API as IOMMU- capable devices.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> >=20
> > ---
> > v4:
> >     - handle partially initialized idev w/o igroup (Sashiko)
> > v3:
> >     - handle new error cases iommufd_device_bind. (Mostafa)
> > ---
> >   drivers/iommu/iommufd/device.c | 132
> > +++++++++++++++++++++++---------- 1 file changed, 93 insertions(+),
> > 39 deletions(-)
> >=20
> > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c index 2f30ea069f66..0283ac39be55
> > 100644 --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -23,6 +23,11 @@ struct iommufd_attach {
> >   	struct xarray device_array;
> >   };
> >  =20
> > +static bool is_vfio_noiommu(struct iommufd_device *idev) =20
>=20
> perhaps iommufd_device_is_noiommu().
>=20
sounds good, remove vfio.

> > +{
> > +	return !device_iommu_mapped(idev->dev) ||
> > !idev->dev->iommu; +}
> > +
> >   static void iommufd_group_release(struct kref *kref)
> >   {
> >   	struct iommufd_group *igroup =3D
> > @@ -30,9 +35,11 @@ static void iommufd_group_release(struct kref
> > *kref)=20
> >   	WARN_ON(!xa_empty(&igroup->pasid_attach));
> >  =20
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
> > @@ -204,32 +211,19 @@ void iommufd_device_destroy(struct
> > iommufd_object *obj) struct iommufd_device *idev =3D
> >   		container_of(obj, struct iommufd_device, obj);
> >  =20
> > -	iommu_device_release_dma_owner(idev->dev);
> > +	if (!idev->igroup)
> > +		return;
> > +	if (!is_vfio_noiommu(idev))
> > +		iommu_device_release_dma_owner(idev->dev);
> >   	iommufd_put_group(idev->igroup);
> >   	if (!iommufd_selftest_is_mock_dev(idev->dev))
> >   		iommufd_ctx_put(idev->ictx);
> >   }
> >  =20
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
> > +	struct iommufd_ctx *ictx =3D idev->ictx;
> > +	struct device *dev =3D idev->dev;
> >   	struct iommufd_group *igroup;
> >   	int rc;
> >  =20
> > @@ -238,11 +232,11 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx,
> >   	 * to restore cache coherency.
> >   	 */
> >   	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> > -		return ERR_PTR(-EINVAL);
> > +		return -EINVAL;
> >  =20
> > -	igroup =3D iommufd_get_group(ictx, dev);
> > +	igroup =3D iommufd_get_group(idev->ictx, dev); =20
>=20
> no need as you already have a local ictx.
will do.

>=20
> >   	if (IS_ERR(igroup))
> > -		return ERR_CAST(igroup);
> > +		return PTR_ERR(igroup);
> >  =20
> >   	/*
> >   	 * For historical compat with VFIO the insecure interrupt
> > path is @@ -268,21 +262,69 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx, if (rc)
> >   		goto out_group_put;
> >  =20
> > +	/* igroup refcount moves into iommufd_device */
> > +	idev->igroup =3D igroup;
> > +	return 0;
> > +
> > +out_group_put:
> > +	iommufd_put_group(igroup);
> > +	return rc;
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
> >   	idev =3D iommufd_object_alloc(ictx, idev,
> > IOMMUFD_OBJ_DEVICE);
> > -	if (IS_ERR(idev)) {
> > -		rc =3D PTR_ERR(idev);
> > -		goto out_release_owner;
> > -	}
> > +	if (IS_ERR(idev))
> > +		return idev;
> > +
> >   	idev->ictx =3D ictx;
> > -	if (!iommufd_selftest_is_mock_dev(dev))
> > -		iommufd_ctx_get(ictx);
> >   	idev->dev =3D dev;
> >   	idev->enforce_cache_coherency =3D
> >   		device_iommu_capable(dev,
> > IOMMU_CAP_ENFORCE_CACHE_COHERENCY); =20
>=20
> Functioanlly, it is harmless since device_iommu_capable() returns
> false for noiommu device. But conceptually, it is nice to move it to=20
> iommufd_bind_iommu().
make sense, will move it.
>=20
> > +
> > +	if (!is_vfio_noiommu(idev)) {
> > +		rc =3D iommufd_bind_iommu(idev);
> > +		if (rc)
> > +			goto err_out;
> > +	} else {
> > +		struct iommufd_group *igroup;
> > +
> > +		/*
> > +		 * Create a dummy igroup, lots of stuff expects
> > ths igroup to be
> > +		 * present, but a NULL igroup->group is OK
> > +		 */
> > +		igroup =3D iommufd_alloc_group(ictx, NULL);
> > +		if (IS_ERR(igroup)) {
> > +			rc =3D PTR_ERR(igroup);
> > +			goto err_out;
> > +		}
> > +		idev->igroup =3D igroup;
> > +	}
> > +
> > +	if (!iommufd_selftest_is_mock_dev(dev))
> > +		iommufd_ctx_get(ictx);
> >   	/* The calling driver is a user until
> > iommufd_device_unbind() */ refcount_inc(&idev->obj.users);
> > -	/* igroup refcount moves into iommufd_device */
> > -	idev->igroup =3D igroup;
> >  =20
> >   	/*
> >   	 * If the caller fails after this success it must call
> > @@ -294,11 +336,14 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx, *id =3D idev->obj.id;
> >   	return idev;
> >  =20
> > -out_release_owner:
> > -	iommu_device_release_dma_owner(dev);
> > -out_group_put:
> > -	iommufd_put_group(igroup);
> > +err_out:
> > +	/*
> > +	 * Be careful that iommufd_device_destroy() can handle
> > partial
> > +	 * initialization.
> > +	 */ =20
>=20
> no native speaker. This is a bit strange to me. I think the comment=20
> wants to highligh that iommufd_device_destroy() can handle partial
> initialization. But the above comment seems to warn something...
> how about below?
>=20
yes, that is better, This is not a warning, just explaining.

> /*
>   * iommufd_device_destroy() handles partially initialized idev,
>   * so iommufd_object_abort_and_destroy() is safe to call here.
>   */
>=20
> > +	iommufd_object_abort_and_destroy(ictx, &idev->obj);
> >   	return ERR_PTR(rc);
> > +
> >   }
> >   EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
> >  =20
> > @@ -512,6 +557,9 @@ static int iommufd_hwpt_attach_device(struct
> > iommufd_hw_pagetable *hwpt, struct iommufd_attach_handle *handle;
> >   	int rc;
> >  =20
> > +	if (is_vfio_noiommu(idev))
> > +		return 0;
> > +
> >   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
> >   		return -EINVAL;
> >  =20
> > @@ -559,6 +607,9 @@ static void iommufd_hwpt_detach_device(struct
> > iommufd_hw_pagetable *hwpt, {
> >   	struct iommufd_attach_handle *handle;
> >  =20
> > +	if (is_vfio_noiommu(idev))
> > +		return;
> > +
> >   	handle =3D iommufd_device_get_attach_handle(idev, pasid);
> >   	if (pasid =3D=3D IOMMU_NO_PASID)
> >   		iommu_detach_group_handle(hwpt->domain,
> > idev->igroup->group); @@ -577,6 +628,9 @@ static int
> > iommufd_hwpt_replace_device(struct iommufd_device *idev, struct
> > iommufd_attach_handle *handle, *old_handle; int rc;
> >  =20
> > +	if (is_vfio_noiommu(idev))
> > +		return 0;
> > +
> >   	if (!iommufd_hwpt_compatible_device(hwpt, idev))
> >   		return -EINVAL;
> >  =20
> > @@ -652,7 +706,7 @@ int iommufd_hw_pagetable_attach(struct
> > iommufd_hw_pagetable *hwpt, goto err_release_devid;
> >   	}
> >  =20
> > -	if (attach_resv) {
> > +	if (attach_resv && !is_vfio_noiommu(idev)) { =20
>=20
> how about the iommufd_hw_pagetable_detach() path? Does it also need to
> check noiommu device?
I don't think it is needed. iopt_remove_reserved_iova() is safe to call
when nothing was added =E2=80=94 it's a no-op. But I can add the guard for
symmetry if preferred.

>=20
> >   		rc =3D iommufd_device_attach_reserved_iova(idev,
> > hwpt_paging); if (rc)
> >   			goto err_release_devid; =20
>=20
> Regards,
> Yi Liu

