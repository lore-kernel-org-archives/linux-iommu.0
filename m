Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7BC433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:27:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AECE60FC0
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AECE60FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05C60415CF;
	Wed, 29 Sep 2021 06:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mYPYuwpe7-zE; Wed, 29 Sep 2021 06:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC4E1415E4;
	Wed, 29 Sep 2021 06:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB62C000F;
	Wed, 29 Sep 2021 06:27:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20680C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F1F0415BF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pNTBaztGrnmy for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 06:27:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1E19414CA
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:50 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK5yr36wnz4xbQ; Wed, 29 Sep 2021 16:27:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632896868;
 bh=84Gyy3tmXwjpmsJHYbmrxXvK4fzmC1cEHvDeygx5s+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AhGDfuYPOlGUSuom+ZFhfDR+0E6zEp1+ikOguhPsycEGfWi+lEdZ1J67HITD2BESc
 LhxdiLgQOxdYonrF4rpT7AhUaE0Wgvc5HtY5RYwmrixbhEbT91DVUh6Kie1a7hE6/1
 SZ/mzPVkZ8GOVNHS8h4nH/SJI4i2Gk41TuIjyI+s=
Date: Wed, 29 Sep 2021 16:23:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <YVQGaL8RHIw8q/Sq@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-11-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============0302532588613384823=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0302532588613384823==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oXt6fvEiSX3VHBf1"
Content-Disposition: inline


--oXt6fvEiSX3VHBf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:38PM +0800, Liu Yi L wrote:
> After a device is bound to the iommufd, userspace can use this interface
> to query the underlying iommu capability and format info for this device.
> Based on this information the user then creates I/O address space in a
> compatible format with the to-be-attached devices.
>=20
> Device cookie which is registered at binding time is used to mark the
> device which is being queried here.
>=20
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd.c | 68 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/iommu.h      | 49 ++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
>=20
> diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iomm=
ufd.c
> index e16ca21e4534..641f199f2d41 100644
> --- a/drivers/iommu/iommufd/iommufd.c
> +++ b/drivers/iommu/iommufd/iommufd.c
> @@ -117,6 +117,71 @@ static int iommufd_fops_release(struct inode *inode,=
 struct file *filep)
