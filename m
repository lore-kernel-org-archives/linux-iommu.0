Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D72C4709E
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361A6613E4
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361A6613E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D94D404EE;
	Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9zrDQoXWzSf; Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2666404F9;
	Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4BBC002A;
	Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9599AC000E
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84A8F60AF6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xz3qj2Fj9m8L for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:28:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4927C60695
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:24 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FwbYy44Thz9sPf; Thu,  3 Jun 2021 16:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622701702;
 bh=Im+2Djp5gR2RMkXG5p9+sCOYMYJjvti9fvFxoFpJey4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WsScy8BnPuo53/ZXsNvoxThhhw/Iuink1z7WK6oUHqDJOErRG99uMrpTGNIAqzQM6
 vDzcFu4WUEIuDrmZV3ut76tHt0PiO/rTe3n7/Xbn5ZAtfxponhExCojwGNOkkUG0OJ
 H5VFolYx9qnXsdaOc9Rbf3twprUIREb+M874Btfk=
Date: Thu, 3 Jun 2021 15:09:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLhj9mi9J/f+rqkP@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
 <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601174229.GP1002214@nvidia.com>
 <MWHPR11MB1886283575628D7A2F4BFFAB8C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160914.GX1002214@nvidia.com>
 <MWHPR11MB18861FA1636BFB66E5E563508C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB18861FA1636BFB66E5E563508C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============5336382336207183768=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5336382336207183768==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ccSPSdMlO8T7edI6"
Content-Disposition: inline


--ccSPSdMlO8T7edI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 01:29:58AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe
> > Sent: Thursday, June 3, 2021 12:09 AM
> >=20
> > On Wed, Jun 02, 2021 at 01:33:22AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, June 2, 2021 1:42 AM
> > > >
> > > > On Tue, Jun 01, 2021 at 08:10:14AM +0000, Tian, Kevin wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Saturday, May 29, 2021 1:36 AM
> > > > > >
> > > > > > On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> > > > > >
> > > > > > > IOASID nesting can be implemented in two ways: hardware nesti=
ng
> > and
> > > > > > > software nesting. With hardware support the child and parent =
I/O
> > page
> > > > > > > tables are walked consecutively by the IOMMU to form a nested
> > > > translation.
> > > > > > > When it's implemented in software, the ioasid driver is respo=
nsible
> > for
> > > > > > > merging the two-level mappings into a single-level shadow I/O=
 page
> > > > table.
> > > > > > > Software nesting requires both child/parent page tables opera=
ted
> > > > through
> > > > > > > the dma mapping protocol, so any change in either level can be
> > > > captured
> > > > > > > by the kernel to update the corresponding shadow mapping.
> > > > > >
> > > > > > Why? A SW emulation could do this synchronization during
> > invalidation
> > > > > > processing if invalidation contained an IOVA range.
> > > > >
> > > > > In this proposal we differentiate between host-managed and user-
> > > > > managed I/O page tables. If host-managed, the user is expected to=
 use
> > > > > map/unmap cmd explicitly upon any change required on the page tab=
le.
> > > > > If user-managed, the user first binds its page table to the IOMMU=
 and
> > > > > then use invalidation cmd to flush iotlb when necessary (e.g. typ=
ically
> > > > > not required when changing a PTE from non-present to present).
> > > > >
> > > > > We expect user to use map+unmap and bind+invalidate respectively
> > > > > instead of mixing them together. Following this policy, map+unmap
> > > > > must be used in both levels for software nesting, so changes in e=
ither
> > > > > level are captured timely to synchronize the shadow mapping.
> > > >
> > > > map+unmap or bind+invalidate is a policy of the IOASID itself set w=
hen
> > > > it is created. If you put two different types in a tree then each I=
OASID
> > > > must continue to use its own operation mode.
> > > >
> > > > I don't see a reason to force all IOASIDs in a tree to be consisten=
t??
> > >
> > > only for software nesting. With hardware support the parent uses map
> > > while the child uses bind.
> > >
> > > Yes, the policy is specified per IOASID. But if the policy violates t=
he
> > > requirement in a specific nesting mode, then nesting should fail.
> >=20
> > I don't get it.
> >=20
> > If the IOASID is a page table then it is bind/invalidate. SW or not SW
> > doesn't matter at all.
> >=20
> > > >
> > > > A software emulated two level page table where the leaf level is a
> > > > bound page table in guest memory should continue to use
> > > > bind/invalidate to maintain the guest page table IOASID even though=
 it
