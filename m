Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4668BC433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:27:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3857613D0
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 06:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3857613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA748415F0;
	Wed, 29 Sep 2021 06:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WpDUzJaOIfTv; Wed, 29 Sep 2021 06:27:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90374415F2;
	Wed, 29 Sep 2021 06:27:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26ADEC0023;
	Wed, 29 Sep 2021 06:27:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADF50C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E19C415F0
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljb2_UiS0T-E for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 06:27:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D6C3414CA
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 06:27:53 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK5yr30DVz4xZJ; Wed, 29 Sep 2021 16:27:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632896868;
 bh=nW9WwB4krc4OXpzxcuXzAt9baC6o0ghnIlnPDB1Xd1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dzMvEezuJqaNXvc6p9R9PekRSEZPKDJLmyBFe5iPlbl7WM+U48X2/7TNxFUIJe0iT
 ZBH8X4JWaE9lnwOQmhvTPuRimhY7Ef7t3zCXnigRgV2cBvGwwsKzGQYiIjyRyXJqFL
 n3NyZ5fOSQeT7eoVP+Lyf1cA5NZWTAY29Fy+kLk8=
Date: Wed, 29 Sep 2021 16:18:34 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <YVQFOun0Ae3/V2Y4@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210921174049.GV327412@nvidia.com>
 <BN9PR11MB5433D26EFA94F59756AF91838CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922124150.GK327412@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210922124150.GK327412@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============0278322182416241085=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0278322182416241085==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9KkT761rRKdNuQHa"
Content-Disposition: inline


--9KkT761rRKdNuQHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 22, 2021 at 09:41:50AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 03:30:09AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, September 22, 2021 1:41 AM
> > >=20
> > > On Sun, Sep 19, 2021 at 02:38:38PM +0800, Liu Yi L wrote:
> > > > After a device is bound to the iommufd, userspace can use this inte=
rface
> > > > to query the underlying iommu capability and format info for this d=
evice.
> > > > Based on this information the user then creates I/O address space i=
n a
> > > > compatible format with the to-be-attached devices.
> > > >
> > > > Device cookie which is registered at binding time is used to mark t=
he
> > > > device which is being queried here.
> > > >
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > >  drivers/iommu/iommufd/iommufd.c | 68
> > > +++++++++++++++++++++++++++++++++
> > > >  include/uapi/linux/iommu.h      | 49 ++++++++++++++++++++++++
> > > >  2 files changed, 117 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/iommufd/iommufd.c
> > > b/drivers/iommu/iommufd/iommufd.c
> > > > index e16ca21e4534..641f199f2d41 100644
> > > > +++ b/drivers/iommu/iommufd/iommufd.c
> > > > @@ -117,6 +117,71 @@ static int iommufd_fops_release(struct inode
> > > *inode, struct file *filep)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static struct device *
> > > > +iommu_find_device_from_cookie(struct iommufd_ctx *ictx, u64
> > > dev_cookie)
> > > > +{
> > >=20
> > > We have an xarray ID for the device, why are we allowing userspace to
> > > use the dev_cookie as input?
> > >=20
> > > Userspace should always pass in the ID. The only place dev_cookie
> > > should appear is if the kernel generates an event back to
> > > userspace. Then the kernel should return both the ID and the
> > > dev_cookie in the event to allow userspace to correlate it.
> > >=20
> >=20
> > A little background.
> >=20
> > In earlier design proposal we discussed two options. One is to return
> > an kernel-allocated ID (label) to userspace. The other is to have user
> > register a cookie and use it in iommufd uAPI. At that time the two
> > options were discussed exclusively and the cookie one is preferred.
> >=20
> > Now you instead recommended a mixed option. We can follow it for
> > sure if nobody objects.
>=20
> Either or for the return is fine, I'd return both just because it is
> more flexable
>=20
> But the cookie should never be an input from userspace, and the kernel
> should never search for it. Locating the kernel object is what the ID
> and xarray is for.

Why do we need two IDs at all?  Can't we just use the cookie as the
sole ID?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9KkT761rRKdNuQHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFUBTgACgkQbDjKyiDZ
s5K4CQ//ZP7Vd8mpipNUS/AWU7c4/szaCvt/v2he80AMrFlcUx0PojUtRabS9Rg2
2auIXhqeFqWUUyCVzQ60/f5L+v0VSosRphUA0yG0QZcVjvKeOFXScIBHadS1xELL
j6XaydocIV/EUeGlUkMC2bPeJpeEEu5oN4SBu28yw2cJdIDeI8mtLotdPtYEHtai
HSPjBt+38dmgUGGXlDpnBwrTs9sHb4BHgbMIM0ExcL8+GC0nzdWVxA0bV1C6Z4bD
vaDKQXGoj3Vjw69+tSAhLluI44nIHL7zcXeXols27ly2RP7XIeygkS6/6Jtx2zAv
dNBYSYWJ1KiGRF/5UrWmAOF9pWt4X+6seHSee60SKnb1sEl17i/MUZYMdE2cQSAe
R7L9aEagtEfTGaDLVL6O1MuP1uo+RFgUz83b+JawOe7K0d4G32rh6uqicsaVhh5E
k8hGjb7XdU+zqJmNj+eva5nuk/ocOsKoshp5nJ6dNwZB3og09ctk/6Yas6lO1t/1
vPi7Z6XsRUMsqvyc/D7Xzsira7wC6OkrR4aZGez5PjibC9WlLZyZ4XD1E/H2+rCY
u+W4Kvy2++kJZ5kBrU0li+DMQvuEy7uWwMYqmlsmqGLqRta2+Fdl7OpmBA7Lm0VK
sV/FGvMX1N5t7yNzChqAqDps4uSA6pHtKuIjJOcNuK3BAD6powQ=
=VX0E
-----END PGP SIGNATURE-----

--9KkT761rRKdNuQHa--

--===============0278322182416241085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0278322182416241085==--
