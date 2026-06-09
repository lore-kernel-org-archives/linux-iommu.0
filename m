Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978C35675A
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039513; cv=none; b=EfykWKL9r9yOaFyhl2cSVCgJy4X4E0p8RyLjA04t3Hd5tzpGmZRMw7Z6CJ30kLvVNI0W+yFTTPNsKJJTF/FXFsH180YtxnZsu+gFJlK5N8PtFMOhYQNVg8kK0KBV/Bz5+rgDwNrZdh6+CPuB/2dE77oRUHWJxlIlz7nswK5qLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039513; c=relaxed/simple;
	bh=y3U83AYUvSpm524LHztHqMAdoU7hsd3sPIybPAtFu/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRfg+Hn69FYg4XJbdbear86hQBPwyxcAzbeEA9OQfTdnCviArjE5z1bhPEp40VJkvWQmALtzVFxzNmCT/3gPK/cicJZOqIHesXwquei6q0/S7RyNhld3egIicQCHo/QPYjv7X4qkBRazG69INqW+dxgdKCsILnG+txRGS+tKhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U91f739T; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U91f739T"
Received: from localhost (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id B98A820B7167;
	Tue,  9 Jun 2026 14:11:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B98A820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781039493;
	bh=AfJkmBVkxO1N1JJTfVIDP68w+HJ2osiBsKUHGkRPPfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U91f739T2Jso9GUFuEwuODB/9OZIWkFVQPTWsPURBMwKYqyPFfddSbqcLUrC009Pt
	 HYf+Zz4PXlIzFVON1TI26+wJqHGypDq/NtiJnkYCapUgrzJ573ExRiPQ6OZcqC9IZW
	 xG5EzehcWm8o50txZpPtOlRVW0/HThgElMwkFoiI=
Date: Tue, 9 Jun 2026 14:11:48 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v8 5/6] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260609141148.000023ab@linux.microsoft.com>
In-Reply-To: <20260609140757.08d8addb@shazbot.org>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
	<20260603220211.2584590-6-jacob.pan@linux.microsoft.com>
	<20260608171956.7e98bc8e@shazbot.org>
	<20260609115058.000056cd@linux.microsoft.com>
	<20260609140757.08d8addb@shazbot.org>
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

