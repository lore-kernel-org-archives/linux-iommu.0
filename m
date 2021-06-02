Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14DC47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E0E6138C
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E0E6138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D689160A9A;
	Wed,  2 Jun 2021 07:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5UPawj2vJoW4; Wed,  2 Jun 2021 07:29:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A11E8606AF;
	Wed,  2 Jun 2021 07:29:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B1EFC000D;
	Wed,  2 Jun 2021 07:29:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24160C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 204BC40249
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qOlHe2j1AOq0 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:29:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0BFB400BA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:18 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fw0yh3X6mz9sVb; Wed,  2 Jun 2021 17:29:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622618956;
 bh=fjBj8PRTLF5KDwaLcn9aAOU++MBjXNfeiCyAkMaW3Ag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z6CS9wi3Osfai3DhrzeU4984e1Da0ZUcR5rLzfNFxtCeqynzeaTIhFbh/7QEZGAS8
 t3kHkF+5OYj581MKnYDWSbt+aqlk7j1IOHj/33PliumMl3R0PZ86z+woiS98olm5W/
 mMZL0mIj0lBLdHgsWroftN+GVi0Pf6DrOd4A2iJE=
Date: Wed, 2 Jun 2021 16:57:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLcr8B7EPDCejlWZ@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601175643.GQ1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210601175643.GQ1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============5995879399166846936=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5995879399166846936==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fYHZ/urV5RbW7aYp"
Content-Disposition: inline


--fYHZ/urV5RbW7aYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 02:56:43PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 01, 2021 at 08:38:00AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, May 29, 2021 3:59 AM
> > >=20
> > > On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> > > >
> > > > 5. Use Cases and Flows
> > > >
> > > > Here assume VFIO will support a new model where every bound device
> > > > is explicitly listed under /dev/vfio thus a device fd can be acquir=
ed w/o
> > > > going through legacy container/group interface. For illustration pu=
rpose
> > > > those devices are just called dev[1...N]:
> > > >
> > > > 	device_fd[1...N] =3D open("/dev/vfio/devices/dev[1...N]", mode);
> > > >
> > > > As explained earlier, one IOASID fd is sufficient for all intended =
use cases:
> > > >
> > > > 	ioasid_fd =3D open("/dev/ioasid", mode);
> > > >
> > > > For simplicity below examples are all made for the virtualization s=
tory.
> > > > They are representative and could be easily adapted to a non-virtua=
lization
> > > > scenario.
> > >=20
> > > For others, I don't think this is *strictly* necessary, we can
> > > probably still get to the device_fd using the group_fd and fit in
> > > /dev/ioasid. It does make the rest of this more readable though.
> >=20
> > Jason, want to confirm here. Per earlier discussion we remain an
> > impression that you want VFIO to be a pure device driver thus
> > container/group are used only for legacy application.
>=20
> Let me call this a "nice wish".
>=20
> If you get to a point where you hard need this, then identify the hard
> requirement and let's do it, but I wouldn't bloat this already large
> project unnecessarily.
>=20
> Similarly I wouldn't depend on the group fd existing in this design
> so it could be changed later.

I don't think presence or absence of a group fd makes a lot of
difference to this design.  Having a group fd just means we attach
groups to the ioasid instead of individual devices, and we no longer
need the bookkeeping of "partial" devices.

> > From this comment are you suggesting that VFIO can still keep
> > container/ group concepts and user just deprecates the use of vfio
> > iommu uAPI (e.g. VFIO_SET_IOMMU) by using /dev/ioasid (which has a
> > simple policy that an IOASID will reject cmd if partially-attached
> > group exists)?
>=20
> I would say no on the container. /dev/ioasid =3D=3D the container, having
> two competing objects at once in a single process is just a mess.

Right.  I'd assume that for compatibility, creating a container would
create a single IOASID under the hood with a compatiblity layer
translating the container operations to iosaid operations.

> If the group fd can be kept requires charting a path through the
> ioctls where the container is not used and /dev/ioasid is sub'd in
> using the same device FD specific IOCTLs you show here.

Again, I don't think it makes much difference.  The model doesn't
really change even if you allow both ATTACH_GROUP and ATTACH_DEVICE on
the IOASID.  Basically ATTACH_GROUP would just be equivalent to
attaching all the constituent devices.

> I didn't try to chart this out carefully.
>=20
> Also, ultimately, something need to be done about compatability with
> the vfio container fd. It looks clear enough to me that the the VFIO
> container FD is just a single IOASID using a special ioctl interface
> so it would be quite rasonable to harmonize these somehow.
>=20
> But that is too complicated and far out for me at least to guess on at
> this point..
>=20
> > > Still a little unsure why the vPASID is here not on the gva_ioasid. Is
> > > there any scenario where we want different vpasid's for the same
> > > IOASID? I guess it is OK like this. Hum.
> >=20
> > Yes, it's completely sane that the guest links a I/O page table to=20
> > different vpasids on dev1 and dev2. The IOMMU doesn't mandate
> > that when multiple devices share an I/O page table they must use
> > the same PASID#.=20
>=20
> Ok..
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fYHZ/urV5RbW7aYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC3K/AACgkQbDjKyiDZ
s5L/aRAAl5MdgT6Qfp8L0FSuJM4hyAWp5EatxJgBSzaVAbqXESHHMUXl8AN/nsDW
KsgexDRZXSFelArNl5MN0dbxk1gjFZUQHea+cVb89ym9hEF+WKW+COb1wOBCl3A1
aHM3sXc3A9TCbfFLUysEJ+yHyDisNhvt7qwxw3qLnrqgHTZvTFIpQVCzD+XoB0mp
e6aQC9uN99cCf1+ZGCHaVHbx1Ym4NtJEPxetSWe/k5dVKi89lmtujlW1pWt58AL/
sN8pzcMMlaXIw5ImB23JB9ohNCm5F0lfyuXgxeK5/Cc88D/2d+E1Q7r68lj2aVIr
+bInhy44ZzB+fBK/dDzpD0WdoxXHsZXhAch2bWwK61ovSfoWBqzTAHOJZOFb+rRn
Yt69xgJNUVNe1ll4ksrlmQdUNB7CsZJIr+csmGRhByrW+84JMlBvTlZNDXzfB3z4
S2mtVZU7QwVX3zNzyfvLaZKl5vRlWvf7YiuUaN0c9WtnZgKOhLrLpiM0rI6LJNEn
V2gkaEOQJhpEVXLym4EX3vRgU08bF2gsvSSAL4gDqwrDtv/MUGCWLokbeiOZ0kte
Ewi4+bNTmi9JwGUhhMriTbkFOccil5OTDQwRCx6YR1++2Rtf0G+R90pzQXNudled
S89lwkKtFtdxQ+jhTbbAOvMfyrHi8Fp2FXQs5yubhwFYHIXVuHU=
=hCaa
-----END PGP SIGNATURE-----

--fYHZ/urV5RbW7aYp--

--===============5995879399166846936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5995879399166846936==--
