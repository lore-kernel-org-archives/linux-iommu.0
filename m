Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D4C433E1
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:40:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D1C22201
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 11:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D1C22201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 288DC8A607;
	Tue, 14 Jul 2020 11:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZC7U1JquadV; Tue, 14 Jul 2020 11:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D7C18A535;
	Tue, 14 Jul 2020 11:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA4AC0891;
	Tue, 14 Jul 2020 11:40:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D02DC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0680822660
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kvMB7XaYb4TX for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 11:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 2858520788
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 11:40:06 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C2425AF36;
 Tue, 14 Jul 2020 11:40:06 +0000 (UTC)
Message-ID: <809a3445c6fdbc2dfc0ea00097157bce61ccd5ea.camel@suse.de>
Subject: Re: [PATCH 3/4] dma-pool: Introduce dma_guess_pool()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Jul 2020 13:40:01 +0200
In-Reply-To: <20200714112208.GA18261@lst.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de>
 <20200709161903.26229-4-nsaenzjulienne@suse.de>
 <20200714112208.GA18261@lst.de>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============1848206862453401587=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1848206862453401587==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-jtA8Pvm/q46e3P8cNpns"


--=-jtA8Pvm/q46e3P8cNpns
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-07-14 at 13:22 +0200, Christoph Hellwig wrote:
> This one doesn't appear to actually apply on top of Linus' tree plus the
> two previous patches.

I'll take care of it.


--=-jtA8Pvm/q46e3P8cNpns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8NmZEACgkQlfZmHno8
x/67vgf/S8THsKAgGwIlTRp0AyhSbdCLurjEs05omCC23BcU290BbvGjT1aaYB31
+sO2IbjDIv7EsH/DN4LeiAwJHagCrw8NlEdwSmreJDRdGhCgFaXfCwRBOtK5TXsr
zPrTK//uac3ZdJjrBt76k3ww247ff5lfAuXcXzaemRRPlYk/tM9j6XrONBNtU2Tn
snSlA798GKc5yS77daiyp8Fkb50px6aMj8YW8nQEcInDcUDiVZ7y8mwfojBWZKez
IH48qHWxEEojTBooK2dLlLkhRWAtPLhj8G8CeKFHZh//Zbp5SCuGsQKREh7eRulG
psgvv6ahP0v7UW4NngAQ9Gu3Nz5VTw==
=Yb8P
-----END PGP SIGNATURE-----

--=-jtA8Pvm/q46e3P8cNpns--


--===============1848206862453401587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1848206862453401587==--

