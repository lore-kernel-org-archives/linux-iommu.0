Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE1C43457
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 08:38:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C612087D
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 08:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C612087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF935876A6;
	Fri,  9 Oct 2020 08:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oplgdEtgSXzL; Fri,  9 Oct 2020 08:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D0588876A5;
	Fri,  9 Oct 2020 08:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA72C016F;
	Fri,  9 Oct 2020 08:37:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7096CC0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 08:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5F21D86FB4
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 08:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0kpmFZeW5oU for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 08:37:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5947786FAE
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 08:37:55 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9052AC7D;
 Fri,  9 Oct 2020 08:37:53 +0000 (UTC)
Message-ID: <e5e724bc6f07c766f1f4188729d0b757dea363f3.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Jeremy Linton <jeremy.linton@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Date: Fri, 09 Oct 2020 10:37:50 +0200
In-Reply-To: <978e01a1-71e6-7286-0876-bb10698ba1d2@arm.com>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201008101353.GE7661@gaia>
 <CAMj1kXFDEdEJ_eaB=jb1m=tKBpVdskrC0fW67NvGNZFS5PVL=Q@mail.gmail.com>
 <978e01a1-71e6-7286-0876-bb10698ba1d2@arm.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============4712314440847149983=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4712314440847149983==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-QEUs6mNIatkWXfPNUc5q"


--=-QEUs6mNIatkWXfPNUc5q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy.

On Thu, 2020-10-08 at 22:59 -0500, Jeremy Linton wrote:
> On 10/8/20 2:43 PM, Ard Biesheuvel wrote:
> > (+ Lorenzo)
> >=20
> > On Thu, 8 Oct 2020 at 12:14, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
> > > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > On Fri, 2020-10-02 at 12:55 +0100, Catalin Marinas wrote:
> > > > > On Thu, Oct 01, 2020 at 07:31:19PM +0200, Nicolas Saenz Julienne =
wrote:
> > > > > > On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
> > > > > > > On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wro=
te:
> > > > > > > > On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Jul=
ienne wrote:
> > > > > > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > > > > > index 4602e467ca8b..cd0d115ef329 100644
> > > > > > > > > --- a/drivers/of/fdt.c
> > > > > > > > > +++ b/drivers/of/fdt.c
> > > > > > > > > @@ -25,6 +25,7 @@
> > > > > > > > >   #include <linux/serial_core.h>
> > > > > > > > >   #include <linux/sysfs.h>
> > > > > > > > >   #include <linux/random.h>
> > > > > > > > > +#include <linux/dma-direct.h>      /* for zone_dma_bits =
*/
> > > > > > > > >=20
> > > > > > > > >   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > > > > > > >   #include <asm/page.h>
> > > > > > > > > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nod=
es(void)
> > > > > > > > >      of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > > > > > > >   }
> > > > > > > > >=20
> > > > > > > > > +void __init early_init_dt_update_zone_dma_bits(void)
> > > > > > > > > +{
> > > > > > > > > +   unsigned long dt_root =3D of_get_flat_dt_root();
> > > > > > > > > +
> > > > > > > > > +   if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711")=
)
> > > > > > > > > +           zone_dma_bits =3D 30;
> > > > > > > > > +}
> > > > > > > >=20
> > > > > > > > I think we could keep this entirely in the arm64 setup_mach=
ine_fdt() and
> > > > > > > > not pollute the core code with RPi4-specific code.
> > > > > > >=20
> > > > > > > Actually, even better, could we not move the check to
> > > > > > > arm64_memblock_init() when we initialise zone_dma_bits?
> > > > > >=20
> > > > > > I did it this way as I vaguely remembered Rob saying he wanted =
to centralise
> > > > > > all early boot fdt code in one place. But I'll be happy to move=
 it there.
