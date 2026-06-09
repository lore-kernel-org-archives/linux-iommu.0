Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32733C18B
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035684; cv=none; b=Sh8j/uoEUKbOgIxu+AdqolxxWZjhKIqh7fSt4ZAtcDVD6QbawVKXW61CaCd6LtIEObz8QSkaWtJ2G16Im7Yt9QKEeBKdY281WQVnio2Vp2vOaxZ/DIwjUZxpLfzkgKNr64B9s/FvNQRoZZvrkn2gcBB2CmoCWBcx8LSXcbx49p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035684; c=relaxed/simple;
	bh=iF8A5VWOlPvXER2t/+U/8u9BZCPuJJY3vS5tlW6iajY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce79PCZpAyqlI7nFh16DOxLu2+eMYvturUQpThrNdvnPa1QWpSjkoO2w+waW8DS86Eirt/l06Z1E1eUGDRBE/OgRlNzS6vWM6lWEOjCiQGCtdd2udnbxsqxYbhXQhVdn8NINUycNvAYZx07J5IBv2r6LOlSnzMToxRDazDT6ZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=eBHWsdOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZ7A9KfF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="eBHWsdOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZ7A9KfF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 05BB5EC01EF;
	Tue,  9 Jun 2026 16:08:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 16:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781035681;
	 x=1781122081; bh=/EJlCxNGxuiZzj/l9smoAhjc1aNZ+RJ3RBCEJbXTAVI=; b=
	eBHWsdOOAgujWH2UWJsPNo40P8uRetHRIm+14pFFlnAw6y3BMAbgoOP/IEd1+IiB
	mRayxPutaVSGt25E9f71OqcYdAfxd1yeEbSmz86cKlcB/NFwVrMo1TFWPPeSEVDF
	3/o/ZwnzX870yoT+RQjQa8Oj2zCk2oBhDjqA4B8NI3xLNSVCRW9DNEjHjh5k+XXU
	sdRar16KG16Gr1LRFe62C3y8lpwoJR7gLXrcOBottNj/nuZhG/DPKvEquHJFVrNx
	NqK8RaIHQXTv4fbsHIjcwCIhh4j2UMzsVwxEU5GEAAUo9TcAVTIFJWOvqEfg6EUZ
	+wF3KGtSsOwB5xj+q7f8XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781035681; x=
	1781122081; bh=/EJlCxNGxuiZzj/l9smoAhjc1aNZ+RJ3RBCEJbXTAVI=; b=T
	Z7A9KfFJAecZbvPDISZ6Yb0RkYqLfDnBC9spHweu/CYEkhG7e/3iJMTwdouIL21J
	MImUcW/moHpxQ6lMiw55FsTVsOaFT3Qh+lM3NvtjMynKoMxaBlogWcfnUm/YvzY+
	cRi4kyffhlUkgp3GbK+32YzyqnQPQsqXBSBGbWcAS67GbLkFvTQX0/pVPO9uFlDX
	ZHIkBJYxrZJ2boM1se4zihV4YnW0e2vT9Ns0VS5lUprDN8sz0eKaxM5l0/qsbk6/
	/zpgM/ZPTpcvZUuoZz6c+/kB8acYCAdUujBAGfCYFjUn/Y03aNU0Ggl51hVHs1Wy
	dIAP1kMERqWvO2pLefO+w==
X-ME-Sender: <xms:oHIoajdG5TjbVpi8_mKw5xIjoxbkhnCU734zMkJMtrbzoBILMTj68g>
    <xme:oHIoalIOrezQdqGolXiG3D1xeSFQt_jA4TXVSQzYIaiJax4T3Qtii_wlubFIIHXvW
    9n-IWatgoXx6HutLFIpuir3QfOuMcyfFV7nigCBAEDLgdsz9l2D4w>
X-ME-Received: <xmr:oHIoaiphBlNXaEyqbi8TKWffa23JrMiYFZesu6h95ioexfy8cd8CjoLNPas>
X-ME-Proxy-Cause: dmFkZTFX2wyqfJy/ruIoU87cbIUOPV3woQDYqps0SD/LO8p34bAI5tDSs5/WnvZBNstDdG
    BlIQUxP0byU102tgQo//nMRHOru1dxEVXBroQA5xjj0pb6WIK5XRMgNEuwzY8HAiddSzmO
    el43OUtupgbjE+3aMl/kokchEFV8DRE7ufg1jbvHpLDNGb7WBUnttaHiZni3CTjamV3pvb
    W7TkLEHDnfopK3UtCgXTjUXsbgdGO+NT6y842ZH5r1UYHitC5u7CNk0Mt6bhESzZlDXa6y
    XIIijXcqYc9L8zvgZc/4fRQHVHRTUK9waDtgpGAWiMCcWQDXoLloa1DaWl4+uTPQeMWcYE
    8gM8JH0PwB5TvXqqFK8dhww+vUUtC3uATssNgjyJcvYgytK8oeYO1v2zBjAbVOga4sn0KP
    WhY9rJC3rJ2fXWcdqsxpUEAYpNxBsDpmRmKdnRID/6DuEhEpOB+PCT4BVN3/BdKv5R/G4B
    9aeOdOsoEWo5jzNGj0/hPbOSbpZp0S+UaWD0iyVKPT3O8+/C+LIdyfZzU2zkoht/L6zqFK
    Git+majMrmJQqiAQT/81itSFYmRnY9JCRn5RCwJtz4KEvrBRWcpp0PxtJ0QqqGRXERjk9o
    vx/YBDUzFwKaakMCU0blB8JmpRwo3+9HJ+JH4FNMEvMyEg794dku5G5w1tOA
