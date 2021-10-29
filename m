Return-Path: <SRS0=EsFc=PR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9BC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 07:42:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CAD6108F
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 07:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7CAD6108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C4BA826C7;
	Fri, 29 Oct 2021 07:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8myMjL_xhUE; Fri, 29 Oct 2021 07:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3AFF8271A;
	Fri, 29 Oct 2021 07:42:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D24AEC001E;
	Fri, 29 Oct 2021 07:42:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31E55C0012
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 07:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B83460773
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 07:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oBpOjaEmp3Qq for <iommu@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 07:42:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A184E606B8
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 07:42:41 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HgZCL0M3Nz4xZ1; Fri, 29 Oct 2021 18:42:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1635493358;
 bh=2SGbEMmzDI08MpQNEg9P7FwyGtzoC87TixsMq3kMbWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DaCaXqHDfxUotFEcUMg+PamBC9g7iqAFC2RC5KQzTTsQoPBRE2UcPzL/UbxbSsFmK
 cYTLsEBSxgyd/f0VeRJewC0Wv77RXvwP1qJcaOBxBASlRPwl3f2No6jzK/YiRgwwIZ
 Qo/cRsUraJPqN8Q6FPwVAUzuZMo3+kU696PlmkLQ=
Date: Fri, 29 Oct 2021 11:15:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 20/20] Doc: Add documentation for /dev/iommu
Message-ID: <YXs9IwqYHvUUXePO@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-21-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-21-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============3665716340608476274=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3665716340608476274==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ptBJ3+8XsUlnvRfc"
Content-Disposition: inline


--ptBJ3+8XsUlnvRfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:48PM +0800, Liu Yi L wrote:
> Document the /dev/iommu framework for user.
>=20
> Open:
> Do we want to document /dev/iommu in Documentation/userspace-api/iommu.rs=
t?
> Existing iommu.rst is for the vSVA interfaces, honestly, may need to rewr=
ite
> this doc entirely.
>=20
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  Documentation/userspace-api/index.rst   |   1 +
>  Documentation/userspace-api/iommufd.rst | 183 ++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 Documentation/userspace-api/iommufd.rst
>=20
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/usersp=
ace-api/index.rst
> index 0b5eefed027e..54df5a278023 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -25,6 +25,7 @@ place where this information is gathered.
>     ebpf/index
>     ioctl/index
>     iommu
> +   iommufd
>     media/index
>     sysfs-platform_profile
> =20
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/user=
space-api/iommufd.rst
> new file mode 100644
> index 000000000000..abffbb47dc02
> --- /dev/null
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. iommu:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +IOMMU Userspace API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Direct device access from userspace has been a crtical feature in
> +high performance computing and virtualization usages. Linux now
> +includes multiple device-passthrough frameworks (e.g. VFIO and vDPA)
> +to manage secure device access from the userspace. One critical
> +task of those frameworks is to put the assigned device in a secure,
> +IOMMU-protected context so the device is prevented from doing harm
> +to the rest of the system.
> +
> +Currently those frameworks implement their own logic for managing
> +I/O page tables to isolate user-initiated DMAs. This doesn't scale
> +to support many new IOMMU features, such as PASID-granular DMA
> +remapping, nested translation, I/O page fault, IOMMU dirty bit, etc.
> +
> +The /dev/iommu framework provides an unified interface for managing
> +I/O page tables for passthrough devices. Existing passthrough
> +frameworks are expected to use this interface instead of continuing
> +their ad-hoc implementations.
> +
> +IOMMUFDs, IOASIDs, Devices and Groups
> +-------------------------------------
> +
> +The core concepts in /dev/iommu are IOMMUFDs and IOASIDs. IOMMUFD (by
> +opening /dev/iommu) is the container holding multiple I/O address
> +spaces for a user, while IOASID is the fd-local software handle
> +representing an I/O address space and associated with a single I/O
> +page table. User manages those address spaces through fd operations,
> +e.g. by using vfio type1v2 mapping semantics to manage respective
> +I/O page tables.
> +
> +IOASID is comparable to the conatiner concept in VFIO. The latter
> +is also associated to a single I/O address space. A main difference
> +between them is that multiple IOASIDs in the same IOMMUFD can be
> +nested together (not supported yet) to allow centralized accounting
> +of locked pages, while multiple containers are disconnected thus
> +duplicated accounting is incurred. Typically one IOMMUFD is
> +sufficient for all intended IOMMU usages for a user.
> +
> +An I/O address space takes effect in the IOMMU only after it is
> +attached by a device. One I/O address space can be attached by
> +multiple devices. One device can be only attached to a single I/O
> +address space at this point (on par with current vfio behavior).
> +
> +Device must be bound to an iommufd before the attach operation can
> +be conducted. The binding operation builds the connection between
> +the devicefd (opened via device-passthrough framework) and IOMMUFD.
> +IOMMU-protected security context is esbliashed when the binding
> +operation is completed.

