Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CBC48BDF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842E1613D5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842E1613D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56814608F2;
	Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9r3BshCMasx6; Thu, 24 Jun 2021 04:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3489D60882;
	Thu, 24 Jun 2021 04:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFA6AC0023;
	Thu, 24 Jun 2021 04:52:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30AABC0022
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F4FA607B3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihi_c3_Jf3YJ for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E5536079D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:27 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G9SRT2HPNz9sjD; Thu, 24 Jun 2021 14:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1624510341;
 bh=BdMsr801TLRg6n1agXO9W99Z9X2Ycr8wu5/qVxtFlo0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l/K+SERQX3av85LdONGF5HU3qIWVLog4ZRIrV/rgiI+Ikw4O+mOlGq7sl6zA7Z8m6
 lUgnfpUAdkOH1esnooHfRbWjWNRpnByhKJ4IVoLyKm1h4mmwDN04FGwKWES3DQEt2V
 ffqwCEjaXTnzhHSqjrMWrSoXkKSpxj1Ss22nCr5A=
Date: Thu, 24 Jun 2021 13:53:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YNQBzCbWAJj4HZaQ@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <YL7X0FKj+r6lIHQZ@yekko> <20210608131756.GF1002214@nvidia.com>
 <YMrF2BV0goTIPbrN@yekko>
 <MWHPR11MB188626BD4B67FB00EFD008ED8C089@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB188626BD4B67FB00EFD008ED8C089@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
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
Content-Type: multipart/mixed; boundary="===============7579102776445574264=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7579102776445574264==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gCWd0fTYw+m8JsSq"
Content-Disposition: inline


--gCWd0fTYw+m8JsSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2021 at 07:59:21AM +0000, Tian, Kevin wrote:
> > From: David Gibson <david@gibson.dropbear.id.au>
> > Sent: Thursday, June 17, 2021 11:48 AM
> >=20
> > On Tue, Jun 08, 2021 at 10:17:56AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 08, 2021 at 12:37:04PM +1000, David Gibson wrote:
> > >
> > > > > The PPC/SPAPR support allows KVM to associate a vfio group to an
> > IOMMU
> > > > > page table so that it can handle iotlb programming from pre-regis=
tered
> > > > > memory without trapping out to userspace.
> > > >
> > > > To clarify that's a guest side logical vIOMMU page table which is
> > > > partially managed by KVM.  This is an optimization - things can work
> > > > without it, but it means guest iomap/unmap becomes a hot path becau=
se
> > > > each map/unmap hypercall has to go
> > > > 	guest -> KVM -> qemu -> VFIO
> > > >
> > > > So there are multiple context transitions.
> > >
> > > Isn't this overhead true of many of the vIOMMUs?
> >=20
> > Yes, but historically it bit much harder on POWER for a couple of reaso=
ns:
> >=20
> > 1) POWER guests *always* have a vIOMMU - the platform has no concept
> >    of passthrough mode.  We therefore had a vIOMMU implementation some
> >    time before the AMD or Intel IOMMUs were implemented as vIOMMUs in
> >    qemu.
> >=20
> > 2) At the time we were implementing this the supported IOVA window for
> >    the paravirtualized IOMMU was pretty small (1G, I think) making
> >    vIOMMU maps and unmaps a pretty common operation.
> >=20
> > > Can the fast path be
> > > generalized?
> >=20
> > Not really.  This is a paravirtualized guest IOMMU, so it's a platform
> > specific group of hypercalls that's being interpreted by KVM and
> > passed through to the IOMMU side using essentially the same backend
> > that that the userspace implementation would eventually get to after a
> > bunch more context switches.
> >=20
>=20
> Can virtio-iommu work on PPC? iirc Jean has a plan to implement
> a vhost-iommu which is supposed to implement the similar in-kernel
> acceleration...

I don't know - I'd have to research virtio-iommu a bunch to determine
that.

Even if we can, the platform IOMMU would still be there (it's a
platform requirement), so we couldn't completely ignore it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gCWd0fTYw+m8JsSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDUAcwACgkQbDjKyiDZ
s5KfnRAAwW5fhc16eIczBASYEIkpgZQeK/OLxT7fNHcgkkw9kt7Qa0fLXfsomQgF
Nf3E2pDkzkwaTnvH/ubj7nghSy5cgda5ng8G87HMccVlcFE+8x2Z/9CSqw8tsoCG
MYDc0d2qQ8+Bz3+JvCluzGXcgrMTB1NoJpEX6rl6rk8s1sQuF/vF5z2eSg8Hqui9
NoxtlbfybModgNUSBD2ebUfFFbxGlUOBHpPqPG0zL/nrjPIMZKzWRnJD6qsCe1aT
VBahBFktcwxsdQL8TeN0lWCw2pJ92vho4ryFvGb6+o8VvqpBGGNknPee6zGtBaQ9
Fy4mx7afACusbxJDIMCjS4OifB21P9lh7kGGQFVU5kOr5f+qfXiqZEL+YW+9F2Y2
wy/naoJBiNT7KlDzLgHbjZOH/Z/6pDyUWeHzPU6p/ho398jtQYSWPTTcS36uLxMP
ABdS356rO8U7FTjGE+sQbyzRrnaS+JGVF8PyDV2sNHetyvNwyfeybfYnH9aWlg+x
SrqIRKj6FLrUDxSrldunAOU89dAseeF8geueErh3z0x6sm8xnnB9osDPpgz09ewb
zlbKh8NP33pO+C5592S+kPxf1HCnjKIXdCy9BMndt7zzw3lBKuEr/c+INwsixNfR
/GJRZJvOAh4G8Kms2NQbE8ArNbdSzSFmHoSVqWdWbJck15dGiMg=
=+vXD
-----END PGP SIGNATURE-----

--gCWd0fTYw+m8JsSq--

--===============7579102776445574264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7579102776445574264==--
