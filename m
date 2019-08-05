Return-Path: <SRS0=bWDR=WB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0846C32751
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 16:04:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF089208C3
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF089208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A17921011;
	Mon,  5 Aug 2019 16:04:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 83570FE7
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 16:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B6B3B82F
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 16:03:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id C834AAEFB;
	Mon,  5 Aug 2019 16:03:56 +0000 (UTC)
Message-ID: <2050374ac07e0330e505c4a1637256428adb10c4.camel@suse.de>
Subject: Re: [PATCH 3/8] of/fdt: add function to get the SoC wide DMA
	addressable memory size
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Rob Herring <robh+dt@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>
Date: Mon, 05 Aug 2019 18:03:53 +0200
In-Reply-To: <CAL_JsqKF5nh3hcdLTG5+6RU3_TnFrNX08vD6qZ8wawoA3WSRpA@mail.gmail.com>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
	<20190731154752.16557-4-nsaenzjulienne@suse.de>
	<CAL_JsqKF5nh3hcdLTG5+6RU3_TnFrNX08vD6qZ8wawoA3WSRpA@mail.gmail.com>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: phill@raspberryi.org, devicetree@vger.kernel.org, "moderated list:BROADCOM
	BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Frank Rowand <frowand.list@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
	Matthias Brugger <mbrugger@suse.com>, wahrenst@gmx.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, "moderated
	list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============7518930792492608569=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7518930792492608569==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-bHwRoCAB9PanvfyTc8AQ"


--=-bHwRoCAB9PanvfyTc8AQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,
Thanks for the review!

On Fri, 2019-08-02 at 11:17 -0600, Rob Herring wrote:
> On Wed, Jul 31, 2019 at 9:48 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Some SoCs might have multiple interconnects each with their own DMA
> > addressing limitations. This function parses the 'dma-ranges' on each o=
f
> > them and tries to guess the maximum SoC wide DMA addressable memory
> > size.
> >=20
> > This is specially useful for arch code in order to properly setup CMA
> > and memory zones.
>=20
> We already have a way to setup CMA in reserved-memory, so why is this
> needed for that?

Correct me if I'm wrong but I got the feeling you got the point of the patc=
h
later on.

> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> >  drivers/of/fdt.c       | 72 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_fdt.h |  2 ++
> >  2 files changed, 74 insertions(+)
> >=20
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 9cdf14b9aaab..f2444c61a136 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -953,6 +953,78 @@ int __init early_init_dt_scan_chosen_stdout(void)
> >  }
> >  #endif
> >=20
> > +/**
> > + * early_init_dt_dma_zone_size - Look at all 'dma-ranges' and provide =
the
> > + * maximum common dmable memory size.
> > + *
> > + * Some devices might have multiple interconnects each with their own =
DMA
> > + * addressing limitations. For example the Raspberry Pi 4 has the
> > following:
> > + *
> > + * soc {
> > + *     dma-ranges =3D <0xc0000000  0x0 0x00000000  0x3c000000>;
> > + *     [...]
> > + * }
> > + *
> > + * v3dbus {
> > + *     dma-ranges =3D <0x00000000  0x0 0x00000000  0x3c000000>;
> > + *     [...]
> > + * }
> > + *
> > + * scb {
> > + *     dma-ranges =3D <0x0 0x00000000  0x0 0x00000000  0xfc000000>;
> > + *     [...]
> > + * }
> > + *
> > + * Here the area addressable by all devices is [0x00000000-0x3bffffff]=
.
> > Hence
> > + * the function will write in 'data' a size of 0x3c000000.
> > + *
> > + * Note that the implementation assumes all interconnects have the sam=
e
> > physical
> > + * memory view and that the mapping always start at the beginning of R=
AM.
>=20
> Not really a valid assumption for general code.

Fair enough. On my defence I settled on that assumption after grepping all =
dts
and being unable to find a board that behaved otherwise.

[...]

> It's possible to have multiple levels of nodes and dma-ranges. You need t=
o
> handle that case too. Doing that and handling differing address translati=
ons
> will be complicated.

Understood.

> IMO, I'd just do:
>=20
> if (of_fdt_machine_is_compatible(blob, "brcm,bcm2711"))
>     dma_zone_size =3D XX;
>=20
> 2 lines of code is much easier to maintain than 10s of incomplete code
> and is clearer who needs this. Maybe if we have dozens of SoCs with
> this problem we should start parsing dma-ranges.

FYI that's what arm32 is doing at the moment and was my first instinct. But=
 it
seems that arm64 has been able to survive so far without any machine specif=
ic
code and I have the feeling Catalin and Will will not be happy about this
solution. Am I wrong?


--=-bHwRoCAB9PanvfyTc8AQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1IU2kACgkQlfZmHno8
x/4vnwf/XE8+V9mimMzYNeVSaTESn/AL3orSEJeMoeUZ1CPBVspMiV34YhnJFTs+
P3QiXvdigSX/vj+I8400qhGBhIj/+34A+wdKwEYb80kh2OExM56tuKuptWLPuyPd
u9T3FLJ+NdnV8p6zloY7xYBtI62Hr618kOX/ku1lBC5sJX1y8bRjTpvKqOPnrcC/
lcwjF0tU+HjPtYVDvhm6Joe0DryRATvNyVHzFrzpmcnznP+/6JCSPcaeDzDgY5jK
6/oS4fQQuzbAasQYkJDdOtEbRkE6W933vTGU3+kBwMdMybPYJW47CWedJulvKZvJ
6UP+li0Bb59N44VHgsTjI8pB8bey3g==
=gqcX
-----END PGP SIGNATURE-----

--=-bHwRoCAB9PanvfyTc8AQ--


--===============7518930792492608569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7518930792492608569==--