This can't be quite right.  You can't establish a safe security
context until all devices in the groun are bound, but you can only
bind them one at a time.

>  The passthrough framework must block user
> +access to the assigned device until bind() returns success.
> +
> +The entire /dev/iommu framework adopts a device-centric model w/o
> +carrying any container/group legacy as current vfio does. However
> +the group is the minimum granularity that must be used to ensure
> +secure user access (refer to vfio.rst). This framework relies on
> +the IOMMU core layer to map device-centric model into group-granular
> +isolation.
> +
> +Managing I/O Address Spaces
> +---------------------------
> +
> +When creating an I/O address space (by allocating IOASID), the user
> +must specify the type of underlying I/O page table. Currently only
> +one type (kernel-managed) is supported. In the future other types
> +will be introduced, e.g. to support user-managed I/O page table or
> +a shared I/O page table which is managed by another kernel sub-
> +system (mm, ept, etc.). Kernel-managed I/O page table is currently
> +managed via vfio type1v2 equivalent mapping semantics.
> +
> +The user also needs to specify the format of the I/O page table
> +when allocating an IOASID.

This almost seems redundant with the previous paragraph.  I think
maybe it's making a distinction between "type" and "format", but I
don't think it's very clear what the distinction is.

> The format must be compatible to the
> +attached devices (or more specifically to the IOMMU which serves
> +the DMA from the attached devices). User can query the device IOMMU
> +format via IOMMUFD once a device is successfully bound. Attaching a
> +device to an IOASID with incompatible format is simply rejected.
> +
> +Currently no-snoop DMA is not supported yet. This implies that
> +IOASID must be created in an enforce-snoop format and only devices
> +which can be forced to snoop cache by IOMMU are allowed to be
> +attached to IOASID. The user should check uAPI extension and get
> +device info via IOMMUFD to handle such restriction.
> +
> +Usage Example
> +-------------
> +
> +Assume user wants to access PCI device 0000:06:0d.0, which is
> +exposed under the new /dev/vfio/devices directory by VFIO:
> +
> +	/* Open device-centric interface and /dev/iommu interface */
> +	device_fd =3D open("/dev/vfio/devices/0000:06:0d.0", O_RDWR);
> +	iommu_fd =3D open("/dev/iommu", O_RDWR);
> +
> +	/* Bind device to IOMMUFD */
> +	bind_data =3D { .iommu_fd =3D iommu_fd, .dev_cookie =3D cookie };
> +	ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind_data);
> +
> +	/* Query per-device IOMMU capability/format */
> +	info =3D { .dev_cookie =3D cookie, };
> +	ioctl(iommu_fd, IOMMU_DEVICE_GET_INFO, &info);
> +
> +	if (!(info.flags & IOMMU_DEVICE_INFO_ENFORCE_SNOOP)) {
> +		if (!ioctl(iommu_fd, IOMMU_CHECK_EXTENSION,
> +				EXT_DMA_NO_SNOOP))
> +			/* No support of no-snoop DMA */
> +	}
> +
> +	if (!ioctl(iommu_fd, IOMMU_CHECK_EXTENSION, EXT_MAP_TYPE1V2))
> +		/* No support of vfio type1v2 mapping semantics */
> +
> +	/* Decides IOASID alloc fields based on info */
> +	alloc_data =3D { .type =3D IOMMU_IOASID_TYPE_KERNEL,
> +		       .flags =3D IOMMU_IOASID_ENFORCE_SNOOP,
> +		       .addr_width =3D info.addr_width, };
> +
> +	/* Allocate IOASID */
> +	gpa_ioasid =3D ioctl(iommu_fd, IOMMU_IOASID_ALLOC, &alloc_data);
> +
> +	/* Attach device to an IOASID */
> +	at_data =3D { .iommu_fd =3D iommu_fd; .ioasid =3D gpa_ioasid};
> +	ioctl(device_fd, VFIO_DEVICE_ATTACH_IOASID, &at_data);
> +
> +	/* Setup GPA mapping [0 - 1GB] */
> +	dma_map =3D {
> +		.ioasid	=3D gpa_ioasid,
> +		.data {
> +			.flags  =3D R/W		/* permission */
> +			.iova	=3D 0,		/* GPA */
> +			.vaddr	=3D 0x40000000,	/* HVA */
> +			.size	=3D 1GB,
> +		},
> +	};
> +	ioctl(iommu_fd, IOMMU_MAP_DMA, &dma_map);
> +
> +	/* DMA */
> +
> +	/* Unmap GPA mapping [0 - 1GB] */
> +	dma_unmap =3D {
> +		.ioasid	=3D gpa_ioasid,
> +		.data {
> +			.iova	=3D 0,		/* GPA */
> +			.size	=3D 1GB,
> +		},
> +	};
> +	ioctl(iommu_fd, IOMMU_UNMAP_DMA, &dma_unmap);
> +
> +	/* Detach device from an IOASID */
> +	dt_data =3D { .iommu_fd =3D iommu_fd; .ioasid =3D gpa_ioasid};
> +	ioctl(device_fd, VFIO_DEVICE_DETACH_IOASID, &dt_data);
> +
> +	/* Free IOASID */
> +	ioctl(iommu_fd, IOMMU_IOASID_FREE, gpa_ioasid);
> +
> +	close(device_fd);
> +	close(iommu_fd);
> +
> +API for device-passthrough frameworks
> +-------------------------------------
> +
> +iommufd binding and IOASID attach/detach are initiated via the device-
> +passthrough framework uAPI.
> +
> +When a binding operation is requested by the user, the passthrough
> +framework should call iommufd_bind_device(). When the device fd is
> +closed by the user, iommufd_unbind_device() should be called
> +automatically::
> +
> +	struct iommufd_device *
> +	iommufd_bind_device(int fd, struct device *dev,
> +			   u64 dev_cookie);
> +	void iommufd_unbind_device(struct iommufd_device *idev);
> +
> +IOASID attach/detach operations are per iommufd_device which is
> +returned by iommufd_bind_device():
> +
> +	int iommufd_device_attach_ioasid(struct iommufd_device *idev,
> +					int ioasid);
> +	void iommufd_device_detach_ioasid(struct iommufd_device *idev,
> +					int ioasid);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ptBJ3+8XsUlnvRfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmF7PSMACgkQbDjKyiDZ
s5JX5g//VoYN5DuZHAMTNQKqRM/ijZcatJwkpIL6eQrgohmJImQlSHJ9KUBHej1z
YXlaYqO9q55OZMeUeCMDzZh7u4j07VhaHW1O1qtcuLa0j8+A0vBZeMi2D/tl+tcF
rhsNnftXqAGyk6OXUIVYZnRnE/ZAAfSGp6I4GMF4bwEbTnO3tSseHEQb3j9FWq8N
y6ank6sPpf8BxYTH9CQU5iPWRb/SkYSlJeGfXe4/F/cTor49OEDGoJdidDsFtm7q
XB89OKXHD8zn2ITw/XVawb2qi3boRTibChUCdU1Y2QyrAZQ9ssNIn6ZoZrOBDUCc
JNyf5K3tmNn3cVYbvH2UO7yyUTxY9YfY8Gtue8tsZ6IaNfgKITyBhu6cEk2gD+Mr
iUSqi5IBl4xV0D0l+8lSOLrSgq80/Irw3kbyaOHlqilVhuFASduGUnxHLlNcVxo6
L+78q4Z5GLTc2B2DPAhjxDyWcDzTwqeTC5ouXDIpbBvz8iN+KqT9NAF3zuKN3jxW
DFWnVMxUDzki9MHns04QXXtsJDVGFlVZWq/Wm1ar/cCFANnQaMutKUak1ahNP8bT
Vo5buTPlx9UpRLRw98BYKjB472hjJUooChVEgAhPKaLKtvfFq0f0ab47WUBBWVRd
ycB4qlHgHiY2Tk4uOHLLLpD1e5WNXFjga0kJzeZo4ph4R0LdJAk=
=Qvdu
-----END PGP SIGNATURE-----

--ptBJ3+8XsUlnvRfc--

--===============3665716340608476274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3665716340608476274==--
