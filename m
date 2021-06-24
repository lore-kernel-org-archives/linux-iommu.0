Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB2BC48BDF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C64F613D9
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C64F613D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F12DC406B0;
	Thu, 24 Jun 2021 04:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJTPS96Tr5Pe; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16DF840659;
	Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD13CC001A;
	Thu, 24 Jun 2021 04:52:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769AEC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66999607B3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upl2dCNF0LmG for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:52:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A5526079D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:25 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G9SRT1z33z9sf9; Thu, 24 Jun 2021 14:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1624510341;
 bh=gtNqfON2b+uPZ4FFUk66B4cN5cUYbQo0UQOhSPJibRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jACRQu74hhjVKLkBHbKaYa++no5/SpyDDCAmXLWGBqnA2Fk6QNQppmT/jPuootYM6
 nz5PGPPdqUHpyANKEcuRG0xRLh0p5eDHB2pw4NGtnyyxnslef26zVe84l9SgVHRh2s
 jXTKqSjziY1gxL9oUH4FD6j5EeZKTIYHg7jP5La4=
Date: Thu, 24 Jun 2021 13:55:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YNQCJfU/G5uwDCSE@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLch6zbbYqV4PyVf@yekko>
 <MWHPR11MB188668D220E1BF7360F2A6BE8C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMrKksUeNW/PEGPM@yekko>
 <MWHPR11MB188672DF8E0AC2C0D56EF86D8C089@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB188672DF8E0AC2C0D56EF86D8C089@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============1881697991112076121=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1881697991112076121==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p3xeV50Hfib5E9x2"
Content-Disposition: inline


--p3xeV50Hfib5E9x2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2021 at 08:00:49AM +0000, Tian, Kevin wrote:
> > From: David Gibson
> > Sent: Thursday, June 17, 2021 12:08 PM
> >=20
> > On Thu, Jun 03, 2021 at 08:12:27AM +0000, Tian, Kevin wrote:
> > > > From: David Gibson <david@gibson.dropbear.id.au>
> > > > Sent: Wednesday, June 2, 2021 2:15 PM
> > > >
> > > [...]
> > >
> > > > >
> > > > > /*
> > > > >   * Get information about an I/O address space
> > > > >   *
> > > > >   * Supported capabilities:
> > > > >   *	- VFIO type1 map/unmap;
> > > > >   *	- pgtable/pasid_table binding
> > > > >   *	- hardware nesting vs. software nesting;
> > > > >   *	- ...
> > > > >   *
> > > > >   * Related attributes:
> > > > >   * 	- supported page sizes, reserved IOVA ranges (DMA
> > mapping);
> > > >
> > > > Can I request we represent this in terms of permitted IOVA ranges,
> > > > rather than reserved IOVA ranges.  This works better with the "wind=
ow"
> > > > model I have in mind for unifying the restrictions of the POWER IOM=
MU
> > > > with Type1 like mapping.
> > >
> > > Can you elaborate how permitted range work better here?
> >=20
> > Pretty much just that MAP operations would fail if they don't entirely
> > lie within a permitted range.  So, for example if your IOMMU only
> > implements say, 45 bits of IOVA, then you'd have 0..0x1fffffffffff as
> > your only permitted range.  If, like the POWER paravirtual IOMMU (in
> > defaut configuration) you have a small (1G) 32-bit range and a large
> > (45-bit) 64-bit range at a high address, you'd have say:
> > 	0x00000000..0x3fffffff (32-bit range)
> > and
> > 	0x800000000000000 .. 0x8001fffffffffff (64-bit range)
> > as your permitted ranges.
> >=20
> > If your IOMMU supports truly full 64-bit addressing, but has a
> > reserved range (for MSIs or whatever) at 0xaaaa000..0xbbbb0000 then
> > you'd have permitted ranges of 0..0xaaa9ffff and
> > 0xbbbb0000..0xffffffffffffffff.
>=20
> I see. Has incorporated this comment in v2.
>=20
> >=20
> > [snip]
> > > > For debugging and certain hypervisor edge cases it might be useful =
to
> > > > have a call to allow userspace to lookup and specific IOVA in a gue=
st
> > > > managed pgtable.
> > >
> > > Since all the mapping metadata is from userspace, why would one
> > > rely on the kernel to provide such service? Or are you simply asking
> > > for some debugfs node to dump the I/O page table for a given
> > > IOASID?
> >=20
> > I'm thinking of this as a debugging aid so you can make sure that how
> > the kernel is interpreting that metadata in the same way that your
> > userspace expects it to interpret that metadata.
> >=20
>=20
> I'll not include it in this RFC. There are already too many stuff. The
> debugging aid can be added anyway when it's actually required.

Fair enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p3xeV50Hfib5E9x2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDUAiUACgkQbDjKyiDZ
s5JCJA//d6pXwX9h3dUB9R3TtYglCzE5E3WU1J/RJ2hPYPSn1FwmUqC/d+pCcBzz
0S/8iAD90q2/Ng8z2o/6bb6Tqd85xB892OT32V3QBh+NI4AGPP3qP5oD5lLdGQnI
uCv7s6VkPK5kPZ0rM1C2WTHI07dFMZWLcS0BqBaxXBXF2IkSbqU/2lhNTqyZzOih
TpQNsnXyjyU/IpgugqYfsKgUtWG6g/sKqv1mNOcybEeLbCJx0iFfxJRZz/snJzZo
5VKSP8DOU0Rb53jJo0mAprcCVOd0xUViuoMd1S3SoRjeyY1NFx6A5IxjgyZRWWiS
LWMqsyr9mLSoQ8jLd7DZ+tSjbreP1uQxuvuEpTdOUvoqNdTTYRJW3bwlT8KgduMP
0xGD1FMwbsdg5MkeelGWaiM+pJdEmX/qf5RuWMKm/lUMP6tceG9TJhwLbmv54uDt
nwVtVS/p05hbYdpF3iLfoyGf3Sn8m+qN/x12tX6dAgBpb6xNqRwt7OahBZJ0BFXF
akWb3aclIeeo77zyMxcAz5KcA5XCHlhwagPdEFe40G4mGBQ7kUSx5BduEruB87kC
eGzHy/XzL+9LVF10FQ27FR4wXQifjafgJ0ois5wZOzY2GiauK9Efkop1jZQV6KiU
m0uZtPlFOjfSXLMp6Z9dmaYa74oyLJvF+9ArZwxTpBa4DgHcT5E=
=R3gb
-----END PGP SIGNATURE-----

--p3xeV50Hfib5E9x2--

--===============1881697991112076121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1881697991112076121==--
