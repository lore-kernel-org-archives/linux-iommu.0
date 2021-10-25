Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B7C433FE
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 23:30:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F60760F70
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 23:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F60760F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F027C80F36;
	Mon, 25 Oct 2021 23:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9_gfbZ-mPWG1; Mon, 25 Oct 2021 23:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2D6380F33;
	Mon, 25 Oct 2021 23:30:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD2BAC0012;
	Mon, 25 Oct 2021 23:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1DA2C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 23:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A097340355
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 23:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDAZwCK90Cd8 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 23:30:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C6EE4031B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 23:30:32 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HdWQl4cYRz4xbP; Tue, 26 Oct 2021 10:30:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1635204623;
 bh=D9s8UCsN8uxpZTpLGN0k3xtAwElruVlh1u99paNigtw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dfwE8Xoh5HvMa28V7E3VIIFgW6XK3TRLC4Ppwq51Hj6iQ9qTqJLjRIY5A5rM9Oqfc
 LHgzhmUCt3Q51SUj9eAGPqg36rPwXwefsXL8PyWgfkn4/uaUlseXVg7t3xEtqYO++1
 x/gOAbBdf7mZOlxMlHPGs8ZkAPbaRmWQeMLFaJxY=
Date: Tue, 26 Oct 2021 00:16:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 13/20] iommu: Extend iommu_at[de]tach_device() for multiple
 devices group
Message-ID: <YXauO+YSR7ivz1QW@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-14-yi.l.liu@intel.com>
 <YWe+88sfCbxgMYPN@yekko>
 <BN9PR11MB54337A8E65C789D038D875C68CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YWzwmAQDB9Qwu2uQ@yekko> <20211018163238.GO2744544@nvidia.com>
 <YXY9UIKDlQpNDGax@yekko> <20211025121410.GQ2744544@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211025121410.GQ2744544@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============8524833108400711326=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8524833108400711326==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O2NMk5xF7UYH/YH7"
Content-Disposition: inline


--O2NMk5xF7UYH/YH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 09:14:10AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 25, 2021 at 04:14:56PM +1100, David Gibson wrote:
> > On Mon, Oct 18, 2021 at 01:32:38PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Oct 18, 2021 at 02:57:12PM +1100, David Gibson wrote:
> > >=20
> > > > The first user might read this.  Subsequent users are likely to just
> > > > copy paste examples from earlier things without fully understanding
> > > > them.  In general documenting restrictions somewhere is never as
> > > > effective as making those restrictions part of the interface signat=
ure
> > > > itself.
> > >=20
> > > I'd think this argument would hold more water if you could point to
> > > someplace in existing userspace that cares about the VFIO grouping.
> >=20
> > My whole point here is that the proposed semantics mean that we have
> > weird side effects even if the app doesn't think it cares about
> > groups.
> >=20
> > e.g. App's input is a bunch of PCI addresses for NICs.  It attaches
> > each one to a separate IOAS and bridges packets between them all.  As
> > far as the app is concerned, it doesn't care about groups, as you say.
> >=20
> > Except that it breaks if any two of the devices are in the same group.
> > Worse, it has a completely horrible failure mode: no syscall returns
>=20
> Huh? If an app requests an IOAS attach that is not possible then the
> attachment IOCTL will fail.
>=20
> The kernel must track groups and know that group A is on IOAS A and
> any further attach of a group A device must specify IOAS A or receive
> a failure.

Ok, I misunderstood the semantics that were suggested.

So, IIUC what you're suggested is that if group X is attached to IOAS
1, then attaching the group to IOAS 1 again should succeed (as a
no-op), but attaching to any other IOAS should fail?

That's certainly an improvement, but there's still some questions.

If you attach devices A and B (both in group X) to IOAS 1, then detach
device A, what happens?  Do you detach both devices?  Or do you have a
counter so you have to detach as many time as you attached?

> The kernel should never blindly acknowledge a failed attachment.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O2NMk5xF7UYH/YH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmF2rjkACgkQbDjKyiDZ
s5JwahAA391JynQuavWmhBOhDzb14OvOhpDcitGZ2dFWubVWtz4qL5lRWS/02Q0N
9dpFnqINn3fxXAVKM//9YP5KRFeAS5v5C7ScUL0GDjKLMvQ5cl/YR/t8J2i+q1q5
osWlUmUofwjTKMzxrV+fRaY8W8Ro2vdp9NV3xJsE4ipZVIxU4X2XgIJ8Zp37ED+R
WPftlJukAKQIJmdiqaEyNah+eG0Jl4MmqOsGLRXrD4KFiblKwXX2AlQgxb0hzo6P
eScpIA26XA/v3ch/Llh7mo4obgb0PAsqeGhKUQpfFb7p+APamwdtjGqe8vE1UW+E
jVkaZwKTJ6Y6Dc88FBseS0sFvJDCqzGri023feLbP16V8pwhyweegqx75b0rcL1/
piUbQnSt8ZRidBRKq87NusMkBpV221+uqLvranfuoeqgbt9U0vYIB8J5jW+fyrCp
qu5Ch+wAmJZHr1/WmCAPmHV8pmGKoGUVYwc5vStAKkBTru0qAh5ImN7kTlpd8OpS
ktThhH1jVYpejts5quqAtDi/swpjCIBb209clpsidn8nVPBvI0I3diVWnN7qsXI4
vnmi3K+Y8bjANYPaLBtUVX4motWGBXLbOfbPkAua5bmHIYjZMSSm9E81R+SHzsPY
FOecGoVdowCrUloQPRA0YHxXocyX3ZSYvBWX0a8pZMpfMOuec30=
=dI80
-----END PGP SIGNATURE-----

--O2NMk5xF7UYH/YH7--

--===============8524833108400711326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8524833108400711326==--
