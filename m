Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B7C4321E
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:27:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5E0613D0
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E5E0613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A8A8415E4;
	Wed, 29 Sep 2021 06:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guTTFehV685j; Wed, 29 Sep 2021 06:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E637415BF;
	Wed, 29 Sep 2021 06:27:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3D00C0023;
	Wed, 29 Sep 2021 06:27:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80456C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 615944026F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9vlcQ_NMLTFY for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 06:27:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99EA340249
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:50 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK5yr2tQPz4xbP; Wed, 29 Sep 2021 16:27:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632896868;
 bh=jq2RpusWHbQmu4C255IjEuoWL2nlq46w37a5n3Getco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OlWwvFagh1rqSCOVTOisB2+Tc54K3wngEj09GsGl+QABR6dFisGGAAbOPmjikajsv
 Jhcxd94fi7gfKScaavy0aVLY0ylDiGDa8fXjfeeQ3KR7oRYWzwM+1uCdefDE65x5dO
 Su8cIQcsG+598a5C8JIB6AN+W6jxAaRxg30fTkA4=
Date: Wed, 29 Sep 2021 16:00:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <YVQBFgOa4fQRpwqN@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-9-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-9-yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, jgg@nvidia.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2259484733951161824=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2259484733951161824==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/nD5aDiJP7H15fC3"
Content-Disposition: inline


--/nD5aDiJP7H15fC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:36PM +0800, Liu Yi L wrote:
> This patch adds VFIO_DEVICE_BIND_IOMMUFD for userspace to bind the vfio
> device to an iommufd. No VFIO_DEVICE_UNBIND_IOMMUFD interface is provided
> because it's implicitly done when the device fd is closed.
>=20
> In concept a vfio device can be bound to multiple iommufds, each hosting
> a subset of I/O address spaces attached by this device.

I really feel like this many<->many mapping between devices is going
to be super-confusing, and therefore make it really hard to be
confident we have all the rules right for proper isolation.

That's why I was suggesting a concept like endpoints, to break this
into two many<->one relationships.  I'm ok if that isn't visible in
the user API, but I think this is going to be really hard to keep
track of if it isn't explicit somewhere in the internals.

