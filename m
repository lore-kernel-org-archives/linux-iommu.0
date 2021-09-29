Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40933C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 03:34:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A43613E8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 03:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0A43613E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80CF440258;
	Wed, 29 Sep 2021 03:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Em2JFIjLKncJ; Wed, 29 Sep 2021 03:33:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E61BF40249;
	Wed, 29 Sep 2021 03:33:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8524DC0022;
	Wed, 29 Sep 2021 03:33:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E64ECC000F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D939F4026F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TuAGZa5GtDkD for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 03:33:55 +0000 (UTC)
X-Greylist: delayed 00:05:48 by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A930340249
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:55 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK1zN6nb2z4xbV; Wed, 29 Sep 2021 13:28:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632886080;
 bh=Lh+wqN85LusSTOWoTTGpIhxEKSNXglqDi5cXmcybyPM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m7I2czU/ggIlbJAAyXgNdK8RQLIITkNN0SyDYxNIKsDzIiU5uNcek1Cfjb7jJp1WR
 YwqoJQfaA1ULr8RKCo/228A0SIauH0eZFDoXW7OUbeei1V22P6MVvNhW4rciYaFQA/
 9cfwuWQaJGiCzNlMpKNOef7AQANPmV5yDZ3dOncw=
Date: Wed, 29 Sep 2021 12:52:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 04/20] iommu: Add iommu_device_get_info interface
Message-ID: <YVPU89utk3JFPzS7@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-5-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210919063848.1476776-5-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============0055948241095760027=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0055948241095760027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sQ2hNteQVd2DEBye"
Content-Disposition: inline


--sQ2hNteQVd2DEBye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2021 at 02:38:32PM +0800, Liu Yi L wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This provides an interface for upper layers to get the per-device iommu
> attributes.
>=20
>     int iommu_device_get_info(struct device *dev,
>                               enum iommu_devattr attr, void *data);

That fact that this interface doesn't let you know how to size the
data buffer, other than by just knowing the right size for each attr
concerns me.

>=20
> The first attribute (IOMMU_DEV_INFO_FORCE_SNOOP) is added. It tells if
> the iommu can force DMA to snoop cache. At this stage, only PCI devices
> which have this attribute set could use the iommufd, this is due to
> supporting no-snoop DMA requires additional refactoring work on the
> current kvm-vfio contract. The following patch will have vfio check this
> attribute to decide whether a pci device can be exposed through
> /dev/vfio/devices.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 16 ++++++++++++++++
>  include/linux/iommu.h | 19 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 63f0af10c403..5ea3a007fd7c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3260,3 +3260,19 @@ static ssize_t iommu_group_store_type(struct iommu=
_group *group,
> =20
>  	return ret;
>  }
> +
> +/* Expose per-device iommu attributes. */
> +int iommu_device_get_info(struct device *dev, enum iommu_devattr attr, v=
oid *data)
> +{
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->bus || !dev->bus->iommu_ops)
> +		return -EINVAL;
> +
> +	ops =3D dev->bus->iommu_ops;
> +	if (unlikely(!ops->device_info))
> +		return -ENODEV;
> +
> +	return ops->device_info(dev, attr, data);
> +}
> +EXPORT_SYMBOL_GPL(iommu_device_get_info);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..52a6d33c82dc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -150,6 +150,14 @@ enum iommu_dev_features {
>  	IOMMU_DEV_FEAT_IOPF,
>  };
> =20
> +/**
> + * enum iommu_devattr - Per device IOMMU attributes
> + * @IOMMU_DEV_INFO_FORCE_SNOOP [bool]: IOMMU can force DMA to be snooped.
> + */
> +enum iommu_devattr {
> +	IOMMU_DEV_INFO_FORCE_SNOOP,
> +};
> +
>  #define IOMMU_PASID_INVALID	(-1U)
> =20
>  #ifdef CONFIG_IOMMU_API
> @@ -215,6 +223,7 @@ struct iommu_iotlb_gather {
>   *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
>   *		- IOMMU_DOMAIN_DMA: must use a dma domain
>   *		- 0: use the default setting
> + * @device_info: query per-device iommu attributes
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   * @owner: Driver module providing these ops
>   */
> @@ -283,6 +292,8 @@ struct iommu_ops {
> =20
>  	int (*def_domain_type)(struct device *dev);
> =20
> +	int (*device_info)(struct device *dev, enum iommu_devattr attr, void *d=
ata);
> +
>  	unsigned long pgsize_bitmap;
>  	struct module *owner;
>  };
> @@ -604,6 +615,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device=
 *dev,
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> =20
> +int iommu_device_get_info(struct device *dev, enum iommu_devattr attr, v=
oid *data);
> +
>  #else /* CONFIG_IOMMU_API */
> =20
>  struct iommu_ops {};
> @@ -999,6 +1012,12 @@ static inline struct iommu_fwspec *dev_iommu_fwspec=
_get(struct device *dev)
>  {
>  	return NULL;
>  }
> +
> +static inline int iommu_device_get_info(struct device *dev,
> +					enum iommu_devattr type, void *data)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_IOMMU_API */
> =20
>  /**

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sQ2hNteQVd2DEBye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFT1PMACgkQbDjKyiDZ
s5Kp4xAAuqP94XHXa8idfiJzr+Zmk3LlF5iLCDGNb7As35wm2B95WzFXrIvnG0PR
9GuRnTDbazPssJA5PSwrI8g10LpZ52exjVV00iv1sU62Nk64xahNK+1jpLq5Ktsf
621axCsT3ZqGHy7IQDfERmgJccl4FNdU2Jiv+uUiCcfeUTPNEx6UOggtUGfHMapF
/RYgmuGlI34vI9TUz2y+SxBdfiDp9ySjhNnD5PEjggGy731te7iWKF3nJv4WBPPH
1E0vEaj4ttoY9CnA3ta1waG8pZDJXtNcX3kXC+VE0hmd0KiazEIGt1cqqkZZ9khq
40y+9nfCu2mzsD10qD8VMy3vwoDRnPChsepZRQdT884+J5OjlOk9shLZHdp8mjRh
YDAyqlMyg6dNyHfH/scB7W+eTASkas6FkyNCNvGMFj1nGjGt4xssWFC3mUtHYE1s
Bnd8g5HGZspQKn/hzaXoDgvi6TdNQzApVzIwY+I0AdKFnr3v3kFtIhOptfzKGYGT
q0Ar3JXZAdppywVBThSRKWjMOIBUHbCkXUl6TVdo+ebmeKOJjceKY2BC3SQoDKiG
Pv0vraoPolTkSq1iaKMnR+xwVmATYdZ6wAuKG4TIZ5I7yGAzK+0s5d6zS2mm66kN
uBaU2bfeBKTDdz2xj1fxiK2vZ88TB0rDXoKagGCeKHAigohc82Y=
=EJNn
-----END PGP SIGNATURE-----

--sQ2hNteQVd2DEBye--

--===============0055948241095760027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0055948241095760027==--