> > > > >=20
> > > > > I can see Rob replied and I'm fine if that's his preference. Howe=
ver,
> > > > > what I don't particularly like is that in the arm64 code, if
> > > > > zone_dma_bits =3D=3D 24, we set it to 32 assuming that it wasn't =
touched by
> > > > > the early_init_dt_update_zone_dma_bits(). What if at some point w=
e'll
> > > > > get a platform that actually needs 24 here (I truly hope not, but=
 just
> > > > > the principle of relying on magic values)?
> > > > >=20
> > > > > So rather than guessing, I'd prefer if the arch code can override
> > > > > ZONE_DMA_BITS_DEFAULT. Then, in arm64, we'll just set it to 32 an=
d no
> > > > > need to explicitly touch the zone_dma_bits variable.
> > > >=20
> > > > Yes, sonds like the way to go. TBH I wasn't happy with that solutio=
n either,
> > > > but couldn't think of a nicer alternative.
> > > >=20
> > > > Sadly I just realised that the series is incomplete, we have RPi4 u=
sers that
> > > > want to boot unsing ACPI, and this series would break things for th=
em. I'll
> > > > have a word with them to see what we can do for their use-case.
> > >=20
> > > Is there a way to get some SoC information from ACPI?
> > >=20
> >=20
> > This is unfortunate. We used ACPI _DMA methods as they were designed
> > to communicate the DMA limit of the XHCI controller to the OS.
> >=20
> > It shouldn't be too hard to match the OEM id field in the DSDT, and
> > switch to the smaller mask. But it sucks to have to add a quirk like
> > that.
> > It also requires delaying setting the arm64_dma_phy_limit a bit, but=
=20
> that doesn't appear to be causing a problem. I've been boot/compiling=20
> with a patch like:
>=20
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index cada0b816c8a..9dfe776c1c75 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -14,6 +14,7 @@
>=20
>   #include <linux/acpi.h>
>   #include <linux/cpumask.h>
> +#include <linux/dma-direct.h>
>   #include <linux/efi.h>
>   #include <linux/efi-bgrt.h>
>   #include <linux/init.h>
> @@ -168,6 +169,11 @@ static int __init acpi_fadt_sanity_check(void)
>                  ret =3D -EINVAL;
>          }
>=20
> +       if (!strncmp(table->oem_id, "RPIFDN", ACPI_OEM_ID_SIZE) &&
> +           !strncmp(table->oem_table_id,  "RPI4    ",=20
> ACPI_OEM_TABLE_ID_SIZE) &&
> +           table->oem_revision <=3D 0x200)  {
> +               zone_dma_bits =3D 30;
> +       }
>   out:
>          /*
>           * acpi_get_table() creates FADT table mapping that
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index cd5caca8a929..6c8aaf1570ce 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -195,6 +195,7 @@ static void __init zone_sizes_init(unsigned long=20
> min, unsigned long max)
>          unsigned long max_zone_pfns[MAX_NR_ZONES]  =3D {0};
>=20
>   #ifdef CONFIG_ZONE_DMA
> +       arm64_dma_phys_limit =3D max_zone_phys(zone_dma_bits);
>          max_zone_pfns[ZONE_DMA] =3D PFN_DOWN(arm64_dma_phys_limit);
>   #endif
>   #ifdef CONFIG_ZONE_DMA32
> @@ -393,7 +394,6 @@ void __init arm64_memblock_init(void)
>                   */
>                  if (zone_dma_bits =3D=3D ZONE_DMA_BITS_DEFAULT)
>                          zone_dma_bits =3D 32;
> -               arm64_dma_phys_limit =3D max_zone_phys(zone_dma_bits);
>          }
>=20
>          if (IS_ENABLED(CONFIG_ZONE_DMA32))
>=20
>=20

Thanks for taking the time to look at this!

Regards,
Nicolas


--=-QEUs6mNIatkWXfPNUc5q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+AIV4ACgkQlfZmHno8
x/47xwf/S14oxsPutK80WqAd6TtLMvOUoTUdYaejvsvKz0m5rogBFI3AE8s1LRj5
HtFyy0/t9JlCUlCPqw1p2kx9+Tw/LmrV74OAthLKSnQGhRyDDXXZn4F9qbJp+Bcu
oE+SrvsCaWt+pgyw9H/YjbrKPEah4iV4F86/e8IG2HdevcaB9xNAZ9ymJ9O/mFKK
V4n7FhhWKgfsYZFjiQFQUiGB5iMK2Kwc9W1GiDhYwaorD76GJft3Xh3FsLk1jLrV
DE4OoChhGo48Z98Jmjs2dw9ee4KdyBm10KnTqHbCYwBJReROTuHF6v8JYxT88Msx
ObWZ1Ng0jXl3r4hp4ze8FTlqln/R+w==
=PDNU
-----END PGP SIGNATURE-----

--=-QEUs6mNIatkWXfPNUc5q--


--===============4712314440847149983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4712314440847149983==--

