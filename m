Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E919C47095
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 02:26:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3066761208
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 02:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3066761208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5AC060884;
	Tue,  8 Jun 2021 02:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CpC8Y60J3tUP; Tue,  8 Jun 2021 02:26:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5322560009;
	Tue,  8 Jun 2021 02:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3098DC000B;
	Tue,  8 Jun 2021 02:26:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4061FC000D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15D42402F6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id muC_CRS-mZ8W for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 02:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46DFB402FC
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 02:25:52 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FzYxm5n40z9sRK; Tue,  8 Jun 2021 12:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623119148;
 bh=rxA81Y8neKOEB5Cc9kisefM4q1thUTdt4CWm4Nfc2Yw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mqQDfQu00RfVzGtfTX4DNhpOwyKEuh4+3BuPpAuEQaaigEfRHJ0YKZiEb2L4JHZMU
 nGSyWMI8ikc0MPFbpLIgRTgvQMmRcbl0oY3uYleB8E9LY/GqNVJTxo89kv87GuZa0a
 8u7Qv1p3rtwRcQVht4Y38pf1IFltqs0Vtjlz0v3I=
Date: Tue, 8 Jun 2021 10:49:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YL6+tBc+Xq7pgb/z@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
 <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601174229.GP1002214@nvidia.com>
 <MWHPR11MB1886283575628D7A2F4BFFAB8C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160914.GX1002214@nvidia.com>
 <MWHPR11MB18861FA1636BFB66E5E563508C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLhj9mi9J/f+rqkP@yekko>
 <MWHPR11MB1886E929BD1414817E9247898C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886E929BD1414817E9247898C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============1642474194820009299=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1642474194820009299==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lVmKxZwYU6H/NYU5"
Content-Disposition: inline


--lVmKxZwYU6H/NYU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 06:49:20AM +0000, Tian, Kevin wrote:
> > From: David Gibson
> > Sent: Thursday, June 3, 2021 1:09 PM
> [...]
> > > > In this way the SW mode is the same as a HW mode with an infinite
> > > > cache.
> > > >
> > > > The collaposed shadow page table is really just a cache.
> > > >
> > >
> > > OK. One additional thing is that we may need a 'caching_mode"
> > > thing reported by /dev/ioasid, indicating whether invalidation is
> > > required when changing non-present to present. For hardware
> > > nesting it's not reported as the hardware IOMMU will walk the
> > > guest page table in cases of iotlb miss. For software nesting
> > > caching_mode is reported so the user must issue invalidation
> > > upon any change in guest page table so the kernel can update
> > > the shadow page table timely.
> >=20
> > For the fist cut, I'd have the API assume that invalidates are
> > *always* required.  Some bypass to avoid them in cases where they're
> > not needed can be an additional extension.
> >=20
>=20
> Isn't a typical TLB semantics is that non-present entries are not
> cached thus invalidation is not required when making non-present
> to present?

Usually, but not necessarily.

> It's true to both CPU TLB and IOMMU TLB.

I don't think it's entirely true of the CPU TLB on all ppc MMU models
(of which there are far too many).

> In reality
> I feel there are more usages built on hardware nesting than software
> nesting thus making default following hardware TLB behavior makes
> more sense...

I'm arguing for always-require-invalidate because it's strictly more
general.  Requiring the invalidate will support models that don't
require it in all cases; we just make the invalidate a no-op.  The
reverse is not true, so we should tackle the general case first, then
optimize.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lVmKxZwYU6H/NYU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC+vrQACgkQbDjKyiDZ
s5IOTQ/+OnKcpdjvyqxaSbBDFwAu0SI4Q+ls/bus20IbeYmALM5ylflnO9Xrgryx
Ph3tOOhR7CrHdjhQ/WzsFmemr1rn3ICex6ZLjiRvEI4EYuWtNkYtwA0R579Vzp3t
11E4tYgyL+my7ti4Z5iHhIeQNtxptI9CAVuAe3RGmvEijy5XBCH3Uz2po9dpoZ58
pgNxE71ugfDasnP1JGvXlNYQHVJ5QDuvDcmRDIK+VoOQbnHDo8aL6KwGfBST0cvi
ZfFj4L5xaLFaAeo4lKxe2inPpdAoHNJEbseKBLauVRI47VZ10SWhk3UHdbd1CBjI
qMWo8S+XUkfFL5WHHYfWu8GU5W57EiP8r/ipNDp/kBvtuRvVE8nzOFkrN+6R57XR
DvtV0rxxzzA3K4lZbfRwx71TPHfuVGC5pdhyppKk47HQcXloAGTXYA8TviXDG7hp
Ff7GnUzDcu4z3L2dl70KbX8vn19DdLF6lgsC2xt0OTI77AetybIzAauu5yq1LocD
EuNwCaJy889iZpquHihGoXjmwPph766/JMECSwJh3Uhg0Yiup6XPhOqg8H7lweBK
6ayA51i4GfukYOPdY3dNDTeh4km8PKl8bxhwHI+uqPf1xWjbUG319+oWLVT0oYSn
EzZrA0KOdA9yGoB5IYD7WfXqIkIUoJBu7PoS+RaC91XPuD5id+w=
=5vgw
-----END PGP SIGNATURE-----

--lVmKxZwYU6H/NYU5--

--===============1642474194820009299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1642474194820009299==--
