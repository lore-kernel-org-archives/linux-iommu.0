Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC09C433FF
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:01:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0C62087E
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 16:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0C62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C5A7C8987;
	Thu,  1 Aug 2019 16:01:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 835A26DA7
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:00:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B4C7B8B3
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 16:00:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 7FF1DAC2E;
	Thu,  1 Aug 2019 16:00:27 +0000 (UTC)
Message-ID: <ed5388412df78ad0a9ed69cdf3ac716eac075141.camel@suse.de>
Subject: Re: [PATCH 6/8] dma-direct: turn ARCH_ZONE_DMA_BITS into a variable
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 01 Aug 2019 17:59:34 +0200
In-Reply-To: <20190801140452.GB23435@lst.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
	<20190731154752.16557-7-nsaenzjulienne@suse.de>
	<20190801140452.GB23435@lst.de>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, eric@anholt.net,
	Paul Mackerras <paulus@samba.org>, will@kernel.org,
	phill@raspberryi.org, linux-s390@vger.kernel.org,
	f.fainelli@gmail.com, frowand.list@gmail.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	catalin.marinas@arm.com, devicetree@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>, marc.zyngier@arm.com,
	robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, mbrugger@suse.com,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	wahrenst@gmx.net, akpm@linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============3404404349131040559=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============3404404349131040559==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1xpVXG9aO5tI8LW1PkIr"


--=-1xpVXG9aO5tI8LW1PkIr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph, thanks for the review.

On Thu, 2019-08-01 at 16:04 +0200, Christoph Hellwig wrote:
> A few nitpicks, otherwise this looks great:
>=20
> > @@ -201,7 +202,7 @@ static int __init mark_nonram_nosave(void)
> >   * everything else. GFP_DMA32 page allocations automatically fall back=
 to
> >   * ZONE_DMA.
> >   *
> > - * By using 31-bit unconditionally, we can exploit ARCH_ZONE_DMA_BITS =
to
> > + * By using 31-bit unconditionally, we can exploit arch_zone_dma_bits =
to
> >   * inform the generic DMA mapping code.  32-bit only devices (if not
> > handled
> >   * by an IOMMU anyway) will take a first dip into ZONE_NORMAL and get
> >   * otherwise served by ZONE_DMA.
> > @@ -237,9 +238,18 @@ void __init paging_init(void)
> >  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
> >  	       (long int)((top_of_ram - total_ram) >> 20));
> > =20
> > +	/*
> > +	 * Allow 30-bit DMA for very limited Broadcom wifi chips on many
> > +	 * powerbooks.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PPC32))
> > +		arch_zone_dma_bits =3D 30;
> > +	else
> > +		arch_zone_dma_bits =3D 31;
> > +
>=20
> So the above unconditionally comment obviously isn't true any more, and
> Ben also said for the recent ppc32 hack he'd prefer dynamic detection.
>=20
> Maybe Ben and or other ppc folks can chime in an add a patch to the serie=
s
> to sort this out now that we have a dynamic ZONE_DMA threshold?

Noted, for now I'll remove the comment.

> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 59bdceea3737..40dfc9b4ee4c 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -19,9 +19,7 @@
> >   * Most architectures use ZONE_DMA for the first 16 Megabytes, but
> >   * some use it for entirely different regions:
> >   */
> > -#ifndef ARCH_ZONE_DMA_BITS
> > -#define ARCH_ZONE_DMA_BITS 24
> > -#endif
> > +unsigned int arch_zone_dma_bits __ro_after_init =3D 24;
>=20
> I'd prefer to drop the arch_ prefix and just calls this zone_dma_bits.
> In the long run we really need to find a way to just automatically set
> this from the meminit code, but that is out of scope for this series.
> For now can you please just update the comment above to say something
> like:
>=20
> /*
>  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some u=
se it
>  * it for entirely different regions.  In that case the arch code needs t=
o
>  * override the variable below for dma-direct to work properly.
>  */

Ok perfect.


--=-1xpVXG9aO5tI8LW1PkIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1DDGYACgkQlfZmHno8
x/7w9wgAsuuhgVK1nlC7WgrB2sfSYqL6HTJlDfkLJ2RMgzu/WSw4RJsje86on5R9
NmRSTVntXnCdpTNiKcSEKP7MnrVtMh2TtopfTOCvgho/uDJsc4DPAqZaLHO4quzo
ZfimsWkcpC6n/E8ybEcew+6U7BIyqJPtqxgdkXz98gLQ1NK1wJU2x0Gt+KXT5a/0
hR3hA3whz8yIe4hwQTEiAzX/LnSP8+Yp+g1LLFjYveqt2RUbfC/udykYkLS7LdoO
SJ6j5S/1jRpvusBjENkY3PQiRGrhfRnT4qxVSdpkK/rMG6pLMW4l9YjfbQCLOFhn
8qxZKNifDs1KxpZjExjd4Lisum4nhw==
=nw8i
-----END PGP SIGNATURE-----

--=-1xpVXG9aO5tI8LW1PkIr--


--===============3404404349131040559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3404404349131040559==--

