Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F67C47094
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 02:26:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA2E6124B
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 02:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA2E6124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A33D6087A;
	Tue,  8 Jun 2021 02:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKXjgNLwPugG; Tue,  8 Jun 2021 02:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7486F60888;
	Tue,  8 Jun 2021 02:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B67F8C0029;
	Tue,  8 Jun 2021 02:25:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16AEEC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05394402F4
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNUWJPxRy4Ni for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 02:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D581402F6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:52 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FzYxn01lXz9sWD; Tue,  8 Jun 2021 12:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623119149;
 bh=NE7+usqQ/norkxY9YOA2SirvU/XbC99t4zi6zDKs6fI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l5xQK55tG4fFOstusMEH5nVrLBK4ofIa7MChdPnoNlmO6puIFXbKBv4BQMnCh/qeL
 1AA2jQ0i8sBitMvTHtP5x7lrBh/CWfRRAI6K2JRx5QtBKyXpTNSvgzMSmXnPl0s84G
 EcXVcynJIkkcSXJXWbhlUwqaAJgDgZfBcSVU//N8=
Date: Tue, 8 Jun 2021 11:15:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YL7Elf3KwRarNfLx@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <bb6846bf-bd3c-3802-e0d7-226ec9b33384@metux.net>
 <20210602172424.GD1002214@nvidia.com>
 <bd0f485c-5f70-b087-2a5a-d2fe6e16817d@metux.net>
 <20210604123054.GL1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210604123054.GL1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>, "Jiang,
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
Content-Type: multipart/mixed; boundary="===============0621494565199870876=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0621494565199870876==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4guhZ6fptkEnI3K"
Content-Disposition: inline


--T4guhZ6fptkEnI3K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2021 at 09:30:54AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 04, 2021 at 12:44:28PM +0200, Enrico Weigelt, metux IT consul=
t wrote:
> > On 02.06.21 19:24, Jason Gunthorpe wrote:
> >=20
> > Hi,
> >=20
> > >> If I understand this correctly, /dev/ioasid is a kind of "common
> > supplier"
> > >> to other APIs / devices. Why can't the fd be acquired by the
> > >> consumer APIs (eg. kvm, vfio, etc) ?
> > >
> > > /dev/ioasid would be similar to /dev/vfio, and everything already
> > > deals with exposing /dev/vfio and /dev/vfio/N together
> > >
> > > I don't see it as a problem, just more work.
> >=20
> > One of the problems I'm seeing is in container environments: when
> > passing in an vfio device, we now also need to pass in /dev/ioasid,
> > thus increasing the complexity in container setup (or orchestration).
>=20
> Containers already needed to do this today. Container orchestration is
> hard.

Right to use VFIO a container already needs both /dev/vfio and one or
more /dev/vfio/NNN group devices.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4guhZ6fptkEnI3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC+xJMACgkQbDjKyiDZ
s5JQuhAAxlzUDoVWUS7ZAU8E4fL0Z6TVV8A1LN3veamxiqHFJ6IIVtiV5g7Dy0II
T6GxA3x+7HaPcpMHbqv85GE3DBs7dm4P56B9rTtJU3OkDekISxcG2/IJtIiL0JtJ
BPWgnN6obAOeGlzl1uIxB9GQucvS1pp71jfxhW9BTFidOSg9UFWSu2IN6Hn0ODr0
siVRSG3V861K4yf3KH7GSR3mnrna6VUUclP2Bx8REmagVcPdMUqBNXU+4zg339+C
dwzoc+10bpSYPjgOI77bBCi1fyf5rPixRx3DVEfrWbqgR7AmPT5mrKcd7sL8/ta3
VmypRFa/+50D9qxBKYEFvqYWJHctQ56ZT1GMxIqd+aIY2Y4G1AeJs2lP0tHcfbV8
gQ2m+rpEFaRcN1C5aMVKQ2rs8xBUcbEPDQqpoCz3r8UwcuBC3SRNPEV2irfzJgbX
DaalbaoFGrb7O4Xl5yQ6suRBzr4w6sG9FCBJdzxj8sQgDhnIG2Vj1e+Ve7oqgf1S
WLZVU2GXIdBC3xn6ek5+37aHhsGenq08WQyX15J1q++TzKxba0fphS3qiKJHYGvI
8sTLwzIIRaFdhzXJ99gQyZMzRIwhjqFitlp36Ndc7CAoYtIDpt5iM5NY0RczQn2C
KwVAG28Qz7FdDd2BOeWPFm9CAQJkaJTaVNcNOJhscFENzTVoE2k=
=HWR1
-----END PGP SIGNATURE-----

--T4guhZ6fptkEnI3K--

--===============0621494565199870876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0621494565199870876==--