> > > > is a SW construct.
> > >
> > > with software nesting the leaf should be a host-managed page table
> > > (or metadata). A bind/invalidate protocol doesn't require the user
> > > to notify the kernel of every page table change.
> >=20
> > The purpose of invalidate is to inform the implementation that the
> > page table has changed so it can flush the caches. If the page table
> > is changed and invalidation is not issued then then the implementation
> > is free to ignore the changes.
> >=20
> > In this way the SW mode is the same as a HW mode with an infinite
> > cache.
> >=20
> > The collaposed shadow page table is really just a cache.
> >=20
>=20
> OK. One additional thing is that we may need a 'caching_mode"
> thing reported by /dev/ioasid, indicating whether invalidation is
> required when changing non-present to present. For hardware=20
> nesting it's not reported as the hardware IOMMU will walk the
> guest page table in cases of iotlb miss. For software nesting=20
> caching_mode is reported so the user must issue invalidation=20
> upon any change in guest page table so the kernel can update
> the shadow page table timely.

For the fist cut, I'd have the API assume that invalidates are
*always* required.  Some bypass to avoid them in cases where they're
not needed can be an additional extension.

> Following this and your other comment with David, we will mark
> host-managed vs. guest-managed explicitly for I/O page table
> of each IOASID. map+unmap or bind+invalid is decided by
> which owner is specified by the user.
>=20
> Thanks
> Kevin
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ccSPSdMlO8T7edI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC4Y/MACgkQbDjKyiDZ
s5KQ0Q//aafozrGqMvgUn1faAhJWWtshY6H8eIvQDIjwOVCWsRbAQPCfF3HezrM+
lAx/R9oP0j7fHwJCQQAvR9eqed3RGqGWIKNMi7kDwY9eK9V9N90Zy5mOVoFjIgHs
aY8om8Wg9XLukeXkhpqCbUpPAqUPwZp0HA6cy2b9H8wfIXuaGO1WuQSvuSoo0hO3
UnjmhzZ4fkrSMTcdwaPZJXzcVlUhFNxkQ9k8VfF0c10+GMwvnLsLr7sfoP8qxOVG
p2sD8G+d3K0uPmy/Q4nCJoA2UVeoUccyGeDLsklWCEOjP4k+wp0r39tQglCOzPEa
YAq1hNa+TXM0RzalRvGU7jSa7iXLgICLmHkl286vlWJS1oMx7UZkmTN9XSeZy11p
1jII6RllFGikP5YFNEGPZ+6ZDRurm9MeVeGK+yDh0lRwfHwpx/UspDQgKzl30zTs
Ihxb5hUReLFxggyLd0wA3ho/eZfXvvpdWJHZpO+Jk3W9e79uiQph2awm9P8t6tPB
jv9AghxIuHKsJn7I7CKLvJF8cnPqKW4/qs+cdh4ANhBOAmbLFFL9US9/fhO9Wy9f
/KIKQulRr8H0hSDlsCxYCMDFgP/Z4WVUYalOwJnb8XuBIwiMF4gJEslDMsUifizU
6ibse1q02ITHZ4M3zpS8SwWZrD5hRm3sEsqYLz8NxWjoUS/uxqk=
=0ufI
-----END PGP SIGNATURE-----

--ccSPSdMlO8T7edI6--

--===============5336382336207183768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5336382336207183768==--
