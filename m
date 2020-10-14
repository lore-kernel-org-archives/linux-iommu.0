Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD67C43457
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 11:34:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42CF208B3
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 11:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42CF208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FF7287A04;
	Wed, 14 Oct 2020 11:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C2BoCR2OBjNI; Wed, 14 Oct 2020 11:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38919879FE;
	Wed, 14 Oct 2020 11:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 076ABC07FF;
	Wed, 14 Oct 2020 11:34:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C122C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 11:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7687D87FF7
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 11:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ruVjWHgsTWx for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 11:34:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DEA1887FFE
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 11:34:50 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E2D19ADCC;
 Wed, 14 Oct 2020 11:34:48 +0000 (UTC)
Message-ID: <3023eb53ffd2afd8c6c0755af825e426e109cbc2.camel@suse.de>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Oct 2020 13:34:47 +0200
In-Reply-To: <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-3-nsaenzjulienne@suse.de>
 <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============5554804080346200174=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5554804080346200174==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-3FpJRYmVjKizmPf2oMLX"


--=-3FpJRYmVjKizmPf2oMLX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-10-11 at 09:47 +0200, Ard Biesheuvel wrote:
> Hi Nicolas,
>=20
> $SUBJECT is out of sync with the patch below. Also, for legibility, it
> helps if the commit log is intelligible by itself, rather than relying
> on $SUBJECT being the first line of the first paragraph.

Noted, I'll update all commit logs.

> On Sat, 10 Oct 2020 at 17:12, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > The function provides the CPU physical address addressable by the most
> > constrained bus in the system. It might be useful in order to
> > dynamically set up memory zones during boot.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/of.h   |  7 +++++++
> >  2 files changed, 41 insertions(+)
> >=20
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index eb9ab4f1e80b..755e97b65096 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, con=
st struct bus_dma_region **map)
> >  }
> >  #endif /* CONFIG_HAS_DMA */
> >=20
> > +/**
> > + * of_dma_safe_phys_limit - Get system wide DMA safe address space
> > + *
> > + * Gets the CPU physical address limit for safe DMA addressing system =
wide by
> > + * searching for the most constraining dma-range. Otherwise it returns=
 ~0ULL.
> > + */
> > +u64 __init of_dma_safe_phys_limit(void)
>=20
> I don't think 'safe' strikes the right tone here. You are looking for
> the highest CPU address that is addressable by all DMA masters in the
> system.
>=20
> Something like
>=20
> of_dma_get_max_cpu_address(void)
>=20
> perhaps? Also, since this is generic code, phys_addr_t is probably a
> better type to return.

Sonds good to me, I dindn't like the name I used either.

Will use with phys_addr_t.

Regards,
Nicolas


--=-3FpJRYmVjKizmPf2oMLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+G4lcACgkQlfZmHno8
x/4+2Qf9GAEy2PCZfqL+CKXSci2Q9BU2ykIHZgeZZn6AKWxXV1hrFjie5271Jnmr
ivJ/+EIhJoKSrjOPHETRjSc8vVjYIrZsdJPZjHgiGd7VTCnrER1elr6bUeN0r/LK
4Pk4htI6qYa+qm1olPEV1uG3ZzTFx+STdQnXnDl3CizOdzlSkitgos1bjylAmCVU
UzyQrqA5JQnlmM0DxoJj7gq9DeDpV85cjfngrW6Iq0KJP1iM1NflNW5hMHcL6k/m
a/ykOok8q2IgO4Sv0I2mCn2T/eDieQxGA/ksRjyqwPdbGLTAULFURU01xD2DJsj3
Jj5PawT49NznUrRDddcdpBtXBJ0CKQ==
=O9H3
-----END PGP SIGNATURE-----

--=-3FpJRYmVjKizmPf2oMLX--


--===============5554804080346200174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5554804080346200174==--

