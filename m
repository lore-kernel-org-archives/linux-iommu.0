Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB932B13F
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960803; cv=none; b=t60EF5h3l8b6iRLaQSUCQ5dphfwmRfad41dKfLLEnL9PeLt+wRN1b9/EOZqYP9x29k+X4glNUv7cX8TMhnYgIYPebZNZu8DAydvliiUWChOUEfMKi1HuhBAgvdYq/2lVYp8VP3o1wYcbblln5iI9kj0p693RngLaf8Mj5Nu/NIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960803; c=relaxed/simple;
	bh=uo0u/ZF/vHcrFRkiPmwNrm+iLW0SinpzYCpzE6dAqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG5eOwv3VGAKA8dTEthVi9yh0ArbGAYps9sgioeG/gByE2BMl68Bl0O8bTTWDZ9XLmkDF0o5GWwmKGjec2MAkARZnbnkQtK+M1tSEBve/l5iKJgvxHXiSZ3SaOZxaCqx4vLjAAHYYPccdJOsx+/VnGo+F0cTFiGQ56eALF579Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=SwhIFnn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTtDHP3T; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="SwhIFnn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTtDHP3T"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 78ADEEC010B;
	Mon,  8 Jun 2026 19:19:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 19:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780960799;
	 x=1781047199; bh=iVrIgp8AIxqFZJCc4JtPj8XueXQYaYYg6ehpIAd0zh0=; b=
	SwhIFnn7GKcDeHsCzhkukyVRJp7O919JT9G7PXvmZj3xtEheckXAWFYrMhamyypI
	9WPHy9Jd79LF2CRekxs3VoJarddVrDz5b4qjvK8tfGjqN4KPBEcuJ9UIxBIRJrnU
	MSQ7Bnr7zM6S6KOrcl2SyiU0cXq2Od+jLZhl5QGHhWawYwJ9cwWPx2rDR5VRS46o
	CKVa9/Aoko1SI1bGCdYXUzEJkZlFAI1jcGvPbrwbW1wUj7ZXN9ST4+jsOIsaygyJ
	52mvyqmJyZdU7Sker/qPAeLBCrcTXv+pAso+6C1rSoj6cK8Az7Gxgc42nVCFwNaH
	b8QHnJ6eAfTtRFNeyR++fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780960799; x=
	1781047199; bh=iVrIgp8AIxqFZJCc4JtPj8XueXQYaYYg6ehpIAd0zh0=; b=N
	TtDHP3THMU7LOlAUKEJoo0wUU7d+yHUA3M2bmS9Ydw9HeDFF79f1JGjqAaQuuS9m
	7Ykif21SCt2GzTNf68L6PnnLCCtI5yR/Moy4iw4Gx0KMfW1zte+NkZzs/idvKELw
	6xNK979pApHFLlF0CHMn4joBoQTdGg3n0vRR9N7tC/8ZRhlHVg9cAZu9T4pxo+xv
	/AhsBlV82PbyIc3GklGppuaLGw0RpwOahcc9L8ZCz3cDfW0eTnt12e46X78K66q1
	RNKSL3WwBSxxyLYWj6gfNR9eK1NdgExnRUw7oVeF1EFsRPNlJKJpmiHEbZ6ozoiy
	SmsyzIrbOLnBNHwrpYohQ==
X-ME-Sender: <xms:Hk4nauP38h66A1tzC0XOuKpGxlAaK_9Oc8Cr8rNgfLiF_wOFPra_0g>
    <xme:Hk4nao48siD_BM_K1OMFTuZgfpSpQbLGY5vJArcBapI64WnA685aBHch2e9I0-Gau
    UQTDPXINw97d7ScsP5hncpY6xaY6ut8FXKm6Oh80e0ZiWnqWQpM3w>