X-ME-Proxy: <xmx:oHIoarXzYDYW1jebBA9meUh4E_5BRS7yXMPkqrbEBcA2DWCnRax_dg>
    <xmx:oHIoat0U2O9ggb1wc5DFXLLTaCwLcsBrKsAeXWl-ulLYxgPErTRzUw>
    <xmx:oHIoas0LpMAbFJBQ8yvXYXddxN26nZeleuuWlvsZMW5G9Zs1dheYow>
    <xmx:oHIoaslTDlp8t3iI5fA31NotrqhW1XrlDKUJLXCVTv8ZzRiIDreD2A>
    <xmx:oXIoajrI6zjoXz7qjwgY0YuMRuaOjs6ffksv7q6MBva9q0GcBeJ4U7mf>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 16:07:58 -0400 (EDT)
Date: Tue, 9 Jun 2026 14:07:57 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v8 5/6] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260609140757.08d8addb@shazbot.org>
In-Reply-To: <20260609115058.000056cd@linux.microsoft.com>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
	<20260603220211.2584590-6-jacob.pan@linux.microsoft.com>
	<20260608171956.7e98bc8e@shazbot.org>
	<20260609115058.000056cd@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2026 11:50:58 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Alex,
>=20
> On Mon, 8 Jun 2026 17:19:56 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>=20
> > From: Alex Williamson <alex@shazbot.org>
> > To: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
> > <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg
> > Roedel  <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David
> > Matlack  <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
> > Nicolin Chen  <nicolinc@nvidia.com>, "Tian, Kevin"
> > <kevin.tian@intel.com>, Yi Liu  <yi.l.liu@intel.com>, Baolu Lu
> > <baolu.lu@linux.intel.com>, Saurabh Sengar
> > <ssengar@linux.microsoft.com>, skhawaja@google.com,
> > pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
> > alex@shazbot.org Subject: Re: [PATCH v8 5/6] vfio: Enable cdev
> > noiommu mode under iommufd Date: Mon, 8 Jun 2026 17:19:56 -0600
> > X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
> >=20
> > On Wed,  3 Jun 2026 15:02:10 -0700
> > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> >  =20
> > > Now that devices under noiommu mode can bind with IOMMUFD and
> > > perform IOAS operations, lift restrictions on cdev from VFIO side.
> > > Use cases are documented in Documentation/driver-api/vfio.rst
> > >=20
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > ---
> > > v8:
> > >   - Fix warning message (Kevin)
> > > v7:
> > >   - Avoid treating emulated device as noiommu device (Sashiko)
> > >   - Keep platforms w/ GENERIC_ATOMIC64 to use VFIO group noiommu as
> > >     before (Sashiko)
> > >   - Restore order of group & cdev init for noiommu (Yi)
> > >   - Consolidate noiommu helper for cdev & group (Yi)
> > > v6:
> > >   - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and
> > > group. Use Kconfig dependency to restrict usages and avoid null
> > > group checks. (Alex & Yi)
> > >   - Add CAP_SYS_RAWIO checks for cdev open to maintain security
> > > parity with the group noiommu path. (Alex)
> > > v5:
> > >    - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
> > >      and its dependencies
> > >    - Add comment to explain vfio_noiommu conditional definition
> > > (Alex)
> > >    - Removed early return for group noiommu in bind/unbind
> > >    - Use consistent wording referring to VFIO noiommu mode (Kevin)
> > >    - Update unsafe_noiommu Kconfig help text (Kevin)
> > >    - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> > > v4:
> > >    - Remove early return in iommufd_bind for noiommu (Alex)
> > > v3:
> > >    - Consolidate into fewer patches
> > > v2:
> > >    - removed unnecessary device->noiommu set in
> > >      iommufd_vfio_compat_ioas_get_id()
> > >=20
> > > ---
> > >  drivers/vfio/Kconfig       |  7 ++++---
> > >  drivers/vfio/device_cdev.c |  3 +++
> > >  drivers/vfio/iommufd.c     | 12 ++++++++----
> > >  drivers/vfio/vfio.h        | 23 +++++++++--------------
> > >  drivers/vfio/vfio_main.c   | 26 +++++++++++++++++++++++++-
> > >  include/linux/vfio.h       |  1 +
> > >  6 files changed, 50 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > > index ceae52fd7586..b9d6e1c22aed 100644
> > > --- a/drivers/vfio/Kconfig
> > > +++ b/drivers/vfio/Kconfig
> > > @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
> > >  	  The VFIO device cdev is another way for userspace to get
> > > device access. Userspace gets device fd by opening device cdev under
> > >  	  /dev/vfio/devices/vfioX, and then bind the device fd
> > > with an iommufd
> > > -	  to set up secure DMA context for device access.  This
> > > interface does
> > > -	  not support noiommu.
> > > +	  to set up secure DMA context for device access.
> > > =20
> > >  	  If you don't know what to do here, say N.
> > > =20
> > > @@ -62,7 +61,9 @@ endif
> > > =20
> > >  config VFIO_NOIOMMU
> > >  	bool "VFIO No-IOMMU support"
> > > -	depends on VFIO_GROUP
> > > +	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV &&
> > > !GENERIC_ATOMIC64)
> > > +	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > > IOMMUFD_VFIO_CONTAINER
> > > +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV &&
> > > !GENERIC_ATOMIC64   =20
> >=20
> > Sashiko is warning about this and it seems real, if the config were
> > something like this:
> >=20
> >   CONFIG_GENERIC_ATOMIC64=3Dy
> >   CONFIG_VFIO=3Dy
> >   CONFIG_VFIO_GROUP=3Dy
> >   CONFIG_VFIO_CONTAINER=3Dy
> >   CONFIG_VFIO_DEVICE_CDEV=3Dy
> >=20
> > The result is:
> >=20
> >   # =3D> CONFIG_VFIO_NOIOMMU=3Dy
> >   # =3D> CONFIG_IOMMUFD_NOIOMMU is not set
> >=20
> > Which can result in:
> >=20
> >   /dev/vfio/
> >   =E2=94=9C=E2=94=80=E2=94=80 devices/
> >   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 vfio0
> >   =E2=94=94=E2=94=80=E2=94=80 noiommu-0
> >=20
> > The cdev exists without the noiommu- prefix.
> >  =20
> Indeed, I thought about this which is why I put this comment in the code
> "There cannot be a combination of a plain vfio%d cdev name and
> a no-IOMMU group because VFIO_NOIOMMU selects IOMMUFD_NOIOMMU."
> But I missed the select logic.
>=20
> > Something like this might work
> >=20
> >    config VFIO_NOIOMMU
> >    	bool "VFIO No-IOMMU support"
> >    	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV &&
> > !GENERIC_ATOMIC64)
> >   +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
> >    	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > IOMMUFD_VFIO_CONTAINER
> >   -	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV &&
> > !GENERIC_ATOMIC64
> >   +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
> >    	help
> >    	  VFIO is built on the ability to isolate devices using
> > the IOMMU.
> >  =20
>=20
> This will work, but it disables VFIO_NOIOMMU for configs with
> VFIO_DEVICE_CDEV=3Dy and GENERIC_ATOMIC64=3Dy, even though the legacy gro=
up
> noiommu path still works there. That can break existing distro configs
> which enable both VFIO_GROUP and VFIO_DEVICE_CDEV, right?
>=20
> How about add code change to skip noiommu cdev registeration if
> IOMMUFD_NOIOMMU is not enabled? i.e.
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -359,13 +359,21 @@ void vfio_init_device_cdev(struct vfio_device
> *device);
>=20
>  static inline int vfio_device_add(struct vfio_device *device)
>  {
> +       if (vfio_device_is_noiommu(device) &&
> +           !IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU))
> +               return device_add(&device->device);
> +
>         vfio_init_device_cdev(device);
>         return cdev_device_add(&device->cdev, &device->device);
>  }
>=20
>  static inline void vfio_device_del(struct vfio_device *device)
>  {
> -       cdev_device_del(&device->cdev, &device->device);
> +       if (vfio_device_is_noiommu(device) &&
> +           !IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU))
> +               device_del(&device->device);
> +       else
> +               cdev_device_del(&device->cdev, &device->device);
>  }
> I will also update the documentation to state this behavior:
>=20
> "The cdev noiommu path requires CONFIG_GENERIC_ATOMIC64=3Dn.  When
> CONFIG_VFIO_GROUP=3Dy, CONFIG_VFIO_DEVICE_CDEV=3Dy, and
> CONFIG_GENERIC_ATOMIC64=3Dy, CONFIG_VFIO_NOIOMMU remains selectable for
> the group path, but no noiommu device cdev is registered.  Cdev-only
> noiommu is not selectable on those platforms."

I suspect that the Venn diagram of the set of platforms that set
GENERIC_ATOMIC64 and the set of platforms we care about distro config
compatibility (or even the existence of a distro) is pretty nearly
disjoint.  That said, your solution is better.

One check though, it looks like cdev_device_{add,del} already degrade
to device_{add,del} when device->devt =3D=3D 0, so we could maybe simplify
by making vfio_init_device_cdev() conditional and the rest falls out
automatically.  That also avoids the device->group traversal to check
noiommu on the del path.  Thanks,

Alex
