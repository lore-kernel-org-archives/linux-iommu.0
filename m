Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07CC3A5A6
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 09:44:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605042173E
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605042173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0B8152963;
	Wed, 28 Aug 2019 09:44:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3813A295A
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 09:44:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6181913A
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 09:44:18 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 7A77DAD26;
	Wed, 28 Aug 2019 09:44:16 +0000 (UTC)
Message-ID: <5271f3041cf16ec06a8266b0072f294384280f54.camel@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Wed, 28 Aug 2019 11:44:12 +0200
In-Reply-To: <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-2-nsaenzjulienne@suse.de>
	<20190826070939.GD11331@lst.de>
	<027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, eric@anholt.net, linux-riscv@lists.infradead.org,
	frowand.list@gmail.com, linux-arch@vger.kernel.org,
	f.fainelli@gmail.com, will@kernel.org,
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	marc.zyngier@arm.com, robh+dt@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
	mbrugger@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	wahrenst@gmx.net, akpm@linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============8590430986476221498=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============8590430986476221498==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-HuE7CYEmA0DlmwKJIinl"


--=-HuE7CYEmA0DlmwKJIinl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-26 at 15:46 +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2019-08-26 at 09:09 +0200, Christoph Hellwig wrote:
> > On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrote:
> > > Some architectures have platform specific DMA addressing limitations.
> > > This will allow for hardware description code to provide the constrai=
nts
> > > in a generic manner, so as for arch code to properly setup it's memor=
y
> > > zones and DMA mask.
> >=20
> > I know this just spreads the arm code, but I still kinda hate it.
>=20
> Rob's main concern was finding a way to pass the constraint from HW defin=
ition
> to arch without widening fdt's architecture specific function surface. I'=
d say
> it's fair to argue that having a generic mechanism makes sense as it'll n=
ow
> traverse multiple archs and subsystems.
>=20
> I get adding globals like this is not very appealing, yet I went with it =
as it
> was the easier to integrate with arm's code. Any alternative suggestions?
>=20
> > MAX_DMA_ADDRESS is such an oddly defined concepts.  We have the mm
> > code that uses it to start allocating after the dma zones, but
> > I think that would better be done using a function returning
> > 1 << max(zone_dma_bits, 32) or so.  Then we have about a handful
> > of drivers using it that all seem rather bogus, and one of which
> > I think are usable on arm64.
>=20
> Is it safe to assume DMA limitations will always be a power of 2? I ask a=
s
> RPi4
> kinda isn't: ZONE_DMA is 0x3c000000 bytes big, I'm approximating the zone=
 mask
> to 30 as [0x3c000000 0x3fffffff] isn't defined as memory so it's unlikely=
 that
> we=C2=B4ll encounter buffers there. But I don't know how it could affect =
mm
> initialization code.
>=20
> This also rules out 'zone_dma_bits' as a mechanism to pass ZONE_DMA's siz=
e
> from
> HW definition code to arch's.

Hi Christoph,
I gave it a thought and think this whole MAX_DMA_ADDRESS topic falls out of=
 the
scope of the series. I agree it's something that we should get rid of, but
fixing it isn't going to affect the overall enhancement intended here.  I'd
rather focus on how are we going to pass the DMA zone data into the arch co=
de
and fix MAX_DMA_ADDRESS on another series.

Regards,
Nicolas


--=-HuE7CYEmA0DlmwKJIinl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1mTOwACgkQlfZmHno8
x/5rEQf/a0hgCNBuEJW0dF6JOgmq1B1AUgrpu1lR5mCYvRYKaWrIH0GEWk7/DMYN
5P/0pfK8WcmvSuTsH3kAL9FVcqCF1fm+KHxDUfHg0WM4TbfF/SNx8nzM0thhMSGg
vcgA6AP1aXP4wkqXKPhjga2uBewFfdD02TKqIvsSKEXAUge69kAkVjSAy/Sz8Rj9
NUwJ6GbY5Clul7ZkO6eRe39K/bnmICJytZCvmxas+x3YQN5eiml9ooPhHoCa48l1
tzjKhxg5VSCVPYdvIdauSRDsuHKcYzezXiaX/mX8Rz6h2/4bWbX9/Lt9Y5UZyikO
2DdZK0hdYuTCw2X0qHF5x4sS1s9Tew==
=HHcK
-----END PGP SIGNATURE-----

--=-HuE7CYEmA0DlmwKJIinl--


--===============8590430986476221498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8590430986476221498==--

