Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D36C433ED
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 04:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29E2611EE
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 04:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29E2611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 453AE6079A;
	Tue,  4 May 2021 04:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOCfYWU1KtGy; Tue,  4 May 2021 04:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A407607E5;
	Tue,  4 May 2021 04:18:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09495C000D;
	Tue,  4 May 2021 04:18:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E6D2C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 04:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AAFC8466C
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 04:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nPDQ3SLUnhGg for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 04:18:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 863A0842E8
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 04:18:22 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FZ65j4PK5z9sSs; Tue,  4 May 2021 14:18:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1620101897;
 bh=GF4kY9gVsGuwV9dXBjYISsLPpgjK/7dHag6l9MAWxKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FFVVpB9WNCZN/OHDK7EFnFAqgxNmT0o6j8dz6VB4dGaDgHpoypxvLCGbts5YHK+rc
 /0GWhCoUlX/gdFz9pMVsCPN56Kbv7o9hKTFl972XyyuWKzbIa3TPAw6YsykdDcjnop
 Pv6BeZTFIqQGE9whKr7bxNbIOfV+YYaDGYHwm4S8=
Date: Tue, 4 May 2021 13:54:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YJDFj+sAv41JRIo4@yekko>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210503160530.GL1370958@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============7238783371945612039=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7238783371945612039==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XJz7RUBFhCVAE36r"
Content-Disposition: inline


--XJz7RUBFhCVAE36r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 01:05:30PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 29, 2021 at 01:20:22PM +1000, David Gibson wrote:
> > > There is a certain appeal to having some
> > > 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
> > > information like windows that can be optionally called by the viommu
> > > driver and it remains well defined and described.
> >=20
> > Windows really aren't ppc specific.  They're absolutely there on x86
> > and everything else as well - it's just that people are used to having
> > a window at 0..<something largish> that you can often get away with
> > treating it sloppily.
>=20
> My point is this detailed control seems to go on to more than just
> windows. As you say the vIOMMU is emulating specific HW that needs to
> have kernel interfaces to match it exactly.

It's really not that bad.  The case of emulating the PAPR vIOMMU on
something else is relatively easy, because all updates to the IO page
tables go through hypercalls.  So, as long as the backend IOMMU can
map all the IOVAs that the guest IOMMU can, then qemu's implementation
of those hypercalls just needs to put an equivalent mapping in the
backend, which it can do with a generic VFIO_DMA_MAP.

vIOMMUs with page tables in guest memory are harder, but only really
in the usual ways that a vIOMMU of that type is harder (needs cache
mode or whatever).  At whatever point you need to shadow from the
guest IO page tables to the host backend, you can again do that with
generic maps, as long as the backend supports the necessary IOVAs, and
has an IO page size that's equal to or a submultiple of the vIOMMU
page size.

> I'm remarking that trying to unify every HW IOMMU implementation that
> ever has/will exist into a generic API complete enough to allow the
> vIOMMU to be created is likely to result in an API too complicated to
> understand..

Maybe not every one, but I think we can get a pretty wide range with a
reasonable interface.  Explicitly handling IOVA windows does most of
it.  And we kind of need to handle that anyway to expose what ranges
the IOMMU is capable of translating anyway.  I think making handling
valid IOVA windows explicit makes things simpler than having
per-backend-family interfaces to expose the limits of their
translation ranges, which is what's likely to happen without it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XJz7RUBFhCVAE36r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCQxY0ACgkQbDjKyiDZ
s5Ja1Q//brgY0BJodmvSW7+qUlkQBKlmerMDnujEgNgBr6cbpA9hN6ywQDlkXit7
xrznyLqBx16060E9F6DQqk1aaAj2+iePxmT97vs7MUHmvuXHgTlmU6T6DDC84ICk
cCIfpXsB5R+pDv0JD/j91cPQBZF1Afnf0KhRLpzjcNKgBoFWi23pAYx3E32nPVtb
1UeflnMCMdr/rHfQR9/GoJ5FP/QYvqppU7351C0yFKbI5k0Pg7RvO41pejcNKE2W
q4wmfrzPA9/7G+JtQr03lGXLVy4+xN0UPsRtxkhQtaX+YNKBVL3qb+oO4XeCf7zw
Zw5vw6Ai8reTK948BEe+S+WJZHHAYBw54ztv7P35XFjR3/avEEPWgSIrba6fAeRZ
0E+RWhYL4c09hGpbJk6FiwTan+2a7EgB90ZuanWFtJ8HCFOFSDI3IRoLVU7k7JLC
IQD7LGmsqWzhMf3FtAK++FiVeWu+NpMPGGBx3XXfSl7kWXzf9CUJRFHLv+wPK0vc
Fln92Fj3HBM3D7keiZ85teYT6G5SacTcmtJTHTfsqqmVlTdVCconk7/y0wQhMDt5
TAfzd8YH0dq6toDJqOZzqZKwGmgaYe9HviiRWa5+C6Y3QJ0dBBN6cUKKZhTKeicd
ifZUPO7PC9KjomC7UWcx6g/pN7eNPSZR2YR+Lb0hATzgCVDkcUg=
=OhAa
-----END PGP SIGNATURE-----

--XJz7RUBFhCVAE36r--

--===============7238783371945612039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7238783371945612039==--
