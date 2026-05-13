Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27593C555B
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710084; cv=none; b=CozP8mf9Jz62ZzVmmZlNsGLCN61YU6ufxPFKPA5fuCeoWn3aF/OBhSpbjcNNvJoLSzBlZWzlJu5n5QDpw6FVX8W0RrVbnG24BRv/IceSCvNaCVg1WrfpOTKYVqq4Bdu/0EGNobdOiFoOf7sNN/PA7qtEX8roJIlv3FlhfgiEJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710084; c=relaxed/simple;
	bh=lc++ypMMWwzM49wm5Zo1vGXZTuaKZO6UFDc9QgEtl5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH/nLufMriq/dy53xPPu/yysonYfI4uxCPgmNxqvqU6q94kc8tkOp/0F49HqdXtVkisaedrLDxZJ0u9hCzpUy/bVggWTfmI6Y/HmHZ73uo4PUHk4jfQ+NAc830YpfVgC2KC5is7vNtFSRJmpGTyZT+eU4FAFXtTObyi27WaA5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mwebzaIx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mwebzaIx"
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id C1EF720B7166;
	Wed, 13 May 2026 15:07:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1EF720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778710079;
	bh=qqg7cQRz4C+vb6+/Sy/wGW6QaInCCz8mzs6A5u+2be8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mwebzaIx01Teb9QBh3MVReyX/CgmhUnN4nfjob2uKETolTqQZMLNfs7zEKvQkRABS
	 ZB4RBiRikxp65YPxHT9apTFpkighRl+eM5FV7f/62aDbUKRLzn3mPBSrR07jidPXQL
	 kx1pM5y/IrKMA0mPShPEgZdiZlxXa/xUF2rNd0xg=
Date: Wed, 13 May 2026 15:08:00 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 4/9] iommufd: Allow binding to a noiommu device
Message-ID: <20260513150800.000027e5@linux.microsoft.com>
In-Reply-To: <9f1aa339-6ee5-4ec2-a3f9-b52961afad37@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-5-jacob.pan@linux.microsoft.com>
	<9f1aa339-6ee5-4ec2-a3f9-b52961afad37@linux.intel.com>
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

Hi Baolu,

On Wed, 13 May 2026 15:37:20 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 5/12/26 02:41, Jacob Pan wrote:
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
> >=20
> > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c index d03076fcf3c2..4d75720432cc
> > 100644 --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -23,6 +23,16 @@ struct iommufd_attach {
> >   	struct xarray device_array;
> >   };
> >  =20
> > +/*
> > + * A noiommu device has no IOMMU driver attached regardless of
> > whether it
> > + * enters via the cdev path (no iommu_group) or the group path
> > (fake
> > + * noiommu iommu_group). In both cases dev->iommu is NULL.
> > + */
> > +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> > +{
> > +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> > !idev->dev->iommu; =20
>=20
> How about using device_iommu_mapped()? As I understand it, this is the
> standard way to determine whether a device is protected by an IOMMU.
>=20
device_iommu_mapped() =E2=80=94 checks dev->iommu_group !=3D NULL

For noiommu via the cdev path, there's no iommu_group at all, so both
would return the same thing. But for noiommu via the group path (fake
noiommu group), the device does have an iommu_group (the fake one),
but dev->iommu is still NULL.

I know today we only call this check in the cdev path but seems more
robust not to rely on group.

> > +}
> > +
> >   static void iommufd_group_release(struct kref *kref)
> >   {
> >   	struct iommufd_group *igroup =3D
> > @@ -30,9 +40,11 @@ static void iommufd_group_release(struct kref
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
> > @@ -204,32 +216,19 @@ void iommufd_device_destroy(struct
> > iommufd_object *obj) struct iommufd_device *idev =3D
> >   		container_of(obj, struct iommufd_device, obj);
> >  =20
> > -	iommu_device_release_dma_owner(idev->dev);
> > +	if (!idev->igroup)
> > +		return; =20
>=20
> I don't quite follow this logic. Is this check being added
> specifically for the new noiommu mode? Since the noiommu mode
> introduces the convention that "igroup->group =3D=3D NULL" implies
> noiommu, there should be no cases where idev->igroup itself is NULL.
>=20
idev->igroup can be null on error path only, not limited to noiommu. It
is the partially initialized idev case.
/*
 * iommufd_device_destroy() handles partially initialized idev,
 * so iommufd_object_abort_and_destroy() is safe to call here.
 */

How about add this comment?
 /* igroup is NULL when destroy called during bind error cleanup */

> > +	if (!iommufd_device_is_noiommu(idev))
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
> >   =20
>=20
> Thanks,
> baolu

