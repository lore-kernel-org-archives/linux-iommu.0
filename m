Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8A73B9933
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707812; cv=none; b=WG2JYQwSrrHvOS7rn5wo/mDc/Nkr5sPdOHcdvGLzKtu7MIbmYEn+kWW7xms5neXkb6fLuw4WXmBpWPAojCi0Z9wxnM61ydna6VolyPnPcu/8hI7H9QfF2FEl66fCBkZyo941OWf+LePP7VQBttOa/AcbXfZvycnbqA1ihIMy5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707812; c=relaxed/simple;
	bh=NMKpNaBi50MeDcwlywjVwYM1yMq2jGv4rCqNk+pmhkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCn0gzJBJBJsFr7iR2FbUuq5bBWc0PkNHF0DEZKoraWCCrssvZijq6oF66s8xvfUpiu/ogD9n3gKhRQyLzlDxRium2UruAkGXUlwBcNis2ZhXqiPPDOvW8TPK+bBYCh0S2CcIFlxAGbYvgfebJwLnt8Q+8OOy+bqezOvS6B+Qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=di6svtsk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="di6svtsk"
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 991E220B7166;
	Wed, 13 May 2026 14:30:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 991E220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778707807;
	bh=goYMAmYVUFQXmST8nUkX5z+/+FVBrmJktWtoXoSKc6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=di6svtsksRiyqOyUaJOvtxmmardWN5Rm+jPS1UJLUgFLfBmzNQt0PyIdPKC78DOJ9
	 w2i3Yml199J/kdGGHV9wdfz/7GSXiQHmy6xdhINEd0btOvar46v0VpdGTEH3z4l/0y
	 Hm8SREspCylBvVUHBezUgOx3NvPNAZCge/jy2nzU=
Date: Wed, 13 May 2026 14:30:08 -0700
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
Subject: Re: [PATCH v5 2/9] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260513143008.00007159@linux.microsoft.com>
In-Reply-To: <da30f8e1-b794-4bcf-9c96-7e38f319cf35@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
	<da30f8e1-b794-4bcf-9c96-7e38f319cf35@linux.intel.com>
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

On Wed, 13 May 2026 14:58:40 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 5/12/26 02:41, Jacob Pan wrote:
> > From: Jason Gunthorpe<jgg@nvidia.com>
> >=20
> > Create just a little part of a real iommu driver, enough to
> > slot in under the dev_iommu_ops() and allow iommufd to call
> > domain_alloc_paging_flags() and fail everything else.
> >=20
> > This allows explicitly creating a HWPT under an IOAS.
> >=20
> > A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
> > from the VFIO group/container based noiommu mode.
> >=20
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> > ---
> > v5:
> >     - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
> >     - Use consistent wording referring to VFIO noiommu mode (Kevin)
> >     - Copyright date fix (Kevin)
> > v4:
> >     - Make iommufd_noiommu_ops const
> > v3:
> >     - Add comment to explain the design difference over the
> >       legacy noiommu VFIO code.
> > ---
> >   drivers/iommu/iommufd/Kconfig           |  13 +++
> >   drivers/iommu/iommufd/Makefile          |   1 +
> >   drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
> >   drivers/iommu/iommufd/hwpt_noiommu.c    | 102
> > ++++++++++++++++++++++++ drivers/iommu/iommufd/iommufd_private.h |
> >  2 + 5 files changed, 131 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> >=20
> > diff --git a/drivers/iommu/iommufd/Kconfig
> > b/drivers/iommu/iommufd/Kconfig index 455bac0351f2..74d6ea5b5b3b
> > 100644 --- a/drivers/iommu/iommufd/Kconfig
> > +++ b/drivers/iommu/iommufd/Kconfig
> > @@ -16,6 +16,19 @@ config IOMMUFD
> >   	  If you don't know what to do here, say N.
> >  =20
> >   if IOMMUFD
> > +config IOMMUFD_NOIOMMU
> > +	bool
> > +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires
> > cmpxchg64
> > +	select GENERIC_PT
> > +	select IOMMU_PT
> > +	select IOMMU_PT_AMDV1
> > +	help
> > +	  Provides a SW-only IO page table for devices without
> > hardware
> > +	  IOMMU backing. This uses the AMDV1 page table format for
> > +	  IOVA-to-PA lookups only, not for hardware DMA
> > translation. +
> > +	  Selected by VFIO_CDEV_NOIOMMU. Not intended to be
> > enabled directly. +
> >   config IOMMUFD_VFIO_CONTAINER
> >   	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
> >   	depends on VFIO_GROUP && !VFIO_CONTAINER
> > diff --git a/drivers/iommu/iommufd/Makefile
> > b/drivers/iommu/iommufd/Makefile index 71d692c9a8f4..67207914bb6e
> > 100644 --- a/drivers/iommu/iommufd/Makefile
> > +++ b/drivers/iommu/iommufd/Makefile
> > @@ -10,6 +10,7 @@ iommufd-y :=3D \
> >   	vfio_compat.o \
> >   	viommu.o
> >  =20
> > +iommufd-$(CONFIG_IOMMUFD_NOIOMMU) +=3D hwpt_noiommu.o
> >   iommufd-$(CONFIG_IOMMUFD_TEST) +=3D selftest.o
> >  =20
> >   obj-$(CONFIG_IOMMUFD) +=3D iommufd.o
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> > b/drivers/iommu/iommufd/hw_pagetable.c index
> > fe789c2dc0c9..0ae14cd3fc72 100644 ---
> > a/drivers/iommu/iommufd/hw_pagetable.c +++
> > b/drivers/iommu/iommufd/hw_pagetable.c @@ -8,6 +8,15 @@
> >   #include "../iommu-priv.h"
> >   #include "iommufd_private.h"
> >  =20
> > +static const struct iommu_ops *get_iommu_ops(struct iommufd_device
> > *idev) +{
> > +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> > !idev->igroup->group)
> > +		return &iommufd_noiommu_ops;
> > +	if (WARN_ON_ONCE(!idev->dev->iommu))
> > +		return NULL;
> > +	return dev_iommu_ops(idev->dev);
> > +}
> > +
> >   static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable
> > *hwpt) {
> >   	if (hwpt->domain)
> > @@ -114,11 +123,13 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas, IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> >   				IOMMU_HWPT_FAULT_ID_VALID |
> >   				IOMMU_HWPT_ALLOC_PASID;
> > -	const struct iommu_ops *ops =3D dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops =3D get_iommu_ops(idev);
> >   	struct iommufd_hwpt_paging *hwpt_paging;
> >   	struct iommufd_hw_pagetable *hwpt;
> >   	int rc;
> >  =20
> > +	if (!ops)
> > +		return ERR_PTR(-ENODEV); =20
>=20
> Nit: it's unnecessary to add this check. get_iommu_ops() will WARN if
> ops is NULL. The previous code assumes that ops is always valid and
> does not return here. If you want to change this behavior, it=E2=80=99s
> better to explain the reasoning in the commit message.
>=20
I am fine with removing it, just extra defensive to prevent null
pointer deref.

> Otherwise it looks good to me.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Thanks,
> baolu

Thanks,

Jacob
