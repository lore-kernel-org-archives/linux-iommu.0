Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DECB39C006
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445577; cv=none; b=RkG8Mfmdu2dHBh5rK2gn7g72rTlnM8ihzucvbOxdJyWeh53wFxgKbjS9awlFN+QrhpffQKL4gNyH3fQjvs8oSARb7Xk5fBMcbCe54Y/rsIWX8p4+ERNn6gwRZcQzwpVv4KXHAOm/dH8X8moBGCjAnC068jYMngQ36sjb/wRHbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445577; c=relaxed/simple;
	bh=yhLimzqN4e/EiVErXnmVyYdxqplgIep2hPAn4kIS/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNNZ/xe8dym+C7qNHF3ph9qEdayM1FViXJZAxMPr0FG5fpOr/tQ+0IhiA2EkYrQZLc2MDaKU51GrAtphm2uLXGtHt1JfNZbKXTa7fZClLFcuvYMi/lfPs4jvIqe0rxaJHqE5kmpWHqApKeC028bADKGRLc3mztiXg/E/9x6yxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AleNm2sI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AleNm2sI"
Received: from localhost (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 65AC820B7128;
	Fri, 17 Apr 2026 10:06:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65AC820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776445570;
	bh=d8hyzWcU6tAGJbJtT7CHvfg7OkDcouS8NGuB1I/iEXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AleNm2sILyMtBsSFzk6KuQAgXKZs3tTrQwUukArjyVEwD0s2GvrQO41IZ1U4bE2xK
	 QqWDi06XRK5vVDXtyqvIqcWue1c0StjhgQWEvXYFAUtibcXSsZTMDkL/bBglKR8bGX
	 ZbAfEWYWBf9aIz2SgTSOXCxoqrNhFGmSvHBdlE/M=
Date: Fri, 17 Apr 2026 10:06:09 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V4 05/10] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260417100609.00004775@linux.microsoft.com>
In-Reply-To: <20260416140601.255ec031@shazbot.org>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-6-jacob.pan@linux.microsoft.com>
	<20260416140601.255ec031@shazbot.org>
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

Hi Alex,

On Thu, 16 Apr 2026 14:06:01 -0600
Alex Williamson <alex@shazbot.org> wrote:

> From: Alex Williamson <alex@shazbot.org>
> To: Jacob Pan <jacob.pan@linux.microsoft.com>
> Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
> <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg
> Roedel  <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David
> Matlack  <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
> Nicolin Chen  <nicolinc@nvidia.com>, "Tian, Kevin"
> <kevin.tian@intel.com>, Yi Liu  <yi.l.liu@intel.com>,
> skhawaja@google.com, pasha.tatashin@soleen.com, Will  Deacon
> <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
> alex@shazbot.org Subject: Re: [PATCH V4 05/10] vfio: Allow null group
> for noiommu without  containers Date: Thu, 16 Apr 2026 14:06:01 -0600
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
>=20
> On Tue, 14 Apr 2026 14:14:07 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
>=20
> > In case of noiommu mode is enabled for VFIO cdev without VFIO
> > container nor IOMMUFD provided compatibility container, there is no
> > need to create a dummy group. Update the group operations to
> > tolerate null group pointer.
> >=20
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> >=20
> > ---
> > v4: (Jason)
> >    - Avoid null pointer deref in error unwind
> >    - Add null group check in vfio_device_group_unregister
> >    - repartition to include vfio_device_has_group() in this patch
> > ---
> >  drivers/vfio/group.c     | 20 ++++++++++++++++++++
> >  drivers/vfio/vfio.h      | 17 +++++++++++++++++
> >  drivers/vfio/vfio_main.c | 14 ++++++++++++++
> >  include/linux/vfio.h     |  9 +++++++++
> >  4 files changed, 60 insertions(+)
> >=20
> > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > index 0fa9761b13d3..451e49d851f8 100644
> > --- a/drivers/vfio/group.c
> > +++ b/drivers/vfio/group.c
> > @@ -390,6 +390,9 @@ int vfio_device_block_group(struct vfio_device
> > *device) struct vfio_group *group =3D device->group;
> >  	int ret =3D 0;
> > =20
> > +	if (vfio_null_group_allowed() && !group)
> > +		return 0; =20
>=20
> I think this comes down to the fact that at the end of this series,
> VFIO_NOIOMMU still depends on VFIO_GROUP.  vfio_null_group_allowed()
> can only return true if CONTAINER support is entirely disabled.  Why
> do we still select VFIO_GROUP for VFIO_NOIOMMU and build group.s when
> there's no container support to use it?
If we solve this in Kconfig, I think the dependency should be
config VFIO_GROUP
        bool "Support for the VFIO group /dev/vfio/$group_id"
+       depends on !(VFIO_NOIOMMU && !(VFIO_CONTAINER ||
  IOMMUFD_VFIO_CONTAINER))
But this causes circular dependency in that
       symbol VFIO_NOIOMMU depends on VFIO_GROUP
       symbol VFIO_GROUP depends on VFIO_NOIOMMU

If we cannot force VFIO_GROUP=3Dn when container is entirely disabled and
NOIOMMU & cdev is enabled, then user is free to set VFIO_GROUP=3Dy, which
creates a VFIO_GROUP that cannot be used due to lack of container.
There is no functional issue but less clean.
i.e.
#  tree /dev/vfio/   =20
/dev/vfio/           =20
|-- devices          =20
|   `-- noiommu-vfio0=20
`-- noiommu-0         //not usable
# ls /sys/class/vfio
noiommu-0          =20

Maybe there is a way to force VFIO_GROUP=3Dn w/o the circular dependency?

> Also note that vfio_noiommu is S_IWUSR, so it is mutable at runtime.
Good point, maybe we can make it a one-way latch? i.e.
 - echo 1 > .../enable_unsafe_noiommu_mode =E2=80=94 works (n=E2=86=92y)
 - echo 0 > .../enable_unsafe_noiommu_mode =E2=80=94 returns -EPERM (y=E2=
=86=92n blocked)
 - Boot param vfio.enable_unsafe_noiommu_mode=3D1 =E2=80=94 works
 - Writing 1 when already 1 =E2=80=94 no-op, succeeds



