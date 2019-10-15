Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D8BECE58F
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:07:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D2A21925
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D2A21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9634FC9E;
	Tue, 15 Oct 2019 13:07:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D392C6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C49A96D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:07:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id D5344B300;
	Tue, 15 Oct 2019 13:07:12 +0000 (UTC)
Message-ID: <d57feba7e3956136a5d77cebbbf2807c2950d6df.camel@suse.de>
Subject: Re: [PATCH RFC 4/5] dma/direct: check for overflows in ARM's
	dma_capable()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Date: Tue, 15 Oct 2019 15:07:08 +0200
In-Reply-To: <20191015102346.GA9071@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
	<20191014183108.24804-5-nsaenzjulienne@suse.de>
	<20191015102346.GA9071@infradead.org>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	iommu@lists.linux-foundation.org, mbrugger@suse.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============0698683551521385658=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============0698683551521385658==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-QilbOjg9rL1IFStaY+t4"


--=-QilbOjg9rL1IFStaY+t4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 03:23 -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2019 at 08:31:06PM +0200, Nicolas Saenz Julienne wrote:
> > The Raspberry Pi 4 has a 1GB ZONE_DMA area starting at address
> > 0x00000000 and a mapping between physical and DMA memory offset by
> > 0xc0000000.  It transpires that, on non LPAE systems, any attempt to
> > translate physical addresses outside of ZONE_DMA will result in an
> > overflow. The resulting DMA addresses will not be detected by arm's
> > dma_capable() as they still fit in the device's DMA mask.
> >=20
> > Fix this by failing to validate a DMA address smaller than the lowest
> > possible DMA address.
>=20
> I think the main problem here is that arm doesn't respect the
> bus_dma_mask.  If you replace the arm version of dma_capable with
> the generic one, does that fi the issue for you as well?

Yeah, that was my fist thought too, but it doesn't help.

So with RPi4's DMA mapping:

soc {
	dma-ranges =3D <0xc0000000  0x0 0x00000000  0x3c000000>;
	[...]
};

You'll get a 32bit bus dma map (log2i(0xc0000000 + 0x3c000000) + 1 =3D 32).

Trouble is, taking into account arm's multi_v7_defconfig uses 32bit address=
es,
most phys_to_dma() translations are likely to overflow. For example phys
0x60000000 will be translated to DMA 0x20000000, which is no good.

No mask is going to catch this, and both dma_capable() implementations will
fail.

> We need to untangle the various macros arm uses for the direct mapping
> and eventually we should be able to use the linux/dma-direct.h helpers
> directly.  Here is a branch with some simple preps I had.  Freshly
> rebased, not actually tested:
>=20
>=20
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-generic=
-dma-preps

Noted, looks good to me.

Actually, an alternative to this patch would be to kill all custom
dma_capable() implementations, which are mostly redundant, and add these ex=
tra
checks conditional to the DMA address size in the generic version. I'll try=
 to
respin this if I manage to understand what's going on with x86/sta211-fixup=
.c.


--=-QilbOjg9rL1IFStaY+t4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2lxHwACgkQlfZmHno8
x/5Qcgf9EYUZQRbilIK5s8eKqWcMhlpK7Df2P6SPXLkx+Vmkt2iYDyTfPLwB0Avl
I9aSjwDP/vRSkR7DgiKGQkh2PtdHWFDUoCerdQnJb69v+DiObndKo5Zd0XCtbYx+
+gPtyf43YhEGosmXi6aTI7pEh7HBYqu8ORrFJrdWaff3K5LJ8p4Phkkckup0NjHH
Ddq96VamoZdnKmA171GZ6HNgUdYn8cOjUBA5DLOWK5LAX2rAd1g6bNCgs/GcUL4l
sjoBu3utxJ9O9oe5reVU2XYfmX65xZqHqd1KkwN51Qo/w483+Hn0eSEclTVqT3hm
8tkxAlJWOPwPdLB8706dF6mwsGp2Lw==
=CUJl
-----END PGP SIGNATURE-----

--=-QilbOjg9rL1IFStaY+t4--


--===============0698683551521385658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0698683551521385658==--

