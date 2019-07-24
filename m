Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8DC7618F
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:28:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE92A21738
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE92A21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E4D5DD0;
	Wed, 24 Jul 2019 14:28:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 72D28B8F
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:27:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC65E709
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:27:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 1A8E9AE44;
	Wed, 24 Jul 2019 14:27:57 +0000 (UTC)
Message-ID: <3a2f952e090d972b33f62592b12399f9ef3b0513.camel@suse.de>
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 24 Jul 2019 16:27:55 +0200
In-Reply-To: <20190724135657.GA9075@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
	<20190717153135.15507-4-nsaenzjulienne@suse.de>
	<20190718091526.GA25321@lst.de>
	<13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
	<58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de>
	<20190724135124.GA44864@arrakis.emea.arm.com>
	<20190724135657.GA9075@lst.de>
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Cc: stefan.wahren@i2se.com, Jisheng.Zhang@synaptics.com, f.fainelli@gmail.com,
	will@kernel.org, phil@raspberrypi.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	mbrugger@suse.com, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: multipart/mixed; boundary="===============6314618156046154252=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============6314618156046154252==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-m+/FyWNmUHFI+YRB/Gte"


--=-m+/FyWNmUHFI+YRB/Gte
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-24 at 15:56 +0200, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 02:51:24PM +0100, Catalin Marinas wrote:
> > I think it may be better if we have both ZONE_DMA and ZONE_DMA32 on
> > arm64. ZONE_DMA would be based on the smallest dma-ranges as described
> > in the DT while DMA32 covers the first naturally aligned 4GB of RAM
> > (unchanged). When a smaller ZONE_DMA is not needed, it could be expande=
d
> > to cover what would normally be ZONE_DMA32 (or could we have ZONE_DMA a=
s
> > 0-bytes? I don't think GFP_DMA can still allocate memory in this case).
> >=20
> > We'd probably have to define ARCH_ZONE_DMA_BITS for arm64 to something
> > smaller than 32-bit but sufficient to cover the known platforms like
> > RPi4 (the current 24 is too small, so maybe 30). AFAICT,
> > __dma_direct_optimal_gfp_mask() figures out whether GFP_DMA or GFP_DMA3=
2
> > should be passed.
>=20
> ARCH_ZONE_DMA_BITS should probably become a variable.  That way we can
> just initialize it to the default 24 bits in kernel/dma/direct.c and
> allow architectures to override it in their early boot code.

Thanks both for your feedback. I'll start preparing a proper series.


--=-m+/FyWNmUHFI+YRB/Gte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl04ausACgkQlfZmHno8
x/5nVAf/bB5PkXsWGRSrKIKToRRuuBU3F3Qkczzlf22bZ/BWtFMeSNlTL1Fz2BXY
fntHM/mLq5eBmbhnOMljQi4PSaNXX09olyWxJl4W6kJuDNyoAQ4+ncqWubT9Sevw
Kz7S8rqShYPxZT5vdNUHg/11Clx5lB1FkgmErz+Gc5qUunLClW66KuhTy6pls4vt
Odp5uE2S6j/YXpM1osSK7Ty3psAoyJ8QEGSlDiFFi4Zx69ycqmiKitmWYaAHCLu5
9a/KvFdyeE8UrF5sALymEDQr/G3V+G3AUtbI+xqsmTacUpCJYMhMJr2xtb3sWb5L
+UzW6OpVwWRETgf1XlNpbiIHOrAKKA==
=Tmgu
-----END PGP SIGNATURE-----

--=-m+/FyWNmUHFI+YRB/Gte--


--===============6314618156046154252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6314618156046154252==--

