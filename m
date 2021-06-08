Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA7C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 02:26:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2D86124B
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 02:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2D86124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6E62402C0;
	Tue,  8 Jun 2021 02:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wLwMY4CHdeS; Tue,  8 Jun 2021 02:25:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64529400B9;
	Tue,  8 Jun 2021 02:25:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38C9EC000B;
	Tue,  8 Jun 2021 02:25:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A81FC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52F3D831AC
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MT2r4lst_Wws for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 02:25:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8107B82C6B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:52 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FzYxm6L3yz9sW8; Tue,  8 Jun 2021 12:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623119148;
 bh=lncYIbxArPowV0MRkDFVxKOswtaRzRtG9W2xdghAx6E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fl9N/rY051u/vXA8Hw32d6pExmLKI3N41TquwdbFFNmvj4ancl24Wkx4HSWiolM+/
 pT1F2q/2VhF59OyNxNlXSpAEqFIyRsYMFMf4P3aALG2JOQUSOwl3st8G4JX8vKfRtM
 3qtkRUSTv9gMnqY1vA6bx6Z+lDdwhUTBcM8bIE8I=
Date: Tue, 8 Jun 2021 10:53:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YL6/bjHyuHJTn4Rd@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com> <YLcl+zaK6Y0gB54a@yekko>
 <20210602161648.GY1002214@nvidia.com> <YLhlCINGPGob4Nld@yekko>
 <20210603115224.GQ1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210603115224.GQ1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============4677494160234666538=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4677494160234666538==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g5xwcfR2A+2YrJL6"
Content-Disposition: inline


--g5xwcfR2A+2YrJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 08:52:24AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 03, 2021 at 03:13:44PM +1000, David Gibson wrote:
>=20
> > > We can still consider it a single "address space" from the IOMMU
> > > perspective. What has happened is that the address table is not just a
> > > 64 bit IOVA, but an extended ~80 bit IOVA formed by "PASID, IOVA".
> >=20
> > True.  This does complexify how we represent what IOVA ranges are
> > valid, though.  I'll bet you most implementations don't actually
> > implement a full 64-bit IOVA, which means we effectively have a large
> > number of windows from (0..max IOVA) for each valid pasid.  This adds
> > another reason I don't think my concept of IOVA windows is just a
> > power specific thing.
>=20
> Yes
>=20
> Things rapidly get into weird hardware specific stuff though, the
> request will be for things like:
>   "ARM PASID&IO page table format from SMMU IP block vXX"

So, I'm happy enough for picking a user-managed pagetable format to
imply the set of valid IOVA ranges (though a query might be nice).

I'm mostly thinking of representing (and/or choosing) valid IOVA
ranges as something for the kernel-managed pagetable style
(MAP/UNMAP).

> Which may have a bunch of (possibly very weird!) format specific data
> to describe and/or configure it.
>=20
> The uAPI needs to be suitably general here. :(
>=20
> > > If we are already going in the direction of having the IOASID specify
> > > the page table format and other details, specifying that the page
> > > tabnle format is the 80 bit "PASID, IOVA" format is a fairly small
> > > step.
> >=20
> > Well, rather I think userspace needs to request what page table format
> > it wants and the kernel tells it whether it can oblige or not.
>=20
> Yes, this is what I ment.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g5xwcfR2A+2YrJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC+v24ACgkQbDjKyiDZ
s5Khrg/+O8Zfek3/FbN5ebI8tszXAHZwV5BjxM1PNWD6PIjlBfD/7OG7REO2l9w9
6idpUCjPhg6/3wuCDpPfqgD5xvhKwyW05VrcVUWhKbmMNXZ47iBRkOpeBY99JoIl
IVJeoRMXRwtdHGem7WKJfrg2KZl7uoFDMB5oxswwukVPfVCema7SGEsjnXXCaeQU
oUnl8usFPedPUgf04GUlN4mMOQccOiLcg3B6SxytX/yWY+aal0M3XGcWVIT61vOS
2FEcYxwn1qcZOYMcmqyanLxaAo+8fQ7fSeacF6c5mPG1JJWfdn4J3PCn3Ot8Jz3x
GPvUm2V79AEu8OyEYLGbGnnEY44TaYho40gaoW67Oq3c5vw/jfxKiTDHQ0sZGcE5
/Zx7zjw3XbSDogbyG2EYmZK0peVNPcu1UhWXRYMnC6C2KFWDZnxrJLO8/qNNpIHd
CQXpnEVj8LX5aU4bpg3bTWiidYQ2Ifb+VEyDrJ6NouWwPySDO5Dwv/JySPz8gHbl
4tmiWz1ZdHoTEY1pSrirzPI1S0OY+5n0S5xXFeRayOFdE+3PZ4a5Mn+FEIIh4ynE
SYygZh5LM5KuCjLbT1LO7/bUsCWpNBe9yP0C4kTi6rUVvh4nWq7vO9qpxtMeoVyv
Cd809jz15Cs2A89v65hLgF4MsgFKLxApFx/yXUkp6b27l6gw8Hc=
=2eQJ
-----END PGP SIGNATURE-----

--g5xwcfR2A+2YrJL6--

--===============4677494160234666538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4677494160234666538==--