X-ME-Received: <xmr:Hk4narb4FMi_GqFYznGR47Ib6ZNYBsunOiInItvwUFHyyFZmfRGRT5BTTqQ>
X-ME-Proxy-Cause: dmFkZTG39cW6KKLl0MGOGVemkgXt5zFe8OfW7VXhkWc/PK2TARsZb0x2TUJTKUK31Qrvgc
    NM8NrqpLwS2qb7f40RcXqbPgiWfomnyeUfYd7QBaNkaxChqPdQvp0/2kiczJ8FnGdO4kHv
    lOTh7PcFCfKY5uqH8418yKueOpBtqanyKZqaV234llb3nTuDi8OOtvI0hPOln3aQ8z934F
    GF+dbe1/Dodo1iKHiMq2vofD6Ds87jMABxPS5omF5ScIOHW8R9LBlPRZ5KcNMSZzNOxg4M
    xuWBOzN2OhBZJMm9yD0d9MZM5YrSKfoUf2QRu/l91oGDP+WDiPZEcXiWmYh4K1o2fd+Hq4
    43SeBU3WG/n2ONpkec3zhh8K5jDHHWKSdHbTgzp85SESZsx+CXXmIH8qvIW6PACFV+iKoQ
    b/d5S2q9FHfRiq/tQhcojp8ZQGnmdLEJuyexSe9sykFR6fGUzYt8OJLW3VG1XzkSnpvpke
    DPVKM791e/7LUTiep1j7rM1xQwXAk3dDcgysBqNfF6PRrhhBjLzFNXml/SguILuYBnN/Sl
    tLaZPRlM0sAr5T9UoM8rKkY49U9XR16nFnFFTNp+og9Vmd151/pgtE7Z9JRNdnHvUGxcxG
    IVGLVbPL2AsAjLK9QtR1MwSYp3Zy1Q0waI2ng/CkATE2637V54v7Mw/2GCLA
X-ME-Proxy: <xmx:Hk4nalFCz0amQKEsGjVU6gDzpZDC_s4RNAmqhjPOsL6KrTwY_NjoIg>
    <xmx:Hk4nakm1P8kEPdBIiU3fJRhzpE5lf57cfV2bB3deTgS3tCqeo6UcKg>
    <xmx:Hk4naslhdPd7DGcDZAVSinjKZ34e4w6W6fO7xt7ZP1ebz9OgZ4nZvw>
    <xmx:Hk4nahVYU6oZXCici-PTcI6HD4cq_MtfOVydPwhhp12myCEU1tbzlA>
    <xmx:H04naoY5JInchn_K7Vhw2rT7Sk2tRn_MmyabkEOK5T3xnKn6iWRY3ace>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 19:19:57 -0400 (EDT)
Date: Mon, 8 Jun 2026 17:19:56 -0600
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
Message-ID: <20260608171956.7e98bc8e@shazbot.org>
In-Reply-To: <20260603220211.2584590-6-jacob.pan@linux.microsoft.com>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
	<20260603220211.2584590-6-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  3 Jun 2026 15:02:10 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> Use cases are documented in Documentation/driver-api/vfio.rst
>=20
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v8:
>   - Fix warning message (Kevin)
> v7:
>   - Avoid treating emulated device as noiommu device (Sashiko)
>   - Keep platforms w/ GENERIC_ATOMIC64 to use VFIO group noiommu as
>     before (Sashiko)
>   - Restore order of group & cdev init for noiommu (Yi)
>   - Consolidate noiommu helper for cdev & group (Yi)
> v6:
>   - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and group.
>     Use Kconfig dependency to restrict usages and avoid null group
>     checks. (Alex & Yi)
>   - Add CAP_SYS_RAWIO checks for cdev open to maintain security parity
>     with the group noiommu path. (Alex)
> v5:
>    - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>      and its dependencies
>    - Add comment to explain vfio_noiommu conditional definition (Alex)
>    - Removed early return for group noiommu in bind/unbind
>    - Use consistent wording referring to VFIO noiommu mode (Kevin)
>    - Update unsafe_noiommu Kconfig help text (Kevin)
>    - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> v4:
>    - Remove early return in iommufd_bind for noiommu (Alex)
> v3:
>    - Consolidate into fewer patches
> v2:
>    - removed unnecessary device->noiommu set in
>      iommufd_vfio_compat_ioas_get_id()
>=20
> ---
>  drivers/vfio/Kconfig       |  7 ++++---
>  drivers/vfio/device_cdev.c |  3 +++
>  drivers/vfio/iommufd.c     | 12 ++++++++----
>  drivers/vfio/vfio.h        | 23 +++++++++--------------
>  drivers/vfio/vfio_main.c   | 26 +++++++++++++++++++++++++-
>  include/linux/vfio.h       |  1 +
>  6 files changed, 50 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index ceae52fd7586..b9d6e1c22aed 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
>  	  The VFIO device cdev is another way for userspace to get device
>  	  access. Userspace gets device fd by opening device cdev under
>  	  /dev/vfio/devices/vfioX, and then bind the device fd with an iommufd
> -	  to set up secure DMA context for device access.  This interface does
> -	  not support noiommu.
> +	  to set up secure DMA context for device access.
> =20
>  	  If you don't know what to do here, say N.
> =20
> @@ -62,7 +61,9 @@ endif
> =20
>  config VFIO_NOIOMMU
>  	bool "VFIO No-IOMMU support"
> -	depends on VFIO_GROUP
> +	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64)
> +	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
> +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64