> However as a
> starting point (matching current vfio), only one I/O address space is
> supported per vfio device. It implies one device can only be attached
> to one iommufd at this point.
>=20
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/Kconfig            |  1 +
>  drivers/vfio/pci/vfio_pci.c         | 72 ++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_private.h |  8 ++++
>  include/uapi/linux/vfio.h           | 30 ++++++++++++
>  4 files changed, 110 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 5e2e1b9a9fd3..3abfb098b4dc 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -5,6 +5,7 @@ config VFIO_PCI
>  	depends on MMU
>  	select VFIO_VIRQFD
>  	select IRQ_BYPASS_MANAGER
> +	select IOMMUFD
>  	help
>  	  Support for the PCI VFIO bus driver.  This is required to make
>  	  use of PCI drivers using the VFIO framework.
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 145addde983b..20006bb66430 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -552,6 +552,16 @@ static void vfio_pci_release(struct vfio_device *cor=
e_vdev)
>  			vdev->req_trigger =3D NULL;
>  		}
>  		mutex_unlock(&vdev->igate);
> +
> +		mutex_lock(&vdev->videv_lock);
> +		if (vdev->videv) {
> +			struct vfio_iommufd_device *videv =3D vdev->videv;
> +
> +			vdev->videv =3D NULL;
> +			iommufd_unbind_device(videv->idev);
> +			kfree(videv);
> +		}
> +		mutex_unlock(&vdev->videv_lock);
>  	}
> =20
>  	mutex_unlock(&vdev->reflck->lock);
> @@ -780,7 +790,66 @@ static long vfio_pci_ioctl(struct vfio_device *core_=
vdev,
>  		container_of(core_vdev, struct vfio_pci_device, vdev);
>  	unsigned long minsz;
> =20
> -	if (cmd =3D=3D VFIO_DEVICE_GET_INFO) {
> +	if (cmd =3D=3D VFIO_DEVICE_BIND_IOMMUFD) {
> +		struct vfio_device_iommu_bind_data bind_data;
> +		unsigned long minsz;
> +		struct iommufd_device *idev;
> +		struct vfio_iommufd_device *videv;
> +
> +		/*
> +		 * Reject the request if the device is already opened and
> +		 * attached to a container.
> +		 */
> +		if (vfio_device_in_container(core_vdev))

Usually one would do argument sanity checks before checks that
actually depend on machine state.

> +			return -ENOTTY;

This doesn't seem like the right error code.  It's a perfectly valid
operation for this device - just not available right now.

> +
> +		minsz =3D offsetofend(struct vfio_device_iommu_bind_data, dev_cookie);
> +
> +		if (copy_from_user(&bind_data, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (bind_data.argsz < minsz ||
> +		    bind_data.flags || bind_data.iommu_fd < 0)
> +			return -EINVAL;
> +
> +		mutex_lock(&vdev->videv_lock);
> +		/*
> +		 * Allow only one iommufd per device until multiple
> +		 * address spaces (e.g. vSVA) support is introduced
> +		 * in the future.
> +		 */
> +		if (vdev->videv) {
> +			mutex_unlock(&vdev->videv_lock);
> +			return -EBUSY;
> +		}
> +
> +		idev =3D iommufd_bind_device(bind_data.iommu_fd,
> +					   &vdev->pdev->dev,
> +					   bind_data.dev_cookie);
> +		if (IS_ERR(idev)) {
> +			mutex_unlock(&vdev->videv_lock);
> +			return PTR_ERR(idev);
> +		}
> +
> +		videv =3D kzalloc(sizeof(*videv), GFP_KERNEL);
> +		if (!videv) {
> +			iommufd_unbind_device(idev);
> +			mutex_unlock(&vdev->videv_lock);
> +			return -ENOMEM;
> +		}
> +		videv->idev =3D idev;
> +		videv->iommu_fd =3D bind_data.iommu_fd;
> +		/*
> +		 * A security context has been established. Unblock
> +		 * user access.
> +		 */
> +		if (atomic_read(&vdev->block_access))
> +			atomic_set(&vdev->block_access, 0);
> +		vdev->videv =3D videv;
> +		mutex_unlock(&vdev->videv_lock);
> +
> +		return 0;
> +	} else if (cmd =3D=3D VFIO_DEVICE_GET_INFO) {
>  		struct vfio_device_info info;
>  		struct vfio_info_cap caps =3D { .buf =3D NULL, .size =3D 0 };
>  		unsigned long capsz;
> @@ -2031,6 +2100,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
>  	mutex_init(&vdev->vma_lock);
>  	INIT_LIST_HEAD(&vdev->vma_list);
>  	init_rwsem(&vdev->memory_lock);
> +	mutex_init(&vdev->videv_lock);
> =20
>  	ret =3D vfio_pci_reflck_attach(vdev);
>  	if (ret)
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_=
pci_private.h
> index f12012e30b53..bd784accac35 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/uuid.h>
>  #include <linux/notifier.h>
> +#include <linux/iommufd.h>
> =20
>  #ifndef VFIO_PCI_PRIVATE_H
>  #define VFIO_PCI_PRIVATE_H
> @@ -99,6 +100,11 @@ struct vfio_pci_mmap_vma {
>  	struct list_head	vma_next;
>  };
> =20
> +struct vfio_iommufd_device {
> +	struct iommufd_device *idev;

Could this be embedded to avoid multiple layers of pointers?

> +	int iommu_fd;
> +};
> +
>  struct vfio_pci_device {
>  	struct vfio_device	vdev;
>  	struct pci_dev		*pdev;
> @@ -144,6 +150,8 @@ struct vfio_pci_device {
>  	struct list_head	vma_list;
>  	struct rw_semaphore	memory_lock;
>  	atomic_t		block_access;
> +	struct mutex		videv_lock;
> +	struct vfio_iommufd_device *videv;
>  };
> =20
>  #define is_intx(vdev) (vdev->irq_type =3D=3D VFIO_PCI_INTX_IRQ_INDEX)
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index ef33ea002b0b..c902abd60339 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -190,6 +190,36 @@ struct vfio_group_status {
> =20
>  /* --------------- IOCTLs for DEVICE file descriptors --------------- */
> =20
> +/*
> + * VFIO_DEVICE_BIND_IOMMUFD - _IOR(VFIO_TYPE, VFIO_BASE + 19,
> + *				struct vfio_device_iommu_bind_data)
> + *
> + * Bind a vfio_device to the specified iommufd
> + *
> + * The user should provide a device cookie when calling this ioctl. The
> + * cookie is later used in iommufd for capability query, iotlb invalidat=
ion
> + * and I/O fault handling.
> + *
> + * User is not allowed to access the device before the binding operation
> + * is completed.
> + *
> + * Unbind is automatically conducted when device fd is closed.
> + *
> + * Input parameters:
> + *	- iommu_fd;
> + *	- dev_cookie;
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_device_iommu_bind_data {
> +	__u32	argsz;
> +	__u32	flags;
> +	__s32	iommu_fd;
> +	__u64	dev_cookie;
> +};
> +
> +#define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 19)
> +
>  /**
>   * VFIO_DEVICE_GET_INFO - _IOR(VFIO_TYPE, VFIO_BASE + 7,
>   *						struct vfio_device_info)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/nD5aDiJP7H15fC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFUARMACgkQbDjKyiDZ
s5L4Jw/+NgsMPNvxtj3apjSyt0/aHAJwv8hcuQKR/Ge7fTVxTktX9jnWe75QBOp/
IT1sp5+3SghyQr/BNedlP5/FBslC4xNhxW3PZcHh5tggPT6lMz18PD+Goqoww7DP
c1yAIkOZ12Y1uirUNM6Gk+uj5MpRggT8LImcsAd2pL7RzjF7uGm09GMp5UoU7GMW
ikdShKoEVBw7tnYry7iHK0F35Y8XRO5/qr37G2swxh6dXfa9EtRV7ZMrqR7VD4ky
X4Li8ZeodCjWUwokeJ9mS474vw7dwcdrce9Dq6dv5I6k+bYv6G9LfYLoL5fvd/17
QIdJKFMRyHlZFqlXujXV7g/Yc5G7C0CZhKlarh2QxHgHpNZ6lLBPMqX8awg05j6t
9IE9gVCmva0HI2JXLKje650HWwz3rloIRvN+Ix48ZAWHYkVkHFFZmyl3Fi7vCiVF
qQlr2eLim/Vxj0X/HDYmIzgHZjIVr8LzH+ZkNMjArskc+wU8q+kuIR4tIK4bu8ib
PjTIAdN7oYlAt2tB74FRF/Hh253UQ0qFoFGPOrEfOmLNCYka1TUGxeCGqc273b9a
bpkZr/1/SuOiLOmfwSkMsWeOd9AcXQAv5WZx1QCjpK/BuPMjwpuVG/WtTBk1plPM
uM2HBrEYkizFX8bOlWZsVaTse6IzEIyJYv8kmfT8PXfYvhsc0eM=
=XCRH
-----END PGP SIGNATURE-----

--/nD5aDiJP7H15fC3--

--===============2259484733951161824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2259484733951161824==--
