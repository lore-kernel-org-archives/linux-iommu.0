Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A27C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:12:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1558A613C8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1558A613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D17D140425;
	Wed, 29 Sep 2021 07:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Ac4lAofIpO3; Wed, 29 Sep 2021 07:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E4B3402EF;
	Wed, 29 Sep 2021 07:12:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1141AC0011;
	Wed, 29 Sep 2021 07:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C022C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F11E40425
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L2dcX0XCibcy for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 07:12:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23EDE40323
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:12:34 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HK6yQ59Mkz4xbQ; Wed, 29 Sep 2021 17:12:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632899550;
 bh=L08JZ1sawezeS015D9zgg+63/giIa2dhEn00NU5Gl9Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kzcjZkVIb+59YwusaTa7TDofa176Y01SfMixfjEpvF52DXXtqMYoo/cnit3cVnrbz
 FJpEABiRoF+LPSQAebuks5Y7LnwA+nuDbC3P74eseDZ6sXQrWSonXxWlTdus9grc8d
 /fuzX/44k4p1mGzQ7m6ubwhzdVIm/+dkjaVtCTps=
Date: Wed, 29 Sep 2021 16:35:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <YVQJJ/ZlRoJbAt0+@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <YVPxzad5TYHAc1H/@yekko>
 <BN9PR11MB5433E1BF538C7D3632F4C6188CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433E1BF538C7D3632F4C6188CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
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
Content-Type: multipart/mixed; boundary="===============1779005028126098109=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1779005028126098109==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vlpAh7yLskJZWF4V"
Content-Disposition: inline


--vlpAh7yLskJZWF4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 05:38:56AM +0000, Tian, Kevin wrote:
> > From: David Gibson <david@gibson.dropbear.id.au>
> > Sent: Wednesday, September 29, 2021 12:56 PM
> >=20
> > >
> > > Unlike vfio, iommufd adopts a device-centric design with all group
> > > logistics hidden behind the fd. Binding a device to iommufd serves
> > > as the contract to get security context established (and vice versa
> > > for unbinding). One additional requirement in iommufd is to manage the
> > > switch between multiple security contexts due to decoupled bind/attac=
h:
> > >
> > > 1)  Open a device in "/dev/vfio/devices" with user access blocked;
> >=20
> > Probably worth clarifying that (1) must happen for *all* devices in
> > the group before (2) happens for any device in the group.
>=20
> No. User access is naturally blocked for other devices as long as they
> are not opened yet.

Uh... my point is that everything in the group has to be removed from
regular kernel drivers before we reach step (2).  Is the plan that you
must do that before you can even open them?  That's a reasonable
choice, but then I think you should show that step in this description
as well.

> > > 2)  Bind the device to an iommufd with an initial security context
> > >     (an empty iommu domain which blocks dma) established for its
> > >     group, with user access unblocked;
> > >
> > > 3)  Attach the device to a user-specified ioasid (shared by all devic=
es
> > >     attached to this ioasid). Before attaching, the device should be =
first
> > >     detached from the initial context;
> >=20
> > So, this step can implicitly but observably change the behaviour for
> > other devices in the group as well.  I don't love that kind of
> > difficult to predict side effect, which is why I'm *still* not totally
> > convinced by the device-centric model.
>=20
> which side-effect is predicted here? The user anyway needs to be
> aware of such group restriction regardless whether it uses group
> or nongroup interface.

Yes, exactly.  And with a group interface it's obvious it has to
understand it.  With the non-group interface, you can get to this
stage in ignorance of groups.  It will even work as long as you are
lucky enough only to try with singleton-group devices.  Then you try
it with two devices in the one group and doing (3) on device A will
implicitly change the DMA environment of device B.

(or at least, it will if they share a group because they don't have
distinguishable RIDs.  That's not the only multi-device group case,
but it's one of them).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vlpAh7yLskJZWF4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFUCSUACgkQbDjKyiDZ
s5Knfw//Rw2uKWKlVgUYBuPqXP7H/GPzP0d7Hg2xFwsv688tH/erKlqjFroLLZFv
2Kh4rygO7LibaX6bR5U8t+Dr6xms44sDRhSmcEYqIh2WiE0BlLIAjSQg8YhxIb4J
s6E3xJ0xgDTH/c2ebBZPckFg4jXFZsCtJ5YykxCMZOVZsO7Go236aE9JvIuscatR
TqYIEd2CDV5EELOnRItwWqF/FjfrrbhfavYENVQZU3qdbjQ90Ii1OpWe+wd9jWcd
pudHU2xLjlvchw391gxc2y8qkLEev6E5ZbfOSKa/f6N3aLb55PcN8rqi+zfne9Na
lzs30Gy5TRtEhT/VwsHXHnGz71ueqYPQcLMCBX7J/KgMIxnRtuQtLvYCxM9fzLFb
7DGIXfPpAqla94JMsp4Z6R27pH2QFJQmORJDjJBOkN2UbF3ZkTqFoYxYPbAXQfZH
UPVM7mdAsGtUEKEszBBqAUJG0wQhJweg63WEeczQh4gPR1J6g+ye2l5rXK9Mtl0s
O3DQdpqXkp+dnEjvi2Ybzv0uPvfUbc+pX00a/N0vPB/OO6UfQiYcXx1t5k/A8bO+
8TCgk8WUVMu1z48IG2k6QqQHuO5rMs8NH2NEIs4IownQuZcOtSUDs5p6IwbuNMEv
scg9c+qzutZvCv/flGStpYdrSHMs9iF9n46ce8v9eovGQ99Nubk=
=uIA1
-----END PGP SIGNATURE-----

--vlpAh7yLskJZWF4V--

--===============1779005028126098109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1779005028126098109==--
