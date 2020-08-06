Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE74C433E0
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 11:50:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9676B22D04
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9676B22D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70387881D2;
	Thu,  6 Aug 2020 11:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KeoFBi2EQqBa; Thu,  6 Aug 2020 11:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5A37881BE;
	Thu,  6 Aug 2020 11:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97A57C0050;
	Thu,  6 Aug 2020 11:50:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A09AEC004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 11:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 90EF786DDA
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 11:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0t9L9nF-6B6V for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 11:50:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A46D486DD9
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 11:50:34 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9A7B6AED2;
 Thu,  6 Aug 2020 11:50:49 +0000 (UTC)
Message-ID: <3a530804ad5aa96d2502da8ee3e8650b0b477c0f.camel@suse.de>
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 06 Aug 2020 13:50:29 +0200
In-Reply-To: <20200806051814.GA10143@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de>
 <20200803160956.19235-3-nsaenzjulienne@suse.de>
 <20200804060633.GA7368@lst.de>
 <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
 <20200806051814.GA10143@lst.de>
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
Content-Type: multipart/mixed; boundary="===============0649016993770056811=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0649016993770056811==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-BLB/tUqhN7FZgmlmL87f"


--=-BLB/tUqhN7FZgmlmL87f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-08-06 at 07:18 +0200, Christoph Hellwig wrote:
> On Tue, Aug 04, 2020 at 11:43:15AM +0200, Nicolas Saenz Julienne wrote:
> > > Second I don't see the need (and actually some harm) in preventing GF=
P_KERNEL
> > > allocations from dipping into lower CMA areas - something that we did=
 support
> > > before 5.8 with the single pool.
> >=20
> > My thinking is the least we pressure CMA the better, it's generally sca=
rse, and
> > it'll not grow as the atomic pools grow. As far as harm is concerned, w=
e now
> > check addresses for correctness, so we shouldn't run into problems.
> >=20
> > There is a potential case for architectures defining a default CMA but =
not
> > defining DMA zones where this could be problematic. But isn't that just=
 plain
> > abusing CMA? If you need low memory allocations, you should be defining=
 DMA
> > zones.
>=20
> The latter is pretty much what I expect, as we only support the default a=
nd
> per-device DMA CMAs.

Fair enough, should I send a v3 with everything cleaned-up/rebased, or you'=
d
rather pick it up from your version?


--=-BLB/tUqhN7FZgmlmL87f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8r7oUACgkQlfZmHno8
x/6NNAf8CT1UiVU7PCKz2LUHhepxWBfqr/Fz15NMCjlWxLecIvE8NeFQYjnkzCr8
WNIEZM0Vi5yiy2M5Au0e18rt/S/U2O4wCD95KXIAO7b7iMhP0jJFh9nqnj6IDUrJ
+QzQLSMHGGD+UO4bxtpONvZ0/UekL1werA7sP2qQynpUDFijzq8HZ9/U2tD+Mtyl
CFUOvAI5xO6AsVH4xryG4jWUb66/hflTOJ2nwz6ybrN/R+L2UvxYrynf2/lHIZq/
wqfGMD/Oh+KAiecex8ZgavWC/Adft7bAfJ3E7JZp5V3C+wW/QB7XWeGtAAawy1nC
B5Pd5WHQFwp5oP5bPzDO17kycEbD8Q==
=DGkG
-----END PGP SIGNATURE-----

--=-BLB/tUqhN7FZgmlmL87f--


--===============0649016993770056811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0649016993770056811==--

