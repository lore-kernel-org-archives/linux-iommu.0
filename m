Return-Path: <SRS0=Q5Oi=DP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B2C43467
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 10:05:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208B621527
	for <iommu@archiver.kernel.org>; Thu,  8 Oct 2020 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208B621527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D82B86BBB;
	Thu,  8 Oct 2020 10:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PiBsw_6LfvL; Thu,  8 Oct 2020 10:05:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9503F86BCF;
	Thu,  8 Oct 2020 10:05:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF6AC0051;
	Thu,  8 Oct 2020 10:05:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E6F6C016F
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 10:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6E8A42E13B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 10:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-M0MgjIRQ-W for <iommu@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 10:05:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 9AFF820354
 for <iommu@lists.linux-foundation.org>; Thu,  8 Oct 2020 10:05:28 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 983DBAD20;
 Thu,  8 Oct 2020 10:05:26 +0000 (UTC)
Message-ID: <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 08 Oct 2020 12:05:25 +0200
In-Reply-To: <20201002115541.GC7034@gaia>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, will@kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============8692838906654452947=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8692838906654452947==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-UgRFrRCNh36xLg4FQaLM"


--=-UgRFrRCNh36xLg4FQaLM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, sorry for the late reply.

On Fri, 2020-10-02 at 12:55 +0100, Catalin Marinas wrote:
> On Thu, Oct 01, 2020 at 07:31:19PM +0200, Nicolas Saenz Julienne wrote:
> > On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
> > > On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
> > > > On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > index 4602e467ca8b..cd0d115ef329 100644
> > > > > --- a/drivers/of/fdt.c
> > > > > +++ b/drivers/of/fdt.c
> > > > > @@ -25,6 +25,7 @@
> > > > >  #include <linux/serial_core.h>
> > > > >  #include <linux/sysfs.h>
> > > > >  #include <linux/random.h>
> > > > > +#include <linux/dma-direct.h>	/* for zone_dma_bits */
> > > > > =20
> > > > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > > >  #include <asm/page.h>
> > > > > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
> > > > >  	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > > >  }
> > > > > =20
> > > > > +void __init early_init_dt_update_zone_dma_bits(void)
> > > > > +{
> > > > > +	unsigned long dt_root =3D of_get_flat_dt_root();
> > > > > +
> > > > > +	if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
> > > > > +		zone_dma_bits =3D 30;
> > > > > +}
> > > >=20
> > > > I think we could keep this entirely in the arm64 setup_machine_fdt(=
) and
> > > > not pollute the core code with RPi4-specific code.
> > >=20
> > > Actually, even better, could we not move the check to
> > > arm64_memblock_init() when we initialise zone_dma_bits?
> >=20
> > I did it this way as I vaguely remembered Rob saying he wanted to centr=
alise
> > all early boot fdt code in one place. But I'll be happy to move it ther=
e.
>=20
> I can see Rob replied and I'm fine if that's his preference. However,
> what I don't particularly like is that in the arm64 code, if
> zone_dma_bits =3D=3D 24, we set it to 32 assuming that it wasn't touched =
by
> the early_init_dt_update_zone_dma_bits(). What if at some point we'll
> get a platform that actually needs 24 here (I truly hope not, but just
> the principle of relying on magic values)?
>=20
> So rather than guessing, I'd prefer if the arch code can override
> ZONE_DMA_BITS_DEFAULT. Then, in arm64, we'll just set it to 32 and no
> need to explicitly touch the zone_dma_bits variable.

Yes, sonds like the way to go. TBH I wasn't happy with that solution either=
,
but couldn't think of a nicer alternative.

Sadly I just realised that the series is incomplete, we have RPi4 users tha=
t
want to boot unsing ACPI, and this series would break things for them. I'll
have a word with them to see what we can do for their use-case.

Regards,
Nicolas


--=-UgRFrRCNh36xLg4FQaLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9+5GUACgkQlfZmHno8
x/6e8wf9EJ0i1Wi9BCOQEMRii/Avn31umkWy/c6brw125hfV8Jcwwn6RlD9oTrD6
57UaLxdLJjFjZcCHmPhOG7zcMwfsP/Ft5hmeS6ECAgOl3bL6jDRpnrQ80+gEO3U2
rJ0sgrVHJp+ZC0Yf1HedSnj0EpgjbQFc3iPJHEW19XVLbZ61cu8keEKDZevaHONm
BssWhdVqPaNW8Z9LuT04V4y+JXxLCjflB88QQD+UA5BbdLLRPn2DGZKErUwyyF8O
U68UbaCmHEPIddLXLdHde657lQS0pT99yCJzyGA8S9k3XbNLcPK304WYZj1Qib8Z
DI2imsq4V1HT3TAyebIj++LJgx/Uyg==
=Sv3m
-----END PGP SIGNATURE-----

--=-UgRFrRCNh36xLg4FQaLM--


--===============8692838906654452947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8692838906654452947==--

