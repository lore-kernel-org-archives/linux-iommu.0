Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97730C433DF
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 13:33:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D37E22277
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 13:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D37E22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 70468203E9;
	Fri,  9 Oct 2020 13:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5DtsS4a5to8j; Fri,  9 Oct 2020 13:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5398820355;
	Fri,  9 Oct 2020 13:33:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 347EAC07FF;
	Fri,  9 Oct 2020 13:33:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8346FC0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 717478770D
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QmU4r08ledtU for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 13:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DAC4D87707
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:33:49 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E5225AC3F;
 Fri,  9 Oct 2020 13:33:47 +0000 (UTC)
Message-ID: <7b030a00d866f869acb4dea729df5fc93d561558.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 09 Oct 2020 15:33:46 +0200
In-Reply-To: <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
 <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: multipart/mixed; boundary="===============3339382150100124547=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3339382150100124547==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-QKDQqezONyqKzfC6bWKQ"


--=-QKDQqezONyqKzfC6bWKQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-09 at 11:13 +0200, Ard Biesheuvel wrote:
> On Fri, 9 Oct 2020 at 10:36, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Fri, 2020-10-09 at 09:37 +0200, Ard Biesheuvel wrote:
> > > On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
> > > > On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > Sadly I just realised that the series is incomplete, we have RPi4=
 users that
> > > > > want to boot unsing ACPI, and this series would break things for =
them. I'll
> > > > > have a word with them to see what we can do for their use-case.
> > > >=20
> > > > Stupid question:  why do these users insist on a totally unsuitable
> > > > interface? And why would we as Linux developers care to support suc=
h
> > > > a aims?
> > >=20
> > > The point is really whether we want to revert changes in Linux that
> > > made both DT and ACPI boot work without quirks on RPi4.
> >=20
> > Well, and broke a big amount of devices that were otherwise fine.
> >=20
>=20
> Yeah that was unfortunate.
>=20
> > > Having to check the RPi4 compatible string or OEM id in core init cod=
e is
> > > awful, regardless of whether you boot via ACPI or via DT.
> > >=20
> > > The problem with this hardware is that it uses a DMA mask which is
> > > narrower than 32, and the arm64 kernel is simply not set up to deal
> > > with that at all. On DT, we have DMA ranges properties and the likes
> > > to describe such limitations, on ACPI we have _DMA methods as well as
> > > DMA range attributes in the IORT, both of which are now handled
> > > correctly. So all the information is there, we just have to figure ou=
t
> > > how to consume it early on.
> >=20
> > Is it worth the effort just for a single board? I don't know about ACPI=
 but
> > parsing dma-ranges that early at boot time is not trivial. My intuition=
 tells
> > me that it'd be even harder for ACPI, being a more complex data structu=
re.
> >=20
>=20
> Yes, it will be harder, especially for the _DMA methods.
>=20
> > > Interestingly, this limitation always existed in the SoC, but it
> > > wasn't until they started shipping it with more than 1 GB of DRAM tha=
t
> > > it became a problem. This means issues like this could resurface in
> > > the future with existing SoCs when they get shipped with more memory,
> > > and so I would prefer fixing this in a generic way.
> >=20
> > Actually what I proposed here is pretty generic. Specially from arm64's
> > perspective. We call early_init_dt_scan(), which sets up zone_dma_bits =
based on
> > whatever it finds in DT. Both those operations are architecture indepen=
dent.
> > arm64 arch code doesn't care about the logic involved in ascertaining
> > zone_dma_bits. I get that the last step isn't generic. But it's all set=
up so as
> > to make it as such whenever it's worth the effort.
> >=20
>=20
> The problem is that, while we are providing a full description of the
> SoC's capabilities, we short circuit this by inserting knowledge into
> the code (that is shared between all DT architectures) that
> "brcm,bcm2711" is special, and needs a DMA zone override.

Yes I understand this and I sympathize with it, not the most beautiful thin=
g
out there :). But that's only half the issue, as I said, implementing this
early at boot time is a tangible amount of work and a burden to maintain ju=
st
for one board. So this is the compromise we discussed with the DT maintaine=
r
(RobH). The series sets things up so as to be able to implement the right
thing transparently to arm64's architecture when deemed worth the effort.

Ultimately, if you're worried about inserting knowledge into the code, aren=
't
we doing that, in a more extreme way, when imposing an extra unwarranted zo=
ne
to the whole arm64 ecosystem?

Note that I'm more that happy to work on alternative solutions, but let's f=
irst
settle on what would be acceptable to everyone.

> I think for ACPI boot, we might be able to work around this by cold
> plugging the memory above 1 GB, but I have to double check whether it
> won't get pulled into ZONE_DMA32 anyway (unless anyone can answer that
> for me here from the top of their head)

Don't know much about what ACPI memory cold plugging involves, but we'll st=
ill
need a proper ZONE_DMA32 (i.e. spanning the whole 32-bit address space) for
RPi4.

Regards,
Nicolas


--=-QKDQqezONyqKzfC6bWKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+AZroACgkQlfZmHno8
x/5PlQf+P8QLXrJShl8jG/06exIg90GTMkjn9WMCdvUp6fq+rQCD/XEZW+RmqybB
4hu4TrASI2evkAQUhOw3BuyxEblsrWJrM7ySV9t2bOIAQ+XP4/UVVDg+PP4z310h
QCVHOSyB9OeKVgPMyrm16+Eb8C+cpHIP29TCjTbP/0hiJEWkIzrJE+h+9Vl/JNMs
WBQmbxIzUZK8GlivpqbkbHXaPyo2Fa+Yf4NB/JJB11nRwLrFsA2Ka6yyu0ZVp/CF
gZ2nu1pm9P4DVwpaTrqEdB7g4ghRjHjWH7qxYNLQPm98gB0LZjHrZSXm4sL3pBt3
ZOjgS3QZ6gYgCZIwChD3fk/qcqtRXw==
=tHjf
-----END PGP SIGNATURE-----

--=-QKDQqezONyqKzfC6bWKQ--


--===============3339382150100124547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3339382150100124547==--

