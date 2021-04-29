Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AAFC433ED
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 04:18:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6A961453
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 04:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6A961453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D578D84D3A;
	Thu, 29 Apr 2021 04:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kRo4sbg2Eja; Thu, 29 Apr 2021 04:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BD4484661;
	Thu, 29 Apr 2021 04:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76FF9C000E;
	Thu, 29 Apr 2021 04:18:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08FCAC0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 04:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 022F5419BA
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 04:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7ymYtfkHJSX for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 04:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30874419B3
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 04:18:15 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FW2Kx30D2z9sXM; Thu, 29 Apr 2021 14:18:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1619669893;
 bh=CG0C1TtA2qTxavaiVAaS4f+9gUTbGNBMGx1ubjdyJ4M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FUk8ozxaSPoOFI5vFuUiW8LWW08MXqMNOqVJsKKJJki3yNWJx2/aaXJ78/2tlg8xn
 ZNPGggQaTjc4DHHiTSrWSvtyYTsKBc04Rnj12XujF07YobhtvaHzq/ULiRcwvfW0hE
 S0z6xcIcW9nJNujpxOgM0GT5u5BHhoUZJSXimg7w=
Date: Thu, 29 Apr 2021 13:20:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YIol9p3z8BTWFRh8@yekko>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210429002149.GZ1370958@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============0061335183372466649=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0061335183372466649==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VnpCiNDu5ri/I2+C"
Content-Disposition: inline


--VnpCiNDu5ri/I2+C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2021 at 09:21:49PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 28, 2021 at 11:23:39AM +1000, David Gibson wrote:
>=20
> > Yes.  My proposed model for a unified interface would be that when you
> > create a new container/IOASID, *no* IOVAs are valid.
>=20
> Hurm, it is quite tricky. All IOMMUs seem to have a dead zone around
> the MSI window, so negotiating this all in a general way is not going
> to be a very simple API.
>=20
> To be general it would be nicer to say something like 'I need XXGB of
> IOVA space' 'I need 32 bit IOVA space' etc and have the kernel return
> ranges that sum up to at least that big. Then the kernel can do its
> all its optimizations.

Ah, yes, sorry.  We do need an API that lets the kernel make more of
the decisions too.  For userspace drivers it would generally be
sufficient to just ask for XXX size of IOVA space wherever you can get
it.  Handling guests requires more precision.  So, maybe a request
interface with a bunch of hint variables and a matching set of
MAP_FIXED-like flags to assert which ones aren't negotiable.

> I guess you are going to say that the qemu PPC vIOMMU driver needs
> more exact control..

*Every* vIOMMU driver needs more exact control.  The guest drivers
will expect to program the guest devices with IOVAs matching the guest
platform's IOMMU model.  Therefore the backing host IOMMU has to be
programmed to respond to those IOVAs.  If it can't be, there's no way
around it, and you want to fail out early.  With this model that will
happen when qemu (say) requests the host IOMMU window(s) to match the
guest's expected IOVA ranges.

Actually, come to that even guests without a vIOMMU need more exact
control: they'll expect IOVA to match GPA, so if your host IOMMU can't
be set up translate the full range of GPAs, again, you're out of luck.

The only reason x86 has been able to ignore this is that the
assumption has been that all IOMMUs can translate IOVAs from 0..<a big
enough number for any reasonable RAM size>.  Once you really start to
look at what the limits are, you need the exact window control I'm
describing.

> > I expect we'd need some kind of query operation to expose limitations
> > on the number of windows, addresses for them, available pagesizes etc.
>=20
> Is page size an assumption that hugetlbfs will always be used for backing
> memory or something?

So for TCEs (and maybe other IOMMUs out there), the IO page tables are
independent of the CPU page tables.  They don't have the same format,
and they don't necessarily have the same page size.  In the case of a
bare metal kernel working in physical addresses they can use that TCE
page size however they like.  For userspace you get another layer of
complexity.  Essentially to implement things correctly the backing
IOMMU needs to have a page size granularity that's the minimum of
whatever granularity the userspace or guest driver expects and the
host page size backing the memory.

> > > As an ideal, only things like the HW specific qemu vIOMMU driver
> > > should be reaching for all the special stuff.
> >=20
> > I'm hoping we can even avoid that, usually.  With the explicitly
> > created windows model I propose above, it should be able to: qemu will
> > create the windows according to the IOVA windows the guest platform
> > expects to see and they either will or won't work on the host platform
> > IOMMU.  If they do, generic maps/unmaps should be sufficient.  If they
> > don't well, the host IOMMU simply cannot emulate the vIOMMU so you're
> > out of luck anyway.
>=20
> It is not just P9 that has special stuff, and this whole area of PASID
> seems to be quite different on every platform
>=20
> If things fit very naturally and generally then maybe, but I've been
> down this road before of trying to make a general description of a
> group of very special HW. It ended in tears after 10 years when nobody
> could understand the "general" API after it was Frankenstein'd up with
> special cases for everything. Cautionary tale
>=20
> There is a certain appeal to having some
> 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
> information like windows that can be optionally called by the viommu
> driver and it remains well defined and described.

Windows really aren't ppc specific.  They're absolutely there on x86
and everything else as well - it's just that people are used to having
a window at 0..<something largish> that you can often get away with
treating it sloppily.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VnpCiNDu5ri/I2+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCKJfQACgkQbDjKyiDZ
s5LJkw//bITy91FckatPRCEx8u5jctT/DbzHeYnr8pGEugv3JmhVq72mk2XGwuHB
svC41OVYOD8PC7hX52SQ3PGA+3fNIYvPwALynj2wLlSI7ce79J+NGuREB+7cgB1K
GoOWrzuWf23tFL16G7OhY88nothHY7vUWjil4FWrBZVKxj7vnQZ7SZmlasiDN46m
V9FwTCfu1Mbv8r+FqgTnytjio5wVIxQSfEhIbbevpbyeCZmcvFT4PQfpKiyrM9hp
oRGJibDfILmgCsM20Pj33rNqPcL42Xk/bEllzKnTitoSIcfYBQAUHKjrv3QfPb3d
dR/C8E/jEADfIHvfCLdM3IX9CouAwzcQv+TWg9YDydPKawB9F+3tEEwZj9rH/IOk
12d1AxSNv9ruQ4VLkXqbIANcxAau5iuk2pgd8Gm45MmICvSEtNKCpfHkOCsfgREf
WUAb3vn95RuxSLXJTtEU6SOk4lBzLjFl4tjv7nCZ5ikAz6EQnjEuN0jybXqNC9dX
xdBeT+6Tjq0l8NQxekOv0b1/3ReLenR+MAKsYL1y2OkVVgUiMrBSNtwc3nMqE2ZH
WkBzXWyTy/it2/gR7fesmmvpEFNTaovXfHPkApuHBbX45rABjiLD/vh+j/i1lkTL
WvUcE7BSx27vbWtRfWXHgjrHIfgGe1yIjG3ogwx8sBd5nLSXoC0=
=R90G
-----END PGP SIGNATURE-----

--VnpCiNDu5ri/I2+C--

--===============0061335183372466649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0061335183372466649==--
