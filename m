Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29059C43467
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 08:36:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A607022269
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 08:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A607022269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06DDA876AB;
	Fri,  9 Oct 2020 08:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUyUEf8fD04P; Fri,  9 Oct 2020 08:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50FCC876A5;
	Fri,  9 Oct 2020 08:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44CE6C016F;
	Fri,  9 Oct 2020 08:36:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56117C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 08:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 447BC876DB
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 08:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYLwjiQHnDug for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 08:36:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 34F5F876D9
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 08:36:08 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2F7D6AC7D;
 Fri,  9 Oct 2020 08:36:06 +0000 (UTC)
Message-ID: <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>, Christoph Hellwig <hch@lst.de>
Date: Fri, 09 Oct 2020 10:36:02 +0200
In-Reply-To: <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============9182917798340194995=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============9182917798340194995==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-HZps7YTW5opz4O9P41Ik"


--=-HZps7YTW5opz4O9P41Ik
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > > Sadly I just realised that the series is incomplete, we have RPi4 use=
rs that
> > > want to boot unsing ACPI, and this series would break things for them=
. I'll
> > > have a word with them to see what we can do for their use-case.
> >=20
> > Stupid question:  why do these users insist on a totally unsuitable
> > interface? And why would we as Linux developers care to support such
> > a aims?
>
> The point is really whether we want to revert changes in Linux that
> made both DT and ACPI boot work without quirks on RPi4.

Well, and broke a big amount of devices that were otherwise fine.

> Having to check the RPi4 compatible string or OEM id in core init code is
> awful, regardless of whether you boot via ACPI or via DT.
>
> The problem with this hardware is that it uses a DMA mask which is
> narrower than 32, and the arm64 kernel is simply not set up to deal
> with that at all. On DT, we have DMA ranges properties and the likes
> to describe such limitations, on ACPI we have _DMA methods as well as
> DMA range attributes in the IORT, both of which are now handled
> correctly. So all the information is there, we just have to figure out
> how to consume it early on.

Is it worth the effort just for a single board? I don't know about ACPI but
parsing dma-ranges that early at boot time is not trivial. My intuition tel=
ls
me that it'd be even harder for ACPI, being a more complex data structure.

> Interestingly, this limitation always existed in the SoC, but it
> wasn't until they started shipping it with more than 1 GB of DRAM that
> it became a problem. This means issues like this could resurface in
> the future with existing SoCs when they get shipped with more memory,
> and so I would prefer fixing this in a generic way.

Actually what I proposed here is pretty generic. Specially from arm64's
perspective. We call early_init_dt_scan(), which sets up zone_dma_bits base=
d on
whatever it finds in DT. Both those operations are architecture independent=
.
arm64 arch code doesn't care about the logic involved in ascertaining
zone_dma_bits. I get that the last step isn't generic. But it's all setup s=
o as
to make it as such whenever it's worth the effort.

> Also, I assume papering over the issue like this does not fix the
> kdump issue fundamentally, it just works around it, and so we might
> run into this again in the future.

Any ideas? The way I understand it the kdump issue is just a shortcoming of
the memory zones design.

Regards,
Nicolas


--=-HZps7YTW5opz4O9P41Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+AIPIACgkQlfZmHno8
x/7ixwgArMPUc2i51aFQ1Vewm9MoFEcZuXJtOXO+kufsCRa58yp7GAAVBhH6IBHb
QfxFIDcQrHnSeOcYjCYeFjT1fH8Hg0NusddHoN+1A0dcFJltSmn6We+abDhmHj8M
xtBmhNjGmlvNqZrJdhqqhvT421GIj0cSZZX9ZVfGmFVLb8ALsmRiNaNAzmhkitzI
QMcbZEoCn9M76MC+EsRI6pwpTQsXkuN3XWKqNE8hXVtqXQEBkGqZgZcc6I3OY4MX
mj6kolVLJ/mr785/1E/8qehLDT6J1lg/lH0G6GtMCBagDRfU4cKj/LXr8L/UXtIm
lRJY0eAY18TiA9o655u+JyGxXFqeuQ==
=shiA
-----END PGP SIGNATURE-----

--=-HZps7YTW5opz4O9P41Ik--


--===============9182917798340194995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9182917798340194995==--

