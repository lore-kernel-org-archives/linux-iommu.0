Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D478EC388F2
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 14:03:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F0524182
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 14:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F0524182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AD1DB2040F;
	Thu, 22 Oct 2020 14:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2EfQCO-7NVCE; Thu, 22 Oct 2020 14:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E8FCA20017;
	Thu, 22 Oct 2020 14:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACCA2C08A1;
	Thu, 22 Oct 2020 14:03:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B0B3C0052
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 14:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1908182709
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 14:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FV1IQ2fAwCn9 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 14:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F3E8881DC9
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 14:03:21 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B00A3B181;
 Thu, 22 Oct 2020 14:03:19 +0000 (UTC)
Message-ID: <e1da254cdf27edb3de798058bb234d8ded80267b.camel@suse.de>
Subject: Re: [PATCH v4 3/7] of/address: Introduce of_dma_get_max_cpu_address()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Oct 2020 16:03:16 +0200
In-Reply-To: <CAMj1kXEV846XaZWGFmmq4-1UQBb3kw+E_xQf7tGZG7=wQp9xUQ@mail.gmail.com>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-4-nsaenzjulienne@suse.de>
 <CAMj1kXEV846XaZWGFmmq4-1UQBb3kw+E_xQf7tGZG7=wQp9xUQ@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, "moderated list:BROADCOM BCM2835
 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
 Hanjun Guo <guohanjun@huawei.com>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============6584127973697305920=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6584127973697305920==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-UvLPWvl3/tbDetGzXF2K"


--=-UvLPWvl3/tbDetGzXF2K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 14:23 +0200, Ard Biesheuvel wrote:
> > +/**
> > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable for =
DMA
> > + * @np: The node to start searching from or NULL to start from the roo=
t
> > + *
> > + * Gets the highest CPU physical address that is addressable by all DM=
A masters
> > + * in the sub-tree pointed by np, or the whole tree if NULL is passed.=
 If no
> > + * DMA constrained device is found, it returns PHYS_ADDR_MAX.
> > + */
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +       phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> > +       struct of_range_parser parser;
> > +       phys_addr_t subtree_max_addr;
> > +       struct device_node *child;
> > +       struct of_range range;
> > +       const __be32 *ranges;
> > +       u64 cpu_end =3D 0;
> > +       int len;
> > +
> > +       if (!np)
> > +               np =3D of_root;
> > +
> > +       ranges =3D of_get_property(np, "dma-ranges", &len);
> > +       if (ranges && len) {
> > +               of_dma_range_parser_init(&parser, np);
> > +               for_each_of_range(&parser, &range)
> > +                       if (range.cpu_addr + range.size > cpu_end)
> > +                               cpu_end =3D range.cpu_addr + range.size=
;
>=20
>=20
> Shouldn't this be 'range.cpu_addr + range.size - 1' ?

Yes, I agree. In that case arm64's counterpart should be:

	zone_dma_bits =3D max(32U, fls64(of_dma_get_max_cpu_address(NULL)));

I'll update it.

Regards,
Nicolas


--=-UvLPWvl3/tbDetGzXF2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+RkSUACgkQlfZmHno8
x/6WbQgAkVcDhB3SycLRGqPjX7WUnNsAxd8ccdYnBA32Lo5ualAFZpZH1lAjlBrF
fsE03ZH1EMEFjaV5UJfaquybvyGf4z6boCw+jX30MUDLJePhl3XTMfWhIjTN81t+
8ZW+wKCaL0M+F1hMjE4wGtk4toTaeYHNHxB8t9DKIwxjZ4mUE5sPBmpRQZv6eK/t
YezVQWfjCjOP2MyY76PzZ54F4qSHXBQnsfZciol8tOCFARX/e0HfZtHtsILye37P
nRydYfQsLGMhkDoDUDK4o529hPYTRY4REnEp1lbD0EUiXvpR/ZbnKMTLGz6y5uoQ
2KCLhICIqbSK6ab+UBgXrHFRIRoavA==
=hL5X
-----END PGP SIGNATURE-----

--=-UvLPWvl3/tbDetGzXF2K--


--===============6584127973697305920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6584127973697305920==--

