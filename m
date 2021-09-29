Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA287C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 03:34:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E0A613D3
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 03:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05E0A613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B55F06069E;
	Wed, 29 Sep 2021 03:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLcJE8YSJ_MT; Wed, 29 Sep 2021 03:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 674CE6065F;
	Wed, 29 Sep 2021 03:33:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4993DC000F;
	Wed, 29 Sep 2021 03:33:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD4C1C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC0AB80EE4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ml1wVXEpozxo for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 03:33:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4EF480EE1
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:33:55 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK1zN6cnQz4xbT; Wed, 29 Sep 2021 13:28:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632886080;
 bh=qzQIQZ4QRhIcmilmBeomTPiSlLs3WETVdIoKH8ljR5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p5e2lRrXkAIwbSxkG3qdFSqNl4eS0ICYpOq4Hcu5VnMPhSadYB0m7dyvRiC++N3Lg
 8arvLC3O7qOMZjze+SPIHfiKcZWeSnfEeejTsR98qNOzIYVzQKTVZTraACX8JjPnVJ
 bBLKwH+HMNsXDmQWOS8SMuMsqAS3TnSMGTxZrasU=
Date: Wed, 29 Sep 2021 12:46:14 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <YVPTdqWw6or3mK/h@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922010014.GE327412@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210922010014.GE327412@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============8144096849576316055=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8144096849576316055==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M1+gRInfuzVDe7lG"
Content-Disposition: inline


--M1+gRInfuzVDe7lG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2021 at 10:00:14PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 12:54:02AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, September 22, 2021 12:01 AM
> > >=20
> > > >  One open about how to organize the device nodes under
> > > /dev/vfio/devices/.
> > > > This RFC adopts a simple policy by keeping a flat layout with mixed
> > > devname
> > > > from all kinds of devices. The prerequisite of this model is that d=
evnames
> > > > from different bus types are unique formats:
> > >=20
> > > This isn't reliable, the devname should just be vfio0, vfio1, etc
> > >=20
> > > The userspace can learn the correct major/minor by inspecting the
> > > sysfs.
> > >=20
> > > This whole concept should disappear into the prior patch that adds the
> > > struct device in the first place, and I think most of the code here
> > > can be deleted once the struct device is used properly.
> > >=20
> >=20
> > Can you help elaborate above flow? This is one area where we need
> > more guidance.
> >=20
> > When Qemu accepts an option "-device vfio-pci,host=3DDDDD:BB:DD.F",
> > how does Qemu identify which vifo0/1/... is associated with the specifi=
ed=20
> > DDDD:BB:DD.F?=20
>=20
> When done properly in the kernel the file:
>=20
> /sys/bus/pci/devices/DDDD:BB:DD.F/vfio/vfioX/dev
>=20
> Will contain the major:minor of the VFIO device.
>=20
> Userspace then opens the /dev/vfio/devices/vfioX and checks with fstat
> that the major:minor matches.
>=20
> in the above pattern "pci" and "DDDD:BB:DD.FF" are the arguments passed
> to qemu.

I thought part of the appeal of the device centric model was less
grovelling around in sysfs for information.  Using type/address
directly in /dev seems simpler than having to dig around matching
things here.

Note that this doesn't have to be done in kernel: you could have the
kernel just call them /dev/vfio/devices/vfio0, ... but add udev rules
that create symlinks from say /dev/vfio/pci/DDDD:BB:SS.F - >
=2E./devices/vfioXX based on the sysfs information.

>=20
> You can look at this for some general over engineered code to handle
> opening from a sysfs handle like above:
>=20
> https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M1+gRInfuzVDe7lG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFT03YACgkQbDjKyiDZ
s5L5+RAA2E2lYOOD4bTHuC/PsiWELLG1eQQa3Jb4G+sT+fOVdbBmt8zME8lEAiXb
iKIx7FlKDY1YCkr3fHedUDTXNRKphIvtkJYkHS43zI2KaRkqn20pxvps6kjA0MvV
IMdk+8ZiUyA806bldQ6iEYhk7K888zeHPhSBhdZ6tSiWi5Yg6llD0A+WTGVmI9vx
pm6Cu3r80UouuTm2JY37yyYamFsGAGs0iVNiFxA/zhtGjJ5soKUOcqZSx4P8MfHD
2GOsiRGlwRx2peP+yrqAw9CutaR4jphP2ehVoqjyKq4wzMZ7PQCkuoUiFo3fNFjs
J8lUiY9PxisD+0rStds1WF1oPHocq2B/ALXzDlHPxFTitdH/OiDKZ0p86jHZcNVN
QdqipuJH4bXo4iyqWg0ksf3ECdekPJo0xfN4aMmDLHst4mhjSslQz/0WPZlQJKCe
cOiG2I6akTADkQR65q1bKyr2gZR0fZTZp0AwBGQ6Nj1I2iHKHOI05+/pQC9NCVkn
pkWc6WL12WGybyo/GyDblf5h1bfZTDJFLxS16uymh/MT+LPjGtik1I4KQezl1IA5
rAy5LpQ11dBOizN6dCO7XhmGLeRGXLXGxhe676t9fix+bibSYU0pvZUnffYHOxZw
pOv6wsRFvaM4ZhTBIB8PcbgNZHreiWAoFGdvfjHVRVR1Xl9Kx2A=
=JS/Z
-----END PGP SIGNATURE-----

--M1+gRInfuzVDe7lG--

--===============8144096849576316055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8144096849576316055==--
