Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8BC433E2
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 17:06:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD4E204EC
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 17:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD4E204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7B67F26F1A;
	Thu, 16 Jul 2020 17:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JBE70ts5KZa; Thu, 16 Jul 2020 17:06:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5276126F0D;
	Thu, 16 Jul 2020 17:06:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37A04C07FF;
	Thu, 16 Jul 2020 17:06:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D29DCC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8AC2F26F0D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMiiwv8knGDA for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 17:06:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 0F4A52044D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 17:06:25 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BB08DB609;
 Thu, 16 Jul 2020 17:06:27 +0000 (UTC)
Message-ID: <fe14037b02fd887a73cd91c115dccc4485f8446e.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Only allocate from CMA when in same memory zone
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: hch@lst.de, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
Date: Thu, 16 Jul 2020 19:06:22 +0200
In-Reply-To: <20200710141016.15495-1-nsaenzjulienne@suse.de>
References: <20200710141016.15495-1-nsaenzjulienne@suse.de>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 jeremy.linton@arm.com, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============5650605971811693317=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5650605971811693317==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-i8vqeUqMtzSmwKfBb2jT"


--=-i8vqeUqMtzSmwKfBb2jT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chritoph,

On Fri, 2020-07-10 at 16:10 +0200, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. To get around this double check CMA's placement before
> allocating from it.
>=20
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to g=
fp
> mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>=20
> This is a code intensive alternative to "dma-pool: Do not allocate pool
> memory from CMA"[1].

I see you applied "dma-pool: Do not allocate pool memory from CMA" on your
tree. Do you want me to send a v2 of this patch taking that into account
targeting v5.9? or you'd rather just follow another approach?

Regards,
Nicolas

>=20
> [1] https://lkml.org/lkml/2020/7/8/1108
>=20
>  kernel/dma/pool.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..ccf3eeb77e00 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2012 ARM Ltd.
>   * Copyright (C) 2020 Google LLC
>   */
> +#include <linux/cma.h>
>  #include <linux/debugfs.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dma-noncoherent.h>
> @@ -56,6 +57,39 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t
> size)
>  		pool_size_kernel +=3D size;
>  }
> =20
> +static bool cma_in_zone(gfp_t gfp)
> +{
> +	u64 zone_dma_end, zone_dma32_end;
> +	phys_addr_t base, end;
> +	unsigned long size;
> +	struct cma *cma;
> +
> +	cma =3D dev_get_cma_area(NULL);
> +	if (!cma)
> +		return false;
> +
> +	size =3D cma_get_size(cma);
> +	if (!size)
> +		return false;
> +	base =3D cma_get_base(cma) - memblock_start_of_DRAM();
> +	end =3D base + size - 1;
> +
> +	zone_dma_end =3D IS_ENABLED(CONFIG_ZONE_DMA) ? DMA_BIT_MASK(zone_dma_bi=
ts)
> : 0;
> +	zone_dma32_end =3D IS_ENABLED(CONFIG_ZONE_DMA32) ? DMA_BIT_MASK(32) : 0=
;
> +
> +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp & GFP_DMA &&
> +	   end <=3D zone_dma_end)
> +		return true;
> +	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp & GFP_DMA32 &&
> +		base > zone_dma_end && end <=3D zone_dma32_end)
> +		return true;
> +	else if (base > zone_dma32_end)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  			      gfp_t gfp)
>  {
> @@ -70,7 +104,7 @@ static int atomic_pool_expand(struct gen_pool *pool, s=
ize_t
> pool_size,
>  	do {
>  		pool_size =3D 1 << (PAGE_SHIFT + order);
> =20
> -		if (dev_get_cma_area(NULL))
> +		if (cma_in_zone(gfp))
>  			page =3D dma_alloc_from_contiguous(NULL, 1 << order,
>  							 order, false);
>  		else


--=-i8vqeUqMtzSmwKfBb2jT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8QiQ4ACgkQlfZmHno8
x/5J8wgAgtnoi3awUaaAoJDZ3SxyOCK0RAeATzl/PIyFmwFPHIHmHND7mUjdEKDZ
hAJC5gVoRZfflUHUgQ0VhccWa6KoL0Jkf74PiS0h+JRjsHkLWeGCAsJs8532sRrR
4bHjmyDRi3YtQZu8zpTp9iYbICXN5N9ekA4HyvRo/rTTfbq8THwLsLqtcgfO+uL8
MMDa6Nsh8Y5KyVWJQCo5/giHR3KEqrN2tHkFi3iBwK+7NQxUzKEOaVl5EHXbmf3T
rO2MP6cfi0sIz/r3H1Kuni2ntDI4PP4lGVF45H3WSmTntUVOx8/bqV6FtAV0QhqB
Coam+hyQ0aB/eHvPHwUFJw/fsOQ2KA==
=iOG2
-----END PGP SIGNATURE-----

--=-i8vqeUqMtzSmwKfBb2jT--


--===============5650605971811693317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5650605971811693317==--

