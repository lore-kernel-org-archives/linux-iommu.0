Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C745C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:51:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B0222250
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B0222250
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D1908850C;
	Thu, 15 Oct 2020 09:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2AxIhZQh5+VT; Thu, 15 Oct 2020 09:51:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B41E788508;
	Thu, 15 Oct 2020 09:51:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 856E3C0052;
	Thu, 15 Oct 2020 09:51:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F394CC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EB9708826C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pRHYohJPrQ1 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 09:51:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8A2A288266
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:51:31 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 22A4FB228;
 Thu, 15 Oct 2020 09:51:30 +0000 (UTC)
Message-ID: <165ca8621058696f7df8e8f894cf647b3171d6fd.camel@suse.de>
Subject: Re: [PATCH v3 4/8] of: unittest: Add test for
 of_dma_get_max_cpu_address()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Oct 2020 11:51:28 +0200
In-Reply-To: <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-5-nsaenzjulienne@suse.de>
 <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0770334641772734027=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0770334641772734027==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-X8qOX67+76GtlnxqUBk7"


--=-X8qOX67+76GtlnxqUBk7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-14 at 17:04 -0500, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
> > data as the rest of dma-ranges unit tests.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/of/unittest.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 06cc988faf78..2cbf2a585c9f 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -869,6 +869,25 @@ static void __init of_unittest_changeset(void)
> >  #endif
> >  }
> >=20
> > +static void __init of_unittest_dma_get_max_cpu_address(void)
> > +{
> > +#ifdef CONFIG_HAS_DMA
>=20
> Can't the unittest run without this? I run the unittests under UML.

It was cargo culted from its sibling of_unittest_dma_ranges_one(), now that=
 you
mention it, I can't seem to find the reason why it's here in the first plac=
e,
nor for other similar usages in OF code.

I ran the test in UML with all HAS_DMA conditionals removed from OF code an=
d
things went well. I'll prepare a fix for that.

> > +       struct device_node *np;
> > +       phys_addr_t cpu_addr;
> > +
> > +       np =3D of_find_node_by_path("/testcase-data/address-tests");
> > +       if (!np) {
> > +               pr_err("missing testcase data\n");
> > +               return;
> > +       }
> > +
> > +       cpu_addr =3D of_dma_get_max_cpu_address(np);
> > +       unittest(cpu_addr =3D=3D 0x50000000ULL,
> > +                "of_dma_get_max_cpu_address: wrong CPU addr %pad (expe=
cting %llx)\n",
> > +                &cpu_addr, 0x50000000ULL);
> > +#endif
> > +}
> > +
> >  static void __init of_unittest_dma_ranges_one(const char *path,
> >                 u64 expect_dma_addr, u64 expect_paddr)
> >  {
> > @@ -3266,6 +3285,7 @@ static int __init of_unittest(void)
> >         of_unittest_changeset();
> >         of_unittest_parse_interrupts();
> >         of_unittest_parse_interrupts_extended();
> > +       of_unittest_dma_get_max_cpu_address();
> >         of_unittest_parse_dma_ranges();
> >         of_unittest_pci_dma_ranges();
> >         of_unittest_match_node();
> > --
> > 2.28.0
> >=20


--=-X8qOX67+76GtlnxqUBk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IG6AACgkQlfZmHno8
x/4LMAf/QcDwrq8xC+sEW6qMg3hpF9bfJCqcr+hehJmADyEcCDmz8TevhzumZXeM
RtlVB67o7Z2bAeSpOqTlQGQHYLdWu3zZ+Zqu0PRjUdQ6CE1l9qzLj1TSIME93HrV
kSSiqWLmOlbyISGAb1pFKbzsVqIX4t+Zn6CuH+BBLl4YimWi0Fj2aCNXSobo/K9J
aOkm5VtaIWCYbrv44+KHzpP+pJZIPl0Ya0NOzH2c2YgmL7nj7meneGEWaiRX7p8d
A/5dnYZRj/HJ+VOYW36zDfzsp5nHZxJVMXG76QJYFSleD36Skl2IyjfYQS+XwMEb
rKyrJ54T41B/RpMYjTMKcmO+x/BUMQ==
=Nev7
-----END PGP SIGNATURE-----

--=-X8qOX67+76GtlnxqUBk7--


--===============0770334641772734027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0770334641772734027==--

