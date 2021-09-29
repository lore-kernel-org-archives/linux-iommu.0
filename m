Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E208C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 03:34:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2530F613D1
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 03:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2530F613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E33A7415B6;
	Wed, 29 Sep 2021 03:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWoy2wv2-0mX; Wed, 29 Sep 2021 03:34:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A135C40775;
	Wed, 29 Sep 2021 03:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADBD5C0027;
	Wed, 29 Sep 2021 03:33:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F883C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF8BD40249
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngeyv5X0nizH for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
X-Greylist: delayed 00:05:45 by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D22844026B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:55 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK1zN6KgDz4xZJ; Wed, 29 Sep 2021 13:28:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632886080;
 bh=or14ij/yBL19FjOCDsq0iAERcyiiYaHgFexNi04sb48=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jK76m0XsvCYgqc5O5vt60FBITyisxy37c72l0yhrARzYXhnqOHbuEDZXS3rqSNwKa
 LDl3EBUKF3iXf6FoCnHsokBb8jPZenL2TYKf+4WEHthw3EjMsbu+Bw17crMQDvL7fv
 MGdaUPaeiRdaBOALa7efNweYMOueSg3zZgFhhlD0=
Date: Wed, 29 Sep 2021 12:08:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Message-ID: <YVPKu/F3IpPMtGCh@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-3-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-3-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============3783268896302698385=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3783268896302698385==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rFAAVZBIABvNkDR9"
Content-Disposition: inline


--rFAAVZBIABvNkDR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:30PM +0800, Liu Yi L wrote:
> This patch introduces a new interface (/dev/vfio/devices/$DEVICE) for
> userspace to directly open a vfio device w/o relying on container/group
> (/dev/vfio/$GROUP). Anything related to group is now hidden behind
> iommufd (more specifically in iommu core by this RFC) in a device-centric
> manner.
>=20
> In case a device is exposed in both legacy and new interfaces (see next
> patch for how to decide it), this patch also ensures that when the device
> is already opened via one interface then the other one must be blocked.
>=20
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
[snip]

> +static bool vfio_device_in_container(struct vfio_device *device)
> +{
> +	return !!(device->group && device->group->container);

You don't need !! here.  && is already a logical operation, so returns
a valid bool.

> +}
> +
>  static int vfio_device_fops_release(struct inode *inode, struct file *fi=
lep)
>  {
>  	struct vfio_device *device =3D filep->private_data;
> @@ -1560,7 +1691,16 @@ static int vfio_device_fops_release(struct inode *=
inode, struct file *filep)
> =20
>  	module_put(device->dev->driver->owner);
> =20
> -	vfio_group_try_dissolve_container(device->group);
> +	if (vfio_device_in_container(device)) {
> +		vfio_group_try_dissolve_container(device->group);
> +	} else {
> +		atomic_dec(&device->opened);
> +		if (device->group) {
> +			mutex_lock(&device->group->opened_lock);
> +			device->group->opened--;
> +			mutex_unlock(&device->group->opened_lock);
> +		}
> +	}
> =20
>  	vfio_device_put(device);
> =20
> @@ -1613,6 +1753,7 @@ static int vfio_device_fops_mmap(struct file *filep=
, struct vm_area_struct *vma)
> =20
>  static const struct file_operations vfio_device_fops =3D {
>  	.owner		=3D THIS_MODULE,
> +	.open		=3D vfio_device_fops_open,
>  	.release	=3D vfio_device_fops_release,
>  	.read		=3D vfio_device_fops_read,
>  	.write		=3D vfio_device_fops_write,
> @@ -2295,6 +2436,52 @@ static struct miscdevice vfio_dev =3D {
>  	.mode =3D S_IRUGO | S_IWUGO,
>  };
> =20
> +static char *vfio_device_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));

Others have pointed out some problems with the use of dev_name()
here.  I'll add that I think you'll make things much easier if instead
of using one huge "devices" subdir, you use a separate subdir for each
vfio sub-driver (so, one for PCI, one for each type of mdev, one for
platform, etc.).  That should make avoiding name conflicts a lot simpler.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rFAAVZBIABvNkDR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFTyrkACgkQbDjKyiDZ
s5LDRxAA45DlpAfiA499JLduAg68fEU3Bdr3uqrAxaxXW5bnLJVw9BLOv1YV6Izb
GffTAoUJE/gceiS+dIPmE1A8Zxsdb3vCT3Ci8gKEevQ/zMcqBdnO5KZ//nRAlrMl
vsDahtaUQy/3uxRqSA8r2jlEujuHfdFJzi5pNosxfLQkCiSkYzAG7ePdxDOEBhJv
bqay3ZBkns2E8RjTZ8ytDBV2zHqQW3G2/kqFAK7qx8eefGROcDAv7NoroHt8EB8+
EYBXZgj+4nQChP+wQoEmXkRzkDocPtS4IKODB1YjTTCKW4O0YI8TfuvnCCPRLrku
VZFk4PNw9sADsqB4plA+3/QkeDLskC23/GTZ/+djAVcsSAs+Oyiisw63I7LibeKg
h5LKefqlBoOURSgk9f0AHIYwaxoE7qXgsf7zGKcI80waLoVWkOQXSj5/D0asFtGf
sZrthpsKPKAl40jH+lA35r98Acb/m8uJdICPUoG/QTtc8F/0UIjWKsZxJH8Wtss8
FaCAP1lw3gKK76Trdi2XavMZFkRmWNatPKTiCaNY8qQRyt/RvAteJjnwR1R2RKji
fAQo8P1ZNxAhrGdYI9QzAsy0pYyO0Va/TPy0lf9KRQHIH4ff2DGHQB0azLwyJ+JF
3x7clC6gMiPwmHmWUMwTgrenfi6br6zggTRWzC2sWbs0iJCzIRo=
=C+J/
-----END PGP SIGNATURE-----

--rFAAVZBIABvNkDR9--

--===============3783268896302698385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3783268896302698385==--
