Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A594C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 08:54:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6DF20BED
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6DF20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A3E587567;
	Thu, 15 Oct 2020 08:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o+EilNUdl-hG; Thu, 15 Oct 2020 08:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 918528790E;
	Thu, 15 Oct 2020 08:54:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70AD3C07FF;
	Thu, 15 Oct 2020 08:54:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BAA2C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 08:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EAC8787567
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 08:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZlwSbbS+7xIs for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 08:54:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 00E24877F8
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 08:54:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E0BDEAEC2;
 Thu, 15 Oct 2020 08:54:12 +0000 (UTC)
Message-ID: <de5e33352782331cf0a6ee32c1c8c6bdfe20b6af.camel@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Oct 2020 10:54:11 +0200
In-Reply-To: <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
 <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated
 list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============3253946582533421974=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3253946582533421974==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-YUQJ5U+i4xNz/NZrjBJR"


--=-YUQJ5U+i4xNz/NZrjBJR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-14 at 17:02 -0500, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> > physical address addressable by all DMA masters in the system. It's
> > specially useful for setting memory zones sizes at early boot time.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---

[...]

> > +       struct of_range_parser parser;
> > +       phys_addr_t subtree_max_addr;
> > +       struct device_node *child;
> > +       phys_addr_t cpu_end =3D 0;
> > +       struct of_range range;
> > +       const __be32 *ranges;
> > +       int len;
> > +
> > +       if (!np)
> > +               np =3D of_root;
> > +
> > +       ranges =3D of_get_property(np, "dma-ranges", &len);
>=20
> I'm not really following why you changed the algorithm here. You're
> skipping disabled nodes which is good. Was there some other reason?

Yes, it's a little more complex. But I had to change it in order to be able=
 to
start parsing down from an arbitrary device node, which is needed for the u=
nit
tests.

for_each_of_allnodes() and friends will traverse the whole tree, regardless=
 of
the starting point. I couldn't find a similar function that would just iter=
ate
over a subsection of the tree, so I went with this recursive approach.

Regards,
Nicolas


--=-YUQJ5U+i4xNz/NZrjBJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IDjMACgkQlfZmHno8
x/7rjAf+KrPaZm2zT8XfzDn5CDIf7492No2jTgiouPN9YLIyCBwWqNc3j9ApACr0
Boxl6eP0BL49yAtVQJz+hq86/9a1TTbqs+xj1mdUG0KruCrKQvSm8sd8DexTFBaV
zw7F1cvFs6HgYqAmNfK5ybVBoDy1Br0LVK5E05S2baUkID/HZDVSGEwhS3FSaRQP
WcMPbmIvPgxNg1/Tk16wi9rX2FToZCJymwwil45nHAFnc4hSsudcTHFmX4Td8J01
jd51b5qeWQ1mX3LY7a4xo0YiR18m69VB0ToPRpQKQvAb24nxMatXip9NtseykiQs
4jVbFSQAT/FxsnzgjJRMVHJOBZFvAQ==
=1G9v
-----END PGP SIGNATURE-----

--=-YUQJ5U+i4xNz/NZrjBJR--


--===============3253946582533421974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3253946582533421974==--

