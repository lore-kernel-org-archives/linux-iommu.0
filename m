Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C591C19759
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 15:45:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFBC20644
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 15:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFBC20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 98B1E8917;
	Thu,  1 Aug 2019 15:45:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A6878883C
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 15:44:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1FA10821
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 15:44:52 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 222CDAC9A;
	Thu,  1 Aug 2019 15:44:50 +0000 (UTC)
Message-ID: <d8b4a7cb9c06824ca88a0602a5bf38b6324b43c0.camel@suse.de>
Subject: Re: [PATCH 5/8] arm64: use ZONE_DMA on DMA addressing limited devices
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 01 Aug 2019 17:44:09 +0200
In-Reply-To: <20190731170742.GC17773@arrakis.emea.arm.com>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
	<20190731154752.16557-6-nsaenzjulienne@suse.de>
	<20190731170742.GC17773@arrakis.emea.arm.com>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: phill@raspberryi.org, devicetree@vger.kernel.org, f.fainelli@gmail.com,
	linux-mm@kvack.org, marc.zyngier@arm.com,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	eric@anholt.net, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
	mbrugger@suse.com, Robin Murphy <robin.murphy@arm.com>,
	akpm@linux-foundation.org, frowand.list@gmail.com, hch@lst.de,
	linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
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
Content-Type: multipart/mixed; boundary="===============6296479843951571021=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============6296479843951571021==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Jl/nDcfVAied7u8Yssfo"


--=-Jl/nDcfVAied7u8Yssfo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 18:07 +0100, Catalin Marinas wrote:
> On Wed, Jul 31, 2019 at 05:47:48PM +0200, Nicolas Saenz Julienne wrote:
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 1c4ffabbe1cb..f5279ef85756 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -50,6 +50,13 @@
> >  s64 memstart_addr __ro_after_init =3D -1;
> >  EXPORT_SYMBOL(memstart_addr);
> > =20
> > +/*
> > + * We might create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA is needed =
if
> > there
> > + * are periferals unable to address the first naturally aligned 4GB of=
 ram.
> > + * ZONE_DMA32 will be expanded to cover the rest of that memory. If su=
ch
> > + * limitations doesn't exist only ZONE_DMA32 is created.
> > + */
>=20
> Shouldn't we instead only create ZONE_DMA to cover the whole 32-bit
> range and leave ZONE_DMA32 empty? Can__GFP_DMA allocations fall back
> onto ZONE_DMA32?

Hi Catalin, thanks for the review.

You're right, the GFP_DMA page allocation will fail with a nasty dmesg erro=
r if
ZONE_DMA is configured but empty. Unsurprisingly the opposite situation is =
fine
(GFP_DMA32 with an empty ZONE_DMA32).

I switched to the scheme you're suggesting for the next version of the seri=
es.
The comment will be something the likes of this:

/*
 * We create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA's size is decided bas=
ed
 * on whether the SoC's peripherals are able to address the first naturally
 * aligned 4 GB of ram.
 *
 * If limited, ZONE_DMA covers that area and ZONE_DMA32 the rest of that 32=
 bit
 * addressable memory.
 *
 * If not ZONE_DMA is expanded to cover the whole 32 bit addressable memory=
 and
 * ZONE_DMA32 is left empty.
 */

 Regards,
 Nicolas



--=-Jl/nDcfVAied7u8Yssfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1DCMkACgkQlfZmHno8
x/724wgAlBvY4KUvCY6AbQ4IkNYytX+x49CEh/vxpdWWXLjrWRTBCg2SwWhZ4y9G
OjuuZe9BBgQBgnZBR0lC8MlCFN7w4Ce5aByypx2pzGLefZKqc4pesvda/gC8Jmo8
csbQ988GLPt6V35DcX3N81FjYrdsZGCcJ1XrtpUVlx6YfIPLx4ZRc/6OfV3yXXBc
XiD/luxNVqjDtvy7RnR2so9hSWet0hM4Wv5TDwI+xt1RviR4Tpdd+jNqtjxH+LcV
2uruy3yUhTGeNaiyZsPt/Bj1Mlg+Wab940ahUDn3a1KBkd4BkFZIoqfjQxBgLaal
iZB+n9PmIhCkaHygfxOy1H+xVYO/AA==
=Opde
-----END PGP SIGNATURE-----

--=-Jl/nDcfVAied7u8Yssfo--


--===============6296479843951571021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6296479843951571021==--

