Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D03A1DB;
	Wed, 18 Jun 2025 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224546; cv=none; b=X2WW8++i+DwfRlTSMYWbb3QvuAmA7UMWHzIFqdbIzY20EYK9jYrFK2ywX+xLOoVkcDI7m3u+FA5sBKL4zKUvSWUApgqUici7FrzlZ0et1/SMItg0pcwdNJZak9Jfy4GtXrn7I55sma5Ua7cbp7zQxkoJc1lUs8eDW40XhYZBElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224546; c=relaxed/simple;
	bh=/rNLnBj6xqJ6tGe2PfPPwmW9RkWk2HKA65poVRfVGJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fgB62/H2CZfRS7ypOntaFaHPAVBCvviiBTTzX+A4xb+IalFcyMfUrZYpzo2pYVFeN6sUYHVS1qjA9oh1ggv+O3/Ar4OylLKJzUcMghhgPI+llcgo+XSYVsB27jDA59HEZgLeibusY/e+oBOs/pQyFlMebouG0O1uSfYQl1bys9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjzLUPxC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjzLUPxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1892C4CEE7;
	Wed, 18 Jun 2025 05:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750224546;
	bh=/rNLnBj6xqJ6tGe2PfPPwmW9RkWk2HKA65poVRfVGJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cjzLUPxCtqlNK0aTCh6dlgrKURZMAjPJt1jeDFfjA3LPdr7+G/M3Kb3I7OrEDy//A
	 9rqvf7w+Pj8uZvCvlgEbLoGQxEQdZEGM90oLJEqGodr8bghJb6aYKmwczdpOt+hF0L
	 qZhqaLJdYj3OhwZl1E8+xTYutdQwJYtkcj2PqFkMyAlD7+viEJtZRsyIo/4JxpJuPG
	 6fbij/QOuiU5tXdR+Z6ZfM2RLDBuK4NVmeDdCwrpvdEZnqUIz5DRQE1ey46Ed+y38/
	 fiaGF90yGhvQgStg0q3lEW93tMHQg4JTE9n4pTYltf2AWkJKOkP+ZVV8LvjU/Z2XcD
	 JzxQZI2lqESCQ==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <20250617183452.GG1376515@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca> <yq5azfe6ssev.fsf@kernel.org>
 <20250617183452.GG1376515@ziepe.ca>
Date: Wed, 18 Jun 2025 10:59:00 +0530
Message-ID: <yq5awm99sjmr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Jun 17, 2025 at 01:37:04PM +0530, Aneesh Kumar K.V wrote:
>=20=20
>> How do we reclaim that object id for further reuse?=20
>
> Maybe just don't? Userspace did something it shouldn't, it now leaked
> 8 bytes of kernel memory until the FD is closed.
>

Between the two sequences below, Sequence 1 is the correct one, since we
want the object ID to be released after calling ioctl(DESTROY,
vdevice_id), right?

Sequence 1 (Correct):

close(vfio_cdev)          =E2=86=92 triggers vdevice destruction=20=20
ioctl(DESTROY, vdevice_id) =E2=86=92 reclaims vdevice object ID=20=20
close(iommufd)=20=20

Sequence 2:

ioctl(DESTROY, vdevice_id) =E2=86=92 returns EBUSY=20=20
close(vfio_cdev)           =E2=86=92 triggers vdevice destruction=20=20
close(iommufd)=20=20

Just to confirm: We agree that an EBUSY return from ioctl(DESTROY,
vdevice_id) is expected if it's called before vfio_df_unbind_iommufd(),
correct?

>> is it that if there is a request for a iommufd_object_remove() with obje=
ct
>> refcount > 1, we insert a XA_ZERO_ENTRY and convert that to NULL entry
>> on IOMMU_DESTROY?
>
> Oh no we can't do that, if the refcount is elevated that is a problem,
> it means some thread somewhere is using that memory.
>
> We can sleep and wait for shortterm_users to go to zero and if users
> is still elevated then we are toast. WARN_ON and reatin it in the
> xarray and hope for the best.
>
> So the thread that will trigger the detruction needs to have a users
> refcount of 1. Meaning users needs to be one while idle in the xarray,
> and the idevice destruction will obtain a users=3D2 from its pointer
> under some kind of lock.
>
>> -enum {
>> -	REMOVE_WAIT_SHORTTERM =3D 1,
>> -};
>> +#define	REMOVE_WAIT_SHORTTERM	BIT(0)
>> +#define	REMOVE_OBJ_FORCE	BIT(1)
>
> You can keep the enum for flags, but 'force' isn't the right name. I
> would think it is 'tombstone'
>

These values represent bit flags (e.g., 1, 2, 4, ...), meaning they are
not mutually exclusive and can be combined using bitwise operations. As
such, using an enum=E2=80=94which is typically intended for mutually exclus=
ive
values=E2=80=94is not appropriate in this case?

>
>> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>> index b7aa725e6b37..d27b61787a53 100644
>> --- a/drivers/iommu/iommufd/main.c
>> +++ b/drivers/iommu/iommufd/main.c
>> @@ -88,7 +88,8 @@ struct iommufd_object *iommufd_get_object(struct iommu=
fd_ctx *ictx, u32 id,
>>=20=20
>>  	xa_lock(&ictx->objects);
>>  	obj =3D xa_load(&ictx->objects, id);
>> -	if (!obj || (type !=3D IOMMUFD_OBJ_ANY && obj->type !=3D type) ||
>> +	if (!obj || xa_is_zero(obj) ||
>> +	    (type !=3D IOMMUFD_OBJ_ANY && obj->type !=3D type) ||
>>  	    !iommufd_lock_obj(obj))
>
> xa_load can't return xa_is_zero(), xas_load() can
>
> We already use XA_ZERO_ENTRY to hold an ID during allocation till
> finalize.
>
> I think you want to add a new API
>
> iommufd_object_tombstone_user(idev->ictx, &idev->vdev->obj);
>
> Which I think is the same as the existing
> iommufd_object_destroy_user() except it uses tombstone..
>
> The only thing tombstone does is:
>
> 	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
>
> All the rest of the logic including the users and shorterm check would
> be the same.
>
>> --- a/drivers/iommu/iommufd/viommu.c
>> +++ b/drivers/iommu/iommufd/viommu.c
>> @@ -213,6 +213,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd =
*ucmd)
>>  	/* vdev lifecycle now managed by idev */
>>  	idev->vdev =3D vdev;
>>  	refcount_inc(&vdev->obj.users);
>> +	/* Increment refcount since userspace can hold the obj id */
>> +	refcount_inc(&vdev->obj.users);
>>  	goto out_put_idev_unlock;
>
> I don't think this should change.. There should be no extra user refs
> or userspace can't destroy it.
>
> The pointer back from the idevice needs locking to protect it while a
> refcount is obtained.
>
> Jason

-aneesh
