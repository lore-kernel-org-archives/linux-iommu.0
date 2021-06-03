Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315FC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0E06140D
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0E06140D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28AAA404F6;
	Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oScQE7cOLinJ; Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9F6B404EC;
	Thu,  3 Jun 2021 06:28:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF6FC000E;
	Thu,  3 Jun 2021 06:28:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C0E0C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F859404EE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ieK0t0Yb4rWW for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:28:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 156BD404EC
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:24 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FwbYy6DNyz9sWF; Thu,  3 Jun 2021 16:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622701702;
 bh=aDuwQw7JrOoWOZBdQAxjHc0hPzIrNB9PMwrjph0YmcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dKNw6CKpKiVdxCeJpQ2DPorhkr+EONZiqYqYZqC8QIAFzxeywisBFGPqJ/edk+09f
 cWjm2rFfdwfk2GX0nalZfUYRHjrrrPJ8ZjLmiotFQdHSc6E6Xd4Q5cvTT046PLbFuI
 V474o5BtKuIKa7tr6mqAot0YgGYf0J+3y3B+P3bg=
Date: Thu, 3 Jun 2021 15:48:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLhtJ5tg5TD/9ewj@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com>
 <MWHPR11MB1886A746307BD6E16FCBC3418C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886A746307BD6E16FCBC3418C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============5207978287648771905=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5207978287648771905==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3SygcrTGvz8uv5oi"
Content-Disposition: inline


--3SygcrTGvz8uv5oi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 02:49:56AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, June 3, 2021 12:59 AM
> >=20
> > On Wed, Jun 02, 2021 at 04:48:35PM +1000, David Gibson wrote:
> > > > > 	/* Bind guest I/O page table  */
> > > > > 	bind_data =3D {
> > > > > 		.ioasid	=3D gva_ioasid;
> > > > > 		.addr	=3D gva_pgtable1;
> > > > > 		// and format information
> > > > > 	};
> > > > > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> > > >
> > > > Again I do wonder if this should just be part of alloc_ioasid. Is
> > > > there any reason to split these things? The only advantage to the
> > > > split is the device is known, but the device shouldn't impact
> > > > anything..
> > >
> > > I'm pretty sure the device(s) could matter, although they probably
> > > won't usually.
> >=20
> > It is a bit subtle, but the /dev/iommu fd itself is connected to the
> > devices first. This prevents wildly incompatible devices from being
> > joined together, and allows some "get info" to report the capability
> > union of all devices if we want to do that.
>=20
> I would expect the capability reported per-device via /dev/iommu.=20
> Incompatible devices can bind to the same fd but cannot attach to
> the same IOASID. This allows incompatible devices to share locked
> page accounting.

Yeah... I'm not convinced that everything relevant here can be
reported per-device.  I think we may have edge cases where
combinations of devices have restrictions that individual devices in
the set do not.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3SygcrTGvz8uv5oi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC4bScACgkQbDjKyiDZ
s5LHWA//XLNAmCjZXhhflQU9dr/nQ8aAcicFwWhaZzX2v+8YuOCWt1u2b9O2Qtnd
fYOr3khb983eHexf5jwEIVgf7OzbcbsywHB2m6Y+o8940ybteoDeK9GXINp1B0Tx
q7GB4VtU3LhIumTZaiml1glDQPmZOtvntLTCQhAY9ynT8+GctbJTVf47dxi3aRff
xpTSrkyO3pwlXSQMpjiSP7uuYI4OZ28A9v5C/fvvKjYAiWV5oKoJvMbY91E9uKwF
vRV9vUOnq9XU+p9laziHzHVowiaq4wWmSP+DAqehdp4h/B78oT9xKxvd8/+tIopp
NOOjhmqwlYOHB7HZgP3nK2A1gzNlFMzo7nCUBTYpdSB+aZMCfmLKhihoY45wKswk
bV7mFju9KjvhIe7nby8KFI4UossQANvvQxtMShXl11h/2Vh8gXCeG7gm6/F0QuGc
SPa4PPjWH+lb72aFu7wH8AxzVEezof2gsKyyYhKgxgFaXtI8V4DYhHBk84W3Xy+S
op8M3AOGzk+tPGz5FUeIwqkvZYQaQVP5AbhroUilAaI7OaQ/qmxPupi02b4AV3oR
yhOOINsW1r+EvGRZzsD5utY1XLTQTeEuXdi2ydhojMsCXrZa2r8Ed2HWDS0Wh+yV
Xf7prWcJhkicS2LUH/l1Ras21cl2lCYOkZab+GAQJX/xhitcRm4=
=fgPw
-----END PGP SIGNATURE-----

--3SygcrTGvz8uv5oi--

--===============5207978287648771905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5207978287648771905==--
