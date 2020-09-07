Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9D6C43461
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 18:20:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC9F20738
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 18:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC9F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E498C2263C;
	Mon,  7 Sep 2020 18:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B+GQsUT+cWdA; Mon,  7 Sep 2020 18:19:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0059020398;
	Mon,  7 Sep 2020 18:19:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7633C0052;
	Mon,  7 Sep 2020 18:19:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C32EC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 18:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A7B120410
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 18:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UpiDu7cLB7UQ for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 18:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 27B1A20398
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 18:19:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A61C2AD2F;
 Mon,  7 Sep 2020 18:19:52 +0000 (UTC)
Message-ID: <b4761ade39af346eebec917ca2a415c09681542a.camel@suse.de>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 07 Sep 2020 20:19:43 +0200
In-Reply-To: <CA+-6iNyJ3ey0zPKj9nh8uL3AwTBhJqgD01wc=7G4NF35NXmV1Q@mail.gmail.com>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
 <20200902215314.GA881878@ubuntu-n2-xlarge-x86>
 <CA+-6iNzc38OAL7TGxobpODKXOD1CW-VFNU0rK9Z043QfR3MfsQ@mail.gmail.com>
 <20200902223852.GA1786990@ubuntu-n2-xlarge-x86>
 <6922bc0b-1849-2f2f-ec2f-fe9f0124dcfc@gmail.com>
 <20200903005240.GA1118@Ryzen-9-3900X.localdomain>
 <CA+-6iNyv_sFJOxDi5OcYNWe=ovLnOnrZNsWFQk5b-bzQzA8T_Q@mail.gmail.com>
 <34aa0d6094e7d6fb3492d2cda0fec8ecc04790ed.camel@suse.de>
 <CA+-6iNyJ3ey0zPKj9nh8uL3AwTBhJqgD01wc=7G4NF35NXmV1Q@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI
 NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "open
 list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Frank Rowand <frowand.list@gmail.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND
 64-BIT" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 ACPI/arm64" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM
 ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============3300846597983374088=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3300846597983374088==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-CCYbyXut8xg9u3LxoqD9"


--=-CCYbyXut8xg9u3LxoqD9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-07 at 13:40 -0400, Jim Quinlan wrote:
> On Mon, Sep 7, 2020 at 11:01 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > >=20
> > > Hi Nicolas,
> > >=20
> > > Can you please help us out here?  It appears that your commit
> >=20
> > It's dma_offset_from_dma_addr() that's causing trouble. It goes over al=
l the
> > dma regions and, if no region matches the phys address range, it return=
s 0.
> > This isn't acceptable as is. In the past, we used to pass the offset
> > nonetheless, which would make the phys address grow out of the dma memo=
ry area
> > and fail the dma_capable() test.
> >=20
> > For example, RPi4 devices attached to the old interconnect see phys [0x=
0
> > 0x3fffffff] at [0xc0000000 0xffffffff]. So say you're trying to convert
> > physical address 0xfa000000, you'll get 0 from dma_offset_from_phys_add=
r()
> > (since your dma range only covers the first GB) to then test if 0xfa000=
000 is
> > dma_capable(), which it is, but for the wrong reasons. Causing DMA issu=
es
> > further down the line.
> >=20
> > I don't have a proper suggestion on how to solve this but here's the so=
lution I
> > used:
> >=20
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4c4646761afe..40fe3c97f2be 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -217,11 +217,19 @@ static inline u64 dma_offset_from_phys_addr(struc=
t device *dev,
> >  {
> >         const struct bus_dma_region *m =3D dev->dma_range_map;
> >=20
> > -       if (m)
> > +       if (m) {
> >                 for (; m->size; m++)
> >                         if (paddr >=3D m->cpu_start &&
> >                             paddr - m->cpu_start < m->size)
> >                                 return m->offset;
> > +
> > +               /*
> > +                * The physical address doesn't fit any of the DMA regi=
ons,
> > +                * return an impossible to fulfill offset.
> > +                */
> > +               return -(1ULL << 46);
> > +       }
> > +
> >         return 0;
> >  }
> Hi Nicolas,
>=20
> Thanks for looking into this.  The concern I have with your solution
> is that returning an arbitrarily large offset might overlap with an
> improbable but valid usage.  AFAIK there is nothing that disallows
> mapping a device to anywhere within the 64bit range of PCIe space,
> including up to say 0xffffffffffffffff.

Indeed, that's why I wasn't all that happy with my solution.

As an alternative, how about returning '-dev->bus_dma_limit' instead of 0? =
It's
always 0 for the devices without bus_dma_regions, and, I think, an always
unattainable offset for devices that do (I tested it on RPi4 with the 30bit
limitd mmc controller and it seems to work alright).

--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -222,7 +222,8 @@ static inline u64 dma_offset_from_phys_addr(struct devi=
ce *dev,
                        if (paddr >=3D m->cpu_start &&
                            paddr - m->cpu_start < m->size)
                                return m->offset;
-       return 0;
+
+       return -dev->bus_dma_limit;
 }

> As an alternative perhaps changing dma_capable() so that if the
> dma_range_map is present then it validates that both ends of the
> prospective DMA region get "hits" on one of the offset regions in the
> map.  Christoph, if you are okay with this I can quickly post a patch.

IIUC, by the time you enter dma_capable() you already converted the physica=
l
address to DMA address and the damage is done.

Regards,
Nicolas


--=-CCYbyXut8xg9u3LxoqD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9Web8ACgkQlfZmHno8
x/45Vwf4u5fnJDiKEs0mFEm6022UPGAILzSlkRbZK5tlG8tC70JI0n+grJc5zkc9
NV/xshHdLaJrcyZ03Dq+MpkS3vOQXcE9HaNyGtezeeY2dcOMKercmFB61drDGcLm
Igf60gx9lZXvEouCNIlMfA4fxSABbxHFEnu6n3zxMvPUutKzu0eac7I5tPj6sX+y
4twi6cWPpfZjthY99DKO9ZRjB0G16zULuX+SyPhp3TczBlNsZ+Y5u6hMG513P643
ZE14+DNLgu0fHmruhv78bZ7aEBIh3jpnhUNjxQvVYPWDfY+KYr4gK3rQlhAiybpX
n9v72bBytwS+sV/EWzrcQ6vYFZft
=2g98
-----END PGP SIGNATURE-----

--=-CCYbyXut8xg9u3LxoqD9--


--===============3300846597983374088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3300846597983374088==--

