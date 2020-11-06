Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E0C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:46:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC1D206C1
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC1D206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F16B98694A;
	Fri,  6 Nov 2020 18:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GlhAaszFGzMe; Fri,  6 Nov 2020 18:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87F5886964;
	Fri,  6 Nov 2020 18:46:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 748A6C0893;
	Fri,  6 Nov 2020 18:46:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBC83C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C955A86964
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TJBsQrrp_nyb for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:46:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CCD4F8694A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:46:33 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B18D4AD52;
 Fri,  6 Nov 2020 18:46:31 +0000 (UTC)
Message-ID: <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: James Morse <james.morse@arm.com>
Date: Fri, 06 Nov 2020 19:46:29 +0100
In-Reply-To: <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com, will@kernel.org,
 hch@lst.de, linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============2989364331775433495=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2989364331775433495==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-TnJp0vXFQpxxgYpSGy1Q"


--=-TnJp0vXFQpxxgYpSGy1Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, thanks for the review. Some comments/questions below.

On Thu, 2020-11-05 at 16:11 +0000, James Morse wrote:
> Hi!
>=20
> On 03/11/2020 17:31, Nicolas Saenz Julienne wrote:
> > crashkernel might reserve memory located in ZONE_DMA. We plan to delay
> > ZONE_DMA's initialization after unflattening the devicetree and ACPI's
> > boot table initialization, so move it later in the boot process.
> > Specifically into mem_init(), this is the last place crashkernel will b=
e
> > able to reserve the memory before the page allocator kicks in.
> > There
> > isn't any apparent reason for doing this earlier.
>=20
> It's so that map_mem() can carve it out of the linear/direct map.
> This is so that stray writes from a crashing kernel can't accidentally co=
rrupt the kdump
> kernel. We depend on this if we continue with kdump, but failed to offlin=
e all the other
> CPUs.

I presume here you refer to arch_kexec_protect_crashkres(), IIUC this will =
only
happen further down the line, after having loaded the kdump kernel image. B=
ut
it also depends on the mappings to be PAGE sized (flags =3D=3D NO_BLOCK_MAP=
PINGS |
NO_CONT_MAPPINGS).

> We also depend on this when skipping the checksum code in purgatory, whic=
h can be
> exceedingly slow.

This one I don't fully understand, so I'll lazily assume the prerequisite i=
s
the same WRT how memory is mapped. :)

Ultimately there's also /sys/kernel/kexec_crash_size's handling. Same
prerequisite.

Keeping in mind acpi_table_upgrade() and unflatten_device_tree() depend on
having the linear mappings available. I don't see any simple way of solving
this. Both moving the firmware description routines to use fixmap or correc=
ting
the linear mapping further down the line so as to include kdump's regions, =
seem
excessive/impossible (feel free to correct me here). I'd be happy to hear
suggestions. Otherwise we're back to hard-coding the information as we
initially did.

Let me stress that knowing the DMA constraints in the system before reservi=
ng
crashkernel's regions is necessary if we ever want it to work seamlessly on=
 all
platforms. Be it small stuff like the Raspberry Pi or huge servers with TB =
of
memory.

Regards,
Nicolas


--=-TnJp0vXFQpxxgYpSGy1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+lmgUACgkQlfZmHno8
x/5+dgf+Pf8JjmucAPuXan1nTGcvtuILsP3sC+cq8tqi84bsKFRFACqHN5J2rXwK
ZzRX2RyPQDWT3O3Fbp7i/wYt2XDie598NvbIozdZ6ojULPL1FEUwn/6f2Eb2uuPE
bMSfZt/hTSa7wEESYeNV2gLjAb/bsA7Y4kxy8sDrTIJl44vJLbcdbE1MGX7wyBSi
YtNOajCrqpvkiXofu5+d6TFJLGALl27t2uLIuBMZU9OK5bkS7As75nsyPnRjwtQp
cwLHdyNtpgY1PJ2Za6gJyvyykaz8RAlgWbxeAANcdn6lGtVgDEcwVs/d25skS2k3
KY4U5Ag5+Nextbi5cic+Ep4C2Pfb3A==
=8Wzl
-----END PGP SIGNATURE-----

--=-TnJp0vXFQpxxgYpSGy1Q--


--===============2989364331775433495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2989364331775433495==--

