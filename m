Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D52C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:16:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D6422269
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D6422269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB2FC20450;
	Thu, 15 Oct 2020 09:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FMqoBLB6BwGo; Thu, 15 Oct 2020 09:16:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7FCA620445;
	Thu, 15 Oct 2020 09:16:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68540C0052;
	Thu, 15 Oct 2020 09:16:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7C9BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D1C5E2044F
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id onotji-BbdO4 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 09:16:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 9173820445
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:16:05 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1FF6AAC97;
 Thu, 15 Oct 2020 09:16:04 +0000 (UTC)
Message-ID: <607e809796bc57ee649390824c4ab2bb767b00ba.camel@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Oct 2020 11:16:02 +0200
In-Reply-To: <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
 <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
 <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:BROADCOM BCM2835
 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
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
Content-Type: multipart/mixed; boundary="===============8443161901477836479=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8443161901477836479==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-sQ2v3OKZpIeLs71fPeU6"


--=-sQ2v3OKZpIeLs71fPeU6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 08:56 +0200, Ard Biesheuvel wrote:
> On Thu, 15 Oct 2020 at 00:03, Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > Introduce of_dma_get_max_cpu_address(), which provides the highest CP=
U
> > > physical address addressable by all DMA masters in the system. It's
> > > specially useful for setting memory zones sizes at early boot time.
> > >=20
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >=20
> > > ---
> > >=20
> > > Changes since v2:
> > >  - Use PHYS_ADDR_MAX
> > >  - return phys_dma_t
> > >  - Rename function
> > >  - Correct subject
> > >  - Add support to start parsing from an arbitrary device node in orde=
r
> > >    for the function to work with unit tests
> > >=20
> > >  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of.h   |  7 +++++++
> > >  2 files changed, 49 insertions(+)
> > >=20
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index eb9ab4f1e80b..b5a9695aaf82 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, c=
onst struct bus_dma_region **map)
> > >  }
> > >  #endif /* CONFIG_HAS_DMA */
> > >=20
> > > +/**
> > > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable fo=
r DMA
> > > + * @np: The node to start searching from or NULL to start from the r=
oot
> > > + *
> > > + * Gets the highest CPU physical address that is addressable by all =
DMA masters
> > > + * in the system (or subtree when np is non-NULL). If no DMA constra=
ined device
> > > + * is found, it returns PHYS_ADDR_MAX.
> > > + */
> > > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np=
)
> > > +{
> > > +       phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> >=20
> > One issue with using phys_addr_t is it may be 32-bit even though the
> > DT is 64-bit addresses. LPAE capable system with LPAE disabled. Maybe
> > the truncation is fine here? Maybe not.
> >=20
>=20
> PHYS_ADDR_MAX is the max addressable CPU address on the system, and so
> it makes sense to use it for the return type, and for the preliminary
> return value: this is actually what /prevents/ truncation, because we
> will only overwrite max_cpu_addr if the new u64 value is lower.
>=20

Actually I now see how things might go south.

> > > +       if (ranges && len) {
> > > +               of_dma_range_parser_init(&parser, np);
> > > +               for_each_of_range(&parser, &range)
> > > +                       if (range.cpu_addr + range.size > cpu_end)
> > > +                               cpu_end =3D range.cpu_addr + range.si=
ze;

If cpu_end hits 0x1_00000000, it'll overflow to 0. This is possible on 32-b=
it
systems (LPAE or not). And something similar might happen on LPAE disabled
systems.

I could add some extra logic, something like:

	/* We overflowed */
	if (cpu_end < range.cpu_addr)
		cpu_end =3D PHYS_ADDR_MAX;

Which is not perfect but will cover most sensible cases.

Or simply deal internally in u64s, and upon returning, check if "max_cpu_ad=
dr"
falls higher than PHYS_ADDR_MAX.

> > > +
> > > +               if (max_cpu_addr > cpu_end)
> > > +                       max_cpu_addr =3D cpu_end;
> > > +       }
> > > +
> > > +       for_each_available_child_of_node(np, child) {
> > > +               subtree_max_addr =3D of_dma_get_max_cpu_address(child=
);
> > > +               if (max_cpu_addr > subtree_max_addr)
> > > +                       max_cpu_addr =3D subtree_max_addr;
> > > +       }
> > > +
> > > +       return max_cpu_addr;
> > > +}

Regards,
Nicolas


--=-sQ2v3OKZpIeLs71fPeU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IE1IACgkQlfZmHno8
x/48cAf/f4EAh2ApzAtvkP3faJslUt27+oT3TMeyHfRGhMr3i4A+86Y9VRAHTnf6
D8Cv30Frgv5i6wg3cTNmZKcjNF5fF6VV+qChZnKZjv+v2F8PDTr169C/c6hRINWD
JgANJ6T7JV6okI5WkEJHD/j9YFtdvBFltt6NqXmds6VewS6mOLVXRxj+N9qP+V5P
caGCEU9eJt9sqRRwL37RX80slzlHggLsjc4RigF61x/TDzjztg8UdFocYuUTvJCW
bfYgyhq40knvU84wyiCvNhOVSKIVgtYXNf5usrKV/mm886P76nUx1LBek4X0aMKq
9w/J+VYneK8lMET/YF6FKVHt/y5TcQ==
=V7Cs
-----END PGP SIGNATURE-----

--=-sQ2v3OKZpIeLs71fPeU6--


--===============8443161901477836479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8443161901477836479==--

