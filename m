Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1935C76195
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 11:19:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD32217F4
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD32217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4D95D157C;
	Thu, 18 Jul 2019 11:19:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 40ABA157A
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 11:18:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9D77C8A7
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 11:18:46 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id A89C5AF8A;
	Thu, 18 Jul 2019 11:18:44 +0000 (UTC)
Message-ID: <13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 18 Jul 2019 13:18:42 +0200
In-Reply-To: <20190718091526.GA25321@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
	<20190717153135.15507-4-nsaenzjulienne@suse.de>
	<20190718091526.GA25321@lst.de>
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com, catalin.marinas@arm.com,
	phil@raspberrypi.org, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jisheng.Zhang@synaptics.com, mbrugger@suse.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============7963161755901868236=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7963161755901868236==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-u4X6VmDDAIHDooroH1Nl"


--=-u4X6VmDDAIHDooroH1Nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 11:15 +0200, Christoph Hellwig wrote:
> On Wed, Jul 17, 2019 at 05:31:34PM +0200, Nicolas Saenz Julienne wrote:
> > Historically devices with ZONE_DMA32 have been assumed to be able to
> > address at least the lower 4GB of ram for DMA. This is still the defual=
t
> > behavior yet the Raspberry Pi 4 is limited to the first GB of memory.
> > This has been observed to trigger failures in dma_direct_supported() as
> > the 'min_mask' isn't properly set.
> >=20
> > We create 'dma_direct_min_mask' in order for the arch init code to be
> > able to fine-tune dma direct's 'min_dma' mask.
>=20
> Normally we use ZONE_DMA for that case.

Fair enough, I didn't think of that possibility.

So would the arm64 maintainers be happy with something like this:

- ZONE_DMA: Follows standard definition, 16MB in size. ARCH_ZONE_DMA_BITS i=
s
	    left as is.
- ZONE_DMA32: Will honor the most constraining 'dma-ranges'. Which so far f=
or
	      most devices is 4G, except for RPi4.
- ZONE_NORMAL: The rest of the memory.


--=-u4X6VmDDAIHDooroH1Nl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0wVZIACgkQlfZmHno8
x/5UBwgAnIorcvhqJGeCU5fyBsfWXYHjNwasQPCU1TRsSi98KiAGitUFSad2SNFL
nQ+EYRvqt0z/niIozLsQpVl1Yt7ccXZDHImuEEb4DEEFiTm+AYIV5jwyiRo9owAc
8IAb+IYT6JZ9F9PRfZoALsi4dpG7t3o/YLPAg0Faphlvb5xj9Bv1yD0bXaHAldzY
Yp7rtu3knI8rhmOpnzH6HCU5PvC51EbcN7UE8Mc2hWiC7iBfQDGgyd3kor71xku9
6nV+594cncBJlkVwiQ8cwOTqGJ5AeygYXy1wGEsLnk8Xyd+vK3e6tVMMJW/F0nuw
8u0mlFrs+jSLsnFe6WhaGTgsPSZ7Ow==
=DM0Q
-----END PGP SIGNATURE-----

--=-u4X6VmDDAIHDooroH1Nl--


--===============7963161755901868236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7963161755901868236==--

