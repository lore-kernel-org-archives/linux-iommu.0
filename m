Return-Path: <SRS0=Y3fO=BO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C624CC433E0
	for <iommu@archiver.kernel.org>; Tue,  4 Aug 2020 09:43:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64522086A
	for <iommu@archiver.kernel.org>; Tue,  4 Aug 2020 09:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64522086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7708987A00;
	Tue,  4 Aug 2020 09:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ehaw61KzmIdq; Tue,  4 Aug 2020 09:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0FA68878F0;
	Tue,  4 Aug 2020 09:43:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB581C0050;
	Tue,  4 Aug 2020 09:43:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 282D5C004C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 09:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1550585EA8
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 09:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zh2HmUTs9HwZ for <iommu@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5400F85DBB
 for <iommu@lists.linux-foundation.org>; Tue,  4 Aug 2020 09:43:23 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 747B9ADE5;
 Tue,  4 Aug 2020 09:43:36 +0000 (UTC)
Message-ID: <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 04 Aug 2020 11:43:15 +0200
In-Reply-To: <20200804060633.GA7368@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de>
 <20200803160956.19235-3-nsaenzjulienne@suse.de>
 <20200804060633.GA7368@lst.de>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Cc: amit.pundir@linaro.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 rientjes@google.com, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============2004804738319316884=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2004804738319316884==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-37n9dG1PtRrqctFyLGEb"


--=-37n9dG1PtRrqctFyLGEb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 08:06 +0200, Christoph Hellwig wrote:
> On Mon, Aug 03, 2020 at 06:09:56PM +0200, Nicolas Saenz Julienne wrote:
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> > +		return end <=3D DMA_BIT_MASK(zone_dma_bits);
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> > +		return end <=3D DMA_BIT_MASK(32);
> > +	if (gfp & GFP_KERNEL)
> > +		return end > DMA_BIT_MASK(32);
>=20
> So the GFP_KERNEL one here looks weird.  For one I don't think the if
> line is needed at all, and it just confuses things.

Yes, sorry, shoud've seen that.

> Second I don't see the need (and actually some harm) in preventing GFP_KE=
RNEL
> allocations from dipping into lower CMA areas - something that we did sup=
port
> before 5.8 with the single pool.

My thinking is the least we pressure CMA the better, it's generally scarse,=
 and
it'll not grow as the atomic pools grow. As far as harm is concerned, we no=
w
check addresses for correctness, so we shouldn't run into problems.

There is a potential case for architectures defining a default CMA but not
defining DMA zones where this could be problematic. But isn't that just pla=
in
abusing CMA? If you need low memory allocations, you should be defining DMA
zones.

Regards,
Nicolas


--=-37n9dG1PtRrqctFyLGEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8pLbMACgkQlfZmHno8
x/6CFQgAroY7OAksNUQQ1MqKTFjhXVRYkfoAZYNmH6unfh6DBZ8bbSiIy9zgoaP8
W4Ve63kWqEzS9f64iOzDugZuZA5Cxs8w7ELVhNtfxN/qdLNHYOA3BkDsvDy+fHcD
Q5ITY/XPPFvGoLsI8N4z1DT4GAnS3iRZhl9LzslqGoOyQPcl9iLgVrxCOWDNhAek
7HGtXe+7mTFogwtf6r03ywUQCpBs56ZFXAbzKfeyhMSUHNjz4rPlfruOW8GpyMvA
JZeK2B6Pk4QSads310PrY4ZRkLYO2vmrYlFXSOosFv7oF6wwd7wnYMVI05JuQ7Yo
55KdR6h6r+HQ7BslvbaH8GDPGMiYhA==
=Ah73
-----END PGP SIGNATURE-----

--=-37n9dG1PtRrqctFyLGEb--


--===============2004804738319316884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2004804738319316884==--

