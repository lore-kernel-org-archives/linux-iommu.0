Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C4C388F9
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 15:27:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434CC21D47
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 15:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434CC21D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9EE66873F6;
	Fri, 23 Oct 2020 15:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IzeExNDMCnIk; Fri, 23 Oct 2020 15:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC7C1873EB;
	Fri, 23 Oct 2020 15:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8B11C088B;
	Fri, 23 Oct 2020 15:27:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAC06C0051
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 15:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A491873EC
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 15:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEC0pgsHmnSD for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:27:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 472C3873EB
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 15:27:53 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 29FF5AD09;
 Fri, 23 Oct 2020 15:27:51 +0000 (UTC)
Message-ID: <a6ab535a70958b1f79b45583eef8ba7f7172f9ce.camel@suse.de>
Subject: Re: [PATCH v4 5/7] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 23 Oct 2020 17:27:49 +0200
In-Reply-To: <20201022180632.GI1229@gaia>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-6-nsaenzjulienne@suse.de>
 <20201022180632.GI1229@gaia>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, ardb@kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============3525800370345910392=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3525800370345910392==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Ujnlgbo17hnk+IMBN7Ez"


--=-Ujnlgbo17hnk+IMBN7Ez
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin,

On Thu, 2020-10-22 at 19:06 +0100, Catalin Marinas wrote:
> On Wed, Oct 21, 2020 at 02:34:35PM +0200, Nicolas Saenz Julienne wrote:
> > @@ -188,9 +186,11 @@ static phys_addr_t __init max_zone_phys(unsigned i=
nt zone_bits)
> >  static void __init zone_sizes_init(unsigned long min, unsigned long ma=
x)
> >  {
> >  	unsigned long max_zone_pfns[MAX_NR_ZONES]  =3D {0};
> > +	unsigned int __maybe_unused dt_zone_dma_bits;
> > =20
> >  #ifdef CONFIG_ZONE_DMA
> > -	zone_dma_bits =3D ARM64_ZONE_DMA_BITS;
> > +	dt_zone_dma_bits =3D ilog2(of_dma_get_max_cpu_address(NULL));
> > +	zone_dma_bits =3D min(32U, dt_zone_dma_bits);
>=20
> A thought: can we remove the min here and expand ZONE_DMA to whatever
> dt_zone_dma_bits says? More on this below.

On most platforms we'd get PHYS_ADDR_MAX, or something bigger than the actu=
al
amount of RAM. Which would ultimately create a system wide ZONE_DMA. At fir=
st
sight, I don't see it breaking dma-direct in any way.

On the other hand, there is a big amount of MMIO devices out there that can
only handle 32-bit addressing. Be it PCI cards or actual IP cores. To make
things worse, this limitation is often expressed in the driver, not FW (wit=
h
dma_set_mask() and friends). If those devices aren't behind an IOMMU we hav=
e be
able to provide at least 32-bit addressable memory. See this comment from
dma_direct_supported():

/*
 * Because 32-bit DMA masks are so common we expect every architecture
 * to be able to satisfy them - either by not supporting more physical
 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
 * architecture needs to use an IOMMU instead of the direct mapping.
 */

I think, for the common case, we're stuck with at least one zone spanning t=
he
32-bit address space.

> >  	arm64_dma_phys_limit =3D max_zone_phys(zone_dma_bits);
> >  	max_zone_pfns[ZONE_DMA] =3D PFN_DOWN(arm64_dma_phys_limit);
> >  #endif
>=20
> I was talking earlier to Ard and Robin on the ZONE_DMA32 history and the
> need for max_zone_phys(). This was rather theoretical, the Seattle
> platform has all RAM starting above 4GB and that led to an empty
> ZONE_DMA32 originally. The max_zone_phys() hack was meant to lift
> ZONE_DMA32 into the bottom of the RAM, on the assumption that such
> 32-bit devices would have a DMA offset hardwired. We are not aware of
> any such case on arm64 systems and even on Seattle, IIUC 32-bit devices
> only work if they are behind an SMMU (so no hardwired offset).
>=20
> In hindsight, it would have made more sense on platforms with RAM above
> 4GB to expand ZONE_DMA32 to cover the whole memory (so empty
> ZONE_NORMAL). Something like:
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a53c1e0fb017..7d5e3dd85617 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -187,8 +187,12 @@ static void __init reserve_elfcorehdr(void)
>   */
>  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  {
> -	phys_addr_t offset =3D memblock_start_of_DRAM() & GENMASK_ULL(63, zone_=
bits);
> -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> +	phys_addr_t zone_mask =3D 1ULL << zone_bits;
> +
> +	if (!(memblock_start_of_DRAM() & zone_mask))
> +		zone_mask =3D PHYS_ADDR_MAX;
> +
> +	return min(zone_mask, memblock_end_of_DRAM());
>  }
> =20
>  static void __init zone_sizes_init(unsigned long min, unsigned long max)
>=20
> I don't think this makes any difference for ZONE_DMA unless a
> broken DT or IORT reports the max CPU address below the start of DRAM.
>=20
> There's a minor issue if of_dma_get_max_cpu_address() matches
> memblock_end_of_DRAM() but they are not a power of 2. We'd be left with
> a bit of RAM at the end in ZONE_NORMAL due to ilog2 truncation.

I agree it makes no sense to create more than one zone when the beginning o=
f
RAM is located above the 32-bit address space. I'm all for disregarding the
possibility of hardwired offsets. As a bonus, as we already discussed some =
time
ago, this is something that never played well with current dma-direct code[=
1].

Regards,
Nicolas

[1] https://lkml.org/lkml/2020/9/8/377


--=-Ujnlgbo17hnk+IMBN7Ez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+S9nUACgkQlfZmHno8
x/4bWwf/RU6S2bHqFyxWdx39X7G+AyLeTNrRfdRYBq5dQHNz63eBLMKXhKJYSIxJ
lAB9g/YyWW45wZBp+W3KPfwetOEZAb/p0UnQf3rT4hyQLgr+0J/cCo31FOJ/JrYu
957o5e9GSLClCnVvZeUfUtsBGG7fIbOQ6SvOqNoVjZJxlj1HUmeJ5pDUKnZM2KC7
8ySMMQASAXDcIqkdRLLZ95agreaq1hNp7HhqQodOYfjN6PnyfuD3SWJVNBd+la73
ZRof26n506CWYveO4nKT9bnzR6kUxqXEMK6zfCNGM29+h7RwcSPEe/37Yx7vnX5B
lwNRGARdY8QPxuPe4d7SHTNsjlWiOg==
=xV7b
-----END PGP SIGNATURE-----

--=-Ujnlgbo17hnk+IMBN7Ez--


--===============3525800370345910392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3525800370345910392==--

