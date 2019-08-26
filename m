Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B2C3A59F
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 11:10:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32B92070B
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 11:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32B92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8E15913FC;
	Mon, 26 Aug 2019 11:10:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BF70113F4
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 11:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 47072710
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 11:08:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id E9BAEAF23;
	Mon, 26 Aug 2019 11:08:55 +0000 (UTC)
Message-ID: <4d8d18af22d6dcd122bc9b4d9c2bd49e8443c746.camel@suse.de>
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
	dma-direct min mask
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 Aug 2019 13:08:50 +0200
In-Reply-To: <20190826070633.GB11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-11-nsaenzjulienne@suse.de>
	<20190826070633.GB11331@lst.de>
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
	will@kernel.org, eric@anholt.net, marc.zyngier@arm.com,
	catalin.marinas@arm.com, frowand.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	wahrenst@gmx.net, mbrugger@suse.com, linux-riscv@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, phill@raspberryi.org
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
Content-Type: multipart/mixed; boundary="===============7344391699437889227=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7344391699437889227==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RvTUUUche1DA67AZeVhb"


--=-RvTUUUche1DA67AZeVhb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-26 at 09:06 +0200, Christoph Hellwig wrote:
> On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:
> > -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> >  		arm64_dma_phys_limit =3D max_zone_dma_phys();
> > +		zone_dma_bits =3D ilog2((arm64_dma_phys_limit - 1) &
> > GENMASK_ULL(31, 0)) + 1;
>
Hi Christoph,
thanks for the rewiews.

> This adds a way too long line.

I know, I couldn't find a way to split the operation without making it even
harder to read. I'll find a solution.

> I also find the use of GENMASK_ULL
> horribly obsfucating, but I know that opinion is't shared by everyone.

Don't have any preference so I'll happily change it. Any suggestions? Using=
 the
explicit 0xffffffffULL seems hard to read, how about SZ_4GB - 1?


--=-RvTUUUche1DA67AZeVhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1jvcIACgkQlfZmHno8
x/6y/wf/XTe7dlASMoYApyVt+lL6chBcap2r7MVKOVhCbC1oJQb7UdRyW7MVDO6k
gwdo2WmXqD3wUwhY5djX0adczLOJye1iGEdrrQfheRqm1rh07um3quT3TzgCSPat
OuX+vHuNsUE+3GyI+0OoOF0tu/TzOKJjgs4H645cnbuCaXbQFbL94yBctsDTF5hc
m4Bx+nksz99ddodUnw9CF4Ss5DPwkX23I3h7okwMMjvVuegIPUa9edppw3Za0Kby
k8b9QGCiMsGcwyq3+uSXTCq4iIU8reLTfvpZmVZ9QugMn8TkjjIQFyWS0HrXt2pz
r9iNomMe9w20W9Y9jS5Aj8bxByoK+Q==
=nQ/V
-----END PGP SIGNATURE-----

--=-RvTUUUche1DA67AZeVhb--


--===============7344391699437889227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7344391699437889227==--

