Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B9C433E1
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155472070B
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155472070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C057D204B1;
	Mon, 27 Jul 2020 17:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Q4ACsERMwwY; Mon, 27 Jul 2020 17:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B98481FF98;
	Mon, 27 Jul 2020 17:57:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B52FC0050;
	Mon, 27 Jul 2020 17:57:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 589D8C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 17:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B45D20008
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 17:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RtGMZfdZfzNE for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 17:57:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id D93311FF98
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 17:57:00 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 08CABABE9;
 Mon, 27 Jul 2020 17:57:09 +0000 (UTC)
Message-ID: <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>, Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 27 Jul 2020 19:56:56 +0200
In-Reply-To: <20200724134114.GA3152@lst.de>
References: <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
 <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
 <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
 <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
 <20200724134114.GA3152@lst.de>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>
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
Content-Type: multipart/mixed; boundary="===============7155787206931749180=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7155787206931749180==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-qFFwwRyYdW0g8uHUD6n0"


--=-qFFwwRyYdW0g8uHUD6n0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,
thanks for having a look at this!

On Fri, 2020-07-24 at 15:41 +0200, Christoph Hellwig wrote:
> Yes, the iommu is an interesting case, and the current code is
> wrong for that.

Care to expand on this? I do get that checking dma_coherent_ok() on memory
that'll later on be mapped into an iommu is kind of silly, although I think
harmless in Amir's specific case, since devices have wide enough dma-ranges=
. Is
there more to it?

> Can you try the patch below?  It contains a modified version of Nicolas'
> patch to try CMA again for the expansion and a new (for now hackish) way =
to
> not apply the addressability check for dma-iommu allocations.
>=20
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 6bc74a2d51273e..ec5e525d2b9309 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2012 ARM Ltd.
>   * Copyright (C) 2020 Google LLC
>   */
> +#include <linux/cma.h>
>  #include <linux/debugfs.h>
> +#include <linux/dma-contiguous.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/init.h>
> @@ -55,6 +57,31 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t
> size)
>  		pool_size_kernel +=3D size;
>  }
> =20
> +static bool cma_in_zone(gfp_t gfp)
> +{
> +	phys_addr_t end;
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
> +	end =3D cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
> +
> +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA) &&
> +	    end <=3D DMA_BIT_MASK(zone_dma_bits))
> +		return true;
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) &&
> +	    end <=3D DMA_BIT_MASK(32))
> +		return true;
> +	return true;

IIUC this will always return true given a CMA is present. Which reverts to =
the
previous behaviour (previous as in breaking some rpi4 setups), isn't it?

Regards,
Nicolas


--=-qFFwwRyYdW0g8uHUD6n0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8fFWgACgkQlfZmHno8
x/6obgf+LDzEyQY0PPgnBX0Bop85cj9nPiNdylLhZ6He/5cLrZMAcWtA69qcst1i
PQdp5ThWKd7Gd0mlmg+B9MdxgehKMf0q517j0pb4pBBxx96D4Hg/QjGSOfGeHLVe
9oaxYdxDf+xKTIn5v8myvHyQIHPYF8pkcVHp1M5b+q/Q9CUXpWB7wVQWM0vlcCIt
+HgRuyEzktxngXkRZsYCxmtEMEGGUri5klRs7O+M6Vbn+tlRHtYmjCFOEzmlXS9W
+bph7Ekf1b448fF2q5P7Xu5fhE7CYN8k8nr63AcVXVaLR/DsJ5GxjWFGKNye5/21
91Uk2Go4FCB6IrjoB9vmp5/TowXkOQ==
=D8U2
-----END PGP SIGNATURE-----

--=-qFFwwRyYdW0g8uHUD6n0--


--===============7155787206931749180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7155787206931749180==--

