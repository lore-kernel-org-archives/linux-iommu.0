Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E61C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 17:25:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEF923429
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 17:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEF923429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 86DC96337;
	Fri, 30 Aug 2019 17:25:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 66D6C62FF
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 17:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8906EEC
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 17:24:30 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 5DC6FAEAE;
	Fri, 30 Aug 2019 17:24:28 +0000 (UTC)
Message-ID: <bdeda2206b751a1c6a8d2e0732186792282633c6.camel@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Aug 2019 19:24:25 +0200
In-Reply-To: <20190830144536.GJ36992@arrakis.emea.arm.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-2-nsaenzjulienne@suse.de>
	<20190826070939.GD11331@lst.de>
	<027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
	<20190830144536.GJ36992@arrakis.emea.arm.com>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
	f.fainelli@gmail.com, phill@raspberryi.org,
	Arnd Bergmann <arnd@arndb.de>, mbrugger@suse.com,
	marc.zyngier@arm.com, frowand.list@gmail.com, wahrenst@gmx.net,
	eric@anholt.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	linux-riscv@lists.infradead.org, will@kernel.org,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============4575791344885494264=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============4575791344885494264==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-VseoIlC7OSxnfDPpE7cN"


--=-VseoIlC7OSxnfDPpE7cN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-30 at 15:45 +0100, Catalin Marinas wrote:
> On Mon, Aug 26, 2019 at 03:46:52PM +0200, Nicolas Saenz Julienne wrote:
> > On Mon, 2019-08-26 at 09:09 +0200, Christoph Hellwig wrote:
> > > On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > Some architectures have platform specific DMA addressing limitation=
s.
> > > > This will allow for hardware description code to provide the constr=
aints
> > > > in a generic manner, so as for arch code to properly setup it's mem=
ory
> > > > zones and DMA mask.
> > >=20
> > > I know this just spreads the arm code, but I still kinda hate it.
> >=20
> > Rob's main concern was finding a way to pass the constraint from HW
> > definition
> > to arch without widening fdt's architecture specific function surface. =
I'd
> > say
> > it's fair to argue that having a generic mechanism makes sense as it'll=
 now
> > traverse multiple archs and subsystems.
> >=20
> > I get adding globals like this is not very appealing, yet I went with i=
t as
> > it
> > was the easier to integrate with arm's code. Any alternative suggestion=
s?
>=20
> In some discussion with Robin, since it's just RPi4 that we are aware of
> having such requirement on arm64, he suggested that we have a permanent
> ZONE_DMA on arm64 with a default size of 1GB. It should cover all arm64
> SoCs we know of without breaking the single Image binary. The arch/arm
> can use its current mach-* support.
>=20
> I may like this more than the proposed early_init_dt_get_dma_zone_size()
> here which checks for specific SoCs (my preferred way was to build the
> mask from all buses described in DT but I hadn't realised the
> complications).

Hi Catalin, thanks for giving it a thought.

I'll be happy to implement it that way. I agree it's a good compromise.

@Christoph, do you still want the patch where I create 'zone_dma_bits'? Wit=
h a
hardcoded ZONE_DMA it's not absolutely necessary. Though I remember you sai=
d it
was a first step towards being able to initialize dma-direct's min_mask in
meminit.

Regards,
Nicolas


--=-VseoIlC7OSxnfDPpE7cN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1pW8kACgkQlfZmHno8
x/4ltggAgcfG1puKlA5IJJrCySlntixj950TwNq7qMwwKwzxVCTojg/6HtjhOmlp
IRbqq36DEjcQ12ulD0rqU84gMIP6jryt4iVDDutg18liBPSH3eekj9Wf22J+Vq7f
5yw3zuYyCkrTcgWufsIwn4kbH0GRXCCLV8kwfKFRtXE5dtcWTRbOeNPpmh4HxIJW
z0SkTnBc03CvX0VamQYNZ45QvBFVntqKMCExrvinZyOBUs4+/nd68IXfBU+rj9qb
IBbZaZspKLp1NdVxSo/Tmamv2NVTodxnue9KbFzQe8r3n1bak/9VJKO4z3u0R6AK
6x6oAxLccyXIktLiudLXEMdXMar2vw==
=LsVM
-----END PGP SIGNATURE-----

--=-VseoIlC7OSxnfDPpE7cN--


--===============4575791344885494264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4575791344885494264==--

