Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB85C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B798461881
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B798461881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F816607A9;
	Thu, 30 Sep 2021 04:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RObRjSqlZHll; Thu, 30 Sep 2021 04:19:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 472B1606D0;
	Thu, 30 Sep 2021 04:19:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1202FC000F;
	Thu, 30 Sep 2021 04:19:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE484C000F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D809606D0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JmWokzElABBm for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:19:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96A90606C6
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:31 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HKg4C5HmYz4xbQ; Thu, 30 Sep 2021 14:19:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632975563;
 bh=NRJoicPyChT5bSglpE5PZvju2v1MLLcprgAknSG0Odk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LApzlqydq0YPauTRjzyufGANEU34JgSwWC9+l6wirLQ69eTfehT2IDIz9jVLzHo2N
 ZWXYeOJU+hjWd2VRWYcn6J0aLOuRugSUOAx2P6CTy4+e8o6cJ/5iS93SF4VnUR31zK
 zHk5YgKuMN0jFZZ0wId4tq0kLP/ReNOcIgk0GaLI=
Date: Thu, 30 Sep 2021 13:05:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <YVUpdKNjxeQ9Oc1y@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <YVPxzad5TYHAc1H/@yekko>
 <BN9PR11MB5433E1BF538C7D3632F4C6188CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YVQJJ/ZlRoJbAt0+@yekko>
 <BN9PR11MB54335B4BA1134B14E1408D358CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54335B4BA1134B14E1408D358CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "lkml@metux.net" <lkml@metux.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "hch@lst.de" <hch@lst.de>,
 "parav@mellanox.com" <parav@mellanox.com>
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
Content-Type: multipart/mixed; boundary="===============4200982120865751147=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4200982120865751147==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YbdJW4Bwlc08+mUE"
Content-Disposition: inline


--YbdJW4Bwlc08+mUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 07:31:08AM +0000, Tian, Kevin wrote:
> > From: David Gibson
> > Sent: Wednesday, September 29, 2021 2:35 PM
> >=20
> > On Wed, Sep 29, 2021 at 05:38:56AM +0000, Tian, Kevin wrote:
> > > > From: David Gibson <david@gibson.dropbear.id.au>
> > > > Sent: Wednesday, September 29, 2021 12:56 PM
> > > >
> > > > >
> > > > > Unlike vfio, iommufd adopts a device-centric design with all group
> > > > > logistics hidden behind the fd. Binding a device to iommufd serves
> > > > > as the contract to get security context established (and vice ver=
sa
> > > > > for unbinding). One additional requirement in iommufd is to manage
> > the
> > > > > switch between multiple security contexts due to decoupled
> > bind/attach:
> > > > >
> > > > > 1)  Open a device in "/dev/vfio/devices" with user access blocked;
> > > >
> > > > Probably worth clarifying that (1) must happen for *all* devices in
> > > > the group before (2) happens for any device in the group.
> > >
> > > No. User access is naturally blocked for other devices as long as they
> > > are not opened yet.
> >=20
> > Uh... my point is that everything in the group has to be removed from
> > regular kernel drivers before we reach step (2).  Is the plan that you
> > must do that before you can even open them?  That's a reasonable
> > choice, but then I think you should show that step in this description
> > as well.
>=20
> Agree. I think below proposal can meet above requirement and ensure
> it's not broken in the whole process when the group is operated by the
> userspace:
>=20
> https://lore.kernel.org/kvm/20210928140712.GL964074@nvidia.com/
>=20
> and definitely an updated description will be provided when sending out
> the new proposal.
>=20
> >=20
> > > > > 2)  Bind the device to an iommufd with an initial security context
> > > > >     (an empty iommu domain which blocks dma) established for its
> > > > >     group, with user access unblocked;
> > > > >
> > > > > 3)  Attach the device to a user-specified ioasid (shared by all d=
evices
> > > > >     attached to this ioasid). Before attaching, the device should=
 be first
> > > > >     detached from the initial context;
> > > >
> > > > So, this step can implicitly but observably change the behaviour for
> > > > other devices in the group as well.  I don't love that kind of
> > > > difficult to predict side effect, which is why I'm *still* not tota=
lly
> > > > convinced by the device-centric model.
> > >
> > > which side-effect is predicted here? The user anyway needs to be
> > > aware of such group restriction regardless whether it uses group
> > > or nongroup interface.
> >=20
> > Yes, exactly.  And with a group interface it's obvious it has to
> > understand it.  With the non-group interface, you can get to this
> > stage in ignorance of groups.  It will even work as long as you are
> > lucky enough only to try with singleton-group devices.  Then you try
> > it with two devices in the one group and doing (3) on device A will
> > implicitly change the DMA environment of device B.
>=20
> for non-group we can also document it obviously in uAPI that the user
> must understand group restriction and violating it will get failure
> when attaching to different IOAS's for devices in the same group.

Documenting limitations is always inferior to building them into the
actual API signatures.  Sometimes its the only option, but people
frequently don't read the docs, whereas they kind of have to look at
the API itself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YbdJW4Bwlc08+mUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFVKXEACgkQbDjKyiDZ
s5LLXhAA4KWUYr6vDUxAFLkT4L1KLKZqWhjkk8LmbvVrhToLi60vFIhp1pTiwMVO
slRlmjGBn/Q33uuWmiFKrcPxz29jfamSP/9zSX4X2qeGKxRXQlxkY+jyNTIjymqI
R8JrzRq+fXG5bFtEZKj/KpBtme+GMfYiDdx/yR8UVbLyLkDXbPK82fltDIDFAnhd
3eon0AdwqF3UNCpBCoDkHa2oPyEvL6eho4olzXkOIIFU/eYcUv8KlLpbg3R3dMP7
hBh6KhIlo0SsWdAdhBYignw8aSeMy4fGWenmsnY4SLLYiaps+g5dYXOolHHRbkWz
Yo+KzfJX82FPXw8VUPoU3ueXMld0C+xYGrFPsv3aL1IHphhdCeMPg5qyVnqYxZa0
h7Z8En/rnzAJGqO2aVaYN+CZJcRX9rpKbL+tieorl2v05F4QI2xyFyFFOwg3Qbhc
Y+8J+aShOklfEI2z38FDgUA5v+FT1sh38ZKxK4DF8AXUEWApgTp1Adhc92Qg+yE4
M5UaX8b18Cic3e6hJ7Zc7xckwjQr2HMpC0YA6Uq8+Hpoc3E4asPg0l1WmxofaxF5
Ix0YsOiFVNhBFqCy9/hDqXZIbs7qThiV7QtQm5vJCXtqxDlb7EjwyQpBG3lbYc/e
1BWuzTON93WgeSg92dgod7n/5aQX6Xb/LLS/MYX3VymPI7xOvbc=
=/I/A
-----END PGP SIGNATURE-----

--YbdJW4Bwlc08+mUE--

--===============4200982120865751147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4200982120865751147==--
