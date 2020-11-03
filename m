Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43270C55179
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 17:00:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D982080D
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 17:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D982080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 46DB285D44;
	Tue,  3 Nov 2020 17:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mz_QKDaUx9JU; Tue,  3 Nov 2020 17:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80A3785CFF;
	Tue,  3 Nov 2020 17:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64B42C0889;
	Tue,  3 Nov 2020 17:00:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBB16C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B9DD7873CF
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EfIqAKrBjFAd for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 17:00:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTP id A7CA8873C9
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:00:36 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9FF7AC97;
 Tue,  3 Nov 2020 17:00:35 +0000 (UTC)
Message-ID: <0fc240575aad6a538fdc282e419411a615ba93f3.camel@suse.de>
Subject: Re: [PATCH v5 0/7] arm64: Default to 32-bit wide ZONE_DMA
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 03 Nov 2020 18:00:33 +0100
In-Reply-To: <20201030181134.GE23196@gaia>
References: <20201029172550.3523-1-nsaenzjulienne@suse.de>
 <20201030181134.GE23196@gaia>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org, will@kernel.org,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 linux-riscv@lists.infradead.org, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============6615173104570752255=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6615173104570752255==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-e4mvEaSQmsP7NUXAJ5iB"


--=-e4mvEaSQmsP7NUXAJ5iB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-30 at 18:11 +0000, Catalin Marinas wrote:
> On Thu, Oct 29, 2020 at 06:25:43PM +0100, Nicolas Saenz Julienne wrote:
> > Ard Biesheuvel (1):
> >   arm64: mm: Set ZONE_DMA size based on early IORT scan
> >=20
> > Nicolas Saenz Julienne (6):
> >   arm64: mm: Move reserve_crashkernel() into mem_init()
> >   arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
> >   of/address: Introduce of_dma_get_max_cpu_address()
> >   of: unittest: Add test for of_dma_get_max_cpu_address()
> >   arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
> >   mm: Remove examples from enum zone_type comment
>=20
> Thanks for putting this together. I had a minor comment but the patches
> look fine to me. We still need an ack from Rob on the DT patch and I can
> queue the series for 5.11.

I'm preparing a v6 unifying both functions as you suggested.

> Could you please also test the patch below on top of this series? It's
> the removal of the implied DMA offset in the max_zone_phys()
> calculation.

Yes, happily. Comments below.

> --------------------------8<-----------------------------
> From 3ae252d888be4984a612236124f5b099e804c745 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Fri, 30 Oct 2020 18:07:34 +0000
> Subject: [PATCH] arm64: Ignore any DMA offsets in the max_zone_phys()
>  calculation
>=20
> Currently, the kernel assumes that if RAM starts above 32-bit (or
> zone_bits), there is still a ZONE_DMA/DMA32 at the bottom of the RAM and
> such constrained devices have a hardwired DMA offset. In practice, we
> haven't noticed any such hardware so let's assume that we can expand
> ZONE_DMA32 to the available memory if no RAM below 4GB. Similarly,
> ZONE_DMA is expanded to the 4GB limit if no RAM addressable by
> zone_bits.
>=20
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/init.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 095540667f0f..362160e16fb2 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -175,14 +175,21 @@ static void __init reserve_elfcorehdr(void)
>  #endif /* CONFIG_CRASH_DUMP */
> =20
>  /*
> - * Return the maximum physical address for a zone with a given address s=
ize
> - * limit. It currently assumes that for memory starting above 4G, 32-bit
> - * devices will use a DMA offset.
> + * Return the maximum physical address for a zone accessible by the give=
n bits
> + * limit. If the DRAM starts above 32-bit, expand the zone to the maximu=
m
> + * available memory, otherwise cap it at 32-bit.
>   */
>  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  {
> -	phys_addr_t offset =3D memblock_start_of_DRAM() & GENMASK_ULL(63, zone_=
bits);
> -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> +	phys_addr_t zone_mask =3D (1ULL << zone_bits) - 1;

Maybe use DMA_BIT_MASK(), instead of the manual calculation?

> +	phys_addr_t phys_start =3D memblock_start_of_DRAM();
> +
> +	if (!(phys_start & U32_MAX))

I'd suggest using 'bigger than' instead of masks. Just to cover ourselves
against memory starting at odd locations. Also it'll behaves properly when
phys_start is zero (this breaks things on RPi4).

> +		zone_mask =3D PHYS_ADDR_MAX;
> +	else if (!(phys_start & zone_mask))
> +		zone_mask =3D U32_MAX;
> +
> +	return min(zone_mask + 1, memblock_end_of_DRAM());

This + 1 isn't going to play well when zone_mask is PHYS_ADDR_MAX.

Regards,
Nicolas


--=-e4mvEaSQmsP7NUXAJ5iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+hjLEACgkQlfZmHno8
x/5wjggAjwdWMN+H9Cj7ukCCZxIw/mZ7tdk+jtxD8++ocqSv/BLWzfPJhliE31of
ShuRaGhx2UpgX/fny9Ng9cEMWPdjYb6wpyI7EEm2As3R8aWDXwEFh1bu6PkdPyLu
VBm0BkVSUY5Iu9fQYym1yA1KukGrzijxEW7+QFIUwrm1Bdralpg+67WLbOWUxmdI
SGlntSKWlUcfRXCg+/XzLFfODu+htiXHSSBW1zMWx/OsNPHb6Mupfrtdogqv65UP
aQpkzoqyZBlC9ueBXHtWUiDEv7EUdosKbia5mxa7i9apZ5ZPSy/OkGkY9mZq3evn
XiCaUCaYMdiZx1RCUE2VRr9HqZnuEQ==
=QpfN
-----END PGP SIGNATURE-----

--=-e4mvEaSQmsP7NUXAJ5iB--


--===============6615173104570752255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6615173104570752255==--

