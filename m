Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854BC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 17:27:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB83722DBF
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 17:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB83722DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8B74CD38;
	Tue, 20 Aug 2019 17:27:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A62B2CBF
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:27:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 13ADA12E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:27:55 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 1272AABBE;
	Tue, 20 Aug 2019 17:27:53 +0000 (UTC)
Message-ID: <ef3eaf8ea03ae8dc86a1a2f293087ff5c2f56b7a.camel@suse.de>
Subject: Re: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible function
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Rob Herring <robh+dt@kernel.org>
Date: Tue, 20 Aug 2019 19:27:50 +0200
In-Reply-To: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-4-nsaenzjulienne@suse.de>
	<CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
	devicetree@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>, phill@raspberryi.org,
	Will Deacon <will@kernel.org>, linux-mm@kvack.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Eric Anholt <eric@anholt.net>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Matthias Brugger <mbrugger@suse.com>, "moderated
	list:BROADCOM BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-riscv@lists.infradead.org, "moderated
	list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, Stefan Wahren <wahrenst@gmx.net>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============6593773105735746703=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============6593773105735746703==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Cm+dM0aB2YImXVa0ovlW"


--=-Cm+dM0aB2YImXVa0ovlW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,
thanks for the rewiew.

On Tue, 2019-08-20 at 12:16 -0500, Rob Herring wrote:
> On Tue, Aug 20, 2019 at 9:58 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Provides the same functionality as of_machine_is_compatible.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes in v2: None
> >=20
> >  drivers/of/fdt.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 9cdf14b9aaab..06ffbd39d9af 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -802,6 +802,13 @@ const char * __init of_flat_dt_get_machine_name(vo=
id)
> >         return name;
> >  }
> >=20
> > +static const int __init of_fdt_machine_is_compatible(char *name)
>=20
> No point in const return (though name could possibly be const), and
> the return could be bool instead.

Sorry, I completely missed that const, shouldn't have been there to begin w=
ith.

I'll add a const to the name argument and return a bool on the next version=
.

Regards,
Nicolas



--=-Cm+dM0aB2YImXVa0ovlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1cLZYACgkQlfZmHno8
x/4DowgAjoLUq0qUOWOtkTx0OcxyQrKy++gIvChR7IajK1yXJKyT8kA/QNZrERqj
nvLlebXPhJG0y4uUTzEVmzsgUFS4vopZAzL+H7TGfXsL8pQbGjnO+l62gc1oqTVd
U+IrQWs0BPZ/MeCxUXUtKlYdMMuf9Ld8z16siDZPj5pYY6IHq8HtS1WseTvTti6S
pHpXyK+XiPpxzupgUjNm6Lzsm8FO0P2tw5IKD3vRLS+4vLaYUPieCLdMvkf1lMU6
DkQ71pEENpt35eBer1lLK/meYuisvK4V+tnwrWSDGZCuywbhi1fpvAyh3CRicE3t
rvLGmR2JEXsldgQeodOoEyKoeWSAgQ==
=hgaN
-----END PGP SIGNATURE-----

--=-Cm+dM0aB2YImXVa0ovlW--


--===============6593773105735746703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6593773105735746703==--