On Tue, 9 Jun 2026 14:07:57 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Tue, 9 Jun 2026 11:50:58 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
>=20
> > Hi Alex,
> >=20
> > On Mon, 8 Jun 2026 17:19:56 -0600
> > Alex Williamson <alex@shazbot.org> wrote:
> >  =20
> > > From: Alex Williamson <alex@shazbot.org>
> > > To: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
> > > <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg
> > > Roedel  <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
> > > David Matlack  <dmatlack@google.com>, Robin Murphy
> > > <robin.murphy@arm.com>, Nicolin Chen  <nicolinc@nvidia.com>,
> > > "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
> > > <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
> > > Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
> > > pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
> > > alex@shazbot.org Subject: Re: [PATCH v8 5/6] vfio: Enable cdev
> > > noiommu mode under iommufd Date: Mon, 8 Jun 2026 17:19:56 -0600
> > > X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
> > >=20
> > > On Wed,  3 Jun 2026 15:02:10 -0700
> > > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> > >    =20
> > > > Now that devices under noiommu mode can bind with IOMMUFD and
> > > > perform IOAS operations, lift restrictions on cdev from VFIO
> > > > side. Use cases are documented in
> > > > Documentation/driver-api/vfio.rst
> > > >=20
> > > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > > ---
> > > > v8:
> > > >   - Fix warning message (Kevin)
> > > > v7:
> > > >   - Avoid treating emulated device as noiommu device (Sashiko)
> > > >   - Keep platforms w/ GENERIC_ATOMIC64 to use VFIO group
> > > > noiommu as before (Sashiko)
> > > >   - Restore order of group & cdev init for noiommu (Yi)
> > > >   - Consolidate noiommu helper for cdev & group (Yi)
> > > > v6:
> > > >   - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev
> > > > and group. Use Kconfig dependency to restrict usages and avoid
> > > > null group checks. (Alex & Yi)
> > > >   - Add CAP_SYS_RAWIO checks for cdev open to maintain security
> > > > parity with the group noiommu path. (Alex)
> > > > v5:
> > > >    - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
> > > >      and its dependencies
> > > >    - Add comment to explain vfio_noiommu conditional definition
> > > > (Alex)
> > > >    - Removed early return for group noiommu in bind/unbind
> > > >    - Use consistent wording referring to VFIO noiommu mode
> > > > (Kevin)
> > > >    - Update unsafe_noiommu Kconfig help text (Kevin)
> > > >    - Change dev_warn to dev_info for noiommu enabling msg
> > > > (Kevin) v4:
> > > >    - Remove early return in iommufd_bind for noiommu (Alex)
> > > > v3:
> > > >    - Consolidate into fewer patches
> > > > v2:
> > > >    - removed unnecessary device->noiommu set in
> > > >      iommufd_vfio_compat_ioas_get_id()
> > > >=20
> > > > ---
> > > >  drivers/vfio/Kconfig       |  7 ++++---
> > > >  drivers/vfio/device_cdev.c |  3 +++
> > > >  drivers/vfio/iommufd.c     | 12 ++++++++----
> > > >  drivers/vfio/vfio.h        | 23 +++++++++--------------
> > > >  drivers/vfio/vfio_main.c   | 26 +++++++++++++++++++++++++-
> > > >  include/linux/vfio.h       |  1 +
> > > >  6 files changed, 50 insertions(+), 22 deletions(-)
> > > >=20
> > > > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > > > index ceae52fd7586..b9d6e1c22aed 100644
> > > > --- a/drivers/vfio/Kconfig
> > > > +++ b/drivers/vfio/Kconfig
> > > > @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
> > > >  	  The VFIO device cdev is another way for userspace to
> > > > get device access. Userspace gets device fd by opening device
> > > > cdev under /dev/vfio/devices/vfioX, and then bind the device fd
> > > > with an iommufd
> > > > -	  to set up secure DMA context for device access.  This
> > > > interface does
> > > > -	  not support noiommu.
> > > > +	  to set up secure DMA context for device access.
> > > > =20
> > > >  	  If you don't know what to do here, say N.
> > > > =20
> > > > @@ -62,7 +61,9 @@ endif
> > > > =20
> > > >  config VFIO_NOIOMMU
> > > >  	bool "VFIO No-IOMMU support"
> > > > -	depends on VFIO_GROUP
> > > > +	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV &&
> > > > !GENERIC_ATOMIC64)
> > > > +	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > > > IOMMUFD_VFIO_CONTAINER
> > > > +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV &&
> > > > !GENERIC_ATOMIC64     =20
> > >=20
> > > Sashiko is warning about this and it seems real, if the config
> > > were something like this:
> > >=20
> > >   CONFIG_GENERIC_ATOMIC64=3Dy
> > >   CONFIG_VFIO=3Dy
> > >   CONFIG_VFIO_GROUP=3Dy
> > >   CONFIG_VFIO_CONTAINER=3Dy
> > >   CONFIG_VFIO_DEVICE_CDEV=3Dy
> > >=20
> > > The result is:
> > >=20
> > >   # =3D> CONFIG_VFIO_NOIOMMU=3Dy
> > >   # =3D> CONFIG_IOMMUFD_NOIOMMU is not set
> > >=20
> > > Which can result in:
> > >=20
> > >   /dev/vfio/
> > >   =E2=94=9C=E2=94=80=E2=94=80 devices/
> > >   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 vfio0
> > >   =E2=94=94=E2=94=80=E2=94=80 noiommu-0
> > >=20
> > > The cdev exists without the noiommu- prefix.
> > >    =20
> > Indeed, I thought about this which is why I put this comment in the
> > code "There cannot be a combination of a plain vfio%d cdev name and
> > a no-IOMMU group because VFIO_NOIOMMU selects IOMMUFD_NOIOMMU."
> > But I missed the select logic.
> >  =20
> > > Something like this might work
> > >=20
> > >    config VFIO_NOIOMMU
> > >    	bool "VFIO No-IOMMU support"
> > >    	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV &&
> > > !GENERIC_ATOMIC64)
> > >   +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
> > >    	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > > IOMMUFD_VFIO_CONTAINER
> > >   -	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV &&
> > > !GENERIC_ATOMIC64
> > >   +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
> > >    	help
> > >    	  VFIO is built on the ability to isolate devices using
> > > the IOMMU.
> > >    =20
> >=20
> > This will work, but it disables VFIO_NOIOMMU for configs with
> > VFIO_DEVICE_CDEV=3Dy and GENERIC_ATOMIC64=3Dy, even though the legacy
> > group noiommu path still works there. That can break existing
> > distro configs which enable both VFIO_GROUP and VFIO_DEVICE_CDEV,
> > right?
> >=20
> > How about add code change to skip noiommu cdev registeration if
> > IOMMUFD_NOIOMMU is not enabled? i.e.
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -359,13 +359,21 @@ void vfio_init_device_cdev(struct vfio_device
> > *device);
> >=20
> >  static inline int vfio_device_add(struct vfio_device *device)
> >  {
> > +       if (vfio_device_is_noiommu(device) &&
> > +           !IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU))
> > +               return device_add(&device->device);
> > +
> >         vfio_init_device_cdev(device);
> >         return cdev_device_add(&device->cdev, &device->device);
> >  }
> >=20
> >  static inline void vfio_device_del(struct vfio_device *device)
> >  {
> > -       cdev_device_del(&device->cdev, &device->device);
> > +       if (vfio_device_is_noiommu(device) &&
> > +           !IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU))
> > +               device_del(&device->device);
> > +       else
> > +               cdev_device_del(&device->cdev, &device->device);
> >  }
> > I will also update the documentation to state this behavior:
> >=20
> > "The cdev noiommu path requires CONFIG_GENERIC_ATOMIC64=3Dn.  When
> > CONFIG_VFIO_GROUP=3Dy, CONFIG_VFIO_DEVICE_CDEV=3Dy, and
> > CONFIG_GENERIC_ATOMIC64=3Dy, CONFIG_VFIO_NOIOMMU remains selectable
> > for the group path, but no noiommu device cdev is registered.
> > Cdev-only noiommu is not selectable on those platforms." =20
>=20
> I suspect that the Venn diagram of the set of platforms that set
> GENERIC_ATOMIC64 and the set of platforms we care about distro config
> compatibility (or even the existence of a distro) is pretty nearly
> disjoint.  That said, your solution is better.
>=20
> One check though, it looks like cdev_device_{add,del} already degrade
> to device_{add,del} when device->devt =3D=3D 0, so we could maybe simplify
> by making vfio_init_device_cdev() conditional and the rest falls out
> automatically.  That also avoids the device->group traversal to check
> noiommu on the del path.  Thanks,
>=20
Indeed, this is much simpler. Will do below as you suggested, Thanks.
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -11,6 +11,10 @@ static dev_t device_devt;

 void vfio_init_device_cdev(struct vfio_device *device)
 {
+       if (vfio_device_is_noiommu(device) &&
+           !IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU))
+               return;
+