>  	return 0;
>  }
> =20
> +static struct device *
> +iommu_find_device_from_cookie(struct iommufd_ctx *ictx, u64 dev_cookie)
> +{
> +	struct iommufd_device *idev;
> +	struct device *dev =3D NULL;
> +	unsigned long index;
> +
> +	mutex_lock(&ictx->lock);
> +	xa_for_each(&ictx->device_xa, index, idev) {
> +		if (idev->dev_cookie =3D=3D dev_cookie) {
> +			dev =3D idev->dev;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ictx->lock);
> +
> +	return dev;
> +}
> +
> +static void iommu_device_build_info(struct device *dev,
> +				    struct iommu_device_info *info)
> +{
> +	bool snoop;
> +	u64 awidth, pgsizes;
> +
> +	if (!iommu_device_get_info(dev, IOMMU_DEV_INFO_FORCE_SNOOP, &snoop))
> +		info->flags |=3D snoop ? IOMMU_DEVICE_INFO_ENFORCE_SNOOP : 0;
> +
> +	if (!iommu_device_get_info(dev, IOMMU_DEV_INFO_PAGE_SIZE, &pgsizes)) {
> +		info->pgsize_bitmap =3D pgsizes;
> +		info->flags |=3D IOMMU_DEVICE_INFO_PGSIZES;
> +	}
> +
> +	if (!iommu_device_get_info(dev, IOMMU_DEV_INFO_ADDR_WIDTH, &awidth)) {
> +		info->addr_width =3D awidth;
> +		info->flags |=3D IOMMU_DEVICE_INFO_ADDR_WIDTH;
> +	}
> +}
> +
> +static int iommufd_get_device_info(struct iommufd_ctx *ictx,
> +				   unsigned long arg)
> +{
> +	struct iommu_device_info info;
> +	unsigned long minsz;
> +	struct device *dev;
> +
> +	minsz =3D offsetofend(struct iommu_device_info, addr_width);
> +
> +	if (copy_from_user(&info, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +
> +	info.flags =3D 0;
> +
> +	dev =3D iommu_find_device_from_cookie(ictx, info.dev_cookie);
> +	if (!dev)
> +		return -EINVAL;
> +
> +	iommu_device_build_info(dev, &info);
> +
> +	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
> +}
> +
>  static long iommufd_fops_unl_ioctl(struct file *filep,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -127,6 +192,9 @@ static long iommufd_fops_unl_ioctl(struct file *filep,
>  		return ret;
> =20
>  	switch (cmd) {
> +	case IOMMU_DEVICE_GET_INFO:
> +		ret =3D iommufd_get_device_info(ictx, arg);
> +		break;
>  	default:
>  		pr_err_ratelimited("unsupported cmd %u\n", cmd);
>  		break;
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 59178fc229ca..76b71f9d6b34 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -7,6 +7,55 @@
>  #define _UAPI_IOMMU_H
> =20
>  #include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +/* -------- IOCTLs for IOMMU file descriptor (/dev/iommu) -------- */
> +
> +#define IOMMU_TYPE	(';')
> +#define IOMMU_BASE	100
> +
> +/*
> + * IOMMU_DEVICE_GET_INFO - _IOR(IOMMU_TYPE, IOMMU_BASE + 1,
> + *				struct iommu_device_info)
> + *
> + * Check IOMMU capabilities and format information on a bound device.
> + *
> + * The device is identified by device cookie (registered when binding
> + * this device).
> + *
> + * @argsz:	   user filled size of this data.
> + * @flags:	   tells userspace which capability info is available
> + * @dev_cookie:	   user assinged cookie.
> + * @pgsize_bitmap: Bitmap of supported page sizes. 1-setting of the
> + *		   bit in pgsize_bitmap[63:12] indicates a supported
> + *		   page size. Details as below table:
> + *
> + *		   +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+
> + *		   |  Bit[index]   |  Page Size |
> + *		   +---------------+------------+
> + *		   |  12           |  4 KB      |
> + *		   +---------------+------------+
> + *		   |  13           |  8 KB      |
> + *		   +---------------+------------+
> + *		   |  14           |  16 KB     |
> + *		   +---------------+------------+
> + *		   ...
> + * @addr_width:    the address width of supported I/O address spaces.
> + *
> + * Availability: after device is bound to iommufd
> + */
> +struct iommu_device_info {
> +	__u32	argsz;
> +	__u32	flags;
> +#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU enforced snoop=
 */
> +#define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page sizes */
> +#define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /* addr_wdith field valid =
*/
> +	__u64	dev_cookie;
> +	__u64   pgsize_bitmap;
> +	__u32	addr_width;

I think this is where you should be reporting available IOVA windows,
rather than just an address width.  I know that for ppc a real
situation will be to have two different windows of different sizes:
that is the effective address width depends on which IOVA window
you're mapping into.


> +};
> +
> +#define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE + 1)
> =20
>  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oXt6fvEiSX3VHBf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFUBmgACgkQbDjKyiDZ
s5KcNA/+IYrmUsKSSfvS/47hGdeBYJpksx+ZL28qskNmbeiW9fpqaLm9zXFIk4rM
TYVhlAdZtzk1659i4sub5I0dDoWjOGX9xY46cnFveCUG+n5Wf0vScBH6XGRGSBId
aVUqF2RRZJ5OCFaOsqK9m1EWjSAZ5zD+k6H9EQD+6F3JALEXz8CLJSnj4cUIY/20
lrJJnkGY8sp5WjHlsCL1G5fvwMQiAyPgrGSKFhqTuOxDUuEtH5jqIOHYXjU54vwu
fI+iWSQRaAJChS6MIbarg79+XKdqM07y6S50GWRRivpAO0HNbO+m5fnBsqQrMLVD
YFPgcvz/BVpVQf8VKdjxroHiOcJlrWRrbgMocQTwqtRLzGK14gCiYhIVjSImyORm
WKLjYtVBj/dcepThrhSgFtgf5+KW/QZA+UWcitNEDLGNyX9Zt1vCNyZ5Hw2tGNCv
p3btffpwFArW+XBJ/MCLtDPyjeO4fpmcE0vpxX2kM1OJIPkXsbB2eEVeC2gjBxV1
Gw5AtGzatKkPCWpDuc8yqRAuYCOTtaGsZBkAdLx6aKsqwq7m8hpn/P2nCWVOlEwv
l+2goqLnjLvtaOnH7tf8GpCZ67LdYDgSqnM9dwXyOUtlyx4CYzVOkmgnIp01JHg4
lARdTzJUUSug0rMN04JBeoMIw2UYTPSoDIcFcCE9HatkqcH11CI=
=8Y79
-----END PGP SIGNATURE-----

--oXt6fvEiSX3VHBf1--

--===============0302532588613384823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0302532588613384823==--