Sashiko is warning about this and it seems real, if the config were
something like this:

  CONFIG_GENERIC_ATOMIC64=3Dy
  CONFIG_VFIO=3Dy
  CONFIG_VFIO_GROUP=3Dy
  CONFIG_VFIO_CONTAINER=3Dy
  CONFIG_VFIO_DEVICE_CDEV=3Dy

The result is:

  # =3D> CONFIG_VFIO_NOIOMMU=3Dy
  # =3D> CONFIG_IOMMUFD_NOIOMMU is not set

Which can result in:

  /dev/vfio/
  =E2=94=9C=E2=94=80=E2=94=80 devices/
  =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 vfio0
  =E2=94=94=E2=94=80=E2=94=80 noiommu-0

The cdev exists without the noiommu- prefix.

Something like this might work

   config VFIO_NOIOMMU
   	bool "VFIO No-IOMMU support"
   	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64)
  +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
   	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
  -	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64
  +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
   	help
   	  VFIO is built on the ability to isolate devices using the IOMMU.

>  	help
>  	  VFIO is built on the ability to isolate devices using the IOMMU.
>  	  Only with an IOMMU can userspace access to DMA capable devices be
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf04..5ca14979b56e 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode *inode, str=
uct file *filep)
>  	struct vfio_device_file *df;
>  	int ret;
> =20
> +	if (vfio_device_is_noiommu(device) && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +

Sashiko also notes a use-after-free issue here that seems real, we
likely need a vfio_device_try_get_registration() before with put on
error.  Thanks,

Alex

>  	/* Paired with the put in vfio_device_fops_release() */
>  	if (!vfio_device_try_get_registration(device))
>  		return -ENODEV;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a38d262c6028..e9893d34d07b 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -25,8 +25,8 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
> =20
>  	lockdep_assert_held(&vdev->dev_set->lock);
> =20
> -	/* Returns 0 to permit device opening under noiommu mode */
> -	if (vfio_device_is_noiommu(vdev))
> +	/* Group noiommu via iommufd compat needs no device binding */
> +	if (df->group && vfio_device_is_noiommu(vdev))
>  		return 0;
> =20
>  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> @@ -40,7 +40,11 @@ int vfio_iommufd_compat_attach_ioas(struct vfio_device=
 *vdev,
> =20
>  	lockdep_assert_held(&vdev->dev_set->lock);
> =20
> -	/* compat noiommu does not need to do ioas attach */
> +	/*
> +	 * Compat noiommu does not need to do ioas attach. This helper is
> +	 * only called from the legacy group/iommufd compat path, so no
> +	 * explicit df->group check is needed.
> +	 */
>  	if (vfio_device_is_noiommu(vdev))
>  		return 0;
> =20
> @@ -58,7 +62,7 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
> =20
>  	lockdep_assert_held(&vdev->dev_set->lock);
> =20
> -	if (vfio_device_is_noiommu(vdev))
> +	if (df->group && vfio_device_is_noiommu(vdev))
>  		return;
> =20
>  	if (vdev->ops->unbind_iommufd)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e4b72e79b7e3..7728bc99b63d 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -112,11 +112,6 @@ bool vfio_device_has_container(struct vfio_device *d=
evice);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);
> =20
> -static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
> -{
> -	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> -	       vdev->group->type =3D=3D VFIO_NO_IOMMU;
> -}
>  #else
>  struct vfio_group;
> =20
> @@ -188,11 +183,17 @@ static inline void vfio_group_cleanup(void)
>  {
>  }
> =20
> +#endif /* CONFIG_VFIO_GROUP */
> +
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
> -	return false;
> +#if IS_ENABLED(CONFIG_VFIO_GROUP)
> +	if (vdev->group && vdev->group->type =3D=3D VFIO_NO_IOMMU)
> +		return true;
> +#endif
> +
> +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vdev->noiommu;
>  }
> -#endif /* CONFIG_VFIO_GROUP */
> =20
>  #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
>  /**
> @@ -358,19 +359,13 @@ void vfio_init_device_cdev(struct vfio_device *devi=
ce);
> =20
>  static inline int vfio_device_add(struct vfio_device *device)
>  {
> -	/* cdev does not support noiommu device */
> -	if (vfio_device_is_noiommu(device))
> -		return device_add(&device->device);
>  	vfio_init_device_cdev(device);
>  	return cdev_device_add(&device->cdev, &device->device);
>  }
> =20
>  static inline void vfio_device_del(struct vfio_device *device)
>  {
> -	if (vfio_device_is_noiommu(device))
> -		device_del(&device->device);
> -	else
> -		cdev_device_del(&device->cdev, &device->device);
> +	cdev_device_del(&device->cdev, &device->device);
>  }
> =20
>  int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab..fc8a50941aac 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -321,6 +321,24 @@ static int vfio_init_device(struct vfio_device *devi=
ce, struct device *dev,
>  	return ret;
>  }
> =20
> +static int vfio_device_set_noiommu_and_name(struct vfio_device *device, =
enum vfio_group_type type)
> +{
> +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vfio_noiommu &&
> +	    !device->dev->iommu && type =3D=3D VFIO_IOMMU)
> +		device->noiommu =3D true;
> +
> +	/*
> +	 * device->noiommu records no-IOMMU support for the standalone cdev
> +	 * interface. VFIO_NOIOMMU enables both group and cdev no-IOMMU; when
> +	 * cdev no-IOMMU is available, device->noiommu is set before
> +	 * vfio_device_set_group(), so the cdev is named noiommu-vfio%d up
> +	 * front. There cannot be a combination of a plain vfio%d cdev name and
> +	 * a no-IOMMU group because VFIO_NOIOMMU selects IOMMUFD_NOIOMMU.
> +	 */
> +	return dev_set_name(&device->device, "%svfio%d",
> +		     device->noiommu ? "noiommu-" : "", device->index);
> +}
> +
>  static int __vfio_register_dev(struct vfio_device *device,
>  			       enum vfio_group_type type)
>  {
> @@ -340,7 +358,7 @@ static int __vfio_register_dev(struct vfio_device *de=
vice,
>  	if (!device->dev_set)
>  		vfio_assign_device_set(device, device);
> =20
> -	ret =3D dev_set_name(&device->device, "vfio%d", device->index);
> +	ret =3D vfio_device_set_noiommu_and_name(device, type);
>  	if (ret)
>  		return ret;
> =20
> @@ -348,6 +366,12 @@ static int __vfio_register_dev(struct vfio_device *d=
evice,
>  	if (ret)
>  		return ret;
> =20
> +	if (vfio_device_is_noiommu(device) && IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU=
)) {
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(device->dev,
> +			 "Adding kernel taint for vfio-noiommu cdev\n");
> +	}
> +
>  	/*
>  	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>  	 * restore cache coherency. It has to be checked here because it is only
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 31b826efba00..45f08986359e 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -74,6 +74,7 @@ struct vfio_device {
>  	u8 iommufd_attached:1;
>  #endif
>  	u8 cdev_opened:1;
> +	u8 noiommu:1;
>  	/*
>  	 * debug_root is a static property of the vfio_device
>  	 * which must be set prior to registering the vfio_device.

