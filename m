Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A659DC63697
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 14:10:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAF724655
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 14:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF724655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2921C27366;
	Thu, 19 Nov 2020 14:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Pj+41ntaV46; Thu, 19 Nov 2020 14:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 182B0204D2;
	Thu, 19 Nov 2020 14:10:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05256C1825;
	Thu, 19 Nov 2020 14:10:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 171A7C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 14:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 04B7086B11
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 14:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sReCZsoyaL7X for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 14:10:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A87AC86962
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 14:10:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AEE14AF6F;
 Thu, 19 Nov 2020 14:09:59 +0000 (UTC)
Message-ID: <ba343af12fc60bce36837cc090a39c9e42457788.camel@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>, James Morse
 <james.morse@arm.com>
Date: Thu, 19 Nov 2020 15:09:58 +0100
In-Reply-To: <20201113112901.GA3212@gaia>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
 <X6rZRvWyigCJxAVW@trantor>
 <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
 <20201113112901.GA3212@gaia>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 ardb@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com, will@kernel.org,
 hch@lst.de, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============4529406024995206068=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4529406024995206068==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-djfPNN2Al1SIbMgP1HNN"


--=-djfPNN2Al1SIbMgP1HNN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, James,
sorry for the late reply but I got sidetracked.

On Fri, 2020-11-13 at 11:29 +0000, Catalin Marinas wrote:
[...]
> > > > Let me stress that knowing the DMA constraints in the system before=
 reserving
> > > > crashkernel's regions is necessary if we ever want it to work seaml=
essly on all
> > > > platforms. Be it small stuff like the Raspberry Pi or huge servers =
with TB of
> > > > memory.
> > >=20
> > > Indeed. So we have 3 options (so far):
> > >=20
> > > 1. Allow the crashkernel reservation to go into the linear map but se=
t
> > >    it to invalid once allocated.
> > >=20
> > > 2. Parse the flattened DT (not sure what we do with ACPI) before
> > >    creating the linear map. We may have to rely on some SoC ID here
> > >    instead of actual DMA ranges.
> > >=20
> > > 3. Assume the smallest ZONE_DMA possible on arm64 (1GB) for crashkern=
el
> > >    reservations and not rely on arm64_dma_phys_limit in
> > >    reserve_crashkernel().
> > >=20
> > > I think (2) we tried hard to avoid. Option (3) brings us back to the
> > > issues we had on large crashkernel reservations regressing on some
> > > platforms (though it's been a while since, they mostly went quiet ;))=
.
> > > However, with Chen's crashkernel patches we end up with two
> > > reservations, one in the low DMA zone and one higher, potentially abo=
ve
> > > 4GB. Having a fixed 1GB limit wouldn't be any worse for crashkernel
> > > reservations than what we have now.
> > >=20
> > > If (1) works, I'd go for it (James knows this part better than me),
> > > otherwise we can go for (3).
> >=20
> > Overall, I'd prefer (1) as well, and I'd be happy to have a got at it. =
If not
> > I'll append (3) in this series.
>=20
> I think for 1 we could also remove the additional KEXEC_CORE checks,
> something like below, untested:
>=20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3e5a6913acc8..27ab609c1c0c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -477,7 +477,8 @@ static void __init map_mem(pgd_t *pgdp)
>  	int flags =3D 0;
>  	u64 i;
> =20
> -	if (rodata_full || debug_pagealloc_enabled())
> +	if (rodata_full || debug_pagealloc_enabled() ||
> +	    IS_ENABLED(CONFIG_KEXEC_CORE))
>  		flags =3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> =20
>  	/*
> @@ -487,11 +488,6 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * the following for-loop
>  	 */
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> -#ifdef CONFIG_KEXEC_CORE
> -	if (crashk_res.end)
> -		memblock_mark_nomap(crashk_res.start,
> -				    resource_size(&crashk_res));
> -#endif
> =20
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> @@ -518,21 +514,6 @@ static void __init map_mem(pgd_t *pgdp)
>  	__map_memblock(pgdp, kernel_start, kernel_end,
>  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> -
> -#ifdef CONFIG_KEXEC_CORE
> -	/*
> -	 * Use page-level mappings here so that we can shrink the region
> -	 * in page granularity and put back unused memory to buddy system
> -	 * through /sys/kernel/kexec_crash_size interface.
> -	 */
> -	if (crashk_res.end) {
> -		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> -			       PAGE_KERNEL,
> -			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -		memblock_clear_nomap(crashk_res.start,
> -				     resource_size(&crashk_res));
> -	}
> -#endif
>  }
> =20
>  void mark_rodata_ro(void)

So as far as I'm concerned this is good enough for me. I took the time to
properly test crashkernel on RPi4 using the series, this patch, and another
small fix to properly update /proc/iomem.

I'll send v7 soon, but before, James (or anyone for that matter) any obviou=
s
push-back to Catalin's solution?

Regards,
Nicolas


--=-djfPNN2Al1SIbMgP1HNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+2fLYACgkQlfZmHno8
x/6LYAf/dYs/dUiZ3UOC+CEtALMDPumX6JMSH8G/CZS33vGDE37X9INFiU/9MtHz
y8YBPmkaZh44eCsj4C3MGyhha59a0lD9W5mHHh8uJSSU/enwTba0bOdKd88BOrJS
Og/p1JZ4eLlVDKb/vSfBOG4AndVIO1r0GxT9Qdqk0+QgPVdS1GhhYUj4bXb93zqW
XJxCSdLC2qKxb4OgcEjAeywOvFwvj3kzE6qFwo/FHSYBz9nSC+60pioZAW9g1aea
5mg9xwsR7d0Bs941CPOL3VRRpV7cuVY9JLS5zYGIMRxaNQcCFQSA01/Pct2i7h1T
qlBv3OEIAHR5vjjVyC4uWSZE/9k9Vw==
=+J70
-----END PGP SIGNATURE-----

--=-djfPNN2Al1SIbMgP1HNN--


--===============4529406024995206068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4529406024995206068==--

